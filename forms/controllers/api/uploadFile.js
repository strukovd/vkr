const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);



/**
 * Обработка загружаемого файла
 * @param {*} req
 * @param {*} resp
 */
exports.uploadFile = async function(req, resp) {
	log.debug("Вызван метод uploadFile");
	log.trace(`req.file: ${JSON.stringify(req.file)}`);

	const file = req.file;
	const formKey = req.body.formKey;
	/*
	file: {
		"fieldname":"file",
		"originalname":"2.png",
		"encoding":"7bit",
		"mimetype":"image/png",
		"destination":"storage/uploads/",
		"filename":"1d1d3d6cb442152b74e9bd9f9c31f6f6",
		"path":"storage/uploads/1d1d3d6cb442152b74e9bd9f9c31f6f6",
		"size":8793
	}
	*/
	try {

		// Записать файл в БД
		const pgRes = await pg.execSync(`INSERT INTO files
			(name, original_name, mimetype, path, size, form_key)
			VALUES ($1, $2, $3, $4, $5, $6)
			RETURNING id;`,
		[file.filename, file.originalname, file.mimetype, file.path, file.size, formKey]);

		if(pgRes && pgRes.length) {
			const response = {
				fileId: pgRes[0].id,
				fileName: file.filename,
				originalName: file.originalname,
				mimeType: file.mimetype,
				destination: file.destination,
				path: file.path,
				size: file.size
			};

			resp.json(createSuccessResponse(response));
		}
		else
			throw `Данные в БД не записаны!`;

	}
	catch (e) {
		log.error("Ошибка при загрузке файла", e);
		resp.json(createFailedResponse(e));
		//TODO Удалить файл из директории
		return;
	}
};


