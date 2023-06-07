/*
	Этот воркер каждые 30 сек. проверяет БД форм (192.168.50.85), на наличие необработанных заявок.
 */

const config = global.config;
const log = require(`../utils/log`);
const pg = require(`../utils/pg`);
const jiraAPI = require(`../utils/jiraAPI`);

// const {gazHandler} = require(`../form-handlers/GAZ`);
const {rrHandler} = require(`../form-handlers/RR`);
const {obHandler} = require(`../form-handlers/OB`);
const {trHandler} = require(`../form-handlers/TR`);
const {vrHandler} = require(`../form-handlers/VR`);
const {wtrHandler} = require(`../form-handlers/WTR`);
const {usHandler} = require(`../form-handlers/US`);
const {rereHandler} = require(`../form-handlers/RERE`);
// const {jlHandler} = require(`../form-handlers/JL`);
const {ngnHandler} = require(`../form-handlers/NGN`);
const {rjHandler} = require(`../form-handlers/RJ`);
const {papHandler} = require(`../form-handlers/PAP`);
const {siuHandler} = require(`../form-handlers/SIU`);
const {psoHandler} = require(`../form-handlers/PSO`);
const {nvoHandler} = require(`../form-handlers/NVO`);
const {kkHandler} = require(`../form-handlers/KK`);
const {gulHandler} = require(`../form-handlers/GUL`);
const {prv4Handler} = require(`../form-handlers/PRV4`);
const {ngv4Handler} = require(`../form-handlers/NGV4`);

const formHandlersMap = {
	// GAZ: {
	// 	handler: gazHandler
	// },
	RR: {
		handler: rrHandler
	},
	OB: {
		handler: obHandler
	},
	TR: {
		handler: trHandler
	},
	VR: {
		handler: vrHandler
	},
	WTR: {
		handler: wtrHandler
	},
	US: {
		handler: usHandler
	},
	RERE: {
		handler: rereHandler
	},
	// JL: {
	// 	handler: jlHandler
	// },
	NGN: {
		handler: ngnHandler
	},
	RJ: {
		handler: rjHandler
	},
	PAP: {
		handler: papHandler
	},
	SIU: {
		handler: siuHandler
	},
	KK: {
		handler: kkHandler
	},
	NVO: {
		handler: nvoHandler
	},
	PSO: {
		handler: psoHandler
	},
	GUL: {
		handler: gulHandler
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



		// const resChanged = await jiraAPI.changeStatus(json_data.issue_key, json_data.transition_id);
		// if(resChanged.success) {
		// 	log.info(`Статус задачи ${json_data.issue_key} успешно изменен!`);
		// 	sqlite.delete(`DELETE FROM tasks WHERE id = ?`, [form.id]);
		// }
		// else {
		// 	sqlite.update(`UPDATE tasks SET is_valid = 0`, []);
		// }
	}
}




