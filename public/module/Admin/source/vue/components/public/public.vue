<template>
    <section ref="public" class="public">
        <!-- 菜单栏 -->
        <div class="menus">
            <div class="top">
                <div class="ico"><img src="./image/logo.png" class="image"></div>
                <div class="text">兴趣部落</div>
            </div>
            <div class="middle">
                <v-functions :_instance="instance"></v-functions>
            </div>
            <div class="btm">兴趣部落</div>
        </div>

        <!-- 内容区域 -->
        <div class="cons">
            <!-- 顶部导航栏 -->
            <div class="top-nav">
                <div class="top">
                    <div class="left"></div>
                    <div class="right">

                        <!-- 功能选项 -->
                        <div class="user" @mouseover="mouseOverForUser" @mouseout="mouseOutForUser">
                            <div class="info">
                                <div class="ico"><img src="./image/thumb.png" class="image"></div>
                                <div class="text">grayVTouch</div>
                            </div>
                            <ul class="functions">
                                <li @click="loginOut">注销</li>
                            </ul>
                        </div>

                    </div>
                </div>

                <div class="btm multiple-tab-container">
                    <div class="multiple-tab">
                        <div class="tabs"></div>
                    </div>
                </div>
            </div>

            <!-- 内容区域 -->
            <div class="content"></div>
        </div>
    </section>
</template>

<script src="./js/public.js"></script>
<style src="./css/public.css"></style>