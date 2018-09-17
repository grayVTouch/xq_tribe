<template>
    <cons ref="cons">
        <template slot="cons">
            <!-- 操作 -->
            <div class="operation">
                <div class="component-title">
                    <div class="left">全局操作</div>
                    <div class="right"></div>
                </div>
                <div class="functions">
                    <div class="left">
                        <button class="btn-8" @click="delAllEvent">删除</button>
                        <button class="btn-8">待分配</button>
                    </div>
                    <div class="right"></div>
                </div>
            </div>

            <div class="res" ref="res">
                <div class="list">
                    <div class="component-title">
                        <div class="left">数据列表</div>
                        <div class="right">
                            <button class="btn-8" @click="$his.to($_route.controller + '/add')">添加</button>
                        </div>
                    </div>
                    <div class="tree">
                        <v-line v-for="v in list" :key="v.id" :category="v"></v-line>
                    </div>
                </div>
            </div>
        </template>
    </cons>
</template>

<script src="./js/list.js"></script>
<style scoped src="./css/list.css"></style>