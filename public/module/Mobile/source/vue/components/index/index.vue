<template>
    <div class="_fix-mid_" ref="_fixMid_">
        <div class="function-nav">
            <div class="functions clear-float">
                <div class="function" data-id="diary">日常</div>
                <div class="function cur" data-id="image">图片</div>
                <div class="function" data-id="video">视频</div>
                <div class="function" data-id="article">文章</div>
                <div class="function" data-id="circle">圈子</div>
            </div>
            <div class="slider"></div>
        </div>
        <div class="content">
            <div class="switch">
                <div class="items">
                    <div class="item" data-id="diary">日常</div>
                    <div class="item" data-id="image">
                        <v-image></v-image>
                    </div>
                    <div class="item" data-id="video">视频</div>
                    <div class="item" data-id="article">文章</div>
                    <div class="item" data-id="circle">圈子</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script src="./js/index.js"></script>
<style scoped src="./css/index.css"></style>