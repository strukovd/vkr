const log = require("../../utils/log");

exports.generateMemobox = function (input, lang) {
	log.debug(`Вызван метод generateMemobox`);

	if(input) {
		let htmlOptions = [];

		const {id, type, caption, have_static_data,
			default_value, regex, mask,
			order, refillable, tooltip, required,
			placeholder, refillable_source, options, updaters, additional_regulations} = input;


		let metaData = ``;
		// input type
		if(type) {
			metaData += ` data-type="${type}"`;
		}
		// Добавляем метаданные
		if(refillable) {
			metaData += ` data-refillable="${refillable}"`;
		}
		if(required) {
			metaData += ` data-required="${required}"`;
		}
		if(updaters) {
			log.magenta(`updaters`);
			metaData += ` data-updaters='${JSON.stringify(updaters)}'`;
		}
		if(refillable_source) {
			metaData += ` data-refillable_source='${refillable_source}'`;
		}


		if(additional_regulations) {
			const ar = additional_regulations;
			if(ar.regex) {
				metaData += ` data-regex="${ar.regex}"`;
			}
			if(ar.mask) {
				metaData += ` data-mask='${ar.mask}'`;
			}
		}


		// Аттрибуты для самого input
		// Если имеется значение по умолч., добавляем его
		let additionalAttributes = '';
		if(default_value) {
			additionalAttributes += ` value="${default_value}"`;
		}
		// Если имеется значение placeholder, добавляем его
		if(placeholder) {
			additionalAttributes += ` placeholder="${placeholder}"`;
		}

		let res =
		`<section class="box memobox" data-type="memobox">
			<div class="meta" ${metaData}></div>
			<label>
				<div class="boxName" title="${tooltip}">${caption[lang]}</div>
				<div class="errorDesc"></div>
				<div class="wr-memobox">
					<textarea  name="${id}" id="${id}" ${additionalAttributes}></textarea>
				</div>
			</label>
		</section>`;


		return res;
	}
};
