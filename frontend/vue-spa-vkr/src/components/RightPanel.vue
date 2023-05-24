<template>
	<aside class="aside">
		<nav>
			<RoundNavButton :src="require(`@/assets/icons/tasks.svg`)"></RoundNavButton>
			<RoundNavButton :src="require(`@/assets/icons/subscribers.svg`)"></RoundNavButton>
		</nav>
	</aside>
</template>

<script>
import RoundNavButton from './RoundNavButton.vue'

export default {
	components: {
		RoundNavButton
	}
}
</script>

<style lang="scss" scoped>
	.aside {
		background: #fafafae6;
		flex: 0 0 auto;
		width: 50px;
	}
</style>
