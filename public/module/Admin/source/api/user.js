/**
 * 用户相关请求
 */
const prefix = topContext.moduleUrl + 'User/';

const updateAvatar = prefix + 'updateAvatar';
const add = prefix + 'add';
const edit = prefix + 'edit';
const list = prefix + 'list';
const del = prefix + 'del';
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
    add (data , before , success , fail , error) {
        return ajax({
            url: add ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    // 编辑用户
    edit (data , before , success , fail , error) {
        return ajax({
            url: edit ,
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

    list (data , before , success , fail , error) {
        return ajax({
            url: list ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,
    del (data , before , success , fail , error) {
        return ajax({
            url: del ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,
};