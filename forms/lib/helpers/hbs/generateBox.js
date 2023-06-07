const {generateCheckbox} = require("../boxes/checkbox");
const {generateFilebox} = require("../boxes/filebox");
const {generateSelectbox} = require("../boxes/selectbox");
const {generateTextbox} = require("../boxes/textbox");
const {generateSubtitlebox} = require("../boxes/subtitlebox");
const {generateMemobox} = require("../boxes/memobox");
const { generateInfobox } = require("../boxes/infobox");

const log = require("../../utils/log");

exports.generateBox = function(input, lang) {

	if(!lang) {
		lang = "ru"; //TODO: указать в конфиге
	}

	let res;
	// `
	// 	<div>
	// 		<label>
	// 			<div class="boxName">Фамилия:</div>
	// 			<input type="text" class="textbox" name="" id=""/>
	// 		</label>
	// 	</div>`;


	if(input && input.type) {
		switch (input.type) {
			case "textbox":
				res = generateTextbox(input, lang);
				break;
			case "selectbox":
				res = generateSelectbox(input, lang);
				break;
			case "checkbox":
				res = generateCheckbox(input, lang);
				break;
			case "filebox":
				res = generateFilebox(input, lang);
				break;
			case "subtitlebox":
				res = generateSubtitlebox(input, lang);
				break;
			case "memobox":
				res = generateMemobox(input, lang);
				break;
			case "infobox":
				res = generateInfobox(input, lang);
				break;
			default:
				break;
		}
	}
	else {
		return `Не корректные параметры`;
	}
	return res;
};

