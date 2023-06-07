const moment = require(`moment`);
const fs = require(`fs`);
const path = require('path');
// TODO: add sqlite

/*
	КОМАНДЫ:
		LOGGER_RELOAD - Перезагрузить логер
		LOGGER_DEACTIVATE - Сбросить параметры логера (по учмолч. будет console-trace)
	Инициируемые события:
		LOGGER_DEACTIVATED - Логер сброшен
		LOGGER_LOADED - Логер успешно загрузился с указанными параметрами (параметры загрузки)
		LOGGER_RELOADED - Логер перезагружен


	КАК ОН РАБОТАЕТ?
		БЕЗ ИНИЦИАЛИЗАЦИИ:
			Методы логирования будут работать в консольном - trace режиме.
			Поскольку:
				При загрузке (require), инициализируются функции, и метод rec по умолч. использует sendToConsole,
				для логирования в консоль, по умолч. определен конфиг консольного логирования с уровнем trace.
		ИНИЦИАЛИЗАЦИЯ:
			При инициализации логер пытается загрузить переданные параметры режима логирования.
				РЕЖИМ ФАЙЛ:
					Открывает файл, сохраняет курсор, ставит таймер (смены файла в 24:00)
						Метод таймера: 1. Закр. файл, 2. Открывает новый, 3. Запускает новый таймер на след день.

	ФОРМАТ ФАЙЛА КОНФИГУРАЦИИ:
		
*/

const LEVEL = {
	ERROR: {COLORED_PREFIX: `\x1b[31m███`, PRIORITY: 5},
	WARN: {COLORED_PREFIX: `\x1b[33m███`, PRIORITY: 4},
	INFO: {COLORED_PREFIX: `\x1b[34m███`, PRIORITY: 3},
	DEBUG: {COLORED_PREFIX: `\x1b[92m███`, PRIORITY: 2},
	TRACE: {COLORED_PREFIX: `\x1b[37m███`, PRIORITY: 1}
};
const defaultSettings = { console: { level: "TRACE" } };
let localSettings = defaultSettings;
const fileOptions = {
	cursorToFile: null,
	timeoutId: null
};

// CONSOLE MODE

function determineLogLevel({trace, debug, info, warn, error, sysErr, refId}) {
	if(error || sysErr) {
		return "ERROR";
	}
	else if(warn) {
		return "WARN";
	}
	else if(info) {
		return "INFO";
	}
	else if(debug) {
		return "DEBUG";
	}
	else {
		return "TRACE";
	}
}

const sendToConsole = (msgObj, now) => {
	const {trace, debug, info, warn, error, sysErr, refId, logLevel} = msgObj;

	// Если лвл. лога не мешьше требуемого, отображаем все поля, иначе игнорим
	const requiredLevelPriority = LEVEL[ String(localSettings.console.level).toUpperCase() ]["PRIORITY"];
	const logLevelPriority = LEVEL[ logLevel ]["PRIORITY"];
	if(logLevelPriority >= requiredLevelPriority) {
		let msgContent = "";
		if(error) {
			msgContent += `\n${String(error)}`;
		}
		if(sysErr) {
			let details;
			if(sysErr.stack) {
				details = `${sysErr.stack}\nКод ошибки: ${sysErr.code}`;
			}
			else {
				details = JSON.stringify(sysErr);
			}
			msgContent += `\n${String(details)}`;
		}
		if(warn) {
			msgContent += `\n${String(warn)}`;
		}
		if(info) {
			msgContent += `\n${String(info)}`;
		}
		if(debug) {
			msgContent += `\n${String(debug)}`;
		}
		if(trace) {
			msgContent += `\n${String(trace)}`;
		}

		let endOfLog;
		if(refId) endOfLog = `\nrefId: ${refId}\x1b[0m`;
		else endOfLog = `\x1b[0m`;

		console.log(`${LEVEL[logLevel]["COLORED_PREFIX"]} ${now} ${logLevel}${msgContent}${endOfLog}`);
	}

	return;
};



