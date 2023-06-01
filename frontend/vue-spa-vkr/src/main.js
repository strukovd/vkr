import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router';
import App from './App.vue';
import TasksPage from './pages/TasksPage.vue';
import TaskDetailPage from './pages/TaskDetailPage.vue';
import CreateTask from './pages/CreateTask.vue';
import LoginPage from './pages/LoginPage.vue';
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
	if(sessionStorage.getItem('username') == "admin") {
		return true;
	}
	else {
		return false;
	}
}


createApp(App)
	.use(router)
	.mount('#app');
