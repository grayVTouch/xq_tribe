// 上传图片接口
const imageUrl = topContext.apiUrl + 'File/image';

export default {
    name: "v-subject" ,
    data () {
        return {
            form: {
                id: '',
                name: '',
                desc: '',
                attr: {} ,
                sort: 50
            },
            // 错误的表单
            error: {
                name: {
                    id: 'key-name' ,
                    status: 'success' ,
                    msg: ''
                },
                attr: {
                    id: 'key-attr' ,
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
            // 属性循环
            count: 3 ,
        };
    } ,
    mounted () {
        let self = this;
        this.dom.shell  = G(this.$refs.shell);
        this.dom.attr   = G('.attr' , this.dom.shell.get(0));
        this.dom.thumbContainer = G('.thumb-container' , this.dom.shell.get(0));
        this.instance.image = new UploadImage(this.dom.thumbContainer.get(0) , {
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
                    Api.subject.updateThumb(formData , null , msg => {
                        self._end('success');
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

        // 模式
        this.mode = /subject\/edit/.test(this.$_route.path) ? 'edit' : 'add';

        if (this.mode == 'edit') {
            this.form.id = this.$_route.query.id ? this.$_route.query.id : this.form.id;
            this.$nextTick(() => {
                this.current();
            });
        } else {
            if (G.s.exists('_subject_attr_')) {
                this.form.attr = G.s.json('_subject_attr_');
            }
        }
    } ,
    methods: {
        // 设置日期
        setBirthday (date , type) {
            this.form.birthday = date;
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
                            self.$his.to('subject/list');
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
            if (this.instance.image.empty()) {
                this._end('success');
                return ;
            }

            // 上传图片
            this.instance.image.upload();
        } ,

        // 数据验证
        check () {
            return {
                status: true ,
                msg: ''
            };
        } ,

        clear (k) {
            this.error[k].status = 'success';
        } ,

        // 设置属性
        setAttr () {
            let rows = G('.attr-row' , this.dom.attr.get(0));
            let attr = {};
            rows.each((row) => {
                row = G(row);
                let key = G('.attr-key' , row.get(0));
                let val = G('.attr-val' , row.get(0));
                if (key.val() !== '') {
                    attr[key.val()] = val.val();
                }
            });
            this.form.attr = attr;
            // 缓存
            G.s.json('_subject_attr_' , attr);
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

            this.setAttr();
            let data        = G.copy(this.form);
                data.attr   = G.jsonEncode(data.attr);
            let formData    = G.formData(data);

            // 成功处理
            let success = (id) => {
                this.form.id = id;
                this.uploadImage();
            };

            if (this.mode == 'edit') {
                Api.subject.edit(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            } else {
                Api.subject.add(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            }
        } ,

        // 获取当前编辑用户数据
        current () {
            let send = G.formData({
                id: this.form.id
            });

            Api.subject.cur(send , () => {
                this.instance.loading.show();
            } , (data) => {
                this._end('success' , null , false);
                this.cur = data;
                G.assign(this.form , {
                    id: data.id ,
                    name: data.name,
                    desc: data.desc ,
                    sort: data.sort ,
                    attr: data.attrs
                });
                this.thumb = data.thumb_url;
            } , msg => {
                this._end('error' , msg);
            } , msg => {
                this._end('error' , msg);
            });
        } ,
        //
        sexChange () {

        }
    } ,
    watch:{
        logs (v) {
            this.instance.loading.text(v);
        } ,
    }

}