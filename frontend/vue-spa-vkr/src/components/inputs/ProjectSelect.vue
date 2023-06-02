<template>
	<select v-model="projectKey">
		<option v-for="project of projectList" :key="project.key" :value="project.key">{{ project.name }}</option>
	</select>
</template>

<script>
import axios from 'axios';
export default {
	mounted() {
		this.fetchProjects();
	},
	data() {
		return {
			projectList: [],
			projectKey: ''
		};
	},
	methods: {
		async fetchProjects() {
            axios
                .get(`http://localhost:3000/project`)
                .then((response) => {
                if (Array.isArray(response.data) && response.data.length) {
                    this.projectList = response.data;
                }
            })
                .catch((error) => {
                console.error(error);
            });
        },
	}
}
</script>

<style>

</style>