const log = require('../lib/utils/log');
const pg = require('../lib/utils/pg');


exports.mainController = async function(req, resp) {

	try {

		const cookies = req.cookies;
		let lang = "ru"; //TODO: указать в конфиге
		if(cookies && cookies.lang) {
			lang = cookies.lang;
		}


		let projects = await pg.execSync(`
			SELECT id, name, img, visible
			FROM projects
			WHERE visible = true
			ORDER BY "order";`,
		[]);
		if(!projects || projects.length == 0) {
			throw new Error(`Проекты не обнаружены!`);
		}


		resp.render("main.hbs",
			{
				layout: 'layouts/mainLayout.hbs',
				projects,
				lang,
				jsFiles:[`/js/script-main.js`],
				cssFiles:[`/css/main.css`]
			}
		);
	}
	catch (e) {
		log.error(`В контроллере mainController произошла ошибка!`, e);
		resp.status(500).render("service/500.hbs", {});
	}
};