<template>
    <div class="preview" ref="preview">
        <div class="header">
            <div class="left">
                <div class="function back" @click="$store.commit('back')"><img src="~assets/image/back.png" class="image"></div>
            </div>
            <div class="mid"><span class="cur">{{ index }}</span>/<span class="count">{{ data.images.length }}</span></div>
            <div class="right">

            </div>
        </div>
        <div class="images">
            <div class="switch">
                <div class="items">

                    <div class="item" v-for="v in data.images" :data-id="v.id" :key="v.id">
                        <div class="image-shell"><img :src="v.url" class="image"></div>
                    </div>

                </div>
            </div>
        </div>

        <div class="desc">
            <div class="title">{{ data.name }}</div>
            <div class="control clear-float">
                <div class="left"></div>
                <div class="right clear-float">
                    <div class="function comment">
                        <img src="~assets/image/comment.png" class="image">
                        <span class="count">{{ data.reply_count }}</span>
                    </div>

                    <div class="function focus">
                        <img src="~assets/image/praises.png" class="image">{{ data.praises_count }}
                    </div>
                </div>
            </div>
        </div>

        <div class="btns">
            <div class="btn">收起<img src="~assets/image/back.png" class="image"></div>
        </div>
    </div>
</template>

<script src="./js/preview.js"></script>

<style scoped src="./css/preview.css"></style>