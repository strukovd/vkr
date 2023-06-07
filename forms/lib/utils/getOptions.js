const log = require("../utils/log");
const pg = require("../utils/pg");

exports.getOptions = async function(inputID) {
	log.debug(`Вызван метод getOptions`);

	const res = await pg.execSync(`SELECT *
	FROM options o
	WHERE o.input_id = $1
	ORDER BY o."order";`,
	[inputID]);

	return res;
};