<template>
    <div class="comments hide" ref="comments">
        <div class="title">
            <div class="left"></div>
            <div class="mid">评论详情页</div>
            <div class="right">
                <a class="close" href="javascript:void(0)" @click="close">X</a>
            </div>
        </div>
        <div class="main">
            <!-- 评论者 -->
            <div class="comment">
                <div class="line clear-float">
                    <div class="left"><img :src="comment.user.avatar_url ? comment.user.avatar_url : $store.state.config.avatar" class="image"></div>
                    <div class="right">
                        <div class="c-line user clear-float">
                            <div class="c-left">{{ comment.user.username }}</div>
                            <div class="c-right">
                                <div class="function">
                                    <span class="count">10</span>
                                    <img src="~assets/image/praises.png" class="image">
                                </div>
                                <div class="function">
                                    <img src="~assets/image/comment_share.png" class="image">
                                </div>
                            </div>
                        </div>
                        <div class="c-line text" @click="_reply(comment.id , comment.user.username)">{{ comment.content }}</div>
                        <div class="c-line time">{{ comment.create_time }}</div>
                        <div class="c-line subject">
                            <div class="in clear-float">
                                <div class="c-left"><img :src="subject.thumb ? subject.thumb : $store.state.config.thumb" class="image"></div>
                                <div class="c-right">{{ subject.name }}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 华丽的分割线 -->
            <div class="split-line"><span class="text">全部回复</span></div>

            <!-- 回复者 -->
            <div class="reply">
                <div class="line clear-float" v-for="v in reply.data" @click="_reply(v.id , v.user.username)">
                    <div class="left">
                        <div class="image-shell"><img :src="v.user.avatar_url ? v.user.avatar_url : $store.state.config.avatar" class="image"></div>
                    </div>
                    <div class="right">
                        <div class="c-line user clear-float">
                            <div class="c-left">{{ v.user.username }}</div>
                            <div class="c-right clear-float">
                                <div class="function">
                                    <span class="count">{{ v.hot }}</span>
                                    <img src="~assets/image/praises.png" class="image">
                                </div>

                                <div class="function">
                                    <img src="~assets/image/comment_share.png" class="image">
                                </div>

                            </div>
                        </div>
                        <div class="c-line text">
                            {{ v.content }}
                            <template v-if="v.pid != comment.id">
                                <span class="_reply">//@{{ v.reply.user.username}}：</span>{{ v.reply.content }}
                            </template>
                        </div>
                        <div class="c-line time">{{ v.cerate_time }}</div>
                    </div>
                </div>

                <div class="empty" v-if="reply.page.page === reply.page.max_page">已经到底了</div>
            </div>

            <div class="Load-Btm hide">
                <img :src="$store.state.pluginUrl + 'Load/image/load.gif'" class="image">
                <span class="text">加载中</span>
            </div>

        </div>
        <!-- 固定底部 -->
        <div class="fix-btm" v-if="!isShowPannel">
            <span class="input" @click="_reply(comment.id , comment.user.username)">回复{{ comment.user.username }}：</span>
        </div>

        <!-- 回复评论 -->
        <div class="reply-comment" v-if="isShowPannel">
            <div class="back"></div>
            <div class="main">
                <div class="title clear-float">
                    <div class="left">发布评论</div>
                    <div class="right">
                        <button type="button" @click="isShowPannel = false">X</button>
                    </div>
                </div>
                <div class="input">
                    <textarea class="form-textarea" autofocus="autofocus" :placeholder="'回复' + replyUsername" v-model="form.content"></textarea>
                </div>
                <div class="btns clear-float">
                    <div class="left"></div>
                    <div class="right">
                        <button type="button" class="btn-2" @click="send">发送</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "v-comments" ,
        data () {
            return {
                isShowPannel: false ,
                dom: {} ,
                instance: {} ,
                replyUsername: '' ,
                form: {
                    content: '' ,
                    pid: 0
                } ,
                val: {}
            };
        } ,
        props: {
            subject: {
                type: Object ,
                default () {
                    return {
                        thumb: '',
                        name: ''
                    };
                }
            } ,
            comment: {
                type: Object ,
                default () {
                    return {
                        // 评论用户
                        user: {}
                    };
                }
            } ,
            reply: {
                type: Object ,
                default () {
                    return {
                        page: {
                            page: 0 ,
                            max_page: 1
                        } ,
                        data: []
                    };
                }
            }
        } ,

        activated () {
            this.replyUsername = this.comment.user.username;
        } ,
        mounted () {
            let self = this;
            this.dom.container = G(this.$refs.comments);
            this.dom.title  = this.dom.container.children().filter({class: 'title'});
            this.dom.main   = this.dom.container.children().filter({class: 'main'});
            this.dom.fixBtm = this.dom.container.children().filter({class: 'fix-btm'});

            this.instance.loadBtm = new LoadBtm(this.dom.main.get(0) , {
                status: 'hide'
            });

            this.instance.boundary = new Boundary(this.dom.main.get(0) , {
                once: false ,
                bottom () {
                    if (self.reply.page.page >= self.reply.page.max_page) {
                        return ;
                    }
                    self.$emit('load' , self.comment.id ,  ++self.reply.page.page);
                }
            });

            // 设置高度
            this.setMainH();
            topContext.win.on('resize' , this.setMainH.bind(this) , true , false);
        } ,
        methods: {
            _reply (id , name) {
                this.form.pid       = id;
                this.replyUsername  = name;
                this.isShowPannel   = true;
            } ,
            // 发布评论
            send () {
                this.$emit('send' , this.form);
            } ,
            // 发布完评论后，输入框回复原状
            origin () {
                this.isShowPannel = false;
                this.form.content = '';
                this.form.pid = 0;
            } ,
            // 关闭
            close () {
                this.$emit('close');
            } ,
            // 显示加载层
            showLoading() {
                this.instance.loadBtm.show();
            } ,
            // 关闭加载层
            hideLoading () {
                this.instance.loadBtm.hide();
            } ,

            beforeShow () {
                this.dom.container.removeClass('hide');
                this.dom.container.css({
                    top: '50%' ,
                    opacity: 0
                });
            } ,

            show () {
                this.beforeShow();
                this.dom.container.animate({
                    top: '0px' ,
                    opacity: 1
                });
            } ,

            beforeHide() {
                this.val.containerH = this.dom.container.height('border-box');
            } ,

            hide () {
                this.beforeHide();
                this.dom.container.animate({
                    top: Math.floor(this.val.containerH / 2) + 'px' ,
                    opacity: 0
                } , () => {
                    this.dom.container.addClass('hide');
                });
            } ,

            setMainH () {
                let isHide = this.dom.container.hasClass('hide');
                if (isHide) {
                    this.dom.container.removeClass('hide');
                }
                let containerH  = this.dom.container.height('content-box');
                let titleH      = this.dom.title.height('border-box');
                let fixBtmH     = this.dom.fixBtm.height('border-box');
                let mainH       = containerH - titleH - fixBtmH;
                this.dom.main.css('height' , mainH + 'px');
                if (isHide) {
                    this.dom.container.addClass('hide');
                }
            }
        }
    }
</script>

<style scoped src="./css/comments.css"></style>