<template>
    <cons ref="cons">
        <template slot="cons">
            <!-- 搜索条件 -->
            <div class="search">
                <div class="form">
                    <form @submit.prevent="getList">
                        <!-- 检索 -->
                        <div class="con">
                            <div class="component-title">
                                <div class="left">筛选</div>
                                <div class="right"></div>
                            </div>
                            <div class="filter-options">
                                <div class="option">
                                    <div class="field">id：</div>
                                    <div class="value"><input type="number" v-model="filter.id" class="form-text"></div>
                                </div>

                                <div class="option">
                                    <div class="field">名称：</div>
                                    <div class="value"><input type="text" v-model="filter.name" class="form-text"></div>
                                </div>

                                <div class="option">
                                    <div class="field"></div>
                                    <div class="value">
                                        <button @click="getList" class="btn-1">提交</button>
                                        <button @click="reset" class="btn-1">重置</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 排序 -->
                        <div class="sort">
                            <div class="component-title">
                                <div class="left">排序</div>
                                <div class="right"></div>
                            </div>
                            <div class="filter-options">
                                <div class="option">
                                    <div class="field">注册时间：</div>
                                    <div class="value">
                                        <RadioGroup v-model="sort">
                                            <Radio label="create_time|asc">升序</Radio>
                                            <Radio label="create_time|desc">降序</Radio>
                                        </RadioGroup>
                                    </div>
                                </div>

                                <div class="option">
                                    <div class="field"></div>
                                    <div class="value">
                                        <button @click="getList" class="btn-1">提交</button>
                                        <button @click="reset" class="btn-1">重置</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <!-- 操作 -->
                <div class="operation">
                    <div class="component-title">
                        <div class="left">全局操作</div>
                        <div class="right"></div>
                    </div>
                    <div class="functions">
                        <div class="left">
                            <button class="btn-8" @click="delAll">删除</button>
                            <button class="btn-8">待分配</button>
                        </div>
                        <div class="right"></div>
                    </div>
                </div>

            </div>

            <!-- 搜索结果 -->
            <div class="res">
                <div class="list">
                    <div class="component-title">
                        <div class="left">数据列表</div>
                        <div class="right">
                            <button class="btn btn-8" @click="$his.to($_route.controller + '/add')">新增</button>
                        </div>
                    </div>

                    <table class="line-tb">
                        <thead>
                        <tr>
                            <th class="th-cbox"><input type="checkbox" class="form-checkbox" @click="selectedAllEvent"></th>
                            <th class="th-id">id</th>
                            <th class="th-name">名称</th>
                            <th class="th-desc">属性</th>
                            <th class="th-number">权重</th>
                            <th class="th-time">创建时间</th>
                            <th class="th-opr">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="v in list" @click="selectLineEvent" :data-id="v.id" :key="v.id">
                            <td><input type="checkbox" class="form-checkbox" :value="v.id"></td>
                            <td class="multiple-rows">
                                <div class="row">【id】{{ v.id }}</div>
                                <div class="row"><img :src="v.thumb_url" class="image preview"></div>
                            </td>
                            <td>{{ v.name }}</td>
                            <td class="multiple-rows">
                                <div class="row" v-for="(v,k) in v.attrs">【{{ k }}】{{ v }}</div>
                            </td>
                            <td>{{ v.sort }}</td>
                            <td>{{ v.create_time }}</td>
                            <td>
                                <div class="multiple-rows">
                                    <div class="row"><button :data-id='v.id' class="btn btn-1">查看详情</button></div>
                                    <div class="row"><button class="btn btn-1" @click.stop="$his.to($_route.controller + '/edit?id=' + v.id)">编辑</button></div>
                                    <div class="row"><button :data-id='v.id' @click="delEvent" class="btn btn-1">删除</button></div>
                                </div>
                            </td>
                        </tr>
                        <tr v-if="list.length == 0">
                            <td colspan="7">未找到相关数据</td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <div class="page">
                    <div class="in">
                        <Page :current="page.page" :total="page.count" show-total :page-size="page.limit" :page-size-opts="page.limitOpt" show-elevator show-sizer @on-change="pageChange" @on-page-size-change="pageSizeChange"></Page>
                    </div>
                </div>

            </div>
        </template>
    </cons>
</template>

<script src="./js/list.js"></script>
<style scoped src="./css/list.css"></style>