<template>
	<div id="wr-bct-button">
		<div id="bct-button" @click="$router.replace(`/createTask`)">Создать задачу</div>
	</div>
</template>

<script>
export default {
	components: {

	}
}
</script>

<style lang="scss" scoped>
	#wr-bct-button {
		display: flex;

		#bct-button {
			background: #0079c1;
			line-height: 2em;
			color: #f0f0f0;
			padding: 0 .8em;
			border-radius: 4px;
			font-size: .8em;
			margin: auto;
			font-weight: 700;
			transition:200ms all 0s ease;
			cursor: pointer;
			&:hover {
				background: #0c91e1;
			}
		}
	}
</style>
