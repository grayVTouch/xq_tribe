<template>
    <section class="container" ref="container">
        <!-- 幻灯片 -->
        <div class="top">
            <div class="btns">
                <div class="left clear-float">
                    <a class="link" href="javascript:void(0);" @click.prevent="$store.commit('back')"><img src="~assets/image/back.png" class="image"></a>
                </div>
                <div class="right"></div>
            </div>

            <div class="slider">
                <div class='pic-play'>
                    <div class='images'>
                        <div class='_images'>
                            <a href='javascript:void(0);' class='link' v-for="v in $store.state.user.images"><img :src="v" class='image' /></a>
                        </div>

                        <div class='prev'><img :src="$store.state.pluginUrl + 'PicPlay_Touch/image/prev.png'" class='image'></div>
                        <div class='next'><img :src="$store.state.pluginUrl + 'PicPlay_Touch/image/next.png'" class='image'></div>
                    </div>

                    <div class="index">
                        <div class='_index hide'></div>
                        <div class='_image hide'></div>
                    </div>
                </div>
            </div>

        </div>
        <!-- 表单内容 -->
        <div class="btm">
            <h1 class="header">
                <slot name="title"></slot>
            </h1>

            <slot name="form"></slot>
        </div>
    </section>
</template>

<script>
    export default {
        name: "v-form" ,
        data () {
            return {
                image: 0 ,
                dom: {} ,
                instance: {}
            };
        } ,
        mounted () {
            this.dom.container = G(this.$refs.container);
            this.dom.slider = G('.slider' , this.dom.container.get(0));

            this.instance.picPlay = new PicPlayTouch(this.dom.slider.get(0) , {
                // 动画过度时间
                time: 200 ,
                // 定时器时间
                duration: 5000 ,
                // 索引类型, index-普通索引 image-图片索引 none-无索引
                indexType: 'index' ,
                // 索引容器位置 (inside | outside)
                indexPos: 'outside' ,
                // 索引摆放类型（horizontal|vertical）
                placementType: 'horizontal' ,
                // 索引摆放位置（top|right|bottom|left）
                // placementType = horizontal，则允许的值有 top|bottom；placementType = vertical，则允许的值有 left|right
                placementPos: '' ,
                // 链接点击后回调
                link: null ,
                // 是否启用 上一张 | 下一张 功能
                enableOpr: true ,
                // 是否启用滚动功能
                enableScroll: true ,
                // 是否开启拖拽功能
                enableDrag: true ,
                // 是否开启定时轮播功能
                enableTimer: true ,
                // 初始索引
                index: 1 ,
                // 高宽比
                hwRatio: 0.5 ,
                // 宽高比
                whRatio: 2
            });
        } ,
        activated () {
            this.instance.picPlay.clearTime();
            this.instance.picPlay.setTime();
        } ,
        deactivated () {
            this.instance.picPlay.clearTime();
        } ,
    }
</script>

<style src="./css/gForm.css"></style>
<style scoped src="./css/form.css"></style>