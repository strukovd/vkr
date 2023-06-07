const express = require('express');
const app = express();

global.fullStoragePath = `./storage`;

const config = global.config = require(`${global.fullStoragePath}/config.json`);
const bodyParser = require("body-parser");
const router = require('./router/router');

const statusChanger = require('./lib/workers/checkForms');


async function main() {
	// Инициализируем express
	// app.use(bodyParser.urlencoded({ extended: false }));
	// app.use(bodyParser.json());
	// router.init(app);


	// Инициируем старт воркеров
	statusChanger.start();


	app.listen(config.port, () => {
		console.log(`Сервис запущен по адресу: http://localhost:${config.port}`);
	});
}



main();