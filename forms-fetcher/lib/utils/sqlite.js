/* lastUpdate: 13.03.2021 */
// const config = require(`${global.fullStoragePath}/config.json`);
const config = global.config;
const { createSuccessResponse, createFailedResponse } = require('../helpers/createResponse');
const log = require(`../utils/log`);
const sqlite3 = require('sqlite3').verbose();

let db = null;



exports.init = async function() {

	if(!config.sqlite.enabled) {
		return;
	}

	db = new sqlite3.Database( config.sqlite.path, (err) => {
		if (err) {
			log.error(`Ошибка при подключении к SQLite \nПуть к файлу: ${config.sqlite.path}`, err);
			return;
		}
		log.debug('Успешное подключение к SQlite');
	});

	await createTables();
	return;

};





async function createTables() {

	if(!config.sqlite.enabled) return;

	const createQueries = [
		`CREATE TABLE IF NOT EXISTS logs
		(
			id			INTEGER PRIMARY KEY AUTOINCREMENT,
			type		TEXT,
			desc		TEXT,
			refId		TEXT,
			created		DATETIME NOT NULL DEFAULT (datetime('now', 'localtime'))
		);`,


		`CREATE TABLE IF NOT EXISTS tasks
		(
			id			INTEGER PRIMARY KEY AUTOINCREMENT,
			task_name	TEXT,
			json_data	TEXT,
			is_valid	INTEGER DEFAULT 1,
			created		DATETIME NOT NULL DEFAULT (datetime('now', 'localtime'))
		);`,

		// ifsdocs-post.csv
		`CREATE TABLE IF NOT EXISTS posts
		(
			id			INTEGER NOT NULL
					PRIMARY KEY,
			name		TEXT
		);`,

		// ifsdocs-user.csv
		`CREATE TABLE IF NOT EXISTS users
		(
			id			INTEGER not null
					PRIMARY KEY,
			surname			TEXT,
			name			TEXT,
			fname			TEXT,
			date_of_receipt	DATE,
			date_of_dismissal	DATE,
			isHead			INTEGER,
			position_id	INTEGER,
			department_id	INTEGER,
			order_number	TEXT,
			transfer_date	DATE
		);`,

		// ifsdocs-ad.csv
		`CREATE TABLE IF NOT EXISTS users_info
		(
			id			INTEGER not null
					PRIMARY KEY,
			login			TEXT,
			display_name	TEXT,
			surname			TEXT,
			name			TEXT,
			email			TEXT,
			other_id		INTEGER
		);`,

		// ifsdocs-office.csv.
		`CREATE TABLE IF NOT EXISTS departments
		(
			id					INTEGER not null
					PRIMARY KEY,
			name				TEXT,
			parent_id			INTEGER,
			opening_date		TEXT,
			closing_date		TEXT,
			department_index	TEXT
		);`
	];


	for (const query of createQueries) {
		const created = new Promise( (resolve, reject) => {
			db.run(query, [], function(err) {
				if(err) {
					log.error(`Ошибка при попытке создать таблицу. Запрос: ${query}`, err);
					reject(err);
				}
				resolve(`Done!`);
			});
		});

		await created;
	}

}



exports.select = function (query, params) {
	return new Promise((resolve, reject) => {

		db.all(query, params, (error, rows) => {
			if (error) {
				log.error("При попытке получения данных из SQLite возникла ошибка!", error);
				log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
				reject(error);
			}
			else {
				// log.info(`Данные получены: ${rows}`);
				resolve(rows);
			}
		});
	});
};





exports.insert = async function (query, params) {
	if(!config.sqlite.enabled) return;

	const inserted = new Promise( (resolve, reject) => {
		db.run(query, params, function(err) {
			if(err) {
				log.error(`Ошибка в методе insert. ${err}`);
				log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
				reject(err);
			}
			resolve(`Done!`);

			// log.info(`Осуществляется добавление!`);
			// log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
		});
	});

	await inserted;
};


exports.update = async function(query, params) {
	if(!config.sqlite.enabled) return;

	const updated = new Promise( (resolve, reject) => {
		db.run(query, params, function(err){
			if(err) {
				log.error(`Ошибка в методе update. ${err}`);
				log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
				reject(err);
			}
			resolve(`Done!`);

			// log.info(`Осуществляется обновление!`);
			// log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
		});
	});

	await updated;
};


exports.delete = async function(query, params) {
	if(!config.sqlite.enabled) return;

	const deleted = new Promise( (resolve, reject) => {
		db.run(query, params, function(err){
			if(err) {
				log.error(`Ошибка в методе delete. ${err}`);
				log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
				reject(err);
			}
			resolve(`Done!`);

			// log.info(`Осуществляется удаление!`);
			// log.trace(`Запрос: ${query}, параметры: ${JSON.stringify(params)}`);
		});
	});

	await deleted;
};

