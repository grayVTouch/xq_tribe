// 上传图片接口
const imageUrl = topContext.apiUrl + 'File/image';

export default {
    name: "v-image" ,
    data () {
        return {
            form: {
                id: '',
                name: '',
                module_id: '' ,
                category_id: '' ,
                // 可选值：project misc
                type: 'pro' ,
                subject_id: '' ,
                tag: [] ,
                count: 0 ,
                status: '1' ,
                desc: '' ,
                sort: 50
            },
            // 错误的表单
            error: {
                name: {
                    id: 'key-name' ,
                    status: 'success' ,
                    msg: ''
                } ,
                module_id: {
                    id: 'key-module_id' ,
                    status: 'success' ,
                    msg: ''
                } ,
                category_id: {
                    id: 'key-category_id' ,
                    status: 'success' ,
                    msg: ''
                } ,
                subject_id: {
                    id: 'key-subject_id' ,
                    status: 'success' ,
                    msg: ''
                }
            } ,
            // 用户id
            id: null,
            // 封面
            thumb: null,
            // 第三方插件实例
            instance: {},
            // 简单的错误日志
            logs: [],
            // 模式
            mode: '',
            cur: {} ,
            dom: {} ,
            // 表单所需要的数据
            data: {
                module: [] ,
                category: [] ,
                tag: []
            } ,
            html: {
                category: ''
            } ,
            // 是否正在搜索专题
            isSearchSubject: false ,
            // 专题
            idList: []
        };
    } ,
    created () {
        this.module();
        this.category();
        this.hotTag();
    } ,
    mounted () {
        let self = this;
        this.dom.shell  = G(this.$refs.shell);
        this.dom.content = G('.content' , this.dom.shell.get(0));
        this.dom.items  = G('.items' , this.dom.content.get(0));
        this.dom.items_ = this.dom.items.children({
            class: 'item' ,
            tagName: 'div'
        });
        this.dom.menuSwitchContainer = G('.menu-switch-container' , this.dom.shell.get(0));
        this.dom.thumbContainer = G('.thumb-container' , this.dom.shell.get(0));
        this.dom.imageContainer = G('.image-container' , this.dom.shell.get(0));
        this.instance.thumb = new UploadImage(this.dom.thumbContainer.get(0) , {
            pluginUrl: topContext.pluginUrl + 'UploadImage/' ,
            mode: 'override' ,
            url:  imageUrl ,
            field: 'image' ,
            before () {

            } ,
            success (json) {
                let data = G.jsonDecode(json);

                if (data.status == 'success') {
                    self.thumb = data.msg.path;
                    let formData = G.formData({
                        id: self.form.id ,
                        thumb: self.thumb
                    });

                    // 更新对应用户图片
                    Api.image.updateThumb(formData , null , msg => {
                        if (self.instance.image.empty()) {
                            return self._end('success');
                        }
                        self.instance.image.upload();
                    } , (msg) => {
                        self._end('error' , msg);
                    });

                    return ;
                }

                self._end('error' , data.msg);
            } ,
            error () {
                self._end('error');
            }
        });
        this.instance.image = new UploadImage(this.dom.imageContainer.get(0) , {
            pluginUrl: topContext.pluginUrl + 'UploadImage/' ,
            mode: 'append' ,
            url:  imageUrl ,
            field: 'image' ,
            before () {
                self.instance.menuSwitch.switch('image');
                G.scrollTo(null , 'y' , 0 , 0);
            } ,
            success (json) {
                let data = G.jsonDecode(json);

                if (data.status == 'success') {
                    data = data.msg;
                    let formData = G.formData({
                        image_subject_id: self.form.id ,
                        filename: data.name ,
                        mime: data.mime ,
                        size: data.size ,
                        path: data.path
                    });
                    // 更新对应用户图片
                    Api.image.addImage(formData);

                    return ;
                }

                self._end('error' , data.msg);
            } ,
            callback () {
                self._end('success');
            } ,
            error () {
                self._end('error');
            }
        });
        this.instance.menuSwitch = new MenuSwitch(this.dom.menuSwitchContainer.get(0) , {
            switch (id) {
                self.switch(id);
            }
        });

        // 模式
        this.mode = /image\/edit/.test(this.$_route.path) ? 'edit' : 'add';

        if (this.mode == 'edit') {
            if (G.s.exists(this.$_route.path)) {
                let cache = G.s.json(this.$_route.path);
                G.assign(this.$data , cache);
            }
            this.form.id = this.$_route.query.id ? this.$_route.query.id : this.form.id;
            console.log(this.$_route);
            this.$nextTick(() => {
                this.current();
            });
        }
    } ,
    updated () {
        G.s.json(this.$_route.path , {
            form: this.form
        });
    } ,
    methods: {
        searchSubject (query) {
            let formData = G.formData({
                query
            });
            Api.subject.all(formData , () => {
                this.isSearchSubject = true;
            } , (data) => {
                this.isSearchSubject = false;
                this.data.subject = data;
            } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
        } ,

        // 通过 id 获取到项
        item (id) {
            for (let i = 0; i < this.dom.items_.length; ++i)
            {
                let cur = this.dom.items_.jump(i , true);
                if (cur.data('id') == id) {
                    return cur.get(0);
                }
            }
            throw new Error('未找到当前提供 id：' + id + ' 对应项');
        } ,

        // 切换项
        switch (id) {
            let item = G(this.item(id));
            item.highlight('hide' , this.dom.items_.get() , true);
        } ,

        // 记录日志
        log (text) {
            this.logs.push(text);
        } ,

        _end (status , msg , tip) {
            let self = this;
            tip = G.isBoolean(tip) ? tip : true;
            msg = status === 'error' ? (msg ? msg : '发生未知错误，请稍后再试') : (msg ? msg : this.$routes.cur.cn + '成功');
            const option  = status === 'error' ? null : {
                btn: [
                    {
                        name: '数据列表' ,
                        callback () {
                            this.hide();
                            self.$his.to('image/list');
                        }
                    } ,
                    {
                        name: '继续操作' ,
                        callback () {
                            this.hide();
                        }
                    }
                ]
            };
            self.logs = [];
            this.end(status , msg , tip , option);
        } ,

        // 上传图片
        uploadImage () {
            if (this.instance.thumb.empty() && this.instance.image.empty()) {
                return this._end('success');
            }

            if (this.instance.thumb.empty()) {
                return this.instance.image.upload();
            }

            // 上传图片
            this.instance.thumb.upload();
        } ,

        // 数据验证
        check () {
            if (this.mode === 'add' && this.instance.thumb.empty()) {
                return {
                    status: false ,
                    msg: '请上传封面图'
                };
            }

            if (this.mode === 'add' && this.instance.image.empty()) {
                return {
                    status: false ,
                    msg: '请上传图片'
                };
            }

            return {
                status: true ,
                msg: ''
            };
        } ,

        clear (k) {
            this.error[k].status = 'success';
        } ,

        // 事件提交
        submit () {
            let error = (data) => {
                if (G.isString(data)) {
                    return this._end('error' , data);
                }

                for (let k in this.error)
                {
                    let msg = data[k];
                    let status = G.isUndefined(msg) ? 'success' : 'error';
                    G.assign(this.error[k] , {
                        status ,
                        msg
                    });
                }
                let last = Object.keys(data);
                let lastKey = last[last.length - 1];
                G('#' + this.error[lastKey].id).scrollIntoView(null , null , 'y' , Config.val.scrollExtraH , null);
                this._end('error' , null , false);
            };

            // 数据验证
            const res = this.check();

            if (!res.status) {
                return error(res.msg);
            }

            let form = G.copy(this.form);
            form.tag = G.jsonEncode(form.tag);
            let formData = G.formData(form);

            // 成功处理
            let success = (id) => {
                this.form.id = id;
                this.uploadImage();
            };

            this.instance.menuSwitch.switch('info');

            if (this.mode == 'edit') {
                Api.image.edit(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            } else {
                Api.image.add(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            }
        } ,

        // 获取当前编辑用户数据
        current () {
            let send = G.formData({
                id: this.form.id
            });

            Api.image.cur(send , () => {
                this.instance.loading.show();
            } , (data) => {
                this._end('success' , null , false);
                this.cur = data;

                G.assign(this.form , {
                    id: data.id ,
                    name: data.name ,
                    module_id: data.module_id ,
                    category_id: data.category_id ,
                    // 可选值：project misc
                    type: data.type ,
                    subject_id: data.subject_id ,
                    tag: data._tag ,
                    count: data.count ,
                    status: String(data.status) ,
                    desc: data.desc ,
                    sort: data.sort
                });
                this.thumb = data.thumb_url;
            } , msg => {
                this._end('error' , msg);
            } , msg => {
                this._end('error' , msg);
            });
        } ,

        // 获取模块
        module () {
            Api.module.all(null , (data) => {
                this.data.module = data;
            } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
        } ,

        // 获取所有分类
        category () {
            Api.system.category.list(null , null , (data) => {
                this.data.category = data;
                this.genOptions();
            } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
        } ,
        genOptions () {
            let html = [
                '<option value="">请选择</option>' ,
            ];
            let gen = function(list , count){
                for (let i = 0; i < list.length; ++i)
                {
                    let v = list[i];
                    let space = G.str.repeat('&nbsp;' , count * 5);
                    html.push(`<option value="${v.id}">${space}|_${v.name}</option>`);
                    gen(v.children , count + 1);
                }
            };
            gen(this.data.category , 1);
            // 浪费感情
            this.html.category = html.join('');
        } ,
        // 获取热门标签
        hotTag () {
            Api.tag.hot(null , null , (data) => {
                this.data.tag = data;
            } , this._end.bind(this , 'error') , this._end.bind(this , 'error'));
        } ,

        // 追加 id
        _add (id) {
            let exists = this.idList.some(v => {
                return v == id;
            });

            if (!exists) {
                this.idList.push(id);
            }
        } ,

        // 删除 id
        _del (id) {
            for (let i = 0; i < this.idList.length; ++i)
            {
                let cur = this.idList[i];

                if (cur == id) {
                    this.idList.splice(i , 1);
                    i--;
                }
            }
        } ,

        // 获取行
        _findLine (id) {
            let trs = G('.line-tb > tbody > tr');
            let cur = null;
            let tr = null;
            for (let i = 0; i < trs.length; ++i)
            {
                cur = trs.jump(i , true);
                if (cur.data('id') == id) {
                    return cur.get(0);
                }
            }
            throw new Error('未找到当前提供id:' + id + '对应行');
        } ,

        // 选中行
        selectedLine (id) {
            let tr   = G(this._findLine(id));
            let cBox = G('.form-checkbox' , tr.get(0));

            tr.addClass('focus');
            cBox.checked(true);
            this._add(id);
        } ,

        // 不选中行
        unselectedLine (id) {
            let tr   = G(this._findLine(id));
            let cBox = G('.form-checkbox' , tr.get(0));

            tr.removeClass('focus');
            cBox.checked(false);
            this._del(id);
        } ,

        // 选择行
        selectLineEvent (e) {
            let tar = G(e.currentTarget);
            let id = tar.data('id');

            if (tar.hasClass('focus')) {
                this.unselectedLine(id);
            } else {
                this.selectedLine(id);
            }
        } ,

        // 选择所有
        selectedAll () {
            this.cur.images.forEach(v => {
                this.selectedLine(v.id);
            });
        } ,

        // 反选所有
        unselecedtAll () {
            this.cur.images.forEach(v => {
                this.unselectedLine(v.id);
            });
        } ,

        // 选择所有行
        selectedAllEvent (e) {
            let tar = G(e.currentTarget);
            let checked = tar.checked();

            if (checked) {
                this.selectedAll();
            } else {
                this.unselecedtAll();
            }
        } ,

        // 删除
        del (id , callback) {
            const idList = G.isArray(id) ? id : [id];
            let data = G.formData({
                id_list: G.jsonEncode(idList)
            });

            Api.image.delImage(data , () => {
                this.$refs.cons.instance.loading.show();
            } , (msg) => {
                // 清除已删除 id
                idList.forEach((v) => {
                    this._del(v);
                });
                this.current();
                this.end('success' , '删除数据成功');
            } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
        } ,

        // 删除所有选中项
        delAll () {
            this.del(this.idList);
        } ,

        // 删除用户
        delEvent (e) {
            let tar = G(e.currentTarget);
            let isPending = tar.data('isPending');
            let id = tar.data('id');

            if (isPending === 'y') {
                return this.$layer.alert('删除数据中...请耐心等待');
            }

            this.del(id , () => {
                tar.data('isPending' , 'n');
            });
        } ,
        // 添加标签
        addTag (name) {
            if (G.contain(name , this.form.tag)) {
                return this.$layer.alert('已经存在该标签');
            }
            this.form.tag.push(name);
        } ,
        // 删除标签
        delTag (name) {
            let index = this.form.tag.indexOf(name);
            if (index === -1) {
                return ;
            }
            this.form.tag.splice(index , 1);
        } ,
        // 自定义标签
        customTag (e) {
            let tar = G(e.currentTarget);
            let tag = tar.text();
            if (!G.isValid(tag)) {
                return ;
            }
            let form = G.formData({
                name: tag
            });
            tar.text(tar.text().replace("\n" , ''));
            Api.tag.add(form , null , (v) => {
                this.addTag(tag);
                tar.text('');
            } , this._end.bind(this , 'error') , this._end.bind(this , 'error'));
        } ,
    } ,
    watch:{
        logs (v) {
            this.instance.loading.text(v);
        } ,
    }

}