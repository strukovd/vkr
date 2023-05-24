<template>
	<ul>
		test
		<li v-for="(task) of tasks" :key="task.id">
			<div class="title">{{ task.title }}</div>
			<div class="desc"> {{ task.description }}</div>
		</li>
		<li>
			<div class="title">{{ tasks.length?tasks[0].title:"" }}</div>
			<div class="desc"> {{ tasks.length?tasks[0].description:"" }}</div>
		</li>
	</ul>
</template>

<script>
import axios from 'axios';

export default {
	name: 'App',
	components: {
	},
	data() {
		return {
			tasks: []
		}
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
}
</script>

<style lang="scss" scoped>
	ul {
		list-style: none;
		padding: 0;
		flex-grow: 1;

		li {
			background: #fff;
			border-bottom: 1px solid #f0f0f0;
			padding: .5em 1em;

			.title {
				font-size: 1.6em;
				line-height: 1.4em;
				color: #172B4D;
			}
			.desc {
				color: #172b4d9c;
				font-size: .8em;
			}
		}
	}
</style>
