<template>
    <section ref="public" :class="'public' + ($store.state.bgColor ? ' ' + $store.state.bgColor : '')">
        <div class="main">
            <!-- 固定头部 -->
            <div class="fix-top">
                <div class="left pannel clear-float" @click="pannel">
                    <div class="switch">
                        <div class="in">
                            <div class="line"></div>
                            <div class="line"></div>
                            <div class="line"></div>
                        </div>
                    </div>
                    <div class="avatar">
                        <div class="in">
                            <img :src="$store.state._user_.avatar_url ? $store.state._user_.avatar_url : $store.state.config.res.avatar" class="image">
                        </div>
                    </div>
                </div>
                <div class="mid search">
                    <div class="in">
                        <div class="shell"><img src="~assets/image/search.png" class="image"></div>
                    </div>
                </div>
                <div class="right clear-float">

                    <div class="function">
                        <div class="in">
                            <span class="count">22</span>
                            <img src="~assets/image/msg.png" class="image">
                        </div>
                    </div>

                    <div class="function">
                        <div class="in">
                            <span class="count">22</span>
                            <img src="~assets/image/msg.png" class="image">
                        </div>
                    </div>

                </div>
            </div>

            <div class="fix-mid">
                <router-view></router-view>
            </div>

            <!-- 固定尾部 -->
            <div class="fix-btm clear-float">
                <div class="function">
                    <div class="top"><img src="~assets/image/index.png" class="image"></div>
                    <div class="btm">首页</div>
                </div>

                <div class="function">
                    <div class="top"><img src="~assets/image/find.png" class="image"></div>
                    <div class="btm">发现</div>
                </div>

                <div class="function">
                    <div class="top"><img src="~assets/image/dynamic.png" class="image"></div>
                    <div class="btm">动态</div>
                </div>

                <div class="function">
                    <div class="top"><img src="~assets/image/my.png" class="image"></div>
                    <div class="btm">我的</div>
                </div>
            </div>
        </div>

        <!-- 控制面板 --->
        <div class="slidebar-container">
            <div class="slidebar">
                <div class="mask"></div>
                <div class="con control-pannel">
                    <div class="top">
                        <!-- 用户 -->
                        <div class="user">
                            <div class="background hide"><img src="~assets/image/test/user.jpg" class="image"></div>
                            <div class="info">
                                <div class="line avatar">
                                    <div class="image-shell" @click="userEvent"><img :src="$store.state._user_.avatar_url ? $store.state._user_.avatar_url : $store.state.config.res.avatar" class="image"></div>
                                </div>
                                <div class="line name">{{ $store.state._user_.username ? $store.state._user_.username : '点击头像登陆' }}</div>
                            </div>
                        </div>
                        <!-- 统计 -->
                        <div class="statistics clear-float">
                            <div class="line">
                                <div class="top">0</div>
                                <div class="btm">动态</div>
                            </div>

                            <div class="line">
                                <div class="top">0</div>
                                <div class="btm">关注</div>
                            </div>

                            <div class="line">
                                <div class="top">0</div>
                                <div class="btm">粉丝</div>
                            </div>
                        </div>

                        <!-- 功能 -->
                        <div class="functions">
                            <div class="function cur"><img src="~assets/image/index.png" class="image">首页</div>
                            <div class="function"><img src="~assets/image/index.png" class="image">我的足迹</div>
                            <div class="function"><img src="~assets/image/index.png" class="image">我的收藏</div>
                            <div class="function"><img src="~assets/image/index.png" class="image">反馈</div>
                            <div class="function"><img src="~assets/image/index.png" class="image">帮助</div>
                        </div>
                    </div>

                    <!-- 固定底部 -->
                    <div class="btm fix-btm">
                        <div class="line"><img src="~assets/image/index.png" class="image">设置</div>
                        <div class="line"><img src="~assets/image/index.png" class="image">主题</div>
                        <div class="line"><img src="~assets/image/index.png" class="image">夜间</div>
                    </div>
                </div>
            </div>
        </div>

    </section>
</template>

<script src="./js/public.js"></script>
<style src="./css/reset.css"></style>
<style src="./css/ui.css"></style>
<style scoped src="./css/public.css"></style>