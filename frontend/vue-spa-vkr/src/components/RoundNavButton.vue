<template>
	<div class="right-nav-btn" data-label="Задачи">
		<div class="logo-box">
			<img :src="this.src" alt="">
		</div>
	</div>
</template>

<script>
export default {
	name: 'RoundNavButton',
	props: {
		src: String
	}
}
</script>

<style lang="scss" scoped>
	.right-nav-btn {
		background: #1151a51c;
		border-radius: 50%;
		height: 34px;
		width: 34px;
		margin: 0 auto;
		display: flex;
		transition:200ms all 0s ease;
		cursor: pointer;

		&:hover {
			background: #c0c0c0;
		}

		.logo-box {
			width: 16px;
			height: 16px;
			margin: auto;

			img {
				width: 16px;
				height: 16px;
			}
		}
	}
</style>
