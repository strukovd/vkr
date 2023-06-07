// Инициализация handlebars хелперов
const {generateBox} = require("./hbs/generateBox");


exports.registerHelpers = function(hbs) {

	hbs.registerHelper("toJson", function(object) {
		return new hbs.SafeString(JSON.stringify(object));
	});

	hbs.registerHelper("OR", function() {
		for (const arg of arguments) {
			if (arg) return arg;
		}
	});


	hbs.registerHelper("getLocale", function(data, fieldName) {
		if(fieldName) {
			return data[fieldName];
		}
		else {
			return data["ru"]; //TODO: указать в конфиге
		}
	});

	hbs.registerHelper("generateBox", generateBox);

};