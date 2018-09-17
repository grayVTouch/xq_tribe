/**
 * vue-router
 */
import routes from './routes.js';
let router = new VueRouter({
    routes
});

// 全局前置守卫
// 登录注册验证
router.beforeEach((to , from , next) => {
    // 登陆状态认证
    const authRouteNames = ['login' , 'register' , 'update' , 'home'];
    // 未登录路由认证
    const loginRouteNames = ['login' , 'register' , 'update'];

    if (to.path === '/') {
        return router.push({name: 'index'});
    }

    let user = null;
    if (G.s.exists('app.user') && (user = G.s.json('app.user')) && user.login === 'logged') {
        // 已登录
        if (G.contain(to.name , authRouteNames)) {
            router.push({name: 'index'});
            return ;
        }
    } else {
        // 未登录
        if (!G.contain(to.name , loginRouteNames)) {
            // router.push({name: 'login'});
            // return ;
        }
    }

    next();
});

// 全局后置导航守卫并不会影响到导航本身
router.afterEach(function(to , from){

});

export default router;