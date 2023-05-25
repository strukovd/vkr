<template>
	<div class="msg-block">
		<h1 class="title">Not found 404</h1>
		<div class="msg">Страница не найдена</div>
	</div>
</template>

<script>
export default {
	name: 'App',
	components: {

	}
}
</script>

<style lang="scss" scoped>
	.msg-block {
		margin: auto;
		background: white;
		padding: 4em 12em;
		text-align: center;
		border-radius: 3px;
		box-shadow: 0px 1px 4px 0 rgba(0, 0, 0, 0.1);

		.title {
			color: #172b4d;
		}
		.msg {
			color: #666;
		}
	}
</style>
