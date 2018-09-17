/**
 * 用户相关请求
 */
const prefix = topContext.moduleUrl + 'Image/';

const list = prefix + 'list';
const detail = prefix + 'detail';
const comment = prefix + 'comment';
const comments = prefix + 'comments';
const reply = prefix + 'reply';
const addComment = prefix + 'addComment';

export default {
    // 多条评论
    comments (data , before , success , fail , error) {
        return ajax({
            url: comments ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    // 单条评论
    comment (data , before , success , fail , error) {
        return ajax({
            url: comment ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    // 添加用户
    reply (data , before , success , fail , error) {
        return ajax({
            url: reply ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    // 获取用户数据
    detail (data , before , success , fail , error) {
        return ajax({
            url: detail ,
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

    // 添加用户
    addComment (data , before , success , fail , error) {
        return ajax({
            url: addComment ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,
};