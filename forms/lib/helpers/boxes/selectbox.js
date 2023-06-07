const log = require("../../utils/log");

exports.generateSelectbox = function (input, lang) {
	log.debug(`Вызван метод generateSelectbox`);

	if(input) {

		let htmlOptions = [];
		let metaData = ``;

		const {id, type, caption, have_static_data,
			default_value, regex, mask,
			order, refillable, tooltip, required,
			placeholder, refillable_source, options, updaters} = input;

		// Если имеется значение по умолч., добавляем его
		if(default_value) {
			const str = `<option value="">${default_value}</option>`;
			htmlOptions.push(str);
		}

		// Готовим строку с множеством <option>
		if(have_static_data && options && options.length) {
			for (const option of options) {
				//id, name, input_id, visible, order
				const str = `<option value="${option.value}">${option.name[lang]}</option>`;
				htmlOptions.push(str);
			}
		}

		// Добавляем метаданные
		if(type) {
			metaData += ` data-type="${type}"`;
		}
		if(refillable) {
			metaData += ` data-refillable="${refillable}"`;
		}

		if(regex) {
			metaData += ` data-regex="${regex}"`;
		}
		if(mask) {
			metaData += ` data-mask="${mask}"`;
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


		let res =
		`<section class="box selectbox" data-type="selectbox">
			<div class="meta" ${metaData}></div>
			<label>
				<div class="boxName" title="${tooltip}">${caption[lang]}</div>
				<div class="errorDesc"></div>
				<div class="wr-selectbox">
					<select name="${id}" id="${id}">
						${htmlOptions.join("\n")}
					</select>
				</div>
			</label>
		</section>`;


		return res;
	}
};
