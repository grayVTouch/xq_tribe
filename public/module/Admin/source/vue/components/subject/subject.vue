<template>
    <cons ref="cons">
        <template slot="cons">
            <!-- 新增用户 -->
            <div ref="shell" class="shell">
                <form @submit.prevent="submit">
                    <table class="input-tb">
                        <tbody>
                        <tr :class="error.name.status" :id="error.name.id">
                            <td>用户名：</td>
                            <td>
                                <input type="text" class="form-text" v-model="form.name" @input="clear('name')">
                                <span class="necessary">*</span>
                                <span class="tip"></span>
                                <span class="msg">{{ error.name.msg }}</span>
                            </td>
                        </tr>

                        <tr class="thumb">
                            <td>封面：</td>
                            <td>
                                <div class="thumb-container">
                                    <!-- 上传图片组件 -->
                                    <div class='upload-image'>
                                        <div class='select-images'>
                                            <div class="upload-show">
                                                <div class="image-line"><img src="" class="image upload-image-btn" /><span class="selected-count hide">10</span></div>
                                                <div class="text-line">请选择要上传的图片</div>
                                                <div class="clear-selected" title="清空已选择的图片"><img src="" class="image" /></div>
                                                <input type='file' name='upload_images' class='upload-images-input'  />
                                            </div>
                                            <div class="tip">请选择封面</div>
                                        </div>
                                        <!-- 预置显示图片 -->
                                        <div class="init-show-image-list">
                                            <img :src="thumb" v-if="mode == 'edit'" class="image">
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

                        <tr>
                            <td>属性：</td>
                            <td class="multiple-rows attr">
                                <div class="row attr-row" v-for="(v,k) in form.attr">
                                    <input type="text" placeholder="请输入键名" :value="k" class="form-text attr-key">：<input type="text" :value="mode === 'edit' ? v : ''" class="form-text attr-val" placeholder="请输入键值">
                                </div>
                                <div class="row attr-row" v-for="v in count">
                                    <input type="text" placeholder="请输入键名" class="form-text attr-key">：<input type="text" class="form-text attr-val" placeholder="请输入键值">
                                </div>
                                <div class="row">
                                    <button type="button" class="btn-1" @click="count++">添加</button>
                                    <button type="button" class="btn-1" @click="count = Math.max(0 , --count)">减少</button>
                                    <span class="tip">会自动过滤掉键名为空的项</span>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>权重：</td>
                            <td>
                                <input type="number" step="0" v-model="form.sort" class="form-text">
                                <span class="necessary">*</span>
                                <span class="tip">默认：50</span>
                                <span class="msg"></span>
                            </td>
                        </tr>

                        <tr>
                            <td>描述：</td>
                            <td>
                                <textarea class="form-textarea" v-model="form.desc"></textarea>
                                <span class="necessary">*</span>
                                <span class="tip">默认：保密</span>
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
<script src="./js/subject.js"></script>
<style scoped src="./css/subject.css"></style>