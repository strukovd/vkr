import { Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { DataSource } from 'typeorm';

@Injectable()
export class UserService {
	constructor(
		private readonly connection: DataSource
	) {}

	create(createUserDto: CreateUserDto) {
		const query = `INSERT INTO users (login, password, email, display_name)
			VALUES ($1, $2, $3, $4);`;
		const params = [
			createUserDto.login,
			createUserDto.password,
			createUserDto.email,
			createUserDto.display_name
		];
    	return this.connection.query(query, params);
	}

	auth(formData) {
		console.log(`Вызван метод auth`);
		console.log(`formData: ${JSON.stringify(formData)}`);

		const query = `SELECT id, login, display_name, email
			FROM users
			WHERE login = $1 AND password = $2;`;
		const params = [
			formData.login,
			formData.password
		];
    	const res = this.connection.query(query, params);
		console.log(JSON.stringify(res));
		return res;
	}

	findAll() {
		const query = `SELECT id, login, email, display_name, created, last_auth
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
