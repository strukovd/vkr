<template>
	<div class="details-wrapper">
		<article>
			<h1 class="title">{{ task.title }}</h1>
			<div class="customTable">
				<div class="row">
					<div>Проект:</div>
					<div>{{ task.project_name }}</div>
				</div>
				<div class="row">
					<div>Статус:</div>
					<div>{{ task.status }}</div>
				</div>
				<div class="row">
					<div>Приоритет:</div>
					<PriorityBadge :priority="task.priority"></PriorityBadge>
				</div>
			</div>
			<div class="description">{{ task.description }}</div>
		</article>
		<aside>
			<div class="customTable">
				<div class="row">
					<div>Исполнитель:</div>
					<div>{{ task.assignee_name }} ({{ task.assignee }})</div>
				</div>
				<div class="row">
					<div>Автор:</div>
					<div>{{ creator_name }} ({{ task.creator }})</div>
				</div>
				<div class="row">
					<div>Создано:</div>
					<div>{{ task.created }}</div>
				</div>
				<div class="row">
					<div>Обновлено:</div>
					<div>{{ task.updated }}</div>
				</div>
			</div>
		</aside>
	</div>
</template>

<script>
import axios from 'axios';
import PriorityBadge from './PriorityBadge.vue';
export default {
    mounted() {
        this.fetchTask();
    },
    data: function () {
        return {
            task: {}
        };
    },
    methods: {
        async fetchTask() {
            const taskId = this.$route.params["id"];
            axios
                .get(`http://localhost:3000/task/${taskId}`)
                .then((response) => {
                if (Array.isArray(response.data) && response.data.length) {
                    this.task = response.data[0];
                }
            })
                .catch((error) => {
                console.error(error);
            });
        }
    },
    components: { PriorityBadge }
}
</script>

<style lang="scss" scoped>
	.details-wrapper {
		display: flex;
		margin: 1em;

		article {
			background: #fafafa;
			box-shadow: 0 1px 4px rgba(0, 0, 0, 0.13);
			padding: 1em;
			margin-right:1em;

			.title {
				font-size: 1.6em;
			}

			.description {
				border: 1px dashed #033d7440;
				margin: .5em 0;
				padding: .5em;
			}
		}

		aside {
			background: #fafafa;
			box-shadow: 0 1px 4px rgba(0, 0, 0, 0.13);
			padding: 1em;
		}

		.customTable {
			.row {
				display: flex;
				padding: .2em;
				border-bottom: 1px solid #aaa;

				:nth-child(1) {
					color: #666;
				}
				:nth-child(2) {
					
				}
			}
		}
	}
</style>
