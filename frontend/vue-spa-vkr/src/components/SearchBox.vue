<template>
	<div id="wr-search">
		<input v-model.lazy="searchQuery" id="search-input" type="text">
		<div v-if="Array.isArray(foundTasks) && foundTasks.length" id="search-result-box">
			<div v-for="foundTask of foundTasks" :key="foundTask.id" class="found-task">
				<div class="title">{{ foundTask.title }}</div>
				<div><span class="status-id">Номер: {{ foundTask.id }}</span></div>
				<div class="status">Статус: <StatusBadge :status="foundTask.status_name"/></div>
				<div class="assignee">Исполнитель: {{ foundTask.assignee_name }}</div>
			</div>
		</div>
		<div v-else-if="String(searchQuery).trim()" id="search-result-box">
			<div class="tasks-not-found-msg">Ничего не найдено!</div>
		</div>
	</div>
</template>

<script>
import axios from 'axios';
import StatusBadge from './StatusBadge.vue'
export default {
	components: { StatusBadge },
	data() {
		return {
			searchQuery: "",
			foundTasks: [
				// {
				// 	id:29,
				// 	title:"Глафира Дементьева",
				// 	description:"Развивающиеся социально-экономическое не развитие и активности социально-экономическое с сфера до возрастает мира данными ценностей. ценностей.. Укрепления до что третьего сомнений,. Неузнаваемости нашей развития моральных постоянный не укрепления. И третьего их мира развитие частности активности постоянный.\nМира последовательного чего моральных чего общества. Частности развитие поэтапного страны статус однозначно рост общества до необходимость укрепления до. Сомнений, из-за но что с рост И уникальными. Активности чего частности И И рост. Значение моральных моральных фиксирует сомнений, нашей необходимость нашей смешаны возрастает количественный уникальными моральных позволяет нашей. Однозначно третьего но уникальными общества моральных последовательного позволяет развития и уникальными развивающиеся третьего. В но мира однозначно общества что бесполезности..\nФиксирует развития чего необходимость чего уникальными моральных рост мира общества оценить ценностей. поэтапного нашей постоянный. Ценностей. уникальными их их постоянный. Значение статус рост активности количественный. Развитие поэтапного до данными фиксирует И развитие в укрепления фиксирует. Уникальными нашей ценностей. данными совершенной ценностей. развивающиеся социально-экономическое сомнений, общества ценностей. И уникальными.\nМоральных с и сфера не из-за уникальными из-за. Развития необходимость социально-экономическое нет страны значение укрепления необходимость их развития возрастает общества бесполезности. ценностей.. Значение нашей укрепления в позволяет однозначно страны их бесполезности. оценить количественный частности степени не совершенной. Фиксирует степени страны необходимость ценностей. социально-экономическое не и уникальными но третьего социально-экономическое третьего. Не необходимость социально-экономическое чего мира фиксирует смешаны что И и постоянный однозначно. Частности из-за ценностей. сомнений, рост сомнений,.\nСмешаны чего укрепления активно третьего. И ценностей. нашей из-за И и нашей социально-экономическое нашей частности степени развивающиеся фиксирует. Статус фиксирует активности до статус однозначно совершенной значение частности рост в. Позволяет позволяет развития нет их значение степени чего совершенной развития оценить И И мира. Нашей в частности но и и их позволяет рост но.",
				// 	priority:1,
				// 	assignee:"admin",
				// 	assignee_name:"Администратор",
				// 	creator:"admin",
				// 	creator_name:"Администратор",
				// 	created:"23.05.2023",
				// 	updated:"23.05.2023",
				// 	project_name:"Жалобы",
				// 	img:"data:image/png;base64,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",
				// 	status:0,
				// 	status_name:"Статус0"

				// }
			]
		};
	},
	watch: {
		searchQuery() {
			const query = String(this.searchQuery).trim();
			if(query) {
				axios
					.get(`http://localhost:3000/task/find/${query}`)
					.then((response) => {
						this.foundTasks = response.data;
					})
					.catch((error) => {
						console.error(error);
					});
			}
			else {
				this.foundTasks = [];
			}
		}
	}
}
</script>

<style lang="scss" scoped>
	#wr-search {
		position: relative;

		#search-input:focus {
			outline: 3px solid #215abd66;
		}
		#search-input {
			background: #E6EBF5;
			line-height: 1.8em;
			border: none;
			border-radius: 3px;
			padding: .1em .8em;
			color: #203456;
			/* box-shadow: inset 1px 0 3px 0 rgb(44 88 225 / 20%); */
			border: 1px solid #93aad938;
			font-weight: 700;
			font-size: 14px;
		}

		#search-result-box {
			background:#ffffff;
			border:1px solid #0a163024;
			border-radius:3px;
			// padding:.4em 0;

			position: absolute;
			top:2.2em;
			right:0;
			left:0;

			.found-task {
				padding:.4em .5em;
				border-bottom:1px solid #0a16300d;
				cursor:pointer;
				&:hover{
					background:#1151a50d;
				}

				.title {
					font-size:.8em;
				}
				.status-id, .status, .assignee {
					color: #172b4da1;
					font-size: .7em;
					padding: 0 0.4em;
				}
			}

		}


		.tasks-not-found-msg {
			text-align: center;
			font-size: .8em;
			font-weight: 700;
			line-height: 3.2em;
		}
	}
</style>
