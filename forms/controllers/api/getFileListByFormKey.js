const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getFileListByFormKey = async function(req, resp) {
	log.debug("Вызван метод getFileListByFormKey");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const body = req.body;
		const formKey = body.formKey;
		const fileIdsList = await getFileListFromDB(formKey);

		resp.json(createSuccessResponse( fileIdsList ));
	}
	catch (err) {
		log.error("Ошибка при получении информации о файлах", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getFileListFromDB(formKey) {
	log.debug(`Вызван метод getFileListFromDB`);

	const query = `
		SELECT id
		FROM files
		WHERE form_key = $1;`;
	const params = [formKey];

	try {
		let result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получена информация о файле");
			log.trace(`result: ${JSON.stringify( result )}`);

			return result;
		}
		else {
			log.error("Метод getFileListFromDB: Получен пустой ответ с базы данных при получении информации о файлах", null);
			return false;
		}
	}
	catch (err) {
		log.error("Метод getFileListFromDB: Ошибка при получении списка идентификаторов файлов", err);
		log.trace(`Запрос: ${query}, параметры: ${params}`);
		throw new Error(err);
	}
}


class File {
	constructor(id, name, original_name, mimetype, path, size, content, created) {
		this.id = String(id);
		this.name = String(name);
		this.original_name = String(original_name);
		this.mimetype = String(mimetype);
		this.path = String(path);
		this.size = Number(size);
		this.content = content.toString("hex");
		this.created = created;
	}
}
