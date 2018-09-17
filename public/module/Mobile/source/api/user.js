/**
 * 用户相关请求
 */
const prefix = topContext.moduleUrl + 'User/';

const updateAvatar = prefix + 'updateAvatar';
const login = prefix + 'login';
const cur = prefix + 'cur';

export default {
    // 更新图片
    updateAvatar (data , before , success , fail , error) {
        return ajax({
            url: updateAvatar ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    // 添加用户
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

    // 获取用户数据
    cur (data , before , success , fail , error) {
        return ajax({
            url: cur ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,
};