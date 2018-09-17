const prefix = topContext.apiUrl + 'Code/';

// 获取验证码
const code = prefix + 'captcha';

export default {
    // 单张：上传图片
    code (success , fail , error) {
        ajax({
            url: code ,
            method: 'get' ,
            success ,
            fail ,
            error
        });
    } ,
    //
};