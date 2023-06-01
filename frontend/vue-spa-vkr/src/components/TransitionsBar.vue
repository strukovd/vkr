<template>
	<div id="transitionsBar">
		<div class="transitionButton" v-for="transition of allowedTransitions" :key="transition.id">{{ transition.name }}</div>
	</div>
</template>

<script>
export default {
	props: {
		allowedTransitions: Array
	},
	methods: {
		async doTransition() {
			Notification.success($key);
			// const taskId = this.$route.params["id"];
			// axios
			// 	.post(`http://localhost:3000/task/${taskId}/doTransition`, {
			// 		data: {
			// 			transitionId: event.key
			// 		}
			// 	})
			// 	.then((response) => {
			// 		this.tasks = response.data;
			// 	})
			// 	.catch((error) => {
			// 		console.error(error);
			// 	});
		}
	}
}
</script>

<style lang="scss" scoped>
	#transitionsBar {
		display: flex;
		// flex-direction: row-reverse;
		flex-flow: row;

		.transitionButton {
			background: #f0f0f0;
			line-height: 2em;
			padding: 0 1em;
			border-radius: 4px;
			cursor: pointer;
			font-size: .9em;
			margin:0 .25em;
		}
	}
</style>