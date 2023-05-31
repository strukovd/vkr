<template>
	<div class="priorityBadge" :class="computedPriorityClass">{{getPriorityName()}}</div>
</template>

<script>
export default {
	props: {
		priority: String
	},
	data: ()=>{
		return {

		};
	},
	methods: {
		getPriorityName() {
			const priorityList = ["Очень низкий", "Низкий", "Средний", "Высокий", "Очень высокий"];
			return priorityList[ Math.max(Math.min(this.priority, 5), 1)-1 ];
		}
	},
	computed: {
		computedPriorityClass() {
			switch (Number(this.priority)) {
				case 1:
				return 'pb-lowest';
				case 2:
				return 'pb-act-soon';
				case 3:
				return 'pb-alarming';
				case 4:
				return 'pb-critical';
				case 5:
				return 'pb-highest';
				default:
				return '';
			}
		}
	}
}
</script>

<style lang="scss">
	.pb-highest {
		background: #fd4f4f;
		// background: linear-gradient(0deg, #bf360d, #e93a3a, #f56464); /* #dc6350 */
		color: #7c0d0d;
	}
	.pb-critical {
		background: linear-gradient(0deg, #f2ae5d, #f2ae5d, #f2ae5d);
		color: #7e4f16;
	}
	.pb-alarming {
		background: linear-gradient(0deg, #efd648, #efd648, #efd648);
		color: #786705;
	}
	.pb-act-soon {
		background: linear-gradient(0deg, #79ba5e, #79ba5e, #79ba5e);
		color: #265a10;
	}
	.pb-lowest {
		background: linear-gradient(0deg, #f6f6f6, #f6f6f6, #f6f6f6);
	}
	.priorityBadge {
		display: inline-block;
		line-height: 1.6em;
		padding: 0 2em;
		border-radius: 4px;
		font-size: 12px;
		font-weight: 900;
	}
</style>