/**
 * ****************
 * vuex
 * ****************
 */
import mutations from './mutations.js';
import getters from './getters.js';
import actions from './actions.js';
import modules from './module.js';

let store = new Vuex.Store({
    // strict: true ,
    state: {
        // 以下参数仅用于模板渲染的时候使用
        // 因为模板渲染的时候引用的变量必须是响应式变量
        // 说白了就是必须要在 vue 中定义过的变量
        // 否则无法使用
        host: topContext.host ,
        apiUrl: topContext.apiUrl ,
        moduleUrl: topContext.moduleUrl ,
        shareUrl: topContext.shareUrl ,
        resUrl: topContext.resUrl ,
        pluginUrl: topContext.pluginUrl ,
        logo: topContext.logo ,
        config: Config ,

        trans: '_slide-right' ,
        // 路由类型: back next
        routeDir: '' ,
        // 背景颜色
        bgColor: '' ,
        // 登陆用户
        _user_: {} ,
        // 是否登陆
        login: false ,

    } ,
    mutations ,
    getters ,
    actions ,
    modules
});

export default store;