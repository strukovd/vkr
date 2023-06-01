<template>
	<select ref="prioritySelect">
		<option v-for="count of 5" :key="count" :value="count">{{ count }}</option>
	</select>
</template>

<script>
export default {

}
</script>

<style>

</style>