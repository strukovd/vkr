import { createApp } from 'vue';
import { createRouter, createWebHashHistory } from 'vue-router'
import App from './App.vue';
import './styles/index.css';

const router = createRouter({
	history: createWebHashHistory(),
	routes: [
		{
			path: "/",
			component: ""
		},
		{
			path: "/start",
			component: ""
		}
		// здесь должны быть определены маршруты
	]
});


createApp(App)
	.use(router)
	.mount('#app');
