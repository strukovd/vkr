<template>
	<aside >
		<nav>
			<div class="">
				<div class="logo-box">
					<img src="@/assets/icons/tasks.svg" alt="">
				</div>
				<div class="caption-box">
					Задачи
				</div>
			</div>
		</nav>
	</aside>
</template>

<script>

export default {
	name: 'TopNavBar',
	components: {

	}
}
</script>

<style lang="scss" scoped>
	#top-nav-bar {
		background: #FAFAFACC;
		height: 50px;
		padding:0 1em;
		display: flex;

		.tnb-left {
			display: flex;
			flex-direction: row;
		}

		.tnb-right {
			$INTERCEIL_MARGIN: .2em;

			flex-grow: 1;
			display: flex;
			flex-direction: row;
			justify-content: flex-end;
			// margin: auto 0;

			.ceil-searchbox {
				margin:auto $INTERCEIL_MARGIN;
			}

			.ceil-user {
				margin:0 $INTERCEIL_MARGIN;

				&:hover {
				background: #35455C22;
				// background: #DADADA99;
			}
			}
		}
	}
</style>
