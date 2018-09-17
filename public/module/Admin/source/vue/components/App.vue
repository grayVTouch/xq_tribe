<template>
    <section ref="container" class="container">
        <!-- 加载层 -->
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

        <!-- 主体内容 -->
        <div class="main">
            <transition :name="this.$store.state.trans">
                <keep-alive>
                    <router-view class="trans"></router-view>
                </keep-alive>
            </transition>
        </div>
    </section>
</template>

<script>
    export default {
        name: "v-app" ,
        data () {
            return {
                dom: {} ,
                instance: {}
            };
        } ,
        mounted () {
            let self = this;
            this.dom.container = G(this.$refs.container);
            // 设置加载层
            this.instance.loading = new Loading(this.dom.container.get(0) , {
                pluginUrl: topContext.pluginUrl + 'Loading/' ,
                status: 'hide'
            });
        }
    }
</script>

<style scoped>
    .container {
        position: absolute;
        left:0;
        top:0;
        width:100%;
        height:100%;
    }

    .container .main {
        height: 100%;
        position: relative;
    }

    .container .main .trans {
        position:absolute;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        transition:all 0.3s linear;
        -webkit-transition:all 0.3s linear;
        -moz-transition:all 0.3s linear;
        -ms-transition:all 0.3s linear;
        -o-transition:all 0.3s linear;
    }
</style>