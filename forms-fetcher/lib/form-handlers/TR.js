const log = require('../utils/log');
const pg = require('../utils/pg');
const fs = require('fs');
const jiraAPI = require('../utils/jiraAPI');
const formsAPI = require('../utils/formsAPI');
const moment = require('moment');

exports.trHandler = async function(form) {
	log.debug(`Вызван метод trHandler`);

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
		log.error(`В методе trHandler, возникла ошибка!`, err);
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
	// Получим данные из адресного классификатора
	const pgClient = await pg.getConnection();

	if(formData["region_uuid"]) {
		const region = await pgClient.query(`
			SELECT uuid AS id, description AS name
				FROM rng_address_classificator
				WHERE uuid = $1;`, [ formData["region_uuid"] ]);

		formData["region"] = region.rows[0];
		log.debug(`formData["region"]: ${JSON.stringify(formData["region"])}`);
	}


	if(formData["district_uuid"]) {
		const district = await pgClient.query(`
			SELECT uuid AS id, description AS name
				FROM rng_address_classificator
				WHERE uuid = $1;`, [ formData["district_uuid"] ]);

		formData["district"] = district.rows[0];
	}


	if(formData["locality_uuid"]) {
		const locality = await pgClient.query(`
			SELECT uuid AS id, description AS name
				FROM rng_address_classificator
				WHERE uuid = $1;`, [ formData["locality_uuid"] ]);

		formData["locality"] = locality.rows[0];
	}


	if(formData["street_uuid"]) {
		const street = await pgClient.query(`
			SELECT uuid AS id, description AS name
				FROM rng_address_classificator
				WHERE uuid = $1;`, [ formData["street_uuid"] ]);

		formData["street"] = street.rows[0];
	}


	// 
	if(formData["building_type_uuid"]) {
		const building_type = await pgClient.query(`
			SELECT description AS name, uuid AS id
				FROM rng_types_house
				WHERE uuid = $1;`, [ formData["building_type_uuid"] ]);

		formData["building_type"] = building_type.rows[0];
	}

	if(formData["sector_type_uuid"]) {
		const sector_type = await pgClient.query(`
			SELECT description AS name, uuid AS id
				FROM rng_types_sector
				WHERE uuid = $1;`, [ formData["sector_type_uuid"] ]);

		formData["sector_type"] = sector_type.rows[0];
	}


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



async function prepareBody(formData) {
	await prepareCustomfields(formData);

	const body = {
		"fields": {
			project: { id: "11200" },
			summary: generateSummary(formData),
			issuetype: { "id": "11600" },
			customfield_12301: { value: `Web` }, //Источник
			customfield_11917: '0',// Номер заявки
			customfield_11903: { id: "11302" },// Название офиса (ул.Ю.Фучика, 47)
		}
	};


	body.fields['customfield_10107'] = formData["sname"] || ''; //Фамилия (Строка)
	body.fields['customfield_10108'] = formData["name"] || ''; //Имя (Строка)
	body.fields['customfield_10109'] = formData["fname"] || ''; //Отчетсво (Строка)
	body.fields['customfield_10110'] = moment(formData["birthday"], "DD.mm.yyyy").format("yyyy-mm-DD") || ''; //Дата рождения (Строка)

	body.fields['customfield_10300'] = { "id": formData["gender"] || '-1' }; //Пол (Объект)

	// 10142 еще 1 серия паспорта
	body.fields['customfield_12500'] = formData["passport_num"] || ''; //Номер паспорта (Строка)
	body.fields['customfield_11922'] = formData["passport_series"].id || ''; //pasportid (Строка) {ECB09D66-107D-11E8-80C7-005056B35097}
	body.fields['customfield_11921'] = formData["passport_series"].name || ''; //Серия паспорта (Строка)

	body.fields['customfield_10121'] = formData["issuing_authority"] || ''; // Орган выдавщий документ (Строка)
	body.fields['customfield_10111'] = formData["date_of_issue_of_the_document"] ? moment( formData["date_of_issue_of_the_document"], "DD.mm.yyyy").format("yyyy-mm-DD") : undefined; //Дата выдачи документа (Строка)

	body.fields['customfield_12501'] = formData["contact_number"] || ''; // Контактный номер (Строка)
	body.fields['customfield_10126'] = Number( formData["additional_number"] ) || undefined; //Доп. номер (Число)
	body.fields['customfield_11006'] = formData["email"] || ''; //Эл. адрес (Строка)

	body.fields['customfield_11915'] = formData["inn"] || ''; //ИНН (Строка)

	//12300 пользователь тест

	// body.fields['customfield_13200'] = formData["sssss"] || ''; //Подразделение (Строка)
	// body.fields['customfield_13201'] = formData["sssss"] || ''; //divisionid

	body.fields['customfield_13302'] = formData["building_type"].id || ''; // housetypeid (Строка)
	body.fields['customfield_13300'] = formData["building_type"].name || ''; //тип здания (Строка)

	body.fields['customfield_13304'] = formData["sector_type"].id || ''; //сектор_тип_ид (Строка)
	body.fields['customfield_13303'] = formData["sector_type"].name || ''; //тип сектора (Строка)




	

	body.fields['customfield_11709'] = formData["region"].id || ''; //regionid (Строка)
	body.fields['customfield_11703'] = formData["region"].name || ''; //Регион (Строка)

	body.fields['customfield_11712'] = formData["district"].id || ''; //districtid (Строка)
	body.fields['customfield_11711'] = formData["district"].name || ''; //Район (Строка)

	body.fields['customfield_11820'] = formData["locality"].id || ''; //pgtid (Строка)
	body.fields['customfield_11806'] = formData["locality"].name || ''; //Населенный пункт (Строка)

	body.fields['customfield_11821'] = formData["street"].id || ''; //streetid (Строка)
	body.fields['customfield_11713'] = formData["street"].name || ''; //Улица (Строка)
	// body.fields['customfield_11824'] = formData["sssss"] || ''; // Улица ПГТ (Строка)

	body.fields['customfield_11307'] = formData["house_number"] || ''; //Номер дома (Строка)
	// body.fields['customfield_11308'] = formData["sssss"] || ''; //Номер квартиры (Строка)

	// body.fields['customfield_13305'] = formData["sssss"] || ''; //Организация (Строка)
	// body.fields['customfield_13306'] = formData["sssss"] || ''; //организейшн_ид (Строка)

	// 13400 ФИО
	// 10127 адрес газификации (текстовое поле)
	








	body.fields['customfield_14200'] = { id: "13200" }; //выбор региона (Объект) //12400[Бишкек], 12401[Токмокская ЭГС], 12402[Кантская ЭГС], 12403[Кара-Балтинская ЭГС], 12404[Ленинская ЭГС], 12405[Аманбаевская ЭГС], 12406[«Чуйгаз»] 13200[Онлайн]
	body.fields['customfield_10115'] = { "id": formData["technical_conditions"] || '-1' }; //технические условия (Объект) //10006[есть], 10007[нет], -1
	body.fields['customfield_13101'] = [ {"id": formData["gas_consumption_pattern"] || '-1' } ]; //характер потребления газа (Массив) // 11803[отопление], 11804[горячее водоснабжение], 11805[пищеприготовление], 11806[технологические нужды]
	body.fields['customfield_10141'] = { "id": formData["housing_type"] || '-1' }; //тип жилья (Объект) //10010[частный сектор], 10011[государственный сектор], -1
	body.fields['customfield_13100'] = [ {"id": formData["planned_gas-using_devices"] || '-1' } ]; //Планируемые газоиспользующие приборы (Массив) //11800[плита], 11801[котел], 11802[газовая колонка]
	// body.fields['customfield_11903'] = { "id": formData["sssss"] || '-1' }; //Название офиса (Объект) //11300[Ахунбаева, 186/1], 11301[Горького, 22], 11302[Фучика 47], 11303[Токтогула, 45], 11304[Чуй 230], 11305[Жибек-Жолу, 150], 12800[Сокулук, Октябрьская,41], 12801[Токмок, Горького,1 подъезд 17], 12802[Кант, Маликова,6], 12803[Кара-Балта,Садовая, 112], 12804[Ленинское,Алма-Атинская,248]

	body.fields['customfield_14100'] = { "id": '15700' } || ''; //инвест программа (Объект) //12200[2016 год], 12201[2017 год], 12202[2018 год], 12203[2019 год], 12204[2020 год], 12205[2021 год], 12300[город]
	// body.fields['customfield_11828'] = formData[""] || ''; //Задача (Число)
	// body.fields['customfield_13105'] = formData[""] || ''; //leadid (Строка)

	return body;
}

