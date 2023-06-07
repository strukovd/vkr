import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router';
import VueApexCharts from "vue3-apexcharts";
import App from './App.vue';
import TasksPage from './pages/TasksPage.vue';
import TaskDetailPage from './pages/TaskDetailPage.vue';
import CreateTask from './pages/CreateTask.vue';
import LoginPage from './pages/LoginPage.vue';
import ReportsPage from './pages/ReportsPage.vue';
import SettingUsersPage from './pages/SettingUsersPage.vue';
import CreateUser from './pages/CreateUser.vue';
import PageNotFound from './pages/PageNotFound.vue';
import './styles/index.css';
import './styles/notification.scss';

const router = createRouter({
	history: createWebHistory(),
	routes: [
		{
			path: "/",
			component: TasksPage,
			meta: { requiresAuth: true }
		},
		{
			path: "/task/:id",
			component: TaskDetailPage,
			meta: { requiresAuth: true }
		},
		{
			path: "/createTask",
			component: CreateTask,
			meta: { requiresAuth: true }
		},
		{
			path: "/login",
			component: LoginPage
		},
		{
			path: "/setting",
			meta: { requiresAuth: true },
			children: [
				{
					path: "users",
					component: SettingUsersPage
				},
				{
					path: "createUser",
					component: CreateUser
				},
				{
					path: "projects",
					component: null
				}
			]
		},
		{
			path: "/reports",
			component: ReportsPage
		},
		{
			path: "/:catchAll(.*)",
			component: PageNotFound
		}
	]
});

router.beforeEach((to, from, next) => {
	if (to.meta.requiresAuth && !isUserAuthenticated()) {
		// Если маршрут требует авторизации и пользователь не авторизован
		next('/login');
	} else {
		next();
	}
});

function isUserAuthenticated() {
	console.log(sessionStorage.getItem('username'));
	const res = sessionStorage.getItem('username') === "admin";
	console.log(res);
	return res;
}


createApp(App)
	.use(router)
	.use(VueApexCharts)
	.mixin({
		isUserAuthenticated
	})
	.mount('#app');
