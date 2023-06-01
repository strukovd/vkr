<template>
	<select ref="userSelect">
		<option v-for="user of userList" :key="user.id" :value="user.id">{{ user.display_name }}</option>
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
			userList: []
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