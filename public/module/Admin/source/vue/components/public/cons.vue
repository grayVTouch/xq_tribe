<template>
    <div  ref="cons" class="cons v-cons">
        <!-- 当前位置 -->
        <div class="top pos">
            <div class="left">
                <img :src="route.top.bIco" class="image">
                {{ route.top.cn }}
            </div>
            <div class="right">
                <span class="sec" v-for="v in route.routes" :class="v.path === route.cur.path ? 'cur' : ''" :key="v.path" @click="to(v)">{{ v.cn }}<i class="sep">/</i></span>
            </div>
        </div>

        <div class="btm c-cons">
            <slot name="cons"></slot>
        </div>

        <!-- 加载元素 -->
        <div class="Loading hide">
            <!-- 背景颜色 -->
            <div class='bg'></div>
            <div class="cons">
                <div class="text"></div>
                <div class="animate">
                    <!-- 图片加载动画 -->
                    <div class="_image">
                        <img :src="$store.state.pluginUrl + 'Loading/image/style-1.png'" data-style="1" class='image'>
                        <img :src="$store.state.pluginUrl + 'Loading/image/style-2.png'" data-style="2" class='image'>
                        <img :src="$store.state.pluginUrl + 'Loading/image/style-3.png'" data-style="3" class='image'>
                    </div>
                    <!-- 线条加载动画 -->
                    <div class="html">
                        <div class="item line-scale" data-style="1">
                            <div></div>
                            <div></div>
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>

                        <div class="item ball-pulse" data-style="2">
                            <div></div>
                            <div></div>
                            <div></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 关闭按钮 -->
            <div class="btns">
                <div class="btn close">
                    <div class="positive"></div>
                    <div class="negative"></div>
                </div>
            </div>
        </div>
    </div>
</template>

<script src="./js/cons.js"></script>
<style scoped src="./css/cons.css"></style>