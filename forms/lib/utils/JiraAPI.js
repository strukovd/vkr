const fs = require('fs');
const req = require('request-promise');

const setBaseAuth = (user, pass) => { return "Basic " + Buffer.from(user + ':' + pass).toString('base64'); };

const getOptions = (url, user, pass) => {
	const auth = setBaseAuth(user, pass);

	return {
		method: 'GET',
		url: url,
		headers: { Authorization: auth }
	};
};



class JiraClient {

	/**
	 * @param {JiraClientOption} options
	 */
	constructor(options) {
		if (!options) throw 'JiraClient options is undefined';
		if (!options.host) throw 'JiraClient options.host is undefined';
		if (!options.username) throw 'JiraClient options.username is undefined';
		if (!options.password) throw 'JiraClient options.password is undefined';

		this.host = options.host || '';
		this.username = options.username || '';
		this.password = options.password || '';
	}


	async getStatuses(projectID) {
		const url = `${this.host}project/${projectID}/statuses/`;
		const options = getOptions(url, this.username, this.password);
		return await req(options).then(data => JSON.parse(data));
	}



	// async getIssue(key) {
	// 	const url = encodeURI(`${this.host + 'issue/' + key}`);
	// 	const options = getOptions(url, this.username, this.password);
	// 	return await req(options).then(data => JSON.parse(data));
	// }

	// /**
	//  * Отправляет запрос на JiraAPI (host + queries)
	//  * @param {*} queries описание API запрос
	//  */
	// async search(queries) {
	// 	const url = encodeURI(`${this.host + queries}`);
	// 	const options = getOptions(url, this.username, this.password);
	// 	return await req(options).then(data => JSON.parse(data));
	// }


	// /**
	//  * Отправляет POST запрос в jira-API, с целью создания новой задачи (bs-docker-srv01, 10.88.0.10)
	//  * @param {JiraCreateIssueFormat} body
	//  */
	// async createIssue(body) {
	// 	const url = `${this.host + 'issue/'}`;
	// 	const auth = setBaseAuth(this.username, this.password);

	// 	const options = {
	// 		method: 'POST',
	// 		url: url,
	// 		headers:
	// 		{
	// 			Authorization: auth,
	// 			'Content-Type': 'application/json'
	// 		},
	// 		body: JSON.stringify(body),
	// 	};

	// 	return await req(options).then(data => JSON.parse(data));
	// }

	// async changeStatus(issueIdOrKey, transitionId) {
	// 	const url = `${this.host + 'issue/' + issueIdOrKey + '/transitions?expand=transitions.fields'}`;
	// 	const auth = setBaseAuth(this.username, this.password);
	// 	const options = {
	// 		method: 'POST',
	// 		url: url,
	// 		headers: { Authorization: auth, 'Content-Type': 'application/json' },
	// 		body: JSON.stringify({ transition: { id: transitionId } }),
	// 	};
	// 	return await req(options).then(data => data ? JSON.parse(data) : 'Response is undefined');
	// }

	// async addComment(issueIdOrKey, comment) {
	// 	const url = `${this.host + 'issue/' + issueIdOrKey + '/comment'}`;
	// 	const auth = setBaseAuth(this.username, this.password);
	// 	const options = {
	// 		method: 'POST',
	// 		url: url,
	// 		headers: { Authorization: auth, 'Content-Type': 'application/json' },
	// 		body: JSON.stringify({ body: comment }),
	// 	};
	// 	return await req(options).then(data => data ? JSON.parse(data) : 'Response is undefined');
	// }

	// /**
	//  * Отправляет PUT запрос в jira-API, с целью обновления полей задачи (bs-docker-srv01, 10.88.0.10)
	//  * @param {String} issueIdOrKey код проекта (CL-0000)
	//  * @param {String} editMeta
	//  * @param {JiraUpdateIssueFormat} body
	//  */
	// async updateIssue(issueIdOrKey, editMeta, body) {
	// 	const url = `${this.host + 'issue/' + issueIdOrKey + '/' + editMeta}`;
	// 	const auth = setBaseAuth(this.username, this.password);

	// 	const options = {
	// 		method: 'PUT',
	// 		url: url,
	// 		headers:
	// 		{
	// 			Authorization: auth,
	// 			'Content-Type': 'application/json'
	// 		},
	// 		body: JSON.stringify(body),
	// 	};
	// 	return await req(options).then(data => data ? JSON.parse(data) : 'Response is undefined');
	// }

	// async attachFile(params) {
	// 	const url = encodeURI(`${this.host}issue/${params.key}/attachments`);
	// 	const auth = setBaseAuth(this.username, this.password);

	// 	const options = {
	// 		method: 'POST',
	// 		url: url,
	// 		headers: {
	// 			Authorization: auth,
	// 			'X-Atlassian-Token': 'nocheck',
	// 			'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
	// 		},
	// 		formData: {
	// 			file: {
	// 				value: fs.createReadStream(params.path),
	// 				options: {
	// 					filename: params.name,
	// 					contentType: null
	// 				}
	// 			}
	// 		}
	// 	};

	// 	return await req(options).then(data => JSON.parse(data));
	// }

	// async removeAttachment(id) {
	// 	const url = encodeURI(`${this.host + 'attachment/' + id}`);
	// 	const auth = setBaseAuth(this.username, this.password);

	// 	const options = {
	// 		method: 'DELETE',
	// 		url: url,
	// 		headers: {
	// 			Authorization: auth,
	// 		},
	// 	};
	// 	return await req(options).then(data => data ? JSON.parse(data) : 'response is null');
	// }

	// async getAttachment(link) {
	// 	return new Promise(async (resolve, reject) => {
	// 		const auth = setBaseAuth(this.username, this.password);
	// 		request({ url: link, encoding: null, headers: { Authorization: auth } }, (error, response, body) => {
	// 			if (error) return reject(error);
	// 			resolve(body);
	// 		});
	// 	});
	// }
}

module.exports = JiraClient;