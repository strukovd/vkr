<template>
	<div id="settings-block">
		<header>
			<h1>Управление пользователями</h1>
		</header>
		<hr/>
		<main>
			<div class="controllsBar">
				<button @click="$router.replace(`/setting/createUser`)" class="createUserButton">
					Создать пользователя
				</button>
			</div>
			<div id="userList">
				<table>
					<tr>
						<th>ID</th>
						<th>Имя</th>
						<th>Логин</th>
						<th>Е-мейл</th>
						<th>Создан</th>
						<th>Последний вход</th>
					</tr>
					<tr>
						<td>1</td>
						<td>Струков Дмитрий Геннадьевич</td>
						<td><span class="login">strukovd</span></td>
						<td>strukoff97@gmail.com</td>
						<td class="time">22.03.2023 10:54</td>
						<td class="time">05.07.2023 22:13:21</td>
					</tr>
					<tr>
						<td>2</td>
						<td>Администратор</td>
						<td><span class="login">admin</span></td>
						<td>admin@gmail.com</td>
						<td class="time">22.03.2023 10:54</td>
						<td class="time">05.07.2023 22:13:21</td>
					</tr>
					<tr>
						<td>3</td>
						<td>User</td>
						<td><span class="login">user</span></td>
						<td>just-simple-user@gmail.com</td>
						<td class="time">22.03.2023 10:54</td>
						<td class="time">05.07.2023 22:13:21</td>
					</tr>
				</table>
			</div>
		</main>
	</div>
</template>

<script>
export default {

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

			.controllsBar {
				margin:1em;

				.createUserButton {
					background: #0079c1;
					line-height: 2em;
					color: #f0f0f0;
					padding: 0 .8em;
					border-radius: 4px;
					font-size: .8em;
					margin: auto;
					font-weight: 700;
					transition:200ms all 0s ease;
					cursor: pointer;
					border:none;
					&:hover {
						background: #0c91e1;
					}
				}
			}

			#userList {
				margin:1em;

				table {
					width:100%;
					font-size:.9em;
					border-collapse: collapse;

					tr:first-child {
						th {
							background: #f8f8f9;
							border-bottom: 2px solid #0079c1;
							line-height:1.8em;
						}
					}

					tr:not(:first-child) {
						transition:all 300ms ease 0s;
						&:hover {
							background: #f8f8f9;
						}

						td{
							padding:.2em 1em;
							line-height:2.2em;
							font-size:.9em;
							// background: red;

							.login {
								padding:.25em .7em;
								border-radius:6px;
								border: 1px solid #172b4d17;
								background: #172b4d17;
							}

							&.time {
								font-family:monospace;
								color: #830e0e;
							}
						}
					}
				}
			}
		}
	}
</style>