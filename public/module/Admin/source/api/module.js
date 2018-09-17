/**
 * 用户相关请求
 */
const prefix = topContext.moduleUrl + 'Module/';

const list = prefix + 'list';
const add = prefix + 'add';
const edit = prefix + 'edit';
const del = prefix + 'del';
const cur = prefix + 'cur';
const all = prefix + 'all';

export default {
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
    all (before , success , fail , error) {
        return ajax({
            url: all ,
            method: 'post' ,
            before ,
            success ,
            fail ,
            error
        });
    }
};