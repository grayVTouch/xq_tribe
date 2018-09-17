/**
 * 用户相关请求
 */
const prefix = topContext.moduleUrl;
const urls = {
    category: {
        list: prefix + 'Category/list' ,
        edit: prefix + 'Category/edit' ,
        add: prefix + 'Category/add' ,
        del: prefix + 'Category/del' ,
        cur: prefix + 'Category/cur' ,
    }
};

export default {
    // 分类管理
    category: {
        list (data , before , success , fail , error) {
            return ajax({
                url: urls.category.list ,
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
                url: urls.category.edit ,
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
                url: urls.category.add ,
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
                url: urls.category.del ,
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
                url: urls.category.cur ,
                method: 'post' ,
                data ,
                before ,
                success ,
                fail ,
                error
            });
        } ,
    }
};