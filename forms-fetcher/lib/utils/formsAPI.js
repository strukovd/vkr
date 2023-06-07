const config = global.config;
const log = require(`../utils/log`);
const fetch = require('node-fetch');



exports.getFileListByFormKey = async function(formKey) {
	try {
		const body = {
			formKey: formKey
		};
		const response = await fetch("http://192.168.50.85:8080/api/getFileListByFormKey", {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(body)
		});

		let res;
		if(response.ok) {
			res = await response.json();
		}
		else {
			const code = response.status;
			// const text = await response.text();
			const errorMsg = `Получен отрицательный ответ. Код HTTP запроса: ${code}`;
			throw new Error( errorMsg );
		}

		return res;
	}
	catch (err) {
		log.error(`В методе getFileListByFormKey возникла ошибка!`, err);
		throw new Error(`В методе getFileListByFormKey возникла ошибка!`);
	}
};


exports.getFile = async function(fileId) {

	try {
		const body = {
			fileId: fileId
		};
		const response = await fetch("http://192.168.50.85:8080/api/getFile", {
			method: 'POST', // *GET, POST, PUT, DELETE, etc.
			// mode: 'cors', // no-cors, *cors, same-origin
			// cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
			// credentials: 'same-origin', // include, *same-origin, omit
			headers: {
				'Content-Type': 'application/json'
			},
			// redirect: 'follow', // manual, *follow, error
			// referrerPolicy: 'no-referrer', // no-referrer, *client
			body: JSON.stringify(body) // body data type must match "Content-Type" header
		});
		const res = await response.json(); // parses JSON response into native JavaScript objects

		return res;
	}
	catch (err) {
		log.error(`В методе getFile возникла ошибка!`, err);
		throw new Error(`В методе getFile возникла ошибка!`);
	}
};