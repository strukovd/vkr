<template>
	<div id="transitionsBar">
		<TransitionButton
			v-for="transition of allowedTransitions"
			:key="transition.id"
			:transitionId="transition.id"
			:transitonName="transition.name"/>
	</div>
</template>

<script>
import TransitionButton from './TransitionButton.vue';
export default {
  components: { TransitionButton },
	props: {
		allowedTransitions: Array
	}
}
</script>

<style lang="scss" scoped>
	#transitionsBar {
		display: flex;
		// flex-direction: row-reverse;
		flex-flow: row;
	}
</style>