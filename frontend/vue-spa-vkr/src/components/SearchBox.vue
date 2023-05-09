<template>
	<div>
		<input id="search-input" type="text">
	</div>
</template>

<script>
export default {
  name: 'SearchBox'
}
</script>

<style scoped>
	#search-input:focus {
		outline: 3px solid #215abd66;
	}
	#search-input {
		background: #E6EBF5;
		line-height: 1.8em;
		border: none;
		border-radius: 3px;
		padding: .1em .8em;
		color: #203456;
		/* box-shadow: inset 1px 0 3px 0 rgb(44 88 225 / 20%); */
		border: 1px solid #93aad938;
		font-weight: 700;
		font-size: 14px;
	}
</style>
