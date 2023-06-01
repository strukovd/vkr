<template>
	<nav id="top-nav-bar">
		<ul>
			<li>Проекты</li>
			<li>Список задач</li>
		</ul>
	</nav>
</template>

<script>
export default {
	components: {
		
	}
}
</script>

<style lang="scss" scoped>
	#top-nav-bar {
		padding:0 1em;

		ul {
			list-style: none;
			padding: 0;
			display: flex;

			li {
				font-size:.9em;
				color: #777;
				cursor: pointer;
				padding:0 .6em;
			}
		}
	}
</style>
