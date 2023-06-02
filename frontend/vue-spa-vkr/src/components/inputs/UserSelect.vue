<template>
	<select v-model="username">
		<option v-for="user of userList" :key="user.id" :value="user.login">{{ user.display_name }}</option>
	</select>
</template>

<script>
import axios from 'axios';
export default {
	mounted() {
		this.fetchUsers();
	},
	data() {
		return {
			userList: [],
			username: ""
		};
	},
	methods: {
		async fetchUsers() {
            axios
                .get(`http://localhost:3000/user`)
                .then((response) => {
                if (Array.isArray(response.data) && response.data.length) {
                    this.userList = response.data;
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