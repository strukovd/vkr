/*
	Этот воркер каждые 30 сек. проверяет БД форм (192.168.50.85), на наличие необработанных заявок.
 */

const config = global.config;
const log = require(`../utils/log`);
const pg = require(`../utils/pg`);

const {vrHandler} = require(`../form-handlers/VR`);
const {rjHandler} = require(`../form-handlers/RJ`);
const {prv4Handler} = require(`../form-handlers/PRV4`);
const {ngv4Handler} = require(`../form-handlers/NGV4`);

const formHandlersMap = {
	VR: {
		handler: vrHandler
	},
	RJ: {
		handler: rjHandler
	},
	PRV4: {
		handler: prv4Handler
	},
	NGV4: {
		handler: ngv4Handler
	}
};

let wasActive = false;




/**
 * Запускает воркер check-forms worker
 */
exports.start = function(){
	log.debug("Инициирую старт check-forms worker");
	worker();
};




async function worker(){
	// Если в конфиге воркер был отключен
	if( config.workers.checkForms.isActive !== true ) {
		if(wasActive === true) {
			wasActive = false;
			log.info("check-forms worker стал неактивен!");
		}
		return;
	}
	else {
		try{
			await executeJob();
		}
		catch(e){
			log.error("Ошибка в воркере check-forms worker.", e);
		}
	}

	setTimeout(worker, config.workers.checkForms.interval);
}




async function executeJob() {

	// Достаем валидные задачи смены статуса, которые созданы больше 24 часов назад
	const forms = await pg.execSync(`SELECT id, project_id, form_data, created, form_key
			FROM forms
			WHERE status = 'NEW'
			LIMIT 30;`);


	for (const form of forms) {

		if(formHandlersMap[form.project_id]) {
			formHandlersMap[form.project_id].handler(form);
		}
		else {
			log.rec({
				warn: `Обработчик проекта не найден!`,
				debug: `Статус заявки будет обновлен на ERROR`,
				trace: `Код проекта: ${form.project_id}`
			});

			await pg.execSync(`UPDATE forms SET status = 'ERROR' WHERE id = $1;`, [form.id]);
			await pg.execSync(`INSERT INTO form_errors (form_id, description) VALUES ($1, $2);`, [form.id, `Обработчик проекта ${form.project_id} - не найден!`]);
		}

	}
}




