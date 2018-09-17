<template>
    <div class="sec">
        <!-- 当前位置 -->
        <div class="pos">
            <div class="left">用户列表</div>
            <div class="right">
                <Breadcrumb>
                    <BreadcrumbItem>用户管理</BreadcrumbItem>
                    <BreadcrumbItem to="/admin/User/list">用户列表</BreadcrumbItem>
                </Breadcrumb>
            </div>
        </div>
        <!-- 搜索条件 -->
        <div class="search">
            <!-- 检索 -->
            <div class="con">
                <div class="component-title">
                    <div class="subject">筛选</div>
                    <div class="more"></div>
                </div>
                <div class="filter-options">
                    <div class="option">
                        <div class="field">id：</div>
                        <div class="value"><input type="text" name="id" class="form-text"></div>
                    </div>
                </div>
            </div>

            <!-- 排序 -->
            <div class="sort">
                <div class="component-title">
                    <div class="subject">排序</div>
                    <div class="more"></div>
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
                        <div class="field">用户等级：</div>
                        <div class="value">
                            <RadioGroup v-model="sort">
                                <Radio label="level|asc">升序</Radio>
                                <Radio label="level|desc">降序</Radio>
                            </RadioGroup>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 搜索结果 -->
        <div class="res">
            <i-table stripe :columns="columns" :data="list"></i-table>
        </div>
    </div>
</template>

<script>
    export default {
        name: "v-admins" ,
        data () {
            return {
                sort: '' ,
                columns: [
                    {
                        type: 'selection',
                        width: 60,
                        align: 'center'
                    },
                    {
                        title: '用户ID' ,
                        key: 'id'
                    } ,
                    {
                        title: '用户名' ,
                        key: 'name'
                    } ,
                    {
                        title: '操作' ,
                        key: 'operation'
                    } ,
                    {
                        title: '操作',
                        key: 'action',
                        fixed: 'right',
                        width: 120,
                        render: (h, params) => {
                            return h('div', [
                                h('Button', {
                                    props: {
                                        type: 'text',
                                        size: 'small'
                                    }
                                }, 'View'),
                                h('Button', {
                                    props: {
                                        type: 'text',
                                        size: 'small'
                                    }
                                }, 'Edit')
                            ]);
                        }
                    }
                ] ,
                list: [
                    {
                        id: 1 ,
                        name: '你好' ,
                        operation: '滚动！！'
                    } ,
                    {
                        id: 1 ,
                        name: '你好' ,
                        operation: '滚动！！'
                    }
                ]
            };
        }
    }
</script>

<style src="../../plugins/css/form/filter.css"></style>
<style scoped>
    .component-title {
        border-bottom:none;
    }

    .sec {

    }

    .sec > * {
        margin-bottom:12px;
    }

    .sec > *:nth-last-of-type(1) {
        margin-bottom:0px;
    }

    /**
     * **************
     * 当前位置
     * **************
     */
    .pos {
        height:50px;
        line-height:50px;
    }

    .pos:after {
        display:block;
        content:'';
        clear:both;
    }

    .pos > * {
        box-sizing:border-box;
    }

    .pos .left {
        float:left;
    }

    .pos .right {
        float:right;
    }

    /**
     * **************
     * 搜索条件
     * **************
     */
    .search {

    }

    .search > * {
        margin-bottom:12px;
    }

    .search > *:nth-last-of-type(1) {
        margin-bottom:0px;
    }

</style>