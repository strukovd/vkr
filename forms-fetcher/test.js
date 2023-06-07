// const jiraAPI = require(`./lib/utils/jiraAPI`);
// const parse = require('csv-parse/lib/sync');
// const Iconv = require("iconv").Iconv;
// const fs = require('fs');

const setBaseAuth = (user, pass) => { return "Basic " + Buffer.from(user + ':' + pass).toString('base64'); };

async function main() {

	console.log( setBaseAuth(`admin`, `321`) );
}



main();