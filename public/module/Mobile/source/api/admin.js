const prefix = topContext.moduleUrl + 'AdminUser/';

const login = prefix + 'login';
const loginOut = prefix + 'loginOut';

export default {
    // 登录验证
    login (data , before , success , fail , error) {
        return ajax({
            url: login ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    loginOut (before , success , fail , error) {
        return ajax({
            url: loginOut ,
            method: 'post' ,
            before ,
            success ,
            fail ,
            error
        });
    } ,
};