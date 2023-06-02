<template>
	<select v-model="priority" ref="prioritySelect">
		<option v-for="count of 5" :key="count" :value="count">{{ count }}</option>
	</select>
</template>

<script>
export default {
	data() {
		return {
			priority: ""
		};
	}
}
</script>

<style>

</style>