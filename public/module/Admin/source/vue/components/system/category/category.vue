<template>
    <cons ref="cons">
        <template slot="cons">
            <!-- 新增用户 -->
            <div ref="shell" class="shell">
                <form @submit.prevent="submit">
                    <table class="input-tb">
                        <tbody>
                        <tr :class="error.name.status" :id="error.name.id">
                            <td>名称：</td>
                            <td>
                                <input type="text" class="form-text" v-model="form.name" @input="clear('name')">
                                <span class="necessary">*</span>
                                <span class="tip"></span>
                                <span class="msg">{{ error.name.msg }}</span>
                            </td>
                        </tr>

                        <tr :class="error.pid.status" :id="error.pid.id">
                            <td>上级分类：</td>
                            <td>
                                <select class="form-select" v-model="form.pid" @change="clear('pid')" v-html="html.category"></select>
                                <span class="necessary">*</span>
                                <span class="tip"></span>
                                <span class="msg">{{ error.pid.msg }}</span>
                            </td>
                        </tr>

                        <tr>
                            <td>描述：</td>
                            <td>
                                <textarea class="form-textarea" v-model="form.desc"></textarea>
                                <span class="necessary"></span>
                                <span class="tip"></span>
                                <span class="msg"></span>
                            </td>
                        </tr>

                        <tr>
                            <td>是否禁用：</td>
                            <td>
                                <RadioGroup v-model="form.disabled">
                                    <Radio v-for="(v,k) in $store.state.config.business.bool.str" :key="k" :label="k">{{ v }}</Radio>
                                </RadioGroup>
                                <span class="necessary">*</span>
                                <span class="tip">禁用的分类不会显示</span>
                                <span class="msg"></span>
                            </td>
                        </tr>

                        <tr>
                            <td>系统内置：</td>
                            <td>
                                <RadioGroup v-model="form.system">
                                    <Radio v-for="(v,k) in $store.state.config.business.bool.str" :key="k" :label="k">{{ v }}</Radio>
                                </RadioGroup>
                                <span class="necessary">*</span>
                                <span class="tip">系统内置分类不可修改</span>
                                <span class="msg"></span>
                            </td>
                        </tr>

                        <tr>
                            <td>权重：</td>
                            <td>
                                <input type="number" step="0" class="form-text" v-model="form.sort">
                                <span class="necessary"></span>
                                <span class="tip">选填；默认：50</span>
                                <span class="msg"></span>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <button type="submit" class="btn-2">提交</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </template>
    </cons>
</template>

<script src="./js/category.js"></script>
<style scoped src="./css/category.css"></style>