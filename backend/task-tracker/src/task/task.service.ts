import { Injectable } from '@nestjs/common';
import { CreateTaskDto } from './dto/create-task.dto';
import { UpdateTaskDto } from './dto/update-task.dto';

@Injectable()
export class TaskService {
	create(createTaskDto: CreateTaskDto) {
		//TODO:
		return 'This action adds a new task';
	}

	getAll() {
		//TODO:
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
