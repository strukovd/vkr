const log = require("../../utils/log");

exports.generateInfobox = function (input, lang) {
	log.debug(`Вызван метод generateInfobox`);

	if(input) {
		const {type, additional_regulations} = input;

		let metaData = ``;
		// input type
		if(type) {
			metaData += ` data-type="${type}"`;
		}

		let res =
		`<section class="box infobox" data-type="infobox">
			<div class="meta" ${metaData}></div>
			<div style="background: #e4f5ff; color: #747474; padding: 1em 1em; border-radius: 3px; border-left: 6px solid #00629f;">
				<h2 style="margin:0 0 .2em 0;">${additional_regulations.title}</h2>
				<div style="white-space: pre; font-size: .8em;">${additional_regulations.msg}</div>
			</div>
		</section>`;


		return res;
	}
};
