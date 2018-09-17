import index from '../vue/components/index/index.vue';
import userIndex from '../vue/components/user/index.vue';
import users from '../vue/components/user/list.vue';
import user from '../vue/components/user/user.vue';
import clients from '../vue/components/client/list.vue';
import modules from '../vue/components/module/list.vue';
import _module from '../vue/components/module/module.vue';
import tags from '../vue/components/tag/list.vue';
import tag from '../vue/components/tag/tag.vue';
import categorys from '../vue/components/system/category/list.vue';
import category from '../vue/components/system/category/category.vue';
import images from '../vue/components/image/list.vue';
import image from '../vue/components/image/image.vue';
import subjects from '../vue/components/subject/list.vue';
import subject from '../vue/components/subject/subject.vue';


// 路由 和 组件的映射
export default [
    {
        name: 'index' ,
        path: 'statistics/info' ,
        component: index
    } ,
    {
        path: 'user/index' ,
        component: userIndex
    } ,
    {
        path: 'user/list' ,
        component: users
    } ,
    {
        path: 'auth/list' ,
        component: clients
    } ,
    {
        path: 'user/add' ,
        component: user
    } ,
    {
        path: 'user/edit' ,
        component: user
    } ,
    {
        path: 'module/list' ,
        component: modules
    } ,
    {
        path: 'module/edit' ,
        component: _module
    } ,
    {
        path: 'module/add' ,
        component: _module
    } ,
    {
        path: 'tag/list' ,
        component: tags
    } ,
    {
        path: 'tag/add' ,
        component: tag
    } ,
    {
        path: 'tag/edit' ,
        component: tag
    } ,
    {
        path: 'category/list' ,
        component: categorys
    } ,
    {
        path: 'category/edit' ,
        component: category
    } ,
    {
        path: 'category/add' ,
        component: category
    } ,
    {
        path: 'image/list' ,
        component: images
    } ,
    {
        path: 'image/add' ,
        component: image
    } ,
    {
        path: 'image/edit' ,
        component: image
    } ,
    {
        path: 'subject/list' ,
        component: subjects
    } ,
    {
        path: 'subject/add' ,
        component: subject
    } ,
    {
        path: 'subject/edit' ,
        component: subject
    } ,
];