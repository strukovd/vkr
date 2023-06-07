const config = global.config;
const log = require(`./log`);
const fs = require('fs');
const fetch = require('node-fetch');
const https = require('https');
const FormData = require('form-data');
const {createFailedResponse, createSuccessResponse} = require(`../helpers/createResponse`);

exports.jiraConfigName = "jira";
const setBaseAuth = (user, pass) => { return "Basic " + Buffer.from(user + ':' + pass).toString('base64'); };
const getBaseToken = () => { return setBaseAuth(config.jira.user, config.jira.password); };

// const httpsAgent = new https.Agent({
// 	rejectUnauthorized: false
// });
const httpsAgent = undefined;





async function sendGetRequest(queries, refId) {
	log.rec({
		debug: "Вызван метод sendGetRequest",
		trace: `queries: ${queries}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}${queries}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return data;
		}
		else {
			log.error(`JiraAPI - метод sendGetRequest: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод sendGetRequest: При попытке поиска в жире возникла ошибка.`, e);
		log.trace(`Url: ${config.jira.latestRestUrl}, Запрос: ${queries}`, refId);
		throw e;
	}
}




exports.getUserActivityHistory = async function (queryParams, refId) {
	log.rec({
		debug: "Вызван метод getUserActivityHistory",
		trace: `queryParams: ${queryParams}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.url + queryParams}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira отправлен запрос на получение активности (истории)`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getUserActivityHistory: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getUserActivityHistory: При попытке поиска активности (истории) в жире возникла ошибка.`, e);
		log.trace(`Url: ${config.jira.url}, Запрос: ${queryParams}`, refId);
		throw e;
	}
};



/**
 * @param {String} account лицевой счет
 * @param {Array} fields массив необходимых полей
 * @param {String} refId
 */
