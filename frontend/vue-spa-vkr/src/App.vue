<template>
	<HeaderBar></HeaderBar>
	<main id="main">
		<RightPanel></RightPanel>
		<router-view></router-view>
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

<style>
#main {
	display: flex;
    min-height: calc(100vh - 50px);
}
</style>
