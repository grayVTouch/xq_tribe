// ajax 请求
window.ajax = function(option){
    /**
     * ajax 请求参数
     */
    let _default = {
        // 请求地址
        url: '' ,
        // 请求方法
        method: '' ,
        // 传递数据（仅 post）
        data: '' ,
        // 发送请求之前
        before: null ,
        // 发送请求成功
        success: null ,
        // 服务器发送错误
        fail: null ,
        // ajax 请求发送错误
        error: null
    };

    // ajax 请求错误
    const ajaxError = 'ajax 请求错误';
    const netError = '网络错误';

    return G.ajax({
        url: option.url ,
        method: option.method ,
        data: option.data ,
        before: option.before ,
        success (json) {
            let data = G.jsonDecode(json);

            if (data.status == 'error') {
                if (G.isFunction(option.fail)) {
                    option.fail(data.msg);
                }
                return ;
            }

            if (G.isFunction(option.success)) {
                option.success(data.msg);
            }
        } ,
        error () {
            if (G.isFunction(option.error)) {
                option.error(ajaxError);
            }

            throw new Error(ajaxError);
        } ,
        netError () {
            if (G.isFunction(option.error)) {
                option.error(netError);
                return ;
            }

            throw new Error(netError);
        }
    });
};

// 获取正确的值
function getCorrectVal(val , key){
    key = key.split('.');
    let res = Config;
    key.forEach((v) => {
        res = res[v];
    });
    for (let k in res)
    {
        let v = res[k];
        if (v == val) {
            return k;
        }
    }
    return '';
}