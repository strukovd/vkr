const log = require("../../utils/log");

exports.generateSubtitlebox = function (input, lang) {
	log.debug(`Вызван метод generatesubtitlebox`);

	if(input) {

		const {id, type, caption, have_static_data,
			default_value, regex, mask,
			order, refillable, tooltip, required,
			placeholder, refillable_source, options, updaters, additional_regulations} = input;

		let res =
		`<section class="subtitlebox" data-type="subtitlebox">
			<div class="wr-subtitlebox">
				<h3 title="${tooltip}" id="${id}">${caption[lang]}</h3>
			</div>
		</section>`;


		return res;
	}
};
