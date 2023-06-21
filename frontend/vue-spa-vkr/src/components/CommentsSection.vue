<template>
	<section class="comments">
		<h2>Комментарии</h2>
		<div class="new-comment">
			<div class="wr-textarea">
				<textarea v-model="newComment"></textarea>
			</div>
			<div class="wr-button">
				<button @click="sendComment">Отправить</button>
			</div>
		</div>
		<div v-if="commentsLoaded" class="comments">
			<div class="comment" v-for="comment of comments" :key="comment.id">
				<div class="text">{{ comment.comment }}</div>
				<div><span class="author">{{ comment.author }}</span> <span class="timestamp">{{ comment.created }}</span></div>
			</div>
		</div>
	</section>
</template>

<script>
import axios from 'axios';
export default {
	components: {

	},
	data() {
		return {
			commentsLoaded: false,
			comments: [],
			newComment: undefined
		};
	},
	mounted() {
		this.fetchComments();
	},
	methods: {
		async fetchComments() {
			const taskId = this.$route.params["id"];
			axios
				.get(`http://localhost:3000/comment/task/${taskId}`)
				.then((response) => {
					this.comments = response.data;
					this.commentsLoaded = true;
				})
				.catch((error) => {
					console.error(error);
				});
		},

		async sendComment() {
			const taskId = this.$route.params["id"];
			axios
				.post(`http://localhost:3000/comment`, {
					taskId,
					comment: this.newComment,
					author: sessionStorage.getItem('username')
				})
				.then(() => {
					this.comments.push({id: 0, comment: this.newComment, author: sessionStorage.getItem('username')});
					this.newComment = undefined;
				})
				.catch((error) => {
					console.error(error);
				});
		}
	}
}
</script>

<style lang="scss" scoped>
	section.comments {
		h2 {

		}

		.new-comment {
			textarea {
				font-size: .9em;
				width: 100%;
				box-sizing: border-box;
				outline: none;
				border: 1px dashed #033d7440;
				margin: 0.5em 0;
				padding: 0.8em 1em;
				color: #172b4db5;
				background: #90aacb1c;
				border-radius: 4px;
				min-height: 8em;
			}

			.wr-button {
				button {
					background: #0079c1;
					line-height: 2em;
					color: #f0f0f0;
					padding: 0 0.8em;
					border-radius: 4px;
					font-size: .8em;
					font-weight: 700;
					transition: 200ms all 0s ease;
					cursor: pointer;
					border: none;
				}
			}
		}

		.comment {
			background: #f0f0f0;
			padding: 0.5em 1em;
			margin: 0.4em 0;
			border-left: 3px solid #0079c1;
			border-radius: 2px 0 0 2px;

			.text {
				margin-bottom: 0.8em;
			}
			.author {
				font-size:.8em;
				padding:.25em .7em;
				border-radius:6px;
				border: 1px solid #172b4d17;
				background: #172b4d17;
			}
			.timestamp {
				font-size: .8em;
				margin: 1em 0 0 0;
				color: #8b0000c7;
			}
		}
	}
</style>
