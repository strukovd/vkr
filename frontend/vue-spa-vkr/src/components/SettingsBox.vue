<template>
		<div v-if="displayUserBox" @click="menuIsDisplayed=!menuIsDisplayed" id="settings-box">
			<img src="@/assets/icons/settings.svg" alt="">
			<menu v-if="menuIsDisplayed" id="settingsMenu">
				<li @click="$router.replace(`/setting/projects`)">Управление проектами</li>
				<li @click="$router.replace(`/setting/users`)">Усправление пользователями</li>
				<li @click="$router.replace(`/setting/users`)">Выход</li>
			</menu>
		</div>
</template>

<script>
export default {
	data() {
		return {
			menuIsDisplayed: false
		};
	},
	methods: {
		displayUserBox() {
			return this.isUserAuthenticated();
		}
	}
}
</script>

<style lang="scss" scoped>
	#settings-box {
		width: 50px;
		height: 100%;
		display: flex;
		position: relative;

		img {
			margin: auto;
			position: relative;
		}

		#settingsMenu {
			position: absolute;
			top:3em;
			right:0;
			padding:0;
			margin:0;
			list-style: none;

			background: #ffffff;
			border: 1px solid #0a163024;
			border-radius: 3px;
			white-space: nowrap;

			li {
				font-size:.8em;
				line-height:2.2em;
				padding:0 2em;
				word-break:keep-all;
				cursor:pointer;

				&:hover {
					background: #f0f0f0;
				}
			}
		}
	}
</style>
