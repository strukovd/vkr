const log = require("../utils/log");
const pg = require("../utils/pg");

/**
 * @typedef {Object} InputWithOptions
 * @property {String} project_id
 * @property {String} input_id
 * @property {String} type
 * @property {Object} caption
 * @property {Boolean} have_static_data
 * @property {String} regex
 * @property {String} mask
 * @property {Number} order
 * @property {Boolean} refillable
 * @property {String} tooltip
 * @property {Boolean} require
 * @property {String} placeholder
 * @property {String} refillable_source
 * @property {String} default_value
 * @property {Array<Option>} options
 */

/**
 * @typedef {Object} Project
 * @property {Number} id
 * @property {Object} name
 * @property {Boolean} visible
 */

/**
 * @param {Number} projectID
 * @returns {Project}
 */
exports.getProjectById = async function(projectID) {
	log.debug(`Вызван метод getProjectById`);
	log.trace(`Параметры: projectID: ${projectID}`);

	const query = `
			SELECT id, name, visible
			FROM projects
			WHERE id = $1;`;
	const params = [projectID];

	try {
		let res;
		const projects = await pg.execSync(query, params);

		if(projects && projects.length) {
			res = projects[0];
			return res;
		}
		else {
			log.error(`Не удалось получить информацию о проекте`, null);
			log.trace(`projectID: ${projectID}`);
			throw `Получен пустой ответ из БД!`;
		}
	}
	catch (e) {
		log.error(`При попытке получить данные о проекте из БД возникла ошибка!`, e);
		log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
		throw `Не удалось получить данные из БД!`;
	}
};