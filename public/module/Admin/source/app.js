/**
 * ****************
 * 载入 css
 * ****************
 */
import './assets/css/public.css';
import './assets/css/iview.css';
import './assets/css/routerTransition.css';

/**
 * ******************
 * 载入自定义 js 类库
 * ******************
 */

/**
 * 载入全局变量
 */
import './assets/js/currency.js';
import './assets/js/tool.js';
import './assets/js/globalVars.js';
import './assets/js/subVars.js';
import './config/config.js';
import './assets/js/initialize.js';

/**
 * ************************
 * 载入组件库
 * ***********************
 */
import 'animate.css';

/**
 * ***********************
 * 载入相关组件
 * ***********************
 */
import App from './vue/components/App.vue';

/**
 * **************
 * vuex + vue-router
 * **************
 */
import store from './vue/store';
import router from './vue/router';

// 全局混入
Vue.mixin({
    store ,
    router
});

// 实例化应用
new Vue({
    el: '#app' ,
    template: '<App ref="container" />' ,
    components: {
        App
    } ,
    mounted () {

    }
});