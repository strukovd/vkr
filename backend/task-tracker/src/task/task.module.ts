import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TaskService } from './task.service';
import { TaskController } from './task.controller';

@Module({
	imports: [TypeOrmModule],
	controllers: [TaskController],
	providers: [TaskService]
})
export class TaskModule {}
