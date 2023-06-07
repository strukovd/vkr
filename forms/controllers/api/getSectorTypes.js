const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getSectorTypes = async function(req, resp) {
	log.debug("Вызван метод getSectorTypes");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const sectorTypes = await getSectorTypesFromDB();
		const normalizedSectorTypes = await normalizeSectorTypes(sectorTypes);

		resp.json(createSuccessResponse(normalizedSectorTypes));
	}
	catch (err) {
		log.error("Ошибка при получении справочника городов", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getSectorTypesFromDB() {
	log.debug(`Вызван метод getSectorTypesFromDB`);

	const query = `
			SELECT description AS name, uuid AS id
			FROM rng_types_sector
			ORDER BY description;`;
	const params = [];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены типов секторов из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при получении типов секторов");
			throw new Error("Получен пустой ответ с базы данных при получении типов секторов");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни данных с таблицы rng_types_sector", err);
		log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
		throw new Error(err);
	}
}


async function normalizeSectorTypes(sectorTypes) {
	log.debug(`Вызван метод normalizeSectorTypes`);
	log.trace(`sectorTypes.length: ${sectorTypes.length}`);

	try {
		let sectorTypesNormalized = [];

		for (let sectorType of sectorTypes) {
			const normalizedSectorTypes = new SectorType(
				sectorType.id,
				sectorType.name
			);
			sectorTypesNormalized.push(normalizedSectorTypes);
		}

		log.trace(`Нормализированный SectorType: ${JSON.stringify( sectorTypesNormalized[0] )}`);
		return sectorTypesNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации типов секторов", err);
		throw new Error(err);
	}
}


class SectorType {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
