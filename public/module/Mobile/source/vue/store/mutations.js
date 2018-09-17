import Router from '_vue_/router';

export default {
    // 路由定向跳跃，后退效果
    prev (state , route) {
        state.routeDir = 'back';
        Router.push(route);
    } ,
    // 路由定向跳跃，前进效果
    next (state , route) {
        state.routeDir = 'next';
        Router.push(route);
    } ,
    // 路由后退
    back (state) {
        if (window.history.length === 0) {
            layer.msg('已经是最后一页了！！正常应该是退出应用程序');
            return ;
        }
        state.routeDir = 'back';
        Router.go(-1);
    } ,
    forward (state) {
        state.routeDir = 'next';
        Router.go(1);
    } ,
    // 注册
    user (state , {user , login}) {
        state._user_ = user;
        state.login = login;
    } ,

}
