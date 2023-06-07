const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getRegions = async function(req, resp) {
	log.debug("Вызван метод getRegions");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const regions = await getRegionsFromDB();
		const normalizedRegions = await normalizeRegions(regions);

		resp.json(createSuccessResponse(normalizedRegions));
	}
	catch (err) {
		log.error("Ошибка при получении справочника городов", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getRegionsFromDB() {
	log.debug(`Вызван метод getRegionsFromDB`);

	const query = `
			SELECT description AS name, uuid AS id
			FROM rng_address_classificator
			WHERE parentidrref = '0x00000000000000000000000000000000'
			ORDER BY description;`;
	const params = [];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены регионы из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при получении регионов");
			throw new Error("Получен пустой ответ с базы данных при получении регионов");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни данных с таблицы rng_address_classificator", err);
		log.trace(`Запрос: ${query}, параметры: ${params}`);
		throw new Error(err);
	}
}


async function normalizeRegions(regions) {
	log.debug(`Вызван метод normalizeRegions`);
	log.trace(`regions.length: ${regions.length}`);

	try {
		let regionsNormalized = [];

		for (let region of regions) {
			const normalizedRegion = new Region(
				region.id,
				region.name
			);
			regionsNormalized.push(normalizedRegion);
		}

		log.trace(`Нормализированный Region: ${JSON.stringify( regionsNormalized[0] )}`);
		return regionsNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации регионов", err);
		throw new Error(err);
	}
}


class Region {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
