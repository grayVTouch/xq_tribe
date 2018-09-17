const prefix = topContext.apiUrl + 'File/';

// 上传单张图片
const _image = prefix + 'image';
const _images = prefix + 'images';
const del = prefix + 'del';
const type = 'local';

export default {
    // 单张：上传图片
    uploadImage (image , before , success , fail , error) {
        let data = G.formData({
            image: image
        });

        return ajax({
            url: _image ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    } ,
    // 删除图片
    del () {
        return this.delete.apply(this , arguments);
    } ,
    // 删除图片
    delete (path , before , success , fail , error) {
        let data = G.formData({
            file: G.jsonEncode(path)
        });

        return ajax({
            url: del ,
            method: 'post' ,
            data ,
            before ,
            success ,
            fail ,
            error
        });
    }
};