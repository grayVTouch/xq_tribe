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

G.assign(window , {
    Vue ,
    VueRouter ,
    Vuex ,
    iView ,
});

const host = 'http://192.168.61.103/';
const apiUrl = host + 'api/';
const moduleUrl = apiUrl + 'Admin/';
const resUrl = host + 'static/admin/';
const pluginUrl = host + 'plugins/';
const logo = resUrl + 'image/ico/logo.png';
const token = 'GxZi5BSArCTHGod8UBqWCLu5MQ9bK126wZ4oycgAVEEKVGUoyg3otnMMM8NMvFfNTJhq63Zlz93bZQF3hjBoNNs6CssLYPOTHamgyRTqUYimlJrkTE4KFuNZ71TXRx722V0L8VwewctG7V891QocJAXq5lnKXUur5x8jAAx5h7Felyu2I7BLtDbrT9bpJoRYCuwWpHeIXQstqnY074N0JP6unXpGqT4Ux6ntMFzIbJCvhz8ShqXIMRSJ3zEsO8znAMmfvTM5Rkjjp7amRFEhqLnjwYKO2vpeHeY8wxwEGtnYxMWrbYHdBSfU8mgCyiF8rfSqktEPR3VnWg';

// 定义全局常量
window.topContext = {
    host ,
    apiUrl ,
    moduleUrl ,
    resUrl ,
    pluginUrl ,
    logo ,
    doc: G(document.documentElement) ,
    apiVersion: 'v1' ,
    win: G(window) ,
    body: G(document.body) ,
    head: G(document.head) ,
    token
};