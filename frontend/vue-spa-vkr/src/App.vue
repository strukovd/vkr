<template>
	<component :is="layout"></component>
	<!-- <HeaderBar></HeaderBar>
	<main id="main">
		<section class="left-section">
			<LeftPanel></LeftPanel>
		</section>
		<section class="right-section">
			<router-view></router-view>
		</section>
	</main> -->
</template>

<script>
import LeftPanel from './components/LeftPanel.vue';
import HeaderBar from './components/HeaderBar.vue';
import UnauthorizedLayout from './components/layouts/UnauthorizedLayout.vue';
import AuthorizedLayout from './components/layouts/AuthorizedLayout.vue';

export default {
	components: {
		HeaderBar,
		LeftPanel,
		UnauthorizedLayout,
		AuthorizedLayout
	},
	computed: {
		layout() {
			return "UnauthorizedLayout";
		}
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
Редактирование исполнителя и приоритета задачи
Фильтрация по проектам
Диаграммы (по исполнителям)

+ Переходы
- Авторизация
+ Создание задачи
	+ Исправить назначение первого статуса для каждого проекта свой
	+ И для каждого проекта свой бизнес процесс
	+ Наладить переходы (сохранять испотрию),
		- А затем графики

+ Список пользователей
+ Добавление пользователей

+ Сортировка
Коммантарии
+ Поиск
	Исправить ссылку на задачу (в найденном поиске)
исправиль аватарку в UserBox

+ Отделный сайт как forms, для подачи заявок абонентами
-->