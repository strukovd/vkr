<template>
	<div id="wr-search">
		<input v-model.lazy="searchQuery" id="search-input" type="text">
		<div v-if="Array.isArray(foundTasks) && foundTasks.length" id="search-result-box">
			<div v-for="foundTask of foundTasks" :key="foundTask.id" class="found-task" @click="$router.replace(`/task/${foundTask.id}`)">
				<div class="title">{{ foundTask.title }}</div>
				<div><span class="status-id">Номер: {{ foundTask.id }}</span></div>
				<div class="status">Статус: <StatusBadge :status="foundTask.status_name"/></div>
				<div class="assignee">Исполнитель: {{ foundTask.assignee_name }}</div>
			</div>
		</div>
		<div v-else-if="String(searchQuery).trim()" id="search-result-box">
			<div class="tasks-not-found-msg">Ничего не найдено!</div>
		</div>
	</div>
</template>

<script>
import axios from 'axios';
import StatusBadge from './StatusBadge.vue'
export default {
	components: { StatusBadge },
	data() {
		return {
			searchQuery: "",
			foundTasks: []
		};
	},
	watch: {
		searchQuery() {
			const query = String(this.searchQuery).trim();
			if(query) {
				axios
					.get(`http://localhost:3000/task/find/${query}`)
					.then((response) => {
						this.foundTasks = response.data;
					})
					.catch((error) => {
						console.error(error);
					});
			}
			else {
				this.foundTasks = [];
			}
		}
	}
}
</script>

<style lang="scss" scoped>
	#wr-search {
		position: relative;

		#search-input:focus {
			outline: 3px solid #215abd66;
		}
		#search-input {
			background: #E6EBF5;
			line-height: 1.8em;
			border: none;
			border-radius: 3px;
			padding: .1em .8em;
			color: #203456;
			/* box-shadow: inset 1px 0 3px 0 rgb(44 88 225 / 20%); */
			border: 1px solid #93aad938;
			font-weight: 700;
			font-size: 14px;
		}

		#search-result-box {
			background:#ffffff;
			border:1px solid #0a163024;
			border-radius:3px;
			// padding:.4em 0;

			position: absolute;
			top:2.2em;
			right:0;
			left:0;

			.found-task {
				padding:.4em .5em;
				border-bottom:1px solid #0a16300d;
				cursor:pointer;
				&:hover{
					background:#1151a50d;
				}

				.title {
					font-size:.8em;
				}
				.status-id, .status, .assignee {
					color: #172b4da1;
					font-size: .7em;
					padding: 0 0.4em;
				}
			}

		}


		.tasks-not-found-msg {
			text-align: center;
			font-size: .8em;
			font-weight: 700;
			line-height: 3.2em;
		}
	}
</style>
