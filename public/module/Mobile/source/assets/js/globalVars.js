const host = 'http://xq.com/';
// const host = 'http://192.168.43.128/';
const apiUrl = host + 'api/';
const moduleUrl = apiUrl + 'Mobile/';
const shareUrl = host + 'static/share/';
const resUrl = host + 'static/mobile/';
const pluginUrl = host + 'plugins/';
const logo = resUrl + 'image/ico/logo.png';
// const token = 'GxZi5BSArCTHGod8UBqWCLu5MQ9bK126wZ4oycgAVEEKVGUoyg3otnMMM8NMvFfNTJhq63Zlz93bZQF3hjBoNNs6CssLYPOTHamgyRTqUYimlJrkTE4KFuNZ71TXRx722V0L8VwewctG7V891QocJAXq5lnKXUur5x8jAAx5h7Felyu2I7BLtDbrT9bpJoRYCuwWpHeIXQstqnY074N0JP6unXpGqT4Ux6ntMFzIbJCvhz8ShqXIMRSJ3zEsO8znAMmfvTM5Rkjjp7amRFEhqLnjwYKO2vpeHeY8wxwEGtnYxMWrbYHdBSfU8mgCyiF8rfSqktEPR3VnWg';
const token = 'D91VDxLb8andxZNsudtjS9XtAMoZXnwWNeiDHYLmmAvRjdh9zEOSrwNV3vkSvs6JeuDbUlsyOdCxt6Z5I4LsxcGRL9vMoEaN4DcHZBb9NcOPGFMqLJVSG6WxTMONrBr2F1g7XI9wG0N2y3bICLbW8xkS1oEuJwx50A9IDS0mZpgRPeb32imLBaxNDq9rKm6ZT2i066XIvawEPOXCDahe7zYOQgKVXIKJ6rd0ysDYqsU11XTPSoVeFoEOB5bWliAjYC4nbLrForTmKyWCljUKmT6VtGiDJiy5MBKCneeW7t6Pr2kgjIndH6bIQsknyMulDpYZ514NWCxXA';

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