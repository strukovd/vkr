<template>
	<header id="top-nav-bar" ref="top-nav-bar">
		<section class="tnb-left"></section>
		<section class="tnb-right">
			<div class="ceil-searchbox">
				<SearchBox></SearchBox>
			</div>
			<div class="ceil-user">
				<UserBox></UserBox>
			</div>
		</section>
	</header>
</template>

<script>
import SearchBox from "./SearchBox.vue";
import UserBox from "./UserBox.vue";

export default {
	name: 'TopNavBar',
	components: {
		SearchBox,
		UserBox
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
