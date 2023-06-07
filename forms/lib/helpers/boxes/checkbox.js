const log = require("../../utils/log");

exports.generateCheckbox = function (input, lang) {
	log.debug(`Вызван метод generateCheckbox`);

	if(input) {
		let htmlOptions = [];
		let metaData = ``;

		const {id, type, caption, have_static_data,
			default_value, regex, mask,
			order, refillable, tooltip, required,
			placeholder, refillable_source, options, dependencies} = input;


		// Добавляем метаданные
		if(type) {
			metaData += ` data-type="${type}"`;
		}
		if(required) {
			metaData += ` data-required="${required}"`;
		}


		let res =
		`<section class="box checkbox" data-type="checkbox">
			<div class="meta" ${metaData}></div>
			<label>
				<div class="wr-checkbox" title="${tooltip}">
					<input name="${id}" type="checkbox" name="${id}" />
					<span class="check_mark">
						<svg id="checkmark" viewBox="0 0 24 24">
							<path stroke-linecap="round" stroke-miterlimit="10" fill="none" d="M22.9 3.7l-15.2 16.6-6.6-7.1"></path>
						</svg>
					</span>
					<div class="boxName">${caption[lang]}</div>
				</div>
			</label>
		</section>`;


		return res;
	}
};
