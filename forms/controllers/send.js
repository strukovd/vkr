const log = require(`../lib/utils/log`);
const pg = require('../lib/utils/pg');

exports.send = async function(req, resp) {
	log.debug(`Вызван метод send`);

	try {
		const body = req.body;
		const cookies = req.cookies;
		const projectID = req.params[`id`];
		const formKey = body.formKey;

		delete body.formKey;

		// Узнаем язык пользователя
		let lang = "ru"; //TODO: указать в конфиге
		if(cookies && cookies.lang) {
			lang = cookies.lang;
		}


		// Удаляем пустые поля
		for (const field in body) {
			if (Object.hasOwnProperty.call(body, field)) {
				const value = body[field];

				if(value == "") {
					delete body[field];
				}
			}
		}


		// TODO: провалидировать содержимое полей


		// Отправляем в БД (forms) входящий запрос
		await pg.execSync(`INSERT INTO forms (project_id, form_data, form_key)
				VALUES ($1, $2, $3)
				RETURNING id;`, [projectID, body, formKey]);


		resp.render("send.hbs",
			{
				jsFiles:[],
				cssFiles:[`/css/form.css`, `/css/components.css`],
				lang
			}
		);

	}
	catch (e) {
		log.error(`В контроллере send произошла ошибка!`, e);
		resp.status(500).render("service/500.hbs", {});
	}
};

