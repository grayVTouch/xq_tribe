/**
 * 用户相关请求
 */
const prefix = topContext.moduleUrl + 'Image/';

const updateThumb = prefix + 'updateThumb';
const addImage = prefix + 'addImage';
const delImage = prefix + 'delImage';
const add = prefix + 'add';
const edit = prefix + 'edit';
const list = prefix + 'list';
const del = prefix + 'del';
const cur = prefix + 'cur';

export default {
    // 更新图片
    updateThumb (data , before , success , fail , error) {
        return ajax({
            url: updateThumb ,
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

    // 添加图片
    addImage (data , before , success , fail , error) {
        return ajax({
            url: addImage ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,

    // 删除图片
    delImage (data , before , success , fail , error) {
        return ajax({
            url: delImage ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    }
};