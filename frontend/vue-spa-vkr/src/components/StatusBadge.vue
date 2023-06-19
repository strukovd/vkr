<template>
	<div class="statusBadge" :class="computedStatusClass">{{ status }}</div>
</template>

<script>
export default {
	props: {
		status: String
	},
	data: ()=>{
		return {

		};
	},
	computed: {
		computedStatusClass() {
			if(!this.status || this.status.length < 2) {
				return `badge0`;
			}

			let badgeNum = (
				this.status.charCodeAt(0) +
				this.status.charCodeAt(1) +
				this.status.charCodeAt( this.status.length-1 )
			) % 16;
			return `badge${badgeNum}`;
		},
	}
}
</script>

<style lang="scss">
	.statusBadge {
		display: inline-block;
		line-height: 1.6em;
		padding: 0 1.2em;
		border-radius: 4px;
		font-size: 12px;
		font-weight: 700;
		// box-shadow: 1px 1px 4px 0 rgba(0,0,0,.2);
	}

	.badge0
	{
		background: #3cfdb3;
		color: #006b42;
	}

	.badge1
	{
		background: #ff72b4;
		color: #790039;
	}

	.badge2
	{
		background: #c86aff;
		color: #360056;
	}

	.badge3
	{
		background: #fda953;
		color: #6b3600;
	}

	.badge4
	{
		background: #f57f7f;
		color: #901d1d;
	}

	.badge5
	{
		background: #66a9ef;
		color: #0a417b;
	}

	.badge6
	{
		background: #3cf0fd;
		color: #0d555a;
	}

	.badge7
	{
		background: #e5e800;
		color: #544e00;
	}

	.badge8
	{
		background: #e8e8e8;
		color: #292929;
	}

	.badge9
	{
		background: #609859;
		color: #fff;
	}

	.badge10
	{
		background: #56789c;
		color: #fff;
	}

	.badge11
	{
		background: #d6d6d6;
		color: #353535;
	}

	.badge12
	{
		background: #c49fec;
		color: #411571;
	}

	.badge13
	{
		background: #484848;
		color: #fff;
	}

	.badge14
	{
		background: #fdd33c;
		color: #654f00;
	}

	.badge15
	{
		background: #985e5e;
		color: #fff;
	}
</style>
