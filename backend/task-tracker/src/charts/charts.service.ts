import { Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';

@Injectable()
export class ChartsService {
	constructor(
		private readonly connection: DataSource
	) {}

	tasksCreated() {
		const query = `SELECT EXTRACT(MONTH FROM created) AS month,
				to_char(created, 'Month') AS month_name,
				COUNT(*) AS task_count
		FROM tasks
		GROUP BY EXTRACT(MONTH FROM created), month_name
		ORDER BY month;`;
    	return this.connection.query(query);
	}
}
