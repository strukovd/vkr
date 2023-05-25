import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue';
import TasksPage from './pages/TasksPage.vue';
import TaskDetailPage from './pages/TaskDetailPage.vue';
import Page404 from './pages/Page404.vue';
import './styles/index.css';

const router = createRouter({
	history: createWebHistory(),
	routes: [
		{
			path: "/",
			component: TasksPage
		},
		{
			path: "/task/:id",
			component: TaskDetailPage
		},
		{
			path: "/:catchAll(.*)",
			component: Page404
		}
	]
});


createApp(App)
	.use(router)
	.mount('#app');
