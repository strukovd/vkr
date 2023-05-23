import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { CreateTaskDto } from './dto/create-task.dto';
import { UpdateTaskDto } from './dto/update-task.dto';

@Injectable()
export class TaskService {
	constructor(private readonly configService: ConfigService) {}

	create(createTaskDto: CreateTaskDto) {
		//TODO:
		console.log(
			this.configService.get("PG_CONTAINER_NAME")
		);
		return 'This action adds a new task';
	}

	getAll() {
		//TODO:
		console.log(
			this.configService.get("PG_CONTAINER_NAME")
		);
		return `This action returns all task`;
	}

	getById(id: number) {
		//TODO:
		return `This action returns a #${id} task`;
	}

	editById(id: number, updateTaskDto: UpdateTaskDto) {
		//TODO:
		return `This action updates a #${id} task`;
	}

	removeById(id: number) {
		//TODO:
		return `This action removes a #${id} task`;
	}

	doTransition(id: number): void {
		//TODO:
		return null;
	}
}
