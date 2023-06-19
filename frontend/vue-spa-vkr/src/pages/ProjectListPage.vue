<template>
	<div id="settings-block">
		<header>
			<h1>Управление проектами</h1>
		</header>
		<hr/>
		<main>
			<div class="controllsBar">
				<button @click="$router.replace(`/setting/createProject`)" class="createProjectButton">
					Добавить проект
				</button>
			</div>
			<div v-if="Array.isArray(projectList) && projectList.length" id="projectList">
				<table>
					<tr>
						<th>Иконка</th>
						<th>Ключ</th>
						<th>Имя</th>
						<th>Описание</th>
					</tr>
					<tr v-for="project of projectList" :key="project.id">
						<td><img :src="project.img" width="16"></td>
						<td>{{ project.key }}</td>
						<td>{{ project.name }}</td>
						<td><span class="login">{{ project.description }}</span></td>
					</tr>
				</table>
			</div>
		</main>
	</div>
</template>

<script>
import axios from 'axios';

export default {
	data() {
		return {
			projectList: [],
		};
	},
	mounted() {
		this.fetchProjects();
	},
	methods: {
		async fetchProjects() {
			axios
				.get(`http://localhost:3000/project`)
				.then((response) => {
					console.log(JSON.stringify(response.data));

					this.projectList = response.data;
				})
				.catch((error) => {
					console.error(error);
				});
		}
	}
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

				.createProjectButton {
					background: #f0f0f0;
					line-height: 2em;
					color: #c0c0c0;
					padding: 0 0.8em;
					border-radius: 4px;
					font-size: .8em;
					margin: auto;
					font-weight: 700;
					transition:200ms all 0s ease;
					cursor: pointer;
					border:none;
					&:hover {
						background: #e0e0e0;
					}
				}
			}

			#projectList {
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
						}
					}
				}
			}
		}
	}
</style>