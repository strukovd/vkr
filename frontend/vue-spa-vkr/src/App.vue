<template>
	<TopNavBar></TopNavBar>
	<main id="main">
		<RightPanel></RightPanel>
		<vue-route></vue-route>
	</main>
</template>

<script>
import RightPanel from './components/RightPanel.vue';
import TopNavBar from './components/TopNavBar.vue'

export default {
	name: 'App',
	components: {
    TopNavBar,
    RightPanel
}
}
</script>

<style>
#main {
	display: flex;
}
</style>
