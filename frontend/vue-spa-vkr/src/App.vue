<template>
	<HeaderBar></HeaderBar>
	<main id="main">
		<div class="left-main">
			<RightPanel></RightPanel>
		</div>
		<div class="right-main">
			<router-view></router-view>
		</div>
	</main>
</template>

<script>
import RightPanel from './components/RightPanel.vue';
import HeaderBar from './components/HeaderBar.vue'

export default {
	name: 'App',
	components: {
		HeaderBar,
		RightPanel
	}
}
</script>

<style lang="scss" scoped>
#main {
	display: flex;
    min-height: calc(100vh - 50px);
}
</style>
