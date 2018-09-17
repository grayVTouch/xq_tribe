<template>
    <v-form>
        <template slot="title">用户登录</template>
        <template slot="form">
            <form class="form" @submit.prevent="submit">
                <div class="line" :class="classname.name">
                    <div class="input">
                        <input type="text" v-model="form.username" autofocus="autofocus" @input="verifyName" placeholder="用户名" class="form-text">
                    </div>
                    <div class="tip">{{ tip.name }}</div>
                </div>

                <div class="line" :class="classname.password">
                    <div class="input">
                        <input type="password" v-model="form.password" @input="verifyPassword" placeholder="密码" class="form-text">
                    </div>
                    <div class="tip">{{ tip.password }}</div>
                </div>

                <div class="line verify-code" :class="classname.code">
                    <div class="input">
                        <input type="text" v-model="form.code" @input="verifyCode" placeholder="验证码" class="form-text">
                        <img :src="code" class="image code" @click="captcha" :codeKey="form.codeKey">
                    </div>
                    <div class="tip">{{ tip.code }}</div>
                </div>

                <div class="line">
                    <i-switch v-model="remember"></i-switch>&nbsp;&nbsp;记住密码
                </div>
                <div class="line center">
                    <button type="submit" class="btn-2">登陆</button>
                </div>
            </form>
        </template>
    </v-form>
</template>

<script src="./js/login.js"></script>
<style scoped src="./css/login.css"></style>