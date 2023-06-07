
//GROUPS
/**
 * @typedef {Object} groupData
 * @property {String} groupName
 * @property {Number} recDays
 * @property {Array <status>} statuses имеет динамический набор полей, ключи которых являются номерами статусов
 */

/**
 * @typedef {Object} status
 * @property {String} id
 * @property {String} name
 */





//JiraAPI
/**
 * @typedef {Object} JiraClientOption
 * @property {String} host
 * @property {String} username
 * @property {String} password
 */



//API
/**
 * @typedef {Object} getStatusGroupsReturns
 * @property {String} group_name
 * @property {Number} recomended_day
 * @property {Array <String>} status_keys
 */