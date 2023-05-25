<template>
	<div class="right-main">
		<div v-for="task in tasks" :key="task.id" class="task">
			<div class="task-info">
			<img :src="task.projectImage" alt="Project Image" width="16" height="16" />
			<div class="task-details">
				<span class="task-id">{{ task.id }}</span>
				<h3 class="task-title">{{ task.title }}</h3>
				<div class="task-status">{{ task.status }}</div>
				<div class="task-priority">{{ task.priority }}</div>
			</div>
			</div>
		</div>
	</div>
</template>

<script>
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
			// Add more tasks as needed
			]
		};
		}
	};
</script>

<style scoped>
	.task {
		display: flex;
		align-items: center;
		margin-bottom: 10px;
	}

	.task img {
		margin-right: 10px;
	}

	.task-info {
		display: flex;
		align-items: center;
	}

	.task-details {
		display: flex;
		flex-direction: row;
		align-items: center;
	}

	.task-id {
		font-weight: bold;
		margin-right: 10px;
	}

	.task-title {
		margin: 0;
		margin-right: 10px;
	}

	.task-status {
		margin-right: 10px;
		color: green; /* Customize the color based on the task status */
	}

	.task-priority {
		color: red; /* Customize the color based on the task priority */
	}
</style>