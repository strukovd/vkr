const log = require(`../lib/utils/log`);
const {getInputs} = require(`../lib/utils/getInputs`);
const {getProjectById} = require(`../lib/utils/getProjectById`);


exports.formController = async function(req, resp) {
	log.debug(`Вызван метод formController`);

	try {
		const cookies = req.cookies;
		const projectID = req.params[`id`];

		// Узнаем язык пользователя
		let lang = "ru"; //TODO: указать в конфиге
		if(cookies && cookies.lang) {
			lang = cookies.lang;
		}

		// Получаем из БД input'ы для этого проекта.
		const project = await getProjectById(projectID);
		if(!project) {
			throw new Error(`Проект не найден!`);
		}

		const inputs = await getInputs(projectID);
		log.info(`inputs: ${JSON.stringify(inputs)}`);
		log.debug(`inputs.length: ${inputs.length}`);
		if(!inputs || inputs.length == 0) {
			throw new Error(`Компоненты ввода для проекта не обнаружены!`);
		}



		resp.render("form.hbs",
			{
				layout: 'layouts/mainLayout.hbs',
				jsFiles:[`/js/script-form.js`],
				cssFiles:[`/css/form.css`, `/css/components.css`],
				project,
				inputs,
				lang
			}
		);
	}
	catch (e) {
		log.error(`В контроллере formController произошла ошибка!`, e);
		resp.status(500).render("service/500.hbs", {});
	}
};



