let { Pool } = require('pg');
const config = global.config;
const log = require(`../utils/log`);


const pgconf = {
	host: config.pg.host,
	port: config.pg.port,
	user: config.pg.user,
	password: config.pg.password,
	database: config.pg.database
};



exports.getConnection = async function() {
	return new Promise(async (resolve, reject) => {
		try {
			let pool = new Pool(pgconf);
			const client = await pool.connect();

			resolve(client);
		}
		catch (error) {
			reject(error);
		}
	});
};



/**
 * @param {String} query Запрос
 * @returns {Array} Массив релевантных строк
 */
exports.execSync = async function(query, params) {
	try {
		const pool = await new Pool(pgconf);
		const client = await pool.connect();
		const result = await client.query(query, params);
		client.end();
		return result.rows;
	}
	catch (error) {
		log.error(`Postgres: При попытке выполнить запрос произошла ошибка!`, error);
		log.trace(`Запрос: ${query}`);
		log.trace(`Памаметры: ${JSON.stringify(params)}`);
	}
};