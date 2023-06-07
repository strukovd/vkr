// const sqlite = require(`./sqlite`);
// const config = global.config;

/**
 * @param {String} msg
 * @param {LogDetails} data
 */
function handleLogParams(type, msg, data) {
	if(typeof msg !== "string") {
		console.log(`\x1b[31m███ В функции handleLogParams возникла ошибка. Тип лога: ${type} Параметр msg не является строкой! Его тип: ${typeof msg}\x1b[0m`);
		// throw new Error(`В функции handleLogParams возникла ошибка. Параметр msg не является строкой! Его тип: ${typeof msg}`);
	}

	let res = msg;

	if(typeof data == "object") {
		if(data.refId) {
			res = `${res}\nRefId: ${data.refId}`;
		}

		// if(data.save && config.sqlite.enabled) {
		// 	// Отправляем лог в sqlite
		// 	sqlite.insert(`INSERT INTO logs (type, desc, refId) VALUES (?, ?, ?)`, [type, msg, data.refId]);
		// }
	}
	else {
		if(typeof data == "string") {
			res = `${res}\nRefId: ${data}`;
		}
	}

	return res;
}


/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.green = function(msg, data) {
	console.log(`\x1b[42m\x1b[30m███ ${handleLogParams("green", msg, data)}\x1b[0m`);
};


/**
 * @param {String} msg
 * @param {String} sysErr
 * @param {LogDetails} data
 */
exports.error = function(msg, sysErr, data) {
	console.log(`\x1b[31m███ ${handleLogParams("error", msg, data)}\x1b[0m`);
	if(sysErr) {
		let details;
		if(sysErr.stack) {
			details = `${sysErr.stack}\nКод ошибки: ${sysErr.code}`;
		}
		else {
			details = JSON.stringify(sysErr);
		}

		console.log(`\x1b[31m${details}\x1b[0m`);
	}
};


/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.trace = function(msg, data) {
	console.log(`\x1b[37m███ ${handleLogParams("trace", msg, data)}\x1b[0m`);
};


/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.warn = function(msg, data) {
	console.log(`\x1b[33m███ ${handleLogParams("warn", msg, data)}\x1b[0m`);
};


/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.debug = function(msg, data) {
	console.log(`\x1b[92m███ ${handleLogParams("debug", msg, data)}\x1b[0m`);
};



/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.cyan = function(msg, data) {
	console.log(`\x1b[36m███ ${handleLogParams("cyan", msg, data)}\x1b[0m`);
};




/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.magenta = function(msg, data) {
	console.log(`\x1b[35m███ ${handleLogParams("magenta", msg, data)}\x1b[0m`);
};




/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.info = function(msg, data) {
	//\x1b[34m
	console.log(`\x1b[36m███ ${handleLogParams("info", msg, data)}\x1b[0m`);
};




/**
 * @param {String} msg
 * @param {LogDetails} data
 */
exports.whisper = function(msg, data) {
	console.log(`\x1b[90m███ ${handleLogParams("whisper", msg, data)}\x1b[0m`);
};





/**
 * @typedef {Object} LogDetails
 * @property {String} refId
 * @property {Boolean} save записать лог в реестр sqlite
 */