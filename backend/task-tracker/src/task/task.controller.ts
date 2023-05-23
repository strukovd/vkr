import { Controller, Get, Post, Body, Patch, Param, Delete, Put } from '@nestjs/common';
import { TaskService } from './task.service';
import { CreateTaskDto } from './dto/create-task.dto';
import { UpdateTaskDto } from './dto/update-task.dto';

@Controller('task')
export class TaskController {
	constructor(private readonly taskService: TaskService) {}

	@Post()
	async create(@Body() createTaskDto: CreateTaskDto) {
		return this.taskService.create(createTaskDto);
	}

	@Get()
	getAll() {
		return this.taskService.getAll();
	}

	@Get(':taskId')
	async getById(@Param('taskId') id: string) {
		return this.taskService.getById(+id);
	}

	@Patch(':taskId')
	async editById(@Param('taskId') id: string, @Body() updateTaskDto: UpdateTaskDto) {
		return this.taskService.editById(+id, updateTaskDto);
	}

	@Delete(':taskId')
	async removeById(@Param('taskId') id: string) {
		return this.taskService.removeById(+id);
	}



	@Patch(':taskId/rate')
	async editRating(@Param('taskId') id: string) {
		return this;
	}

	@Patch(':taskId/assign/:username')
	async assign(@Param('taskId') id: string, @Param('username') username: string) {
		return null;
	}


	//TODO: вынести комментарии в отдельный под-модуль
	@Get(':taskId/comments')
	async getComments(@Param('taskId') id: string) {
		return null;
	}

	@Post(':taskId/comment')
	async addComment(@Param('taskId') id: string, @Body('comment') comment: string) {
		return null;
	}

	@Patch(':taskId/comment/:commentId')
	async editCommentById(@Param('taskId') id: string, @Param('commentId') commentId: string, @Body('comment') comment: string) {
		return null;
	}



	@Get(':taskId/transitions')
	async getTransitions(@Param('taskId') id: string) {
		return null;
	}

	@Patch(':taskId/doTransition')
	async doTransition(@Param('taskId') id: string) {
		this.taskService.doTransition(+id);
	}


	@Post(':taskId/attachment')
	async addAttachment(@Param('taskId') id: string) {
		this.taskService.doTransition(+id);
	}
}
