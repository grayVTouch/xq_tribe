<template>
    <section ref="container" class="container">
        <transition
                @enter="enter"
                @leave="leave"
        >
            <keep-alive :exclude="exclude">
                <router-view class="trans"></router-view>
            </keep-alive>
        </transition>
    </section>
</template>

<script>
    export default {
        name: "v-app" ,
        data () {
            return {
                time: 0.25 * 1000 ,
                delay: 20 ,
                enterTimer: null ,
                leaveTimer: null ,
                enterOnce: true ,
                leaveOnce: true ,
                enterWidth: 0 ,
                leaveWidth: 0 ,
                dom: {} ,
                // 排除的缓存的组件
                exclude: []
            };
        } ,
        created () {
            // 获取登陆用户
            this.$store.dispatch('user');
        } ,
        mounted () {
            this.dom.container = G(this.$refs.container);
            this.dom.trans = G('.trans' , this.dom.container.get(0));
        } ,
        methods: {
            beforeEnter (dom) {
                dom = G(dom);
                let domW = dom.width('border-box');
                let json = {
                    opacity: 0 ,
                    zIndex: 10001,
                };
                if (this.$store.state.routeDir === 'next') {
                    // json['transform'] = 'translateX(' + domW + 'px)';
                    json['left'] = 'auto';
                    json['right'] = -domW + 'px';
                } else {
                    // json['transform'] = 'translateX(' + -domW + 'px)';
                    json['left'] = -domW + 'px';
                    json['right'] = 'auto';
                }
                dom.css(json);
            } ,

            enter (dom , done) {
                dom = G(dom);
                let enter = () => {
                    this.beforeEnter(dom.get(0));
                    let domW = dom.width('border-box');
                    let json = {
                        opacity: 1 ,
                        // translateX: '0px'
                    };
                    if (this.$store.state.routeDir === 'next') {
                        json['right'] = '0px';
                    } else {
                        json['left'] = '0px';
                    }
                    dom.animate(json , done , this.time);
                };
                // return enter();
                if (this.enterOnce) {
                    G.timer.clear(this.enterTimer);
                    this.enterTimer = G.timer.time(() => {
                        this.enterOnce = false;
                        enter();
                    } , this.delay);
                } else {
                    enter();
                }
            } ,

            beforeLeave (dom) {
                dom = G(dom);
                let json = {
                    opacity: 1 ,
                    zIndex: 10000 ,
                    // transform: 'translateX(0px)'
                };
                if (this.$store.state.routeDir === 'next') {
                    json['left'] = 'auto';
                    json['right'] = '0px';
                } else {
                    json['left'] = '0px';
                    json['right'] = 'auto';
                }
                dom.css(json);
            } ,

            leave (dom , done) {
                dom = G(dom);
                let leave = () => {
                    this.beforeLeave(dom.get(0));
                    let domW = dom.width('border-box');
                    let json = {
                        opacity: 0
                    };
                    if (this.$store.state.routeDir === 'next') {
                        // json['translateX'] = -domW + 'px';
                        json['right'] = domW + 'px';
                    } else {
                        // json['translateX'] = domW + 'px';
                        json['left'] = domW + 'px';
                    }
                    // debugger
                    dom.animate(json , done , this.time);
                };
                // return leave();
                if (this.leaveOnce) {
                    G.timer.clear(this.leaveTimer);
                    this.leaveTimer = G.timer.time(() => {
                        this.leaveOnce = false;
                        leave();
                    } , this.delay);
                } else {
                    leave();
                }
            } ,
        }
    }
</script>
<style src="./public/css/app.css"></style>
<style scoped>
    .container {
        position: absolute;
        left: 0;
        top: 0;
        width:100%;
        height:100%;
        overflow: hidden;
    }

    .container .trans {
        position: absolute;
        width: 100%;
        height: 100%;
        top: 0;
        left: 0;
    }
</style>