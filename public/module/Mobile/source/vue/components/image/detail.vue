<template>
    <div ref="detail" class="detail gray">
        <!-- 顶部导航 -->
        <div class="top-nav"></div>
        <!-- 内容 -->
        <div class="con">
            <div class="top">
                <!-- 控制层 -->
                <div class="control clear-float">
                    <div class="left clear-float">
                        <a class="link" href="javascript:void(0);" @click.prevent="$store.commit('back')"><img src="~assets/image/back.png" class="image"></a>
                    </div>
                    <div class="right">
                        <a class="link" href="javascript:void(0);"><img src="~assets/image/more.png" class="image"></a>
                    </div>
                </div>
                <div class="user clear-float">
                    <div class="left clear-float">
                        <div class="avatar">
                            <div class="image-shell"><img :src="data.user.avatar_url ? data.user.avatar_url : $store.state.config.res.avatar" class="image"></div>
                        </div>
                        <div class="desc">
                            <div class="in">
                                <div class="line name">{{ data.user.username }}</div>
                                <!--<div class="line _desc"></div>-->
                            </div>
                        </div>
                    </div>
                    <div class="right">
                        <button type="button" class="btn-1">关注</button>
                    </div>
                </div>
                <div class="tags">
                    <span class="tag" v-for="v in data._tag">{{ v }}</span>
                </div>
                <div class="text">
                    <div class="line name">{{ data.name }}</div>
                    <div class="line desc">{{ data.desc }}</div>
                </div>
                <div class="images">
                    <div class="line" v-for="v in data.images"><img :src="v.url ? v.url : $store.state.config.res.thumb" @click="preview(v.image_subject_id , v.id)" class="image"></div>
                </div>
            </div>
            <div class="btm">
                <div class="title">评论（{{ comment.data.count }}）</div>
                <div class="comments">
                    <v-comment v-for="v in comment.data.comment" :data="v" :key="v.id" @click="showComments(v)"></v-comment>
                    <div class="empty" v-if="comment.page.page === comment.page.max_page">已经到底了</div>
                </div>
                <div class="Load-Btm hide">
                    <img :src="$store.state.pluginUrl + 'Load/image/load.gif'" class="image">
                    <span class="text">加载中</span>
                </div>
            </div>
        </div>
        <!-- 发布评论-浮层 -->
        <div class="fix-btm trigger-comment" v-if="send.isShowPannel" @click="send.isShowPannel = false">
            <div class="in">
                <div class="left">
                    <div class="input">言论自由，看你的了！</div>
                </div>
                <div class="right functions clear-float">
                    <div class="function">
                        <div class="top"><img src="~assets/image/comment.png" class="image"></div>
                        <div class="btm">10</div>
                    </div>
                    <div class="function">
                        <div class="top"><img src="~assets/image/praises.png" class="image"></div>
                        <div class="btm">10</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 发布评论 -->
        <div class="send-comment" v-if="!send.isShowPannel">
            <div class="back"></div>
            <div class="main">
                <div class="title clear-float">
                    <div class="left">发布评论</div>
                    <div class="right">
                        <button type="button" @click="send.isShowPannel=true">X</button>
                    </div>
                </div>
                <div class="input">
                    <textarea class="form-textarea" autofocus="autofocus" placeholder="评论点赞，都要勇往直前" v-model="send.form.content"></textarea>
                </div>
                <div class="btns clear-float">
                    <div class="left"></div>
                    <div class="right">
                        <button type="button" class="btn-2" @click="addComment">发送</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 评论详情 -->
        <v-comments ref="comments"
                    :subject="cpData.subject"
                    :comment="cpData.comment"
                    :reply="cpData.reply"
                    @close="closeComments"
                    @load="loadMoreReply"
                    @send="reply"
        ></v-comments>
    </div>
</template>

<script src="./js/detail.js"></script>
<style scoped src="./css/detail.css"></style>