import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { TaskModule } from './task/task.module';
import { ProjectModule } from './project/project.module';
import { UserModule } from './user/user.module';
import { CommentModule } from './comment/comment.module';
import { ChartsModule } from './charts/charts.module';

@Module({
	imports: [
		ConfigModule.forRoot({
			isGlobal: true,
			envFilePath: "../../.env"
		}),
		ConfigModule.forRoot({isGlobal: true}),
		TypeOrmModule.forRootAsync({
			imports: [ConfigModule],
			useFactory: (configService: ConfigService) => {
				return {
					type: 'postgres',
					host: configService.get('PG_HOST'),
					port: +configService.get('PG_PORT'),
					username: configService.get('PG_USERNAME'),
					password: configService.get('PG_PASSWORD'),
					database: configService.get('PG_DATABASE_NAME'),
					entities: []
				};
			},
			inject: [ConfigService],
		}),

		TaskModule,

		ProjectModule,

		UserModule,

		CommentModule,

		ChartsModule
	],
	controllers: [],
	providers: [],
})
export class AppModule {}
