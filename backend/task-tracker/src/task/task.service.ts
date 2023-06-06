import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { DataSource } from 'typeorm';
import { CreateTaskDto } from './dto/create-task.dto';
import { EditTaskDto } from './dto/edit-task.dto';

@Injectable()
export class TaskService {
	constructor(
		private readonly configService: ConfigService,
		private readonly connection: DataSource
	) {}

	async create(createTaskDto: CreateTaskDto) {
		const query = `INSERT INTO tasks
			(title, description, project_key, priority, assignee, status, creator)
			VALUES ($1, $2, $3, $4, $5, $6, $7);`;
		const params = [
			createTaskDto.title,
			createTaskDto.description,
			createTaskDto.projectKey,
			createTaskDto.priority,
			createTaskDto.assignee,
			0,
			"admin"
		];

		console.log(query);
		console.log(JSON.stringify(params));

    	return await this.connection.query(query, params);
	}

	getAll() {
		const query = `SELECT t.id, title, t.description, t.priority,
					t.assignee, uas.display_name AS assignee_name, t.creator,
					ucr.display_name AS creator_name,
					TO_CHAR(t.created, 'DD.MM.YYYY') AS created, TO_CHAR(t.updated, 'DD.MM.YYYY') AS updated,
					p.name AS project_name, p.img,
					t.status,
					s.name           AS status_name
			FROM tasks t
			INNER JOIN projects p ON t.project_key = p.key
			INNER JOIN users uas ON uas.login = t.assignee
			INNER JOIN users ucr ON ucr.login = t.assignee
			LEFT JOIN statuses s ON t.status = s.id;
			--WHERE t.assignee = 'admin';`;
    	return this.connection.query(query);
	}

	getById(taskId: number) {
		const query = `WITH task AS (
			SELECT t.id,
				   title,
				   t.description,
				   t.priority,
				   t.assignee,
				   uas.display_name AS assignee_name,
				   t.creator,
				   ucr.display_name AS creator_name,
				   TO_CHAR(t.created, 'DD.MM.YYYY') AS created,
				   TO_CHAR(t.updated, 'DD.MM.YYYY') AS updated,
				   p.name           AS project_name,
				   t.status,
				   s.name           AS status_name
			FROM tasks t
					 INNER JOIN projects p ON t.project_key = p.key
					 INNER JOIN users uas ON uas.login = t.assignee
					 INNER JOIN users ucr ON ucr.login = t.assignee
					 LEFT JOIN statuses s ON t.status = s.id
			WHERE t.id = $1
		)
		SELECT *,
			   (SELECT json_agg(allowed_trans) FROM (SELECT * FROM transitions WHERE from_status = task.status) AS allowed_trans) AS allowed_transitions
		FROM task;`;
    	return this.connection.query(query, [taskId]);
	}

	find(searchText: string) {
		console.log(`searchText: ${searchText}`);
		const query = `SELECT t.id, title, t.description, t.priority,
					t.assignee, uas.display_name AS assignee_name, t.creator,
					ucr.display_name AS creator_name,
					TO_CHAR(t.created, 'DD.MM.YYYY') AS created, TO_CHAR(t.updated, 'DD.MM.YYYY') AS updated,
					p.name AS project_name, p.img,
					t.status,
					s.name           AS status_name
			FROM tasks t
			INNER JOIN projects p ON t.project_key = p.key
			INNER JOIN users uas ON uas.login = t.assignee
			INNER JOIN users ucr ON ucr.login = t.assignee
			LEFT JOIN statuses s ON t.status = s.id
			WHERE
				t.title ilike $1
				OR t.description ilike $1
				OR s.name ilike $1
				OR ucr.display_name ilike $1
			LIMIT 10;`;
    	return this.connection.query(query, [`%${searchText}%`]);
	}

	editById(taskId: number, editTaskDto: EditTaskDto) {
		let fields = "";
		const params = [];

		if(editTaskDto.title) {
			fields += ` title = $${params.length+1}`;
			params.push(editTaskDto.title);
		}
		if(editTaskDto.description) {
			fields += ` description = $${params.length+1}`;
			params.push(editTaskDto.description);
		}
		if(editTaskDto.assignee) {
			fields += ` assignee = $${params.length+1}`;
			params.push(editTaskDto.assignee);
		}
		if(editTaskDto.priority) {
			fields += ` priority = $${params.length+1}`;
			params.push(editTaskDto.title);
		}
		if(editTaskDto.projectKey) {
			fields += ` project_key = $${params.length+1}`;
			params.push(editTaskDto.title);
		}

		const query = `UPDATE tasks
			${fields}
			updated = now()
			WHERE id = $1;`;
    	return this.connection.query(query, [taskId, ...params]);
	}

	removeById(taskId: number) {
		const query = `DELETE FROM tasks WHERE id = $1;`;
    	return this.connection.query(query, [taskId]);
	}

	editPriority(taskId: number, priority: number) {
		const query = `UPDATE tasks
			priority = $1
			WHERE id = $2;`;
    	return this.connection.query(query, [priority, taskId]);
	}

	assign(taskId: number, username: string) {
		const query = `UPDATE tasks
			assignee = $1
			WHERE id = $2;`;
    	return this.connection.query(query, [username, taskId]);
	}


	getComments(taskId: number) {
		const query = `SELECT
				id, comment,
				TO_CHAR(updated, 'DD.MM.YYYY') AS updated,
				TO_CHAR(created, 'DD.MM.YYYY') AS created,
			FROM task_comments
			WHERE task_id = $1;`;
    	return this.connection.query(query, [taskId]);
	}

	addComment(taskId: number, comment: string) {
		const query = `INSERT INTO task_comments
			(id, comment) VALUES
			($1, $2, $3, $4);`;
    	return this.connection.query(query, [taskId, comment]);
	}

	editComment(taskId: number, newComment: string) {
		const query = `UPDATE task_comments
			SET comment = $1
			WHERE id = $2;`;
    	return this.connection.query(query, [newComment, taskId]);
	}

	deleteComment(commentId: number) {
		const query = `DELETE FROM task_comments
			WHERE id = $1;`;
    	return this.connection.query(query, [commentId]);
	}

	getTransitions(taskId: number) {

	}

	async doTransition(taskId: number, transitionId: number) {
		// Убедимся что текущая задача может перейти по выбранному переходу

		// Если он исполнитель задачи
		// И текущий статус задачи есть в записи требуемого перехода, в поле from_status
		let query = `SELECT t.assignee, t.project_key, t.status AS cur_status, tr.from_status, tr.to_status
		FROM tasks t
		INNER JOIN transitions tr ON tr.id = $1
		WHERE t.id = $2;`;
    	const transitionInfo = await this.connection.query(query, [transitionId, taskId]);
		if(Array.isArray(transitionInfo) && transitionInfo.length) {
			const {assignee, project_key, cur_status, from_status, to_status} = transitionInfo[0];
			if(cur_status !== from_status) {
				throw new HttpException(`Не удалось осуществить переход!`, HttpStatus.BAD_REQUEST,
					{description: `Запрашиваемый переход с текущего статуса (${cur_status}), на статус (${to_status}) - запрещен!`});
			}

			query = `UPDATE tasks SET status = $1, updated = now() WHERE id = $2`;
			await this.connection.query(query, [to_status, taskId]);
			return `Переход успешно осуществлен`;
		}
		else {
			throw new HttpException(`Указанный переход (${transitionId}) не существует!`, HttpStatus.BAD_REQUEST);
		}
	}
}
