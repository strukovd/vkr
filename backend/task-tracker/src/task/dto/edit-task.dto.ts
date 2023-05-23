import { PartialType } from '@nestjs/mapped-types';
import { CreateTaskDto } from './create-task.dto';

export class EditTaskDto extends PartialType(CreateTaskDto) {
	public title: string;
	public description: string;
	public priority: number;
	public assignee: string;
	public projectKey: string;
}
