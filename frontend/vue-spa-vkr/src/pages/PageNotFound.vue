<template>
	<div class="msg-block">
		<h1 class="title">Not found 404</h1>
		<div class="msg">Страница не найдена</div>
	</div>
</template>

<script>
export default {
	components: {

	}
}
</script>

<style lang="scss" scoped>
	.msg-block {
		background: #90aacb1c;
		border-radius: 4px;
		box-shadow: 0 0 2px 0 #172b4d1f;
		margin: 2em 2em;
		padding: 1em 1em 2em 1em;
		border: 1px dashed #033d7440;
		text-align: center;

		.title {
			color: #172b4d;
		}
		.msg {
			color: #666;
		}
	}
</style>
