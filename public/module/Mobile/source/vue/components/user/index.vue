<template>
    <section class="index">
        <button @click.prevent="prev" class="btn-1">首页</button>
    </section>
</template>

<script>
    export default {
        name: "v-index" ,
        methods: {
            prev () {
                // console.log('已经更新状态：' , this.$store.state.trans);
                this.$store.commit('back');
            } ,
            user () {
                this.$store.commit('next' , '/user/index');
            }

        }
    }
</script>

<style scoped>
    .index {
        width:100%;
        height:80px;
        background-color:gray;
    }
</style>