
// 初始化 vue
Vue.use(VueRouter);
Vue.use(Vuex);
Vue.use(iView);
Vue.config.productionTip = false;

// 发送请求之前
G.ajax.before = function(){

};

// 实例创建后
G.ajax.opened = function(res){
    // api 认证请求头
    this.setRequestHeader('Authorization' , topContext.token);

    // 用户登录认证头部
    if (G.s.exists('token')) {
        this.setRequestHeader('token' , G.s.get('token'));
    }
};

// 获取响应后
G.ajax.response = function(res){
    res = G.jsonDecode(res);
    if (res['status'] === 'error') {
        if (res['msg'] === 'Authorization Failed') {
            console.log('认证失败');
            Prompt.alert('认证失败');
            return false;
        }

        if (res['msg'] === 'Access Token Expired') {
            console.log('token 已经失效，请进行 token 刷新操作！');
            Prompt.alert('token 已经失效，请进行 token 刷新操作！');
            return false;
        }

        if (G.contain(res['msg'] , ['Auth Failed' , 'Auth Time Out'])) {
            G.s.del('login');
            G.s.del('token');
            G.s.del('token_expire');
            Prompt.alert(res.msg , {
                btn: [
                    {
                        name: '确认' ,
                        callback () {
                            window.location.reload();
                        }
                    }
                ]
            });
            return false;
        }
    }

    return true;
};

// 接收到响应之后
G.ajax.after = function(ajax){

};