const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getCities = async function(req, resp) {
	log.debug("Вызван метод getCities");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const {districtId} = req.query;

		const cities = await getCitiesFromDB(districtId);
		const normalizedCities = await normalizeCities(cities);

		resp.json(createSuccessResponse(normalizedCities));
	}
	catch (err) {
		log.error("Ошибка при получении справочника городов", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getCitiesFromDB(districtId) {
	log.debug(`Вызван метод getCitiesFromDB`);

	const query = `
		SELECT description AS name, uuid AS id
		FROM rng_address_classificator
		WHERE
			parentuuid = $1 AND
			fld552 = '6'
		ORDER BY description;`;
	const params = [districtId];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены города из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при городов");
			throw new Error("Получен пустой ответ с базы данных при городов");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни данных с таблицы directory_cities", err);
		log.trace(`Запрос: ${query}, параметры: ${params}`);
		throw new Error(err);
	}
}


async function normalizeCities(cities) {
	log.debug(`Вызван метод normalizeCities`);
	log.trace(`cities.length: ${cities.length}`);

	try {
		let citiesNormalized = [];

		for (let city of cities) {
			const normalizedCity = new City(
				city.id,
				city.name
			);
			citiesNormalized.push(normalizedCity);
		}

		log.trace(`Нормализированный City: ${JSON.stringify( citiesNormalized[0] )}`);
		return citiesNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации данных с таблицы directory_cities", err);
		throw new Error(err);
	}
}


class City {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
