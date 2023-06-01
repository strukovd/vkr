import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class UserService {
	constructor(
		private readonly connection: DataSource
	) {}

	// create(createUserDto: CreateUserDto) {
	// 	return 'This action adds a new user';
	// }

	findAll() {
		const query = `SELECT id, login, email, display_name
			FROM users;`;
    	return this.connection.query(query);
	}

	// findOne(id: number) {
	// 	return `This action returns a #${id} user`;
	// }

	// update(id: number, updateUserDto: UpdateUserDto) {
	// 	return `This action updates a #${id} user`;
	// }

	// remove(id: number) {
	// 	return `This action removes a #${id} user`;
	// }
}
