export class CreateTaskDto {
	public title: string;
	public description: string;
	public priority: number;
	public assignee: string;
	public projectKey: string;
	public creator: string;
}
