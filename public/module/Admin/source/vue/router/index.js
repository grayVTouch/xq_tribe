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
    // 需要用户登录检测的界面
    const authRouteNames = ['login' , 'register' , 'update' , 'home'];

    if (G.s.exists('login') && G.s.get('login') == 'logged') {
        // 已登录
        if (G.contain(to.name , authRouteNames)) {
            router.push({name: 'index'});
            return ;
        }
    } else {
        // 未登录
        if (!G.contain(to.name , authRouteNames)) {
            router.push({name: 'login'});
            return ;
        }
    }

    // 以下是对路由的一个改写
    // 避免模块发生变化时，更改所有已定义路由路径！
    // 实际就是增加路由前缀
    let noValidate = authRouteNames;
    let reg = /^\/?[Aa]dmin/;

    if (!G.contain(to.name , noValidate) && !reg.test(to.path)) {
        next({
            path: '/admin/' + to.path.replace(/^\// , '') ,
            query: to.query
        });
        return ;
    }

    next();
});

// 全局后置导航守卫并不会影响到导航本身
router.afterEach(function(to , from){

});

export default router;