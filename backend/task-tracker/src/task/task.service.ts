import { Injectable } from '@nestjs/common';
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

	create(createTaskDto: CreateTaskDto) {
		const query = `INSERT INTO tasks
			(title, description, project_key, priority, assignee, creator)
			VALUES ($1, $2, $3, $4, $5);`;
    	return this.connection.query(query, [
			createTaskDto.title,
			createTaskDto.description,
			createTaskDto.projectKey,
			createTaskDto.priority,
			createTaskDto.assignee,
			createTaskDto.creator
		]);
	}

	getAll() {
		const query = `SELECT t.id, title, t.description, t.priority, t.assignee, uas.display_name AS assignee_name, t.creator, ucr.display_name AS creator_name, t.created, t.updated, p.name AS project_name
			FROM tasks t
			INNER JOIN projects p ON t.project_key = p.key
			INNER JOIN users uas ON uas.login = t.assignee
			INNER JOIN users ucr ON ucr.login = t.assignee
			WHERE t.assignee = 'admin';`;
    	return this.connection.query(query);
	}

	getById(id: number) {
		const query = `SELECT t.id, title, t.description, t.priority, t.assignee, uas.display_name AS assignee_name, t.creator, ucr.display_name AS creator_name, t.created, t.updated, p.name AS project_name
			FROM tasks t
			INNER JOIN projects p ON t.project_key = p.key
			INNER JOIN users uas ON uas.login = t.assignee
			INNER JOIN users ucr ON ucr.login = t.assignee
			WHERE t.id = $1;`;
    	return this.connection.query(query, [id]);
	}

	editById(id: number, editTaskDto: EditTaskDto) {
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
    	return this.connection.query(query, [id, ...params]);
	}

	removeById(id: number) {
		const query = `DELETE FROM tasks WHERE id = $1;`;
    	return this.connection.query(query, [id]);
	}

	doTransition(id: number): void {
		//TODO:
		return null;
	}
}
