import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TaskModule } from './task/task.module';

@Module({
	imports: [
		ConfigModule.forRoot({
			isGlobal: true,
			envFilePath: "../../.env"
		}),
		TaskModule],
	controllers: [],
	providers: [],
})
export class AppModule {}
