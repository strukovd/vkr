<template>
	<div class="transitionButton" @click="doTransition"><span>{{ transitonName }}</span></div>
</template>

<script>
import axios from 'axios';
export default {
	props: {
		transitonName: String,
		transitionId: Number
	},
	methods: {
		async doTransition() {
			const taskId = this.$route.params["id"];

			console.log(`this.transitionId: ${this.transitionId} taskId: ${taskId}`);
			axios
				.patch(`http://localhost:3000/task/${taskId}/doTransition`, {
					transitionId: this.transitionId
				})
				.then((response) => {
					console.log(JSON.stringify(response));
					Notification.success(JSON.stringify(response));
					this.$router.go(0);
					// this.$router.replace(this.$route.path);
				})
				.catch((error) => {
					Notification.error(error?.response?.data?.message);
					console.error(error);
				});
		}
	}
}
</script>

<style lang="scss" scoped>
	.transitionButton {
		display: flex;
		background: #f0f0f0;
		line-height: 2em;
		padding: 0 1em;
		border-radius: 4px;
		cursor: pointer;
		font-size: .9em;
		margin:0 .25em;
		transition:all 300ms ease 0s;

		&::before {
			content:"➪";
			// ⇨ ⇒
			margin:auto;
			padding-right:.6em;
			color:#172b4d82;
		}

		&:hover {
			background: #dbdbdb;
		}
	}
</style>