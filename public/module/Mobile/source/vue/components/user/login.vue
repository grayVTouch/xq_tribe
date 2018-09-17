<template>
    <v-form>
        <template slot="form">
            <form class="form" @submit.prevent="submit">
                <div class="line" :class="error.username.status">
                    <div class="input">
                        <div class="left">
                            <img src="./image/user.png" class="image">
                        </div>
                        <div class="right">
                            <input type="text" v-model="form.username" autofocus="autofocus" placeholder="请输入用户名" class="form-text" @input="clear('username')">
                        </div>
                    </div>
                    <div class="tip">{{ error.username.msg }}</div>
                </div>

                <div class="line" :class="error.password.status">
                    <div class="input">
                        <div class="left">
                            <img src="./image/password.png" class="image">
                        </div>
                        <div class="right">
                            <input type="text" v-model="form.password" placeholder="请输入密码" class="form-text" @input="clear('password')">
                        </div>
                    </div>
                    <div class="tip">{{ error.password.msg }}</div>
                </div>

                <div class="line center">
                    <button class="login">{{ loginText }}</button>
                </div>
                <div class="line center">
                    <button class="update">忘记密码</button>
                </div>
                <div class="line center">
                    <button class="register" type="button" @click="$store.commit('next' , '/register')">注册</button>
                </div>
            </form>
        </template>
    </v-form>
</template>

<script src="./js/login.js"></script>
<style scoped src="./css/login.css"></style>