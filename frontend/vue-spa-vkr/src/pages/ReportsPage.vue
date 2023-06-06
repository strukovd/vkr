<template>
	<main id="reports">
		<aside id="left-side">
			<div class="wr-chart">
				<h1>Заявок поступило</h1>
				<apexchart width="500" type="bar" :options="options" :series="series"></apexchart>
			</div>
			<div class="wr-chart">
				<h1>Заявок исполнено</h1>
				<apexchart width="500" type="bar" :options="options" :series="series"></apexchart>
			</div>
		</aside>
		<aside id="right-side">
			<div class="wr-chart">
				<h1>Зарегистрировано посещений</h1>
				<apexchart width="500" type="line" :options="options" :series="series" title="sas"></apexchart>
			</div>
			<div class="wr-chart">
				<h1>Зарегистрировано пользователей</h1>
				<apexchart width="500" type="pie" :options="options" :series="series"></apexchart>
			</div>
		</aside>
	</main>
</template>

<script>
// import VueApexCharts from 'vue-apexcharts';

export default {
	data() {
		return {
			options: {
				chart: {
					id: 'vuechart-example'
				},
				xaxis: {
					categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998]
				}
			},
			series: [{
				name: 'series-1',
				data: [30, 40, 45, 50, 49, 60, 70, 91]
			}]
		};
	}
	// mounted() {
	// 	this.renderChart();
	// },
	// methods: {
	// 	renderChart() {
	// 	const options = {
	// 		// Здесь вы можете настроить опции для вашей диаграммы
	// 		chart: {
	// 			type: 'bar',
	// 		},
	// 		series: [
	// 			{
	// 				name: 'Sales',
	// 				data: [30, 40, 45, 50, 49, 60, 70, 91, 125],
	// 			},
	// 		],
	// 		xaxis: {
	// 			categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep'],
	// 		},
	// 	};

	// 	// const chart = new ApexCharts(this.$refs.chart, options);
	// 	// chart.render();
	// 	},
	// },
};
</script>

<style lang="scss" scoped>
	.wr-chart {
		background: #fff;
		padding: 1em;
		border: 1px solid #dfe6f0;
		margin: 1em;

		h1 {
			text-align: center;
		}
	}

	#reports {
		display: flex;

		#left-side {

		}
		#right-side {

		}
	}
</style>