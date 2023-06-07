const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getPassportSeries = async function(req, resp) {
	log.debug("Вызван метод getPassportSeries");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const passportSeries = await getPassportSeriesFromDB();
		const normalizedPassportSeries = await normalizegetPassportSeries(passportSeries);

		resp.json(createSuccessResponse(normalizedPassportSeries));
	}
	catch (err) {
		log.error("Ошибка при получении справочника серия паспорта", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getPassportSeriesFromDB() {
	log.debug(`Вызван метод getPassportSeriesFromDB`);

	const query = `
		SELECT description AS name, uuid AS id
		FROM rng_document_types
		ORDER BY description;`;
	const params = [];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены серии паспортов из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при получении серии паспортов");
			throw new Error("Получен пустой ответ с базы дан ных при получении серии паспортов");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни данных с таблицы rng_document_types", err);
		log.trace(`Запрос: ${query}, параметры: ${params}`);
		throw new Error(err);
	}
}


async function normalizegetPassportSeries(passportSeries) {
	log.debug(`Вызван метод normalizegetPassportSeries`);
	log.trace(`passportSeries.length: ${passportSeries.length}`);

	try {
		let passportSeriesNormalized = [];

		for (let passportSeria of passportSeries) {
			const normalizedPassportSeries = new PassportSeries(
				passportSeria.id,
				passportSeria.name
			);
			passportSeriesNormalized.push(normalizedPassportSeries);
		}

		log.trace(`Нормализированный passportSeries: ${JSON.stringify( passportSeriesNormalized[0] )}`);
		return passportSeriesNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации серии паспотра", err);
		throw new Error(err);
	}
}


class PassportSeries {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
