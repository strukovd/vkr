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
					<td><input v-model="passwod" type="password"/></td>
				</tr>
				<tr>
					<td colspan="2"><input @click.prevent="signin" type="submit" value="Войти"></td>
				</tr>
			</table>
		</form>
	</div>
</template>

<script>
export default {
	data() {
		return {
			username: "",
			passwod: ""
		};
	},
	methods: {
		signin() {
			console.log(this.username);
			if(this.username === "admin" && this.passwod === "123") {
				sessionStorage.setItem('username', 'admin');
				this.$router.push("/");
			}
			else {
				alert("bad");
			}
		}
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