// FILE MODE

function fileModeActivate() { // Вызывается 1 раз
	// Открываем курсор на файл
	fileOptions.cursorToFile = openFileCursor();

	// start Worker File Updater
	setTimeoutForUpdateFileAtMidnight();
	return true;
}

function fileModeDeactivate() {
	// Закр. курсора
	closeFileCursor();

	// Удаление таймера
	clearTimeout(fileOptions.timeoutId);
	return true;
}

function setTimeoutForUpdateFileAtMidnight() {
	// Высчитываем время до 00:00 - полуночи (до след. дня)
	const midnight = new Date();
	midnight.setHours(24);
	midnight.setMinutes(0);
	midnight.setSeconds(0);
	midnight.setMilliseconds(0);
	const msUntilMidnight = midnight.getTime() - new Date().getTime();

	// На след. день - запускаем обновление файла конфигурации
	fileOptions.timeoutId = setTimeout( refreshFileCursorByTimeout, msUntilMidnight );
}

function openFileCursor() {
	const today = moment().format("YYYY-MM-DD");
	const pathToDir = path.normalize(localSettings.file.dir);

	// Если нужной директории нет, создаем
	if (!fs.existsSync(pathToDir)){
		fs.mkdirSync(pathToDir, { recursive: true });
	}
	const pathToFile = `${pathToDir}/${today}.log`;
	exports.trace(pathToFile);

	// Создаем и открываем новый файл
	fileOptions.cursorToFile = fs.createWriteStream(pathToFile, {flags: `a+`, encoding:"utf8"});
	return fileOptions.cursorToFile;
}

function closeFileCursor() {
	// Закрываем старый курсор, если он открыт
	if(fileOptions.cursorToFile && fileOptions.cursorToFile instanceof fs.WriteStream) {
		fileOptions.cursorToFile.end("\n");
	}
}

function refreshFileCursorByTimeout() {
	closeFileCursor();
	fileOptions.cursorToFile = openFileCursor();

	// Запускаем другой таймер на след. день
	setTimeoutForUpdateFileAtMidnight();
}

const sendToFile = ({trace, debug, info, warn, error, sysErr, refId, logLevel}, now) => {
	const recToFile = {};

	// TODO: изменить логику определения уровно лога, что бы при error записывает и его trace тоже

	switch (localSettings.file.level) {
		case "trace":
			if(trace) {
				recToFile["trace"] = trace;
			}

		/*eslint no-fallthrough: "error"*/
		case "debug":
			if(debug) {
				recToFile["debug"] = debug;
			}

		/*eslint no-fallthrough: "error"*/
		case "info":
			if(info) {
				recToFile["info"] = info;
			}

		/*eslint no-fallthrough: "error"*/
		case "warn":
			if(warn) {
				recToFile["warn"] = warn;
			}

		/*eslint no-fallthrough: "error"*/
		case "error":

			if(error) {
				recToFile["error"] = error;
			}

			if(sysErr) {
				let details;
				if(sysErr.stack) {
					details = `${sysErr.stack}\nКод ошибки: ${sysErr.code}`;
				}
				else {
					details = JSON.stringify(sysErr);
				}
				recToFile["sysErr"] = details;
			}
	}

	const logString = `${now} [${refId||"-"}] ${JSON.stringify( recToFile )}\n`;

	// Если поля записи нужного уровня, записваем в файл
	if( Object.keys(recToFile).length ) {
		fileOptions.cursorToFile.write(logString);
	}
	return;
};




/**
 * @type {Rec}
 */
exports.rec = ({trace, debug, info, warn, error, sysErr, refId}) => {
	const now = moment().format("YYYY-MM-DD HH:mm:ss");
	const logLevel = determineLogLevel({trace, debug, info, warn, error, sysErr, refId});
	sendToConsole({trace, debug, info, warn, error, sysErr, refId, logLevel}, now);
};

