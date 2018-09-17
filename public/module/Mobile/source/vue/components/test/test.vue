<template>
    <div class="test">
        <button @click="$store.commit('next' , {name: 'login'})">数据测试，点我跳转到注册页面</button>
    </div>
</template>

<script>
    export default {
        name: "v-test"
    }
</script>

<style scoped>

</style>