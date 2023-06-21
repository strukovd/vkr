import { Injectable } from '@nestjs/common';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class CommentService {
	constructor(
		private readonly connection: DataSource
	) {}

	create(createCommentDto: CreateCommentDto) {
		const query = `INSERT INTO task_comments (task_id, comment, author, created)
				VALUES ( $1, $2, $3, now() );`;
    	this.connection.query(query, [
			createCommentDto.taskId,
			createCommentDto.comment,
			createCommentDto.author
		]);

		return '';
	}

	findAllByTaskId(taskId: string) {
		const query = `SELECT id, comment, created, author
			FROM task_comments WHERE task_id = $1;`;
    	return this.connection.query(query, [taskId]);
	}

	findOne(id: number) {
		return `This action returns a #${id} comment`;
	}

	update(id: number, updateCommentDto: UpdateCommentDto) {
		return `This action updates a #${id} comment`;
	}

	remove(id: number) {
		return `This action removes a #${id} comment`;
	}
}
