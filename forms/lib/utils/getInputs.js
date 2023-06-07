const log = require("../utils/log");
const pg = require("../utils/pg");

/**
 * @typedef {Object} InputWithOptions
 * @property {String} project_id
 * @property {String} input_id
 * @property {String} type
 * @property {Object} caption
 * @property {Boolean} have_static_data
 * @property {String} regex
 * @property {String} mask
 * @property {Number} order
 * @property {Boolean} refillable
 * @property {String} tooltip
 * @property {Boolean} require
 * @property {String} placeholder
 * @property {String} refillable_source
 * @property {String} default_value
 * @property {Array<Option>} options
 */

/**
 * @typedef {Object} Option
 * @property {Number} id
 * @property {Object} name
 * @property {String} input_id
 * @property {Boolean} visible
 * @property {Number} order
 */

/**
 * @param {Number} projectID
 * @returns {Array<InputWithOptions>}
 */
exports.getInputs = async function(projectID) {
	log.debug(`Вызван метод getInputs`);
	log.trace(`projectID: ${projectID}`);

	const res = await pg.execSync(`SELECT *,
				CASE
					-- Если инпут имеет статические пункты, загружаем их
					WHEN i.have_static_data THEN
						(
						SELECT json_agg(o)
						FROM
							(
								SELECT *
								FROM options
								WHERE input_id = pi.input_id
								ORDER BY "order"
							) AS o
						)
				END AS options
			FROM project_inputs pi
			INNER JOIN inputs i on i.id = pi.input_id
				AND pi.visible = true
			WHERE pi.project_id = $1
			ORDER BY pi."order";`,
	[projectID]);

	return res;
};