exports.findIssueByAccount = async function(account, fields, refId) {
	log.rec({
		debug: "Вызван метод findIssueByAccount",
		trace: `account: ${account}, fields: ${JSON.stringify(fields)}`,
		refId
	});

	try {
		if(fields instanceof Array && fields.length) {
			fields = `&${fields.toString()}`;
		}
		else {
			fields = '';
		}

		const query = `search?jql=project=CL AND "Лицевой счёт"~"${account}"${fields}`;
		let res = await sendGetRequest(query, refId);
		res = JSON.parse(res);
		return createSuccessResponse(res);
	}
	catch (e) {
		log.error(`JiraAPI - метод findIssueByAccount: При попытке найти задачу, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.findIssueByRngID = async function(rngID, refId) {
	log.rec({
		debug: "Вызван метод findIssueByRngID",
		trace: `key: ${JSON.stringify(rngID)}`,
		refId
	});

	try {
		const query = `search?jql=rngid~"${rngID}"&fields=customfield_12401`;
		let res = await sendGetRequest(query, refId);

		res = JSON.parse(res);
		return createSuccessResponse(res);
	}
	catch (e) {
		log.error(`JiraAPI - метод findIssueByRngID: При попытке найти задачу, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.search = async function(queryParamsString, refId) {
	log.rec({
		debug: "Вызван метод search",
		trace: `queryParamsString: ${JSON.stringify(queryParamsString)}`,
		refId
	});

	try {
		const query = `search?${queryParamsString}`;

		let res = await sendGetRequest(query, refId);
		if(res) {
			log.rec({
				debug: "Получен ответ на зпрос поиска в Jira",
				trace: `res: ${res}`,
				refId
			});

			res = JSON.parse(res);
			return createSuccessResponse(res);
		}
		else {
			return createFailedResponse( new Error("Данные с JiraRestApi не получены!") );
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод search: Во время поиска возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.getIssue = async function(key, refId){
	log.rec({
		debug: "Вызван метод getIssue",
		trace: `key: ${JSON.stringify(key)}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl + 'issue/' + key}`);
		const method = 'GET';

		const options = {
			method: method,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			},
			agent: httpsAgent
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getIssue: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getIssue: При попытке получить задачу, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



/**
 * @param {JiraCreateIssueFormat} body
 */
exports.createIssue = async function(body, refId) {
	log.rec({
		debug: "Вызван метод createIssue",
		trace: `body: ${JSON.stringify(body)}`,
		refId
	});

	try {
		if(body.fields.customfield_12401) {
			const issue = await exports.findIssueByRngID(body.fields.customfield_12401);
			if(issue.success) {
				const foundIssue = issue.data;
				if(foundIssue.total > 0) { // Если задача с таким rngid уже существует
					return createFailedResponse(`Задача с rngid: ${body.fields.customfield_12401} уже существует!`);
				}
			}
			else {
				return createFailedResponse(`Не удалось проверить существование задачи с rngid ${body.fields.customfield_12401}`);
			}
		}


		const url = encodeURI(`${config.jira.latestRestUrl + 'issue/'}`);
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод createIssue: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (err) {
		log.error(`JiraAPI - метод createIssue: При попытке создать задачу, возникла ошибка!`, err);
		return createFailedResponse(err);
	}
};



/**
 * @param {String} issueIdOrKey код проекта (CL-0000)
 * @param {String} editMeta
 * @param {JiraUpdateIssueFormat} body
 */
exports.updateIssue = async function(issueIdOrKey, editMeta, body, refId) {
	log.rec({
		debug: "Вызван метод updateIssue",
		trace: `issueIdOrKey: ${issueIdOrKey}, body: ${JSON.stringify(body)}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl + 'issue/' + issueIdOrKey + '/' + editMeta}`;
		const method = 'PUT';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод updateIssue: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод updateIssue: При попытке обновить задачу, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.deleteIssue = async function(issueIdOrKey, refId) {
	log.rec({
		debug: "Вызван метод deleteIssue",
		trace: `issueIdOrKey: ${issueIdOrKey}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issue/${issueIdOrKey}?deleteSubtasks`);
		const method = 'DELETE';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод deleteIssue: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод deleteIssue: При попытке удалить задачу, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};


exports.changeAssignee = async function(issueIdOrKey, assigneName, refId) {
	log.rec({
		debug: "Вызван метод changeAssignee",
		trace: `issueIdOrKey: ${issueIdOrKey}, assigneName: ${assigneName}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}issue/${issueIdOrKey}/assignee`;
		const method = 'PUT';
		const body = {
			name: assigneName
		};

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод changeAssignee: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод changeAssignee: При попытке изменить исполнителя возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




/**
 * @param {String} issueIdOrKey ключ задачи
 * @param {String|Buffer} file файл или путь к файлу
 * @param {String} fileName назначаемое в жире имя файла
 * @param {String} refId
 */
exports.attachFile = async function(issueIdOrKey, file, fileName, refId) {
	log.rec({
		debug: "Вызван метод attachFile",
		trace: `issueIdOrKey: ${issueIdOrKey}, file: ${file}, fileName: ${fileName}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issue/${issueIdOrKey}/attachments`);
		const method = 'POST';

		const form = new FormData();

		if(typeof file == "string") {
			form.append("file", fs.createReadStream(file), {
				filename: fileName,
				contentType: null
			});
		}
		else if (file instanceof Buffer) {
			form.append("file", file, {
				filename: fileName,
				contentType: null
			});
		}

		const formHeaders = form.getHeaders();

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "nocheck",
				...formHeaders
			},
			body: form
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();

			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод attachFile: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод attachFile: При попытке подвязать файл, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.getAttachment = async function(id, refId) {
	log.rec({
		debug: "Вызван метод getAttachment",
		trace: `id: ${id}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}attachment/${id}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getAttachment: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getAttachment: При попытке получить описание закрепленного файла возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.removeAttachment = async function(attachmentId, refId) {
	log.rec({
		debug: "Вызван метод removeAttachment",
		trace: `attachmentId: ${attachmentId}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}attachment/${attachmentId}`);
		const method = 'DELETE';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод removeAttachment: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (err) {
		log.error(`JiraAPI - метод removeAttachment: При попытке удалить закрепленный файл возникла ошибка!`, err);
		return createFailedResponse(err);
	}
};



exports.getComments = async function(issueIdOrKey, refId) {
	log.rec({
		debug: "Вызван метод getComments",
		trace: `issueIdOrKey: ${issueIdOrKey}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issue/${issueIdOrKey}/comment`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getComments: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getComments: При попытке получить список комментариев возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.addComment = async function(issueIdOrKey, comment, refId) {
	log.rec({
		debug: "Вызван метод addComment",
		trace: `issueIdOrKey: ${issueIdOrKey}, comment: ${comment}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}issue/${issueIdOrKey}/comment`;
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify({ body: comment })
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод addComment: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод addComment: При попытке добавить комментарий к задаче, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.deleteComment = async function(issueIdOrKey, commentId, refId) {
	log.rec({
		debug: "Вызван метод deleteComment",
		trace: `issueIdOrKey: ${issueIdOrKey}, commentId: ${commentId}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}issue/${issueIdOrKey}/comment/${commentId}`;
		const method = 'DELETE';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод deleteComment: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод deleteComment: При попытке удалить комментарий в задаче возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.updateComment = async function(issueIdOrKey, commentId, text, refId) {
	log.rec({
		debug: "Вызван метод updateComment",
		trace: `issueIdOrKey: ${issueIdOrKey}, commentId: ${commentId}, text: ${text}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}issue/${issueIdOrKey}/comment/${commentId}`;
		const method = 'PUT';
		const body = {
			body: text
		};

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok) {
			let data;
			switch (res.status) {
				case 200:
					data = await res.json();
					break;
				default:
					data = await res.text();
					break;
			}

			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод updateComment: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод updateComment: При попытке отредактировать комментарий возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



/**
 * Функция добавления поля к учетке пользователя
 * @param {String} username пользователя к которому добавляется поле (login)
 * @param {String} propName имя добавляемого свойства
 * @param {String} propValue JSON или скалярное значение
 */
exports.setUserProp = async function(username, propName, propValue, refId) {
	log.rec({
		debug: `Вызван метод setUserProp`,
		trace: `username: ${username}, propName: ${propName}, propValue: ${propValue}`
	});

	try {
		const url = `${config.jira.latestRestUrl}user/properties/${propName}?username=${username}`;
		const method = 'PUT';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(propValue)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод setUserProp: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод setUserProp: При попытке добавить поле к учетке пользователя, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};






/**
 * Функция добавления поля к учетке пользователя
 * @param {String} username пользователя к которому добавляется поле (login)
 * @param {String} propName имя добавляемого свойства
 * @param {String} propValue JSON или скалярное значение
 * @returns
 */
exports.getUserProp = async function(username, propName, refId) {
	log.rec({
		debug: `Вызван метод getUserProp`,
		trace: `username: ${username}, propName: ${propName}`
	});

	try {
		const url = `${config.jira.latestRestUrl}user/properties/${propName}?username=${username}`;
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getUserProp: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getUserProp: При попытке получить данные пользовательского поля возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.searchIssues = async function(jql, offset, limit, refId) {
	log.rec({
		debug: "Вызван метод searchIssues",
		trace: `jql: ${jql}, offset: ${offset}, limit: ${limit}`,
		refId
	});

	const fields = "fields=lastViewed,summary,updated,created,creator,status";

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}search?jql=${jql}&${fields}&startAt=${offset}&maxResults=${limit}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.rec({
				debug: "Получен спиосок задач",
				trace: `jql: ${jql}, res: ${res}`
			});

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод searchIssues: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод searchIssues: При попытке получить список задач возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.getIssues = async function(jql, offset, limit, refId) {
	log.rec({
		debug: "Вызван метод getIssues",
		trace: `jql: ${jql}, offset: ${offset}, limit: ${limit}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}search?jql=${jql}&fields=lastViewed,summary,updated,created,creator,status&startAt=${offset}&maxResults=${limit}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.rec({
				debug: "Получен спиосок задач",
				trace: `jql: ${jql}, res: ${res}`
			});

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getIssues: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getIssues: При попытке получить список задач возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.getIssuesByAssigneed = async function(assigneedKey, offset, limit, refId) {
	log.rec({
		debug: "Вызван метод getIssuesByAssigneed",
		trace: `assigneedKey: ${assigneedKey}, offset: ${offset}, limit: ${limit}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}search?jql=assignee="${assigneedKey}"&fields=lastViewed,summary,updated,created,creator,status&startAt=${offset}&maxResults=${limit}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.rec({
				debug: "Получен спиосок задач для исполнителя",
				trace: `assigneedKey: ${assigneedKey}, res: ${res}`
			});

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getIssuesByAssigneed: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getIssuesByAssigneed: При попытке получить список задач возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};






exports.getListOfIssueType = async function(refId) {
	log.rec({
		debug: "Вызван метод getListOfIssueType",
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetype`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен общий спиосок "типов задач"`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getListOfIssueType: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getListOfIssueType: При попытке получить общий список "типов задач" возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.createIssueTypeScheme = async function(body, refId) {
	log.rec({
		debug: "Вызван метод createIssueTypeScheme",
		trace: `body: ${JSON.stringify(body)}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl + 'issuetypescheme'}`);
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод createIssueTypeScheme: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (err) {
		log.error(`JiraAPI - метод createIssueTypeScheme: При попытке создать схему типов задач, возникла ошибка!`, err);
		return createFailedResponse(err);
	}
};




exports.updateIssueTypeScheme = async function(schemeId, body, refId) {
	log.rec({
		debug: "Вызван метод updateIssueTypeScheme",
		trace: `body: ${JSON.stringify(body)}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetypescheme/${schemeId}`);
		const method = 'PUT';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод updateIssueTypeScheme: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (err) {
		log.error(`JiraAPI - метод updateIssueTypeScheme: При попытке обновить схему типов задач, возникла ошибка!`, err);
		return createFailedResponse(err);
	}
};




exports.addProjectAssociationsToScheme = async function(schemeId, arrIdsOrKeysOfPoject, refId) {
	log.rec({
		debug: "Вызван метод addProjectAssociationsToScheme",
		trace: `idsOrKeysOfPoject: ${JSON.stringify(arrIdsOrKeysOfPoject)}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetypescheme/${schemeId}/associations`);
		const method = 'POST';
		const body = {
			idsOrKeys: arrIdsOrKeysOfPoject
		};

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify(body)
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод addProjectAssociationsToScheme: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (err) {
		log.error(`JiraAPI - метод addProjectAssociationsToScheme: При попытке добавить ассоциацию схемы типов задач к проекту, возникла ошибка!`, err);
		return createFailedResponse(err);
	}
};





/**
 * Получает ассоциации (содержимое) схемы "типа задачи"
 * @param {Number} issueTypeSchemeId номер схемы "типов задач"
 * @param {String} refId
 * @returns {Array<Object>} Массив проектов к которым применена данная схема "типов задач"
 */
exports.getProjectsOfIssueTypeScheme = async function(issueTypeSchemeId, refId) {
	log.rec({
		debug: "Вызван метод getProjectsOfIssueTypeScheme",
		trace: `issueTypeSchemeId: ${issueTypeSchemeId}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetypescheme/${issueTypeSchemeId}/associations`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен массив проектов ассоциированных с данной схемой "типов задач"`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getProjectsOfIssueTypeScheme: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getProjectsOfIssueTypeScheme: При попытке получить ассоциации для схемы "типов задач" возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.getListOfIssueTypeScheme = async function(refId) {
	log.rec({
		debug: "Вызван метод getListOfIssueTypeScheme",
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetypescheme`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен массив схем "типов задач"`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getListOfIssueTypeScheme: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getListOfIssueTypeScheme: При попытке получить список схем "типов задач" возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.deleteIssueTypeSchemeById = async function(schemeId, refId) {
	log.rec({
		debug: "Вызван метод deleteIssueTypeSchemeById",
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetypescheme/${schemeId}`);
		const method = 'DELETE';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод deleteIssueTypeSchemeById: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод deleteIssueTypeSchemeById: При попытке удалить схему "типов задач" возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.getListOfIssueType = async function(refId) {
	log.rec({
		debug: "Вызван метод getListOfIssueType",
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issuetype`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен массив "типов задач"`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getListOfIssueType: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getListOfIssueType: При попытке получить список "типов задач" возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.addProjectToScheme = async function(schemeId, idsOrKeys, refId) {
	log.rec({
		debug: "Вызван метод addProjectToScheme",
		trace: `idsOrKeys: ${JSON.stringify(idsOrKeys)}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}issuetypescheme/${schemeId}/associations`;
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify({ idsOrKeys: idsOrKeys })
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод addProjectToScheme: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод addProjectToScheme: При попытке добавить комментарий к задаче, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};









/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * * * * * * * * * * * * * * Экраны * * * * * * * * * * * * * *
https://docs.atlassian.com/software/jira/docs/api/REST/8.1.0/#api/2/screens
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * @typedef {Object} AvailableField
 * @property {String} id
 * @property {String} name
 * @property {String} type
 */

/**
 * @typedef {Object} AvailableFields
 * @property {Boolean} success
 * @property {Object} error
 * @property {Array<AvailableField>} data
 */

/**
 *
 * @param {Number|String} screenId
 * @param {String} refId
 * @returns {AvailableFields}
 */
exports.getFieldsToAdd = async function(screenId, refId) {
	log.rec({
		debug: "Вызван метод getFieldsToAdd",
		trace: `screenId: ${screenId}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}screens/${screenId}/availableFields`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getFieldsToAdd: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getFieldsToAdd: При попытке получить список доступных полей возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



/**
 *
 * @param {Number|String} screenId
 * @param {Number|String} tabId
 * @param {Number|String} fieldId
 * @param {String} refId
 * @returns
 */
exports.screenAddField = async function(screenId, tabId, fieldId, refId) {
	log.rec({
		debug: "Вызван метод screenAddField",
		trace: `screenId: ${screenId}, tabId: ${tabId}, fieldId: ${fieldId}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}screens/${screenId}/tabs/${tabId}/fields`;
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify({ fieldId: fieldId })
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод screenAddField: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод screenAddField: При попытке добавить поле к эрану, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.downloadJiraFile = async function(url, path, refId) {
	log.rec({
		debug: "Вызван метод downloadJiraFile",
		trace: `url ${url}, path ${path}`,
		refId
	});

	const auth = setBaseAuth(config.jira.user, config.jira.password);
	const res = await fetch(url, {
		method: 'GET',
		agent: httpsAgent,
		headers: {
			Authorization: auth,
			"X-Atlassian-Token": "no-check"
		}
	});
	const fileStream = fs.createWriteStream(path);
	await new Promise((resolve, reject) => {
		res.body.pipe(fileStream);
		res.body.on("error", reject);
		fileStream.on("error", reject);
		fileStream.on("finish", resolve);
	});
};




exports.getCustomFields = async function(refId) {
	log.rec({
		debug: "Вызван метод getCustomFields",
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}customFields?maxResults=10000`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен список кастомфилдов`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getCustomFields: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getCustomFields: При попытке получить общий список кастомфилдов возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.getTransitions = async function(issueKey, refId) {
	log.rec({
		debug: "Вызван метод getTransitions",
		trace: `issueKey: ${issueKey}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issue/${issueKey}/transitions`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен список доступных переходов`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getTransitions: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getTransitions: При попытке получить список доступных переходов возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.doTransition = async function(issueIdOrKey, transitionId, refId) {
	log.rec({
		debug: "Вызван метод doTransition",
		trace: `issueIdOrKey: ${issueIdOrKey}, transitionId: ${transitionId}`,
		refId
	});

	try {
		const url = `${config.jira.latestRestUrl}issue/${issueIdOrKey}/transitions`;
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify({ transition: { id: transitionId } })
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const data = await res.text();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод doTransition: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод doTransition: При попытке инициировать переход возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};


exports.findUsers = async function(partLogin, refId) {
	log.rec({
		debug: "Вызван метод findUsers",
		trace: `partLogin: ${partLogin}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}user/picker?query=${partLogin}`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			log.debug(`Получен список пользователей`);

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод findUsers: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод findUsers: При попытке получить список пользователей возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};



exports.fetchResource = async function(url, refId) {
	log.rec({
		debug: "Вызван метод fetchResource",
		trace: `url: ${url}`,
		refId
	});

	try {
		const encodedUrl = encodeURI(url);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `encodedUrl: ${encodedUrl}`,
			refId
		});

		const res = await fetch(encodedUrl, options);
		if(res.ok) {
			// const contentType = res.headers.get('content-type');
			const data = await res.buffer();
			const base64 = data.toString("base64");
			return createSuccessResponse(base64);
		}
		else {
			log.error(`JiraAPI - метод fetchResource: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод fetchResource: При попытке скачать ресурс возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};





exports.getCreateIssueMetaProjectIssueTypes = async function(projectIdOrKey, refId) {
	log.rec({
		debug: "Вызван метод getCreateIssueMetaProjectIssueTypes",
		trace: `projectIdOrKey: ${projectIdOrKey}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issue/createmeta/${projectIdOrKey}/issuetypes?maxResults=1000`);

		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос на получение типов задач: `,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getCreateIssueMetaProjectIssueTypes: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getCreateIssueMetaProjectIssueTypes: При попытке получить список типов задач проекта возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};





exports.getCreateIssueMetaFields = async function(projectIdOrKey, issueTypeId, refId) {
	log.rec({
		debug: "Вызван метод getCreateIssueMetaFields",
		trace: `projectIdOrKey: ${projectIdOrKey}, issueTypeId: ${issueTypeId}`,
		refId
	});

	try {
		const url = encodeURI(`${config.jira.latestRestUrl}issue/createmeta/${projectIdOrKey}/issuetypes/${issueTypeId}?maxResults=1000`);
		const method = 'GET';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: getBaseToken(),
				"X-Atlassian-Token": "no-check"
			}
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {

			const data = await res.json();
			return createSuccessResponse(data);
		}
		else {
			log.error(`JiraAPI - метод getCreateIssueMetaFields: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод getCreateIssueMetaFields: При попытке получить список полей для типа задач и проекта - возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};




exports.login = async function(username, password, refId) {
	log.rec({
		debug: "Вызван метод login",
		trace: `username: ${username}`,
		refId
	});

	try {
		const url = `${config.jira.url}rest/auth/1/session`;
		const method = 'POST';

		const options = {
			method: method,
			agent: httpsAgent,
			headers: {
				Authorization: setBaseAuth(username, password),
				"Content-Type": "application/json",
				"X-Atlassian-Token": "no-check"
			},
			body: JSON.stringify({ username: username, password: password })
		};

		log.rec({
			debug: `В Jira RestAPI отправлен запрос`,
			trace: `url: ${url}`,
			refId
		});

		const res = await fetch(url, options);
		if(res.ok && res.status < 300) {
			const cookies = res.headers.get('Set-Cookie');
			const data = await res.json();
			data["cookies"] = cookies;
			return createSuccessResponse( data );
		}
		else {
			log.error(`JiraAPI - метод login: Получен отрицательный ответ! Код: [${res.status}] ${res.statusText}`, null);
			const err = await res.text();
			return createFailedResponse(err);
		}
	}
	catch (e) {
		log.error(`JiraAPI - метод login: При попытке аутентифицировать пользователя, возникла ошибка!`, e);
		return createFailedResponse(e);
	}
};
