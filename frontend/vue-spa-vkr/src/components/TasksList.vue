<template>
	<div id="tasks-container">
		<table>
			<thead>
				<tr>
					<th></th>
					<th>ID</th>
					<th>Название</th>
					<th>Статус</th>
					<th>Приоритет</th>
				</tr>
			</thead>
			<tbody>
				<router-link v-for="task in tasks" :key="task.id" :to="`/task/${task.id}`" custom v-slot="{ navigate }">
					<tr class="task-row" @click="navigate" @keypress.enter="navigate" role="link">
						<td><img :src="task.img" alt="" width="16"/></td>
						<td>{{ task.id }}</td>
						<td>{{ task.title }}</td>
						<td>status</td>
						<td><PriorityBadge :priority="task.priority"></PriorityBadge></td>
					</tr>
				</router-link>
			</tbody>
		</table>
	</div>
</template>

<script>
import axios from 'axios';
import PriorityBadge from './PriorityBadge.vue';

export default {
  components: { PriorityBadge },
	data() {
		return {
			tasks: [
				{
					projectImage: "path/to/project-image.png",
					id: 1,
					title: "Task 1",
					status: "In Progress",
					priority: "High"
				},
				{
					projectImage: "path/to/project-image.png",
					id: 2,
					title: "Task 2",
					status: "Completed",
					priority: "Medium"
				},
			]
		};
	},
	mounted() {
		this.fetchTasks();
	},
	methods: {
		async fetchTasks() {
			axios
				.get('http://localhost:3000/task')
				.then((response) => {
					this.tasks = response.data;
				})
				.catch((error) => {
					console.error(error);
				});
		}
	}
};
</script>

<style lang="scss" scoped>
	#tasks-container {
		overflow-y: auto;
		margin: 1em;
		box-shadow: 0 1px 4px rgba(0,0,0,.13);

		table {
			width: 100%;
			border-collapse: collapse;
			background: #ffffff;
			color: #172B4D;

			thead {
				background: #fafafae6;
				line-height: 2em;
			}
			tbody {
				.task-row {
					background: #fafafae6;
					border-bottom: 1px solid #f0f0f0;
					line-height: 2em;
					padding:0 10em;
					cursor: pointer;

					&:hover {
						background: #f7f7f7;
					}

					&:active {
						background: #f0f0f0;
					}

					td {
						padding: 0 0.8em;
						border: 1px solid #f5f5f5;
					}
				}
			}
		}
	}
</style>