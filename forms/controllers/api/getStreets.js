const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getStreets = async function(req, resp) {
	log.debug("Вызван метод getStreets");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const {cityIdORDistrictId} = req.query;

		const streets = await getStreetsFromDB(cityIdORDistrictId);
		const normalizedCities = await normalizeStreets(streets);

		resp.json(createSuccessResponse(normalizedCities));
	}
	catch (err) {
		log.error("Ошибка при получении справочника городов", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getStreetsFromDB(cityIdORDistrictId) {
	log.debug(`Вызван метод getStreetsFromDB`);

	const query = `
		SELECT description AS name, uuid AS id
		FROM rng_address_classificator
		WHERE parentuuid = $1
		AND fld552 = 7
		ORDER BY description;`;
	const params = [cityIdORDistrictId];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены улицы из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при улиц");
			throw new Error("Получен пустой ответ с базы данных при улиц");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни данных с таблицы directory_streets", err);
		log.trace(`Запрос: ${query}, параметры: ${params}`);
		throw new Error(err);
	}
}


async function normalizeStreets(streets) {
	log.debug(`Вызван метод normalizeStreets`);
	log.trace(`cities.length: ${streets.length}`);

	try {
		let streetsNormalized = [];

		for (let street of streets) {
			const normalizedStreet = new Street(
				street.id,
				street.name
			);
			streetsNormalized.push(normalizedStreet);
		}

		log.trace(`Нормализированный Street: ${JSON.stringify( streetsNormalized[0] )}`);
		return streetsNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации данных с таблицы directory_streets", err);
		throw new Error(err);
	}
}


class Street {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
