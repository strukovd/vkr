<template>
	<aside class="aside">
		<nav>
			<div class="wr-button">
				<RoundNavButton :src="require(`@/assets/icons/tasks.svg`)"></RoundNavButton>
			</div>
			<div class="wr-button">
				<RoundNavButton :src="require(`@/assets/icons/subscribers.svg`)"></RoundNavButton>
			</div>
			<div class="wr-button">
				<RoundNavButton :src="require(`@/assets/icons/chart.svg`)"></RoundNavButton>
			</div>
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

		nav {
			.wr-button {
				padding:10px 0;
			}
		}
	}
</style>
