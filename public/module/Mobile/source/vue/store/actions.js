export default {
    // 获取登陆用户信息
    user (context) {
        Api.user.cur(null , null , (user) => {
            context.commit('user' , {
                user ,
                login: true
            });
        } , null , layer.msg);
    }
};