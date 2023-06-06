<template>
	<div class="details-wrapper">
		<article>
			<h1 class="title">{{ task.title }}</h1>
			<TransitionsBar @click="doTransition" :allowedTransitions="task.allowed_transitions"></TransitionsBar>
			<div class="customTable">
				<div class="row">
					<div>Проект:</div>
					<div>{{ task.project_name }}</div>
				</div>
				<div class="row">
					<div>Статус:</div>
					<StatusBadge :status="task.status_name"></StatusBadge>
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
					<div class="user">{{ task.assignee_name }} ({{ task.assignee }})</div>
				</div>
				<div class="row">
					<div>Автор:</div>
					<div class="user">{{ task.creator_name }} ({{ task.creator }})</div>
				</div>
				<div class="row">
					<div>Создано:</div>
					<div class="date">{{ task.created }}</div>
				</div>
				<div class="row">
					<div>Обновлено:</div>
					<div class="date">{{ task.updated }}</div>
				</div>
			</div>
		</aside>
	</div>
</template>

<script>
import axios from 'axios';
import PriorityBadge from './PriorityBadge.vue';
import StatusBadge from './StatusBadge.vue';
import TransitionsBar from './TransitionsBar.vue';


export default {
	components: { PriorityBadge, StatusBadge, TransitionsBar },
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
        },
    }
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
			flex-grow: 1;

			.title {
				font-size: 1.6em;
			}

			.description {
				font-size: .9em;
				border: 1px dashed #033d7440;
				margin: 0.5em 0;
				padding: 0.8em 1em;
				color: #172b4db5;
				background: #90aacb1c;
				border-radius: 4px;
			}
		}

		aside {
			background: #fafafa;
			box-shadow: 0 1px 4px rgba(0, 0, 0, 0.13);
			padding: 1em;
		}

		.customTable {
			background: #90aacb1c;
			border-radius: 4px;
			// box-shadow: inset 0 0 4px 0 #172b4d1f;
			box-shadow:0 0 2px 0 #172b4d1f;
			margin: 1em 0;
			padding:.4em 1em;
			border: 1px dashed #033d7440;

			.row {
				display: flex;
				padding: .2em;

				&:not(:last-child) {
					border-bottom: 1px solid #172b4d0d;
				}

				>:nth-child(1) {
					color: #172b4db5;
					padding-right:.8em;
				}
				>:nth-child(2) {

				}

				.statusId {
					background: red;
				}

				.date {
					color: #830e0e;
					font-size: .8em;
					font-family: monospace;
					margin: auto 0;
				}

				.user {
					font-size: .8em;
					margin: auto 0;
				}
			}
		}
	}
</style>
