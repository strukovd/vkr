import { Controller, Get, Post, Body, Patch, Param, Delete, Put } from '@nestjs/common';
import { TaskService } from './task.service';
import { CreateTaskDto } from './dto/create-task.dto';
import { EditTaskDto } from './dto/edit-task.dto';

@Controller('task')
export class TaskController {
	constructor(private readonly taskService: TaskService) {}

	@Post()
	async create(@Body() createTaskDto: CreateTaskDto) {
		return await this.taskService.create(createTaskDto);
	}

	@Get()
	getAll() {
		return this.taskService.getAll();
	}

	@Get(':taskId')
	async getById(@Param('taskId') id: string) {
		return this.taskService.getById(+id);
	}

	@Get('/find/:text')
	async find(@Param('text') text: string) {
		return this.taskService.find(text);
	}

	@Patch(':taskId')
	async editById(@Param('taskId') id: string, @Body() updateTaskDto: EditTaskDto) {
		return this.taskService.editById(+id, updateTaskDto);
	}

	@Delete(':taskId')
	async removeById(@Param('taskId') id: string) {
		return this.taskService.removeById(+id);
	}



	@Patch(':taskId/priority')
	async editPriority(@Param('taskId') id: number, @Body('priority') priority: number) {
		return this.taskService.editPriority(id, priority);
	}

	@Patch(':taskId/assign/:username')
	async assign(@Param('taskId') id: string, @Param('username') username: string) {
		return this.taskService.assign(+id, username);
	}



	@Get(':taskId/comments')
	async getComments(@Param('taskId') id: string) {
		return this.taskService.getComments(+id);
	}

	@Post(':taskId/comment')
	async addComment(@Param('taskId') id: number, @Body('comment') comment: string) {
		return this.taskService.addComment(id, comment);
	}

	@Patch(':taskId/comment/:commentId')
	async editCommentById(@Param('taskId') id: number, @Param('commentId') commentId: string, @Body('comment') comment: string) {
		return this.taskService.editComment(id, comment);
	}

	@Delete('comment/:commentId')
	async deleteCommentById(@Param('commentId') commentId: number, @Body('comment') comment: string) {
		return this.taskService.deleteComment(commentId);
	}



	@Get(':taskId/transitions')
	async getTransitions(@Param('taskId') id: string) {
		return this.taskService.getTransitions(+id);
	}

	@Patch(':taskId/doTransition')
	async doTransition(@Param('taskId') taskId: string, @Body("transitionId") transitionId: number) {
		console.log(`taskId: ${taskId}, transitionId: ${JSON.stringify(transitionId)}`);
		await this.taskService.doTransition(+taskId, transitionId);
	}


	// @Post(':taskId/attachment')
	// async addAttachment(@Param('taskId') id: string) {
	// 	return null;
	// }
}
