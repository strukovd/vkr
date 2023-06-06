<template>
	<div id="tasks-container">
		<table>
			<thead>
				<tr>
					<th @click="sortBy(`id`)" colspan="2" :class="{'up': sortedBy === 'id' && !sortedReverse, 'down': sortedBy === 'id' && sortedReverse}">ID</th>
					<th @click="sortBy(`title`)" :class="{'up': sortedBy === 'title' && !sortedReverse, 'down': sortedBy === 'title' && sortedReverse}">Название</th>
					<th @click="sortBy(`status_name`)" :class="{'up': sortedBy === 'status_name' && !sortedReverse, 'down': sortedBy === 'status_name' && sortedReverse}">Статус</th>
					<th @click="sortBy(`priority`)" :class="{'up': sortedBy === 'priority' && !sortedReverse, 'down': sortedBy === 'priority' && sortedReverse}">Приоритет</th>
					<th @click="sortBy(`assignee`)" :class="{'up': sortedBy === 'assignee' && !sortedReverse, 'down': sortedBy === 'assignee' && sortedReverse}">Исполнитель</th>
					<th @click="sortBy(`created`)" :class="{'up': sortedBy === 'created' && !sortedReverse, 'down': sortedBy === 'created' && sortedReverse}">Создана</th>
					<th @click="sortBy(`creator`)" :class="{'up': sortedBy === 'creator' && !sortedReverse, 'down': sortedBy === 'creator' && sortedReverse}">Автор</th>
				</tr>
			</thead>
			<tbody>
				<router-link v-for="task in tasks" :key="task.id" :to="`/task/${task.id}`" custom v-slot="{ navigate }">
					<tr class="task-row" @click="navigate" @keypress.enter="navigate" role="link">
						<td><img :src="task.img" alt="" width="16"/></td>
						<td class="idCeil">{{ task.id }}</td>
						<td>{{ task.title }}</td>
						<td><StatusBadge :status="task.status_name"></StatusBadge></td>
						<td><PriorityBadge :priority="task.priority"></PriorityBadge></td>
						<td>user</td>
						<td class="dateCeil">{{ task.created }}</td>
						<td>user</td>
					</tr>
				</router-link>
			</tbody>
		</table>
	</div>
</template>

<script>
import axios from 'axios';
import PriorityBadge from './PriorityBadge.vue';
import StatusBadge from './StatusBadge.vue';

export default {
	components: { PriorityBadge, StatusBadge },
	data() {
		return {
			tasks: [
				{
					projectImage: "path/to/project-image.png",
					id: 1,
					title: "Task 1",
					status: "In Progress",
					priority: "High"
				}
			],
			sortedBy: null,
			sortedReverse: false
		};
	},
	mounted() {
		this.fetchTasks();
	},
	methods: {
		async fetchTasks() {
			axios
				.get(`http://localhost:3000/task`)
				.then((response) => {
					this.tasks = response.data;
				})
				.catch((error) => {
					console.error(error);
				});
		},
		sortBy(fieldName) {
			if( Array.isArray(this.tasks) && this.tasks.length ) {
				if(this.sortedBy === fieldName) {
					this.sortedReverse = !this.sortedReverse;
				}
				else {
					this.sortedBy = fieldName;
					this.sortedReverse = false;
				}

				this.tasks.sort((a, b) => {
					let res;
					if( typeof a[fieldName] === "number" ) {
						res = a[fieldName]-b[fieldName];
					}
					else if ( typeof a[fieldName] === "string" ) {
						const lowerA = a[fieldName]?.toLocaleLowerCase();
						const lowerB = b[fieldName]?.toLocaleLowerCase();
						if(lowerA > lowerB) res = 1;
						else if (lowerA < lowerB) res = -1;
						else res = 0;
					}

					if(this.sortedReverse && res !== 0) res = -res;

					this.sortedBy = fieldName;
					return res;
				});
			}
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

				tr {
					th {
						cursor:pointer;

						&.up::before {
							content: "▲";
							color: #56657d;
							font-size: .8em;
							line-height: 1.2em;
							margin: auto 0.2em auto 0;
						}
						&.down::before {
							content: "▼";
							color: #56657d;
							font-size: .8em;
							line-height: 1.2em;
							margin: auto 0.2em auto 0;
						}

						&:hover {
							background:#f5f5f5;
						}
					}
				}
			}
			tbody {
				.task-row {
					background: #fafafae6;
					border-bottom: 1px solid #f0f0f0;
					line-height: 2em;
					padding:0 10em;
					cursor: pointer;

					.idCeil {
						font-family: monospace;
						color: #0e4570;
					}

					.dateCeil {
						color: #830e0e;
						font-size: .8em;
						font-family: monospace;
					}

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