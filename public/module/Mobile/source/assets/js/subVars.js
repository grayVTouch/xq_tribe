/**
 * 这边加载或定义的变量依赖于 globalVars.js 中定义的相关变量
 * 所以是全局变量的子级
 */
/**
 * *******************
 * vuex + vue-router
 * ******************
 */
// 类库 css
import 'iview.css';

/**
 * ********************
 * vue 相关
 * ********************
 */
import Vue from 'vue';
import VueRouter from 'vue-router';
import Vuex from 'vuex';
import iView from 'iview.js';
import Config from 'config/config.js';
import Api from 'api/api.js';

// 所有 api 请求
G.assign(window , {
    Api ,
    Vue ,
    VueRouter ,
    Vuex ,
    iView ,
    Config
});