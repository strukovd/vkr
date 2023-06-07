const log = require('../utils/log');
const pg = require('../utils/pg');

exports.ngv4Handler = async function(form) {
	log.debug(`Вызван метод ngv4Handler`);

	const formData = form.form_data;
	const formKey = form.form_key;

	try {
		// Подготовим объект для жиры
		const title = await prepareTitle(formData);
		const description = await prepareDescription(formData);

		// Обновим статус в БД
		await pg.execSync(`UPDATE forms SET status = 'IN_PROCESS' WHERE id = $1`, [form.id]);

		// Создадим задачу
		await pg.execSyncToTaskTraker(`INSERT INTO tasks
			(title, description, project_key, priority, assignee, status, creator)
			VALUES ($1, $2, $3::varchar(50), $4, $5, (SELECT from_status FROM transitions tr WHERE tr.project_key = $3::varchar(50) AND tr.first_status = true), $6);`,
		[title, description, form.project_id, 1, `admin`, `admin`]);

		// Обновим статус в БД
		await pg.execSync(`UPDATE forms SET status = 'DONE' WHERE id = $1`, [form.id]);
	}
	catch (err) {
		log.error(`В методе ngv4Handler, возникла ошибка!`, err);
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





async function prepareTitle(formData) {
	const res = [formData["sname"], formData["name"], formData["contact_number"]].filter(Boolean).join(" ");
	return res;
}

async function prepareDescription(formData) {
	let res = ``;
	res += `ФИО: ${formData.sname} ${formData.name} ${formData.fname}\n`;
	res += `Пол: ${formData.gender === 10266 ? 'Женский' : 'Мужской'}\n`;
	res += `ИНН: ${formData.inn}\n`;
	res += `Е-мейл: ${formData.email}\n`;
	res += `Дата рождения: ${formData.birthday}\n`;
	res += `Контактный номер: ${formData.contact_number}`;

	return res;
}

