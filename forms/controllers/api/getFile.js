const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const fs = require('fs');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getFile = async function(req, resp) {
	log.debug("Вызван метод getFile");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const body = req.body;

		const fileInfo = await getFileInfo(body.fileId);
		const {id, name, original_name, mimetype, path, size, created} = fileInfo;
		const fileContent = fs.readFileSync(`${path}`);

		const normalizedFile = new File(id, name, original_name, mimetype, path, size, fileContent, created);
		resp.json(createSuccessResponse(normalizedFile));
	}
	catch (err) {
		log.error("Ошибка при получении информации о файле", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getFileInfo(fileId) {
	log.debug(`Вызван метод getFileInfo`);

	const query = `
			SELECT id, name, original_name, mimetype, path, size, created
			FROM files
			WHERE id = $1;`;
	const params = [fileId];

	try {
		let result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получена информация о файле");
			log.trace(`result: ${JSON.stringify( result )}`);

			result = result[0];
			return result;
		}
		else {
			log.error("Получен пустой ответ с базы данных при получении информации о файле", null);
			return false;
		}
	}
	catch (err) {
		log.error("Ошибка при полученни информации о файле из БД", err);
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
