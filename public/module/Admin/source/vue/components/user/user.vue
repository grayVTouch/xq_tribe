<template>
    <cons ref="cons">
        <template slot="cons">
            <!-- 新增用户 -->
            <div ref="shell" class="shell">
                <form @submit.prevent="submit">
                    <table class="input-tb">
                        <tbody>
                        <tr :class="error.username.status ? 'error' : ''" :id="error.username.id">
                            <td>用户名：</td>
                            <td>
                                <input type="text" class="form-text" v-model="form.username" @input="clear(error.username.key)">
                                <span class="necessary">*</span>
                                <span class="tip">最少6位</span>
                                <span class="msg">{{ error.username.msg }}</span>
                            </td>
                        </tr>

                        <tr :class="error.password.status ? 'error' : ''" :id="error.password.id">
                            <td>密码：</td>
                            <td>
                                <input type="text" class="form-text" v-model="form.password" @input="clear(error.password.key)">
                                <template v-if="mode == 'edit'">
                                    <span class="necessary"></span>
                                    <span class="tip">未填写则不修改</span>
                                </template>
                                <template v-if="mode == 'add'">
                                    <span class="necessary">*</span>
                                    <span class="tip">最少6位，支持字母、数字</span>
                                </template>
                                <span class="msg">{{ error.password.msg }}</span>
                            </td>
                        </tr>

                        <tr>
                            <td>性别：</td>
                            <td>
                                <template v-for="(v,k) in $store.state.config.business.sex">
                                    <label>
                                        <input type="radio" name="sex" v-model="form.sex" :value="k">&nbsp;{{ v }}
                                    </label>
                                    &nbsp;
                                </template>
                                <span class="necessary">*</span>
                                <span class="tip">默认：保密</span>
                            </td>
                        </tr>

                        <tr>
                            <td>生日：</td>
                            <td>
                                <DatePicker type="date" @on-change="setBirthday" :value="form.birthday" placeholder="请选择生日"></DatePicker>
                            </td>
                        </tr>

                        <tr class="avatar">
                            <td>头像：</td>
                            <td>
                                <div class="avatar-container">
                                    <!-- 上传图片组件 -->
                                    <div class='upload-image'>
                                        <div class='select-images'>
                                            <div class="upload-show">
                                                <div class="image-line"><img src="" class="image upload-image-btn" /><span class="selected-count hide">10</span></div>
                                                <div class="text-line">请选择要上传的图片</div>
                                                <div class="clear-selected" title="清空已选择的图片"><img src="" class="image" /></div>
                                                <input type='file' name='upload_images' class='upload-images-input'  />
                                            </div>
                                            <div class="tip">请选择头像</div>
                                        </div>
                                        <!-- 预置显示图片 -->
                                        <div class="init-show-image-list">
                                            <img :src="avatar" v-if="mode == 'edit'" class="image">
                                        </div>
                                        <div class='preview-images hide'></div>
                                        <!-- 待上传列表 -->
                                        <div class="upload-image-list hide">
                                            <div class="upload-title">待上传列表</div>
                                            <div class="image-list">
                                                <div class="list-content list-title">
                                                    <div class="item div-preview">图片预览</div>
                                                    <div class="item div-type">类型</div>
                                                    <div class="item div-size">大小</div>
                                                    <div class="item div-speed">速度</div>
                                                    <div class="item div-status">状态</div>
                                                    <div class="item div-opr">操作</div>
                                                </div>
                                                <div class="list-content list-body"></div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </td>
                        </tr>

                        <tr :class="error.id.status ? 'error' : ''" :id="error.id.id">
                            <td colspan="2">
                                <button type="submit" class="btn-2">提交</button>
                                <span class="msg">{{ error.id.msg }}</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </template>
    </cons>
</template>
<script src="./js/user.js"></script>
<style scoped src="./css/user.css"></style>