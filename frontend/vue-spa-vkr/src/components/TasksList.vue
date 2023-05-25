<template>
	<div id="tasks-container">
		<table style="background: #fff;">
			<tbody>
				<tr v-for="task in tasks" :key="task.id" class="task-row">
					<td><img :src="task.img" alt="" width="16"/></td>
					<td>{{ task.id }}</td>
					<td>{{ task.title }}</td>
					<td>status</td>
					<td>{{ task.priority }}</td>
				</tr>
			</tbody>
		</table>
		
		<!-- <div v-for="task in tasks" :key="task.id" class="task">
			<div class="task-info">
			<img :src="task.img" alt="Project Image" width="16" height="16" />
			<div class="task-details">
				<span class="task-id">{{ task.id }}</span>
				<h3 class="task-title">{{ task.title }}</h3>
				<div class="task-status">status</div>
				<div class="task-priority">{{ task.priority }}</div>
			</div>
			</div>
		</div> -->
	</div>
</template>

<script>
import axios from 'axios';

export default {
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
		margin: 1em;
		box-shadow: 0 1px 4px rgba(0,0,0,.13);

		table {
			border-collapse: collapse;
			background: rgb(255, 255, 255);
			color: #172B4D;

			.task-row {
			background: #fff;
			border-bottom: 1px solid #f0f0f0;
			line-height: 2em;
			padding:0 10em;

			td {
				padding: 0 0.8em;
				border: 1px solid #f5f5f5;
			}
		}
		}
	}
</style>