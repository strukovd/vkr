<template>
	<div class="wr-create-task-block">
		<div class="create-task-block">
			<h1 class="title">Создание задачи</h1>
			<form>
				<table>
					<tr>
						<td><span class="label">Проект:</span></td>
						<td><span><ProjectSelect v-model="projectKey"/></span></td>
					</tr>
					<tr>
						<td><span class="label">Заголовок:</span></td>
						<td><span><input v-model="title" type="text"></span></td>
					</tr>
					<tr>
						<td><span class="label">Описание:</span></td>
						<td><span><textarea v-model="description" rows="10"></textarea></span></td>
					</tr>
					<tr>
						<td><span class="label">Приоритет:</span></td>
						<td><span><PrioritySelect v-model="priority"/></span></td>
					</tr>
					<tr>
						<td><span class="label">Исполнитель:</span></td>
						<td><span><UserSelect v-model="assignee"/></span></td>
					</tr>
					<tr>
						<td colspan="2"><input @click.prevent="sendForm" type="submit"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</template>

<script>
import UserSelect from '@/components/inputs/UserSelect.vue';
import ProjectSelect from '@/components/inputs/ProjectSelect.vue';
import PrioritySelect from '@/components/inputs/PrioritySelect.vue';
import axios from 'axios';

export default {
	components: { ProjectSelect, UserSelect, PrioritySelect },
	data() {
		return {
			projectKey: "",
			title: "",
			description: "",
			priority: 1,
			assignee: ""
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
	.wr-create-task-block {
		display: flex;

		.create-task-block {
			margin: 4em auto auto auto;
			background: white;
			padding: 5em 4em;
			flex: 600px 0 1;
			text-align: center;
			border-radius: 3px;
			box-shadow: 0px 1px 4px 0 rgba(0, 0, 0, 0.1);

			table {
				width: 100%;
				max-width: 600px;
				margin: auto;

				tr:not(:last-child) {
					td:first-child {
						text-align: right;
						padding-right: 1em;
					}

					td:last-child {
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

			input[type=text] {
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
