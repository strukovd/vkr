<template>
	<HeaderBar></HeaderBar>
	<main id="main">
		<section class="left-section">
			<RightPanel></RightPanel>
		</section>
		<section class="right-section">
			<router-view></router-view>
		</section>
	</main>
</template>

<script>
import RightPanel from './components/RightPanel.vue';
import HeaderBar from './components/HeaderBar.vue';

export default {
	components: {
		HeaderBar,
		RightPanel
	}
}
</script>

<style lang="scss" scoped>
#main {
	display: flex;
    min-height: calc(100vh - 50px);
	.left-section {
		display: flex; /*что бы вложенная панель заняла всю высоту*/
	}
	.right-section {
		flex-grow: 1;
	}
}
</style>


<!-- TODO:
Переходы
Авторизация
Создание задачи
Графики

Коммантарии
Поиск
Левая панель навигации
-->