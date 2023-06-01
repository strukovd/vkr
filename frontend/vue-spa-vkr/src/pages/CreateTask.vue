<template>
	<form>
		<div class="field">
			<label>
				<span class="label">Проект:</span><span>
					<ProjectSelect></ProjectSelect>
				</span>
			</label>
		</div>
		<div class="field">
			<label>
				<span class="label">Заголовок:</span><span><input type="text"></span>
			</label>
		</div>
		<div class="field">
			<label>
				<span class="label">Описание:</span><span><textarea cols="30" rows="10"></textarea></span>
			</label>
		</div>
		<div class="field">
			<label>
				<span class="label">Приоритет:</span><span>
					<PrioritySelect/>
				</span>
			</label>
		</div>
		<div class="field">
			<label>
				<span class="label">Исполнитель:</span><span>
					<UserSelect/>
				</span>
			</label>
		</div>
		<div class="field">
			<input type="submit">
		</div>
	</form>
</template>

<script>
import UserSelect from '@/components/inputs/UserSelect.vue';
import ProjectSelect from '@/components/inputs/ProjectSelect.vue';
import PrioritySelect from '@/components/inputs/PrioritySelect.vue';
import axios from 'axios';

export default {
	components: { ProjectSelect, UserSelect, PrioritySelect },
	methods: {
		createTask() {
			axios
				.post(`http://localhost:3000/task`, {
					projectKey: "",
					title: "",
					description: "",
					priority: 1,
					assignee: "admin",
					creator: "admin",
				})
				.then((response) => {
					if (Array.isArray(response.data) && response.data.length) {
						this.userList = response.data;
					}
				})
					.catch((error) => {
					console.error(error);
				});
		}
	}
}
</script>

<style>

</style>