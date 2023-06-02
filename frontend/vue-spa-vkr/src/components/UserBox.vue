<template>
		<div v-if="displayUserBox" id="user-avatar-box">
			<img src="@/assets/icons/user.svg" alt="">
		</div>
</template>

<script>
export default {
	name: 'SearchBox',
	methods: {
		displayUserBox() {
			return this.isUserAuthenticated();
		}
	}
}
</script>

<style lang="scss" scoped>
	#user-avatar-box {
		width: 50px;
		height: 100%;
		display: flex;

		img {
			margin: auto;
			position: relative;
		}
	}
</style>
