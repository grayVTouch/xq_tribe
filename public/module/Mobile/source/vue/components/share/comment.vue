<template>
    <div class="line clear-float">
        <div class="left">
            <div class="image-shell"><img :src="data.user.avatar_url ? data.user.avatar_url : $store.state.config.res.avatar" class="image"></div>
        </div>
        <div class="right">
            <div class="c-line user clear-float">
                <div class="c-left">{{ data.user.username }}</div>
                <div class="c-right clear-float">
                    <div class="function">
                        <span class="count">10</span>
                        <img src="~assets/image/praises.png" class="image">
                    </div>

                    <div class="function">
                        <img src="~assets/image/comment_share.png" class="image">
                    </div>

                </div>
            </div>
            <div class="c-line text" @click="click">{{ data.content }}</div>
            <div class="c-line time">{{ data.create_time }}</div>
            <div class="c-line reply" v-if="data.reply_count > 0">

                <div class="r-line" v-for="v in data.simple_reply">
                    <div class="c-r-line name">{{ v.user.username }}</div>
                    <div class="c-r-line text" @click="click">{{ v.content }}<template v-if="v.pid != data.id"><span class="reply-user">@{{ v.reply.user.username }}：</span>{{ v.reply.content }}</template></div>
                </div>

                <div class="r-line view" @click="click">查看全部{{ data.reply_count }}条回复&nbsp;&nbsp;<span class="simsun">&gt;</span></div>

            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "v-comment" ,
        data () {
            return {
            };
        } ,
        props: {
            data: {
                type: Object ,
                required: true
            }
        } ,
        methods: {
            click () {
                this.$emit('click' , this.data);
            }
        }
    }
</script>

<style scoped src="./css/comment.css"></style>