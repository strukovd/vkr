const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getDistricts = async function(req, resp) {
	log.debug("Вызван метод getDistricts");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const {regionId} = req.query;

		const districts = await getDistrictsFromDB(regionId);
		const normalizedDistricts = await normalizeDistricts(districts);

		resp.json(createSuccessResponse(normalizedDistricts));
	}
	catch (err) {
		log.error("Ошибка при получении справочника районов", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getDistrictsFromDB(regionId) {
	log.debug(`Вызван метод getDistrictsFromDB`);

	const query = `
			SELECT description AS name, uuid AS id
			FROM rng_address_classificator
			WHERE parentuuid = $1
			ORDER BY description;`;
	const params = [regionId];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены районы из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при получении районов");
			throw new Error("Получен пустой ответ с базы данных при получении районов");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни районов из БД", err);
		log.trace(`Запрос: ${query}, параметры: ${params}`);
		throw new Error(err);
	}
}


async function normalizeDistricts(districts) {
	log.debug(`Вызван метод normalizeDistricts`);
	log.trace(`districts.length: ${districts.length}`);

	try {
		let districtsNormalized = [];

		for (let district of districts) {
			const normalizedDistrict = new District(
				district.id,
				district.name
			);
			districtsNormalized.push(normalizedDistrict);
		}

		log.trace(`Нормализированный District: ${JSON.stringify( districtsNormalized[0] )}`);
		return districtsNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации районов", err);
		throw new Error(err);
	}
}


class District {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
