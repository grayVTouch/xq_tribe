/**
 * ****************
 * 载入 css
 * ****************
 */
import 'assets/css/public.css';
import 'assets/css/iview.css';

/**
 * 载入全局变量
 */
import 'assets/js/currency.js';
import 'assets/js/tool.js';
import 'assets/js/globalVars.js';
import 'assets/js/subVars.js';
import 'assets/js/initialize.js';

/**
 * ************************
 * 载入组件库
 * ***********************
 */
// import 'animate.css';

import store from '_vue_/store';
import router from '_vue_/router';

/**
 * ***********************
 * 载入相关组件
 * ***********************
 */
import App from '_vue_/components/App.vue';

// 实例化应用
new Vue({
    el: '#app' ,
    template: '<App ref="app" />' ,
    store ,
    router ,
    components: {
        App
    }
});