exports.trace = (msg, refId) => {
	exports.rec({trace: msg, refId});
};

exports.debug = (msg, refId) => {
	exports.rec({debug: msg, refId});
};

exports.info = (msg, refId) => {
	exports.rec({info: msg, refId});
};

exports.warn = (msg, refId) => {
	exports.rec({warn: msg, refId});
};

exports.error = (msg, sysErr, refId) => {
	exports.rec({error: msg, sysErr, refId});
};




exports.init = function(settings) {
	// Инициализируем слушатели команд
	process.on("LOGGER_RELOAD", (params)=>{
		exports.reload(params);
	});

	process.on("LOGGER_DEACTIVATE", ()=>{
		exports.reset();
	});


	localSettings = settings;
	load();
};


function load() {
	let bodyOfHandler = `const now = moment().format("YYYY-MM-DD HH:mm:ss");`;

	if(Array.isArray(localSettings.modes)) {
		for (const logMode of localSettings.modes) {
			switch ( String(logMode) ) {
				case "console":
					exports.info(`Активирован режим логирования - console`);
					bodyOfHandler += `sendToConsole(msg, now);\n`;
					break;
				case "file":
					{
						const fileModeActivated = fileModeActivate(); // В полночь обновляет лог-файл
						if ( fileModeActivated ) {
							exports.info(`Активирован режим логирования - file`);
							bodyOfHandler += `sendToFile(msg, now);`;
						}
					}
					break;
				default:
					throw new Error(`${String(logMode)} - неопределенный режим логирования!`);
			}
		}

		delete exports.rec;
		exports.rec = eval(`(msg)=>{ ${bodyOfHandler} }`);
	}
	else {
		throw new Error(`Не корректное значение конфигурационного поля log.modes`);
	}

	process.emit("LOGGER_LOADED", localSettings);
}



exports.reload = async function(settings) { // Вызывается при обновлении конфига
	exports.reset();

	try {
		// TODO: Передавать новый конфиг как параметр в метод loadи если загрузка произошла успешно, сохранять новый конфиг в переменную localConfig,
		// Иначе, загрузиться со старым конфигом из localSettings
		localSettings = settings;
		load();
	}
	catch (err) {
		// Если конф. файл будет изменен во время работы сервиса,
		// и конф. будет не корретна, не допустима полная остановка
		// сервиса, поэтому, эта функция будет ставить значения
		// логирования по умолчанию
		localSettings = defaultSettings;
		load();
		exports.error("Перезагрузка модуля логирования провалилась! Параметры логирования применены по умолчанию.", err, null);
	}

	process.emit("LOGGER_RELOADED", {});
};

const defaultRecHandler = exports.rec;

exports.reset = function() {
	// Этот метод вызывается при остановке сервиса, необходимо позакрывать все внешние ссылки/курсоры
	fileModeDeactivate();
	exports.rec = defaultRecHandler;

	process.emit("LOGGER_DEACTIVATED", {});
};







/**
 * @callback Rec
 * @param {MsgObj} Msgs
 */
/**
 * @typedef {Object} MsgObj
 * @property {String} trace
 * @property {String} debug
 * @property {String} info
 * @property {String} warn
 * @property {String} error
 * @property {Object<Error>} sysErr
 * @property {String} refId
 */





// exports.green = function(msg, data) {
// 	console.log(`\x1b[42m\x1b[30m███ ${exports.rec("green", msg, data)}\x1b[0m`);
// };

// exports.cyan = (msg, refId) => {
// 	console.log(`\x1b[36m███ ${exports.rec("cyan", msg, refId)}\x1b[0m`);
// };

// exports.whisper = (msg, refId) => {
// 	console.log(`\x1b[90m███ ${exports.rec("whisper", msg, refId)}\x1b[0m`);
// };

// exports.magenta = (msg, refId) => {
// 	console.log(`\x1b[35m███ ${exports.rec("magenta", msg, refId)}\x1b[0m`);
// };