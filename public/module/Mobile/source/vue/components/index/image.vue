<template>
    <div ref="image" class="part-for-image">
        <div class="Load-Top">
            <img :src="$store.state.pluginUrl + 'Load/image/load.gif'" class="image">
            <span class="text"></span>
        </div>

        <div class="images">
            <div class="_image" v-for="v in data" @click="$store.commit('next' , 'image/detail/' + v.id)">
                <div class="user clear-float">
                    <div class="left clear-float">
                        <div class="avatar">
                            <div class="image-shell"><img :src="v.user.avatar_url" class="image"></div>
                        </div>
                        <div class="name">{{ v.user.username }}</div>
                    </div>
                    <div class="right">
                        <button type="button" class="btn-1">关注</button>
                    </div>
                </div>

                <div class="info">
                    <div class="title">{{ v.name }}</div>
                    <div class="desc">{{ v.desc }}</div>
                </div>

                <template>
                    <div class="preview one" v-if="v.type === 'one'">
                        <img :src="v.images[0].url" @click.stop="preview(v.id , v.images[0].id)" class="image">
                    </div>

                    <div class="preview two" v-if="v.type === 'two'">
                        <div class="left"><img :src="v.images[0].url" @click.stop="preview(v.id , v.images[0].id)" class="image"></div>
                        <div class="right"><img :src="v.images[1].url" @click.stop="preview(v.id , v.images[1].id)" class="image"></div>
                    </div>

                    <div class="preview three clear-float" @click.stop v-if="v.type === 'three'">
                        <div class="left">
                            <img :src="v.images[0].url" @click.stop="preview(v.id , v.images[0].id)" class="image">
                        </div>
                        <div class="right">
                            <div class="top"><img :src="v.images[1].url" @click.stop="preview(v.id , v.images[1].id)" class="image"></div>
                            <div class="btm"><img :src="v.images[2].url" @click.stop="preview(v.id , v.images[2].id)" class="image"></div>
                        </div>
                        <div class="count" v-if="v.images.length > 3">
                            <img src="~assets/image/images.png" class="image">{{ v.images.length }}
                        </div>
                    </div>
                </template>

                <div class="tags">
                    <span class="tag" v-for="tag in v._tag">{{ tag }}</span>
                </div>
                <div class="functions clear-float">
                    <div class="share">
                        <img src="~assets/image/share.png" class="image">
                        <span>1</span>
                    </div>
                    <div class="comment">
                        <img src="~assets/image/comment.png" class="image">
                        <span>{{ v.comment_count }}</span>
                    </div>
                    <div class="praises">
                        <img src="~assets/image/praises.png" class="image">
                        <span>{{ v.count }}</span>
                    </div>
                </div>
            </div>

            <div class="empty" v-if="page.page === page.max_page">已经到底了</div>
        </div>

        <div class="Load-Btm hide">
            <img :src="$store.state.pluginUrl + 'Load/image/load.gif'" class="image">
            <span class="text">加载中</span>
        </div>
    </div>
</template>

<script src="./js/image.js"></script>

<style scoped src="./css/image.css"></style>