import { Injectable } from '@nestjs/common';
import { CreateProjectDto } from './dto/create-project.dto';
import { UpdateProjectDto } from './dto/update-project.dto';
import { DataSource } from 'typeorm';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class ProjectService {
	constructor(
		private readonly configService: ConfigService,
		private readonly connection: DataSource
	) {}

	create(createProjectDto: CreateProjectDto) {
		const query = `INSERT INTO projects
			(title, description, project_key, priority, assignee, creator)
			VALUES ($1, $2, $3, $4, $5);`;
    	return this.connection.query(query, [
			createProjectDto.name,
			createProjectDto.description,
			createProjectDto.img,
		]);
	}

	findAll() {
		const query = `SELECT key, name, description, img
			FROM projects;`;
    	return this.connection.query(query);
	}

	findOne(projectKey: string) {
		const query = `SELECT key, name, description, img
			FROM projects
			WHERE key = $1;`;
    	return this.connection.query(query, [projectKey]);
	}

	// update(id: number, updateProjectDto: UpdateProjectDto) {
	// 	return `This action updates a #${id} project`;
	// }

	remove(projectKey: string) {
		const query = `DELETE FROM projects
			WHERE key = $1;`;
    	return this.connection.query(query, [projectKey]);
	}
}
