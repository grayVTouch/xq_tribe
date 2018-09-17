<template>
    <cons ref="cons">
        <template slot="cons">
            <!-- 新增用户 -->
            <div ref="shell" class="shell">
                <!-- 菜单切换 -->
                <div class='menu-switch-container'>
                    <div class="menu-switch menu-switch-for-1">
                        <div class="item" data-id="info">基本信息</div>
                        <div class="item" data-id="image">图片列表</div>
                    </div>
                </div>
                <form class="form" @submit.prevent="submit">
                    <div class="items">
                        <div class="item" data-id="info">
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

                                <tr :class="error.module_id.status" :id="error.module_id.id">
                                    <td>模块：</td>
                                    <td class="iview">
                                        <select v-model="form.module_id" class="form-select">
                                            <option value="">请选择</option>
                                            <option v-for="v in data.module" :key="v.id" :value="v.id">{{ v.name }}</option>
                                        </select>
                                        <span class="necessary">*</span>
                                        <span class="tip"></span>
                                        <span class="msg">{{ error.module_id.msg }}</span>
                                    </td>
                                </tr>

                                <tr :class="error.category_id.status" :id="error.category_id.id">
                                    <td>分类：</td>
                                    <td>
                                        <select class="form-select" v-model="form.category_id" v-html="html.category"></select>
                                        <span class="necessary">*</span>
                                        <span class="tip"></span>
                                        <span class="msg">{{ error.category_id.msg }}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>类型：</td>
                                    <td>
                                        <RadioGroup v-model="form.type">
                                            <Radio v-for="(v,k) in $store.state.config.business.imageType" :label="k" :key="k">{{ v }}</Radio>
                                        </RadioGroup>
                                    </td>
                                </tr>

                                <tr v-if="form.type === 'pro'" :class="error.subject_id.status" :id="error.subject_id.id">
                                    <td>专题：</td>
                                    <td class="iview">
                                        <i-select class="normal-width" v-model="form.subject_id" filterable remote :remote-method="searchSubject" :loading="isSearchSubject">
                                            <i-option v-for="v in data.subject" :key ="v.id" :value="v.id">{{ v.name }}</i-option>
                                        </i-select>
                                        <span class="necessary">*</span>
                                        <span class="tip">数字，则按照id搜索；其他，则按照名称搜索</span>
                                        <span class="msg">{{ error.subject_id.msg }}</span>
                                    </td>
                                </tr>

                                <tr>
                                    <td>标签：</td>
                                    <td class="tag-container">
                                        <div class="line">
                                            <div class="tag" v-for="v in form.tag" :key="v">
                                                <div class="text">{{ v }}</div>
                                                <div class="close" @click="delTag(v)">
                                                    <div class="in">
                                                        <div class="positive"></div>
                                                        <div class="negative"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <span class="tag-input" contenteditable="true" @keyup.enter="customTag"></span>
                                        </div>
                                        <div class="line">
                                            <div class="title">推荐标签</div>
                                            <div class="tags">
                                                <span class="hot-tag" v-for="v in data.tag" :key="v.id" @click="addTag(v.name)">{{ v.name }}</span>
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr class="thumb">
                                    <td>封面：</td>
                                    <td class="thumb-container">
                                        <div class='upload-image'>
                                            <div class='select-images'>
                                                <div class="upload-show">
                                                    <div class="image-line"><img src="" class="image upload-image-btn"><span class="selected-count hide">10</span></div>
                                                    <div class="text-line">请选择要上传的图片</div>
                                                    <div class="clear-selected" title="清空已选择的图片"><img src="" class="image"></div>
                                                    <input type='file' class='upload-images-input'>
                                                </div>
                                                <div class="tip">请选择封面</div>
                                            </div>
                                            <!-- 预置显示图片 -->
                                            <div class="init-show-image-list">
                                                <img :src="cur.thumb_url" v-if="mode == 'edit'" class="image">
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
                                    </td>
                                </tr>

                                <tr>
                                    <td>次数：</td>
                                    <td>
                                        <input type="number" step="0" v-model="form.count" class="form-text">
                                        <span class="necessary">*</span>
                                        <span class="tip">默认：0，浏览次数</span>
                                        <span class="msg"></span>
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
                                    <td>状态：</td>
                                    <td>
                                        <RadioGroup v-model="form.status">
                                            <Radio v-for="(v,k) in $store.state.config.business.imageStatus" :label="k" :key="k">{{ v }}</Radio>
                                        </RadioGroup>
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
                                </tbody>
                            </table>
                        </div>
                        <div class="item" data-id="image">
                            <div class="upload">
                                <table class="input-tb">
                                    <tbody>
                                    <tr>
                                        <td>图库：</td>
                                        <td class="image-container">
                                            <div class='upload-image'>
                                                <div class='select-images'>
                                                    <div class="upload-show">
                                                        <div class="image-line"><img src="" class="image upload-image-btn"><span class="selected-count hide">10</span></div>
                                                        <div class="text-line">请选择要上传的图片</div>
                                                        <div class="clear-selected" title="清空已选择的图片"><img src="" class="image"></div>
                                                        <input type='file' multiple="multiple" class='upload-images-input'>
                                                    </div>
                                                    <div class="tip">请选择图片</div>
                                                </div>
                                                <!-- 预置显示图片 -->
                                                <div class="init-show-image-list"></div>
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
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="images" v-if="mode === 'edit'">
                                <!-- 操作 -->
                                <div class="operation">
                                    <div class="component-title">
                                        <div class="left">全局操作</div>
                                        <div class="right"></div>
                                    </div>
                                    <div class="functions">
                                        <div class="left">
                                            <button class="btn-8" type="button" @click="delAll">删除</button>
                                            <button class="btn-8">待分配</button>
                                        </div>
                                        <div class="right"></div>
                                    </div>
                                </div>
                                <div class="list">
                                    <div class="component-title">
                                        <div class="left">图片列表</div>
                                        <div class="right"></div>
                                    </div>
                                    <table class="line-tb">
                                        <thead>
                                        <tr>
                                            <th class="th-cbox"><input type="checkbox" class="form-checkbox" @click="selectedAllEvent"></th>
                                            <th class="th-id">id</th>
                                            <th class="th-name">名称</th>
                                            <th class="th-preview">预览</th>
                                            <th class="th-type">mime</th>
                                            <th class="th-number">大小</th>
                                            <th class="th-opr">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr v-for="v in cur.images" :key="v.id" @click="selectLineEvent" :data-id="v.id">
                                            <td><input type="checkbox" class="form-checkbox" :value="v.id"></td>
                                            <td>{{ v.id }}</td>
                                            <td>{{ v.filename }}</td>
                                            <td><img :src="v.url" class="image preview"></td>
                                            <td>{{ v.mime }}</td>
                                            <td>{{ v.size }}</td>
                                            <td>
                                                <button type="button" :data-id='v.id' @click="delEvent" class="btn-1">删除</button>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btns">
                        <button type="submit" class="btn-2">提交</button>
                    </div>
                </form>
            </div>
        </template>
    </cons>
</template>
<script src="./js/image.js"></script>
<style scoped src="./css/image.css"></style>