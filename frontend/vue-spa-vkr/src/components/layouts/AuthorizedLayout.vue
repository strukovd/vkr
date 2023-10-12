<template>
	<HeaderBar></HeaderBar>
	<main id="main">
		<section class="left-section">
			<LeftPanel></LeftPanel>
		</section>
		<section class="right-section">
			<router-view></router-view>
		</section>
	</main>
</template>

<script>
import LeftPanel from '../LeftPanel.vue';
import HeaderBar from '../HeaderBar.vue';

export default {
	components: {
		HeaderBar,
		LeftPanel
	}
}
</script>

<style lang="scss">
	#main {
		display: flex;
		min-height: calc(100vh - 50px);
		.left-section {
			display: flex; /*что бы вложенная панель заняла всю высоту*/
		}
		.right-section {
			flex-grow: 1;
		}
	}
</style>