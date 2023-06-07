const log = require('../../lib/utils/log');
const pg = require('../../lib/utils/pg');
const {createFailedResponse, createSuccessResponse} = require(`../../lib/helpers/createResponse`);


exports.getBuildingTypes = async function(req, resp) {
	log.debug("Вызван метод getBuildingTypes");
	log.info(`req.query: ${JSON.stringify(req.query)}`);

	try {
		const houseTypes = await getBuildingTypesFromDB();
		const normalizedHouseTypes = await normalizeBuildingTypes(houseTypes);

		resp.json(createSuccessResponse(normalizedHouseTypes));
	}
	catch (err) {
		log.error("Ошибка при получении справочника городов", err);
		resp.json(createFailedResponse(err));
		return;
	}
};


async function getBuildingTypesFromDB() {
	log.debug(`Вызван метод getBuildingTypesFromDB`);

	const query = `
			SELECT description AS name, uuid AS id
			FROM rng_types_house
			ORDER BY description;`;
	const params = [];

	try {
		const result = await pg.execSync(query, params);

		if (result) {
			log.debug("Получены типов домов из БД");
			log.trace(`result: ${JSON.stringify( result[0] )}`);

			return result;
		}
		else {
			log.warn("Получен пустой ответ с базы данных при получении типов домов");
			throw new Error("Получен пустой ответ с базы данных при получении типов домов");
		}
	}
	catch (err) {
		log.error("Ошибка при полученни данных с таблицы rng_address_classificator", err);
		log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
		throw new Error(err);
	}
}


async function normalizeBuildingTypes(houseTypes) {
	log.debug(`Вызван метод normalizeBuildingTypes`);
	log.trace(`houseTypes.length: ${houseTypes.length}`);

	try {
		let houseTypesNormalized = [];

		for (let houseType of houseTypes) {
			const normalizedHouseTypes = new HouseType(
				houseType.id,
				houseType.name
			);
			houseTypesNormalized.push(normalizedHouseTypes);
		}

		log.trace(`Нормализированный HouseType: ${JSON.stringify( houseTypesNormalized[0] )}`);
		return houseTypesNormalized;
	}
	catch (err) {
		log.error("Ошибка при нормализации типов домов", err);
		throw new Error(err);
	}
}


class HouseType {
	constructor(id, name) {
		this.id = String(id);
		this.name = String(name);
	}
}
