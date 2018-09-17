const host = 'http://192.168.61.103/';
// const host = 'http://192.168.43.128/';
const apiUrl = host + 'api/';
const moduleUrl = apiUrl + 'Mobile/';
const shareUrl = host + 'static/share/';
const resUrl = host + 'static/mobile/';
const pluginUrl = host + 'plugins/';
const logo = resUrl + 'image/ico/logo.png';
const token = 'GxZi5BSArCTHGod8UBqWCLu5MQ9bK126wZ4oycgAVEEKVGUoyg3otnMMM8NMvFfNTJhq63Zlz93bZQF3hjBoNNs6CssLYPOTHamgyRTqUYimlJrkTE4KFuNZ71TXRx722V0L8VwewctG7V891QocJAXq5lnKXUur5x8jAAx5h7Felyu2I7BLtDbrT9bpJoRYCuwWpHeIXQstqnY074N0JP6unXpGqT4Ux6ntMFzIbJCvhz8ShqXIMRSJ3zEsO8znAMmfvTM5Rkjjp7amRFEhqLnjwYKO2vpeHeY8wxwEGtnYxMWrbYHdBSfU8mgCyiF8rfSqktEPR3VnWg';

// 定义全局常量
window.topContext = {
    host ,
    apiUrl ,
    moduleUrl ,
    shareUrl ,
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