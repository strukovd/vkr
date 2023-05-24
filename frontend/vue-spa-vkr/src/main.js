import { createApp } from 'vue';
import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue';
import Tasks from './pages/Tasks.vue';
import './styles/index.css';

const router = createRouter({
	history: createWebHistory(),
	routes: [
		{
			path: "/",
			component: Tasks
		},
		{
			path: "/start",
			component: "",
		}
	]
});


createApp(App)
	.use(router)
	.mount('#app');
