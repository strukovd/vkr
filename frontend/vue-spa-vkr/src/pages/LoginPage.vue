<template>
	<div class="auth-block">
		<h1 class="title">Авторизация</h1>
		<form>
			<table>
				<tr>
					<td><span class="fieldLabel">Логин:</span></td>
					<td><input v-model="username" type="text"/></td>
				</tr>
				<tr>
					<td><span class="fieldLabel">Пароль:</span></td>
					<td><input v-model="password" type="password"/></td>
				</tr>
				<tr>
					<td colspan="2"><input @click.prevent="signin" type="submit" value="Войти"></td>
				</tr>
			</table>
		</form>
	</div>
</template>

<script>
import axios from 'axios';

export default {
	data() {
		return {
			username: "",
			password: ""
		};
	},
	methods: {
		async signin() {
			console.log(`Вызван метод signin`);

			axios
                .post(`http://localhost:3000/user/auth`, {
					login: this.username,
					password: this.password
				})
                .then((response) => {
                if (Array.isArray(response.data) && response.data.length) {
					console.log(`response: ${JSON.stringify(response.data[0])}`);
                    this.userData = response.data[0];

					// id, login, display_name, email
					// id, login, display_name, email
					sessionStorage.setItem('username', this.userData.login);
					this.$router.push("/");
                }
				else {
					Notification.error("Неверный логин или пароль");
				}
            })
                .catch((error) => {
                console.error(error);
            });
		},
	}
}
</script>

<style lang="scss" scoped>
	.auth-block {
		margin: 1em;
		background: white;
		padding: 4em 12em;
		text-align: center;
		border-radius: 3px;
		box-shadow: 0px 1px 4px 0 rgba(0, 0, 0, 0.1);

		.title {
			color: #172b4d;
		}

		form {
			table {
				margin: auto;
				width: 100%;

				tr {
					td{
						padding-bottom:.5em;
					}

					input[type=text], input[type=password] {
						box-sizing: border-box;
						background: #f5f5f5;
						color: #172b4dba;
						font-size: 18px;
						padding: 0 1em;
						line-height: 2em;
						border-radius: 5px;
						outline: none;
						border: none;
					}

					input[type=submit] {
						box-sizing: border-box;
						width: 100%;
						background: #0079c1;
						color: #f0f0f0;
						font-weight: 700;
						font-size: 18px;
						padding: 0 1em;
						line-height: 2em;
						border-radius: 4px;
						outline: none;
						border: none;
					}
				}
			}
		}
	}
</style>
