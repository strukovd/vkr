<template>
	<nav id="top-nav-bar">
		<ul>
			<li>Проекты</li>
			<li @click="$router.replace(`/`)">Список задач</li>
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
				transition:all 300ms ease 0s;

				&:hover {
					color: #333;
				}
			}
		}
	}
</style>
