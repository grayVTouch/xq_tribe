/**
 * ****************
 * vuex
 * ****************
 */
import mutations from './mutations.js';
import getters from './getters.js';
import actions from './actions.js';

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
        resUrl: topContext.resUrl ,
        pluginUrl: topContext.pluginUrl ,
        logo: topContext.logo ,
        mapping: topContext.mapping ,
        components: topContext.components ,
        config: Config ,

        trans: '_ease-in-out' ,
        // 当前模块
        module: 'admin' ,
        // 表示路由路径
        routes: {
            /*
            route_id: {
                // 路由层级
                routes: [] ,
                // 当前路由
                curRoute: {} ,
                // 顶级路由
                topRoute: {} ,
            }
            */
        } ,
        // 历史记录
        history: {} ,
    } ,
    mutations ,
    getters ,
    actions ,
    modules: {
        // 各类数据
    }
});

export default store;