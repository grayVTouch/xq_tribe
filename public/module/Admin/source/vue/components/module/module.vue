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

                        <tr :class="error.sort.status" :id="error.sort.id">
                            <td>权重：</td>
                            <td>
                                <input type="text" class="form-text" v-model="form.sort" @input="clear('sort')">
                                <span class="necessary"></span>
                                <span class="tip">选填；默认：50</span>
                                <span class="msg">{{ error.sort.msg }}</span>
                            </td>
                        </tr>

                        <tr>
                            <td>描述：</td>
                            <td>
                                <textarea class="form-textarea" v-model="form.desc" @input="clear('desc')"></textarea>
                                <span class="necessary"></span>
                                <span class="tip">选填</span>
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

<script src="./js/module.js"></script>
<style scoped src="./css/module.css"></style>