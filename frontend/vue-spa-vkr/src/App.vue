<template>
	<HeaderBar></HeaderBar>
	<main id="main">
		<section class="left-section">
			<LeftPanel></LeftPanel>
		</section>
		<section class="right-section">
			<router-view></router-view>
		</section>
	</main>
</template>

<script>
import LeftPanel from './components/LeftPanel.vue';
import HeaderBar from './components/HeaderBar.vue';

export default {
	components: {
		HeaderBar,
		LeftPanel
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
+ Переходы
- Авторизация
+ Создание задачи
	+ Исправить назначение первого статуса для каждого проекта свой
	+ И для каждого проекта свой бизнес процесс
	+ Наладить переходы (сохранять испотрию),
		А затем графики

Список пользователей

+ Сортировка
Коммантарии
+ Поиск
исправиль аватарку в UserBox

Отделный сайт как forms, для подачи заявок абонентами
-->