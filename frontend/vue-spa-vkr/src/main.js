import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue';
import Tasks from './pages/Tasks.vue';
import Page404 from './pages/Page404.vue';
import './styles/index.css';

const router = createRouter({
	history: createWebHistory(),
	routes: [
		{
			path: "/",
			component: Tasks
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
