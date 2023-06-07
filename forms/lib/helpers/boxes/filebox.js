const log = require("../../utils/log");

exports.generateFilebox = function (input, lang) {
	log.debug(`Вызван метод generateFilebox`);

	if(input) {
		let htmlOptions = [];
		let metaData = ``;

		const {id, type, caption, have_static_data,
			default_value, regex, mask,
			order, refillable, tooltip, required,
			placeholder, refillable_source, options, updaters, additional_regulations} = input;


		// Добавляем метаданные
		if(type) {
			metaData += ` data-type="${type}"`;
		}
		if(regex) {
			metaData += ` data-regex="${regex}"`;
		}
		if(required) {
			metaData += ` data-required="${required}"`;
		}
		if(updaters) {
			metaData += ` data-updaters='${JSON.stringify(updaters)}'`;
		}
		if(refillable_source) {
			metaData += ` data-refillable_source='${refillable_source}'`;
		}

		if(additional_regulations) {
			const ar = additional_regulations;
			if(ar.maxSize) {
				metaData += ` data-maxSize="${ar.maxSize}"`;
			}
			if(ar.ext) {
				metaData += ` data-ext='${JSON.stringify(ar.ext)}'`;
			}
		}


		let res =
		`<section class="box filebox" data-type="filebox">
			<div class="meta" ${metaData}></div>
			<span>
				<div class="boxName">${caption[lang]}</div>
				<div class="errorDesc"></div>
				<div class="wr-filebox">
					<label>
						<div class="fileButton" title="${tooltip}" tabindex="0">Выберите файлы...</div>
						<input type="file" multiple id="${id}"/>
					</label>
					<span class="is_load"></span>
					<div class="fileNames"></div>

				</div>
			</span>
		</section>`;


		return res;
	}
};
