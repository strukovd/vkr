const log = require('../utils/log');
const pg = require('../utils/pg');
const fs = require('fs');
const jiraAPI = require('../utils/jiraAPI');
const formsAPI = require('../utils/formsAPI');
const moment = require('moment');

exports.psoHandler = async function(form) {
	log.debug(`Вызван метод psoHandler`);

	const formData = form.form_data;
	const formKey = form.form_key;

	try {
		// Подготовим объект для жиры
		const body = await prepareBody(formData);
		log.trace(`body:  ${ JSON.stringify(body) }`);

		// Обновим статус в БД
		await pg.execSync(`UPDATE forms SET status = 'IN_PROCESS' WHERE id = $1`, [form.id]);

		// Отправим в жиру
		const jiraRes = await jiraAPI.createIssue(body);
		/* {
			"id":"1027378",
			"key":"GAZ-42538",
			"self":"http://bs-docker-srv01/rest/api/latest/issue/1027378"
		}
		*/

		if(jiraRes.success) {
			log.info(`Успешно создана задача - ${jiraRes.data.key}`);

			const getFileListByFormKeyRes = await formsAPI.getFileListByFormKey(formKey);
			if(getFileListByFormKeyRes && getFileListByFormKeyRes.success) {
				const fileInfoArr = getFileListByFormKeyRes.data;
				for (const fileInfo of fileInfoArr) {
					let getFileRes = await formsAPI.getFile(fileInfo.id);
					if(getFileRes.success) {
						const fileData = getFileRes.data;

						// узнаем расширение файла
						const splitedName = fileData.original_name.split(".");
						const ext = splitedName[ splitedName.length-1 ];
						if(!ext || typeof ext != "string") {
							throw new Error("Не удалось определить расширение файла!");
						}

						// Сохраняем файл на диск и закрепляем в жире
						const pathToFile = `${global.fullStoragePath}/files/${fileData.name}`;
						fs.writeFileSync(pathToFile, fileData.content, {encoding:"hex"});
						jiraAPI.attachFile(jiraRes.data.id, pathToFile, fileData.original_name);
					}
					else {
						throw new Error(`Не удалось получить файл с ID: ${fileInfo.id}`);
					}
				}
			}
			else {
				throw new Error("Список файлов по formKey не получен!");
			}


			// Назначим исполнителем консультанта
			const changingAssignee = await jiraAPI.changeAssignee(jiraRes.data.id, "Kuharkina");

			if(changingAssignee.success) {
				log.debug(`Исполнитель задачи успешно изменен`);
			}
			else {
				log.error(`Не удалось сменить исполнителя задачи`, changingAssignee.error);
			}

			// Обновим статус в БД
			await pg.execSync(`UPDATE forms SET status = 'DONE' WHERE id = $1`, [form.id]);
		}
		else {
			log.error(`Не удалось создать задачу в жире!`, jiraRes.error);
			throw jiraRes.error;
		}



	}
	catch (err) {
		log.error(`В методе psoHandler, возникла ошибка!`, err);
		await pg.execSync(`UPDATE forms SET status = 'ERROR' WHERE id = $1`, [form.id]);
		
		let details = null;
		if(err.stack) {
			details = `${err.stack}\nКод ошибки: ${err.code}`;
		}
		else {
			details = JSON.stringify(err);
		}
		await pg.execSync(`INSERT INTO form_errors (form_id, description) VALUES ($1, $2);`, [form.id, details]);
	}

};

function generateSummary(row) {
	return `${row["sname"] || ''} ${row["name"] || ''},${row["contact_number"] || ''}`;
}


async function prepareCustomfields(formData) {
	// Ищем данные из справочников по ключу
	const pgClient = await pg.getConnection();

	// Получим данные о типе паспорта
	if(formData["passport_series_uuid"]) {
		const passport_series = await pgClient.query(`
			SELECT uuid AS id, description AS name
				FROM rng_document_types
				WHERE uuid = $1;`, [ formData["passport_series_uuid"] ]);

		formData["passport_series"] = passport_series.rows[0];
	}


	pgClient.end();
}


async function getCLDataByAccount(account) {
	const found = await jiraAPI.findIssueByAccount(account);

	if(found.success) {
		if(found.data.total > 0) {
			// const key = found.data.issues[0].key;
			return found.data;
		}
	}
	throw new Error('Не удалось найти ключ задачи по лицевому счету!');
}


async function prepareBody(formData) {
	await prepareCustomfields(formData);

	const body = {
		"fields": {
			project: { id: "12602" },
			summary: generateSummary(formData),
			issuetype: { "id": "13602" },
			customfield_12301: { value: `Web` }, //Источник
			customfield_11917: '0',// Номер заявки
			customfield_11903: { id: "11302" },// Название офиса (ул.Ю.Фучика, 47)
		}
	};


	const CLData = await getCLDataByAccount(formData["account"]);

	body.fields['customfield_12601'] = { "key": CLData.issues[0].key }; //Абонент
	body.fields['customfield_12501'] = formData["contact_number"] || ''; // Контактный номер (Строка)
	body.fields['customfield_11006'] = formData["email"] || ''; //Эл. адрес (Строка)


	body.fields['customfield_11915'] = "0000"; //ИНН (Строка)
	body.fields['customfield_10300'] = { value: "М" }; //Пол (Объект)
	body.fields['customfield_10110'] = "2021-01-01"; //Дата рождения (Строка)
	body.fields['customfield_11921'] = 'Паспорт КР'; //Серия паспорта (Строка)
	body.fields['customfield_12500'] = "0000"; //Номер паспорта (Строка)
	body.fields['customfield_10121'] = "Онлайн"; // Орган выдавщий документ (Строка)
	body.fields['customfield_10111'] = "2021-01-01"; //Дата выдачи документа (Строка)


	return body;
}

