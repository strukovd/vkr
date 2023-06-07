<template>
	<div id="settings-block">
		<header>
			<h1>Создание пользователя</h1>
		</header>
		<hr/>
		<main>
			<form>
				<table>
					<tr>
						<td><span class="label">Имя:</span></td>
						<td><span><input v-model="name" type="text"></span></td>
					</tr>
					<tr>
						<td><span class="label">Логин:</span></td>
						<td><span><input v-model="login" type="text"></span></td>
					</tr>
					<tr>
						<td><span class="label">Пароль:</span></td>
						<td><span><input v-model="password" type="password"></span></td>
					</tr>
					<tr>
						<td><span class="label">Е-мейл:</span></td>
						<td><span><input v-model="email" type="text"></span></td>
					</tr>
					<tr>
						<td colspan="2"><input @click.prevent="sendForm" type="submit" value="Создать"></td>
					</tr>
				</table>
			</form>
		</main>
	</div>
</template>

<script>
import axios from 'axios';

export default {
	data() {
		return {
			name: "",
			login: "",
			password: "",
			email: ""
		};
	},
	methods: {
		sendForm() {
			this.createTask();
		},
		createTask() {
			axios
				.post(`http://localhost:3000/task`, {
					projectKey: this.projectKey,
					title: this.title,
					description: this.description,
					priority: this.priority,
					assignee: this.assignee,
					creator: this.creator,
				})
				.then(() => {
					Notification.success("Задача успешно создана!");
					this.$router.push("/");
					// if (Array.isArray(response.data) && response.data.length) {
					// }
				})
				.catch((error) => {
					Notification.error(error);
					console.error(error);
				});
		}
	}
}
</script>

<style lang="scss" scoped>
	#settings-block {
		margin: 1em;
		background: white;
		// padding: 4em 12em;
		// text-align: center;
		border-radius: 3px;
		box-shadow: 0px 1px 4px 0 rgba(0, 0, 0, 0.1);

		header {
			padding:1em 1em 0 1em;

			h1 {
				padding:0 0 0 1em;
				line-height: 2.2em;
				margin:0;
			}
		}

		hr {
			margin:.5em 1em;
			border-bottom: 1px solid #8895a959;
			border-width:0 0 1px 0;
		}

		main {
			padding:0 1em 1em 1em;

			table {
				width: 100%;
				max-width: 600px;
				margin: auto;

				tr:not(:last-child) {
					td:first-child {
						// text-align: right;
						padding-right: 1em;
						padding-left: 3em;
					}

					td:last-child {
						padding-right: 3em;

						* {
							width: 100%;
						}
					}
				}
			}

			select {
				box-sizing: border-box;
				background: #f5f5f5;
				color: #172b4dba;
				font-size: 16px;
				padding: 0 1em;
				line-height: 2em;
				height: 2em;
				border-radius: 5px;
				outline: none;
				border: none;
			}

			input[type=text], input[type=password] {
				box-sizing: border-box;
				background: #f5f5f5;
				color: #172b4dba;
				font-size: 16px;
				padding: 0 1em;
				line-height: 2em;
				height: 2em;
				border-radius: 5px;
				outline: none;
				border: none;
			}

			input[type=submit] {
				margin-top:.5em;
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
				cursor: pointer;
			}

			textarea {
				box-sizing: border-box;
				background: #f5f5f5;
				color: #172b4dba;
				font-size: 16px;
				padding: 0 1em;
				// line-height: 2em;
				// height: 2em;
				border-radius: 5px;
				outline: none;
				border: none;
			}
		}
	}
</style>













































<!--

<script>


export default {
	
}
</script>

<style lang="scss" scoped>
	
</style>

 -->
