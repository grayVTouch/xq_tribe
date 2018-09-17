// 上传图片接口
const imageUrl = topContext.apiUrl + 'File/image';

export default {
    name: "v-user" ,
    data () {
        return {
            form: {
                username: '',
                password: '',
                sex: '',
                id: '',
                birthday: ''
            },
            // 错误的表单
            error: {
                username: {
                    id: 'key-username' ,
                    key: 'username' ,
                    status: false,
                    msg: ''
                },
                password: {
                    id: 'key-password' ,
                    key: 'password' ,
                    status: false ,
                    msg: ''
                } ,
                sex: {
                    id: 'key-sex' ,
                    key: 'sex' ,
                    status: false ,
                    msg: ''
                } ,
                id: {
                    id: 'key-id' ,
                    key: 'id' ,
                    status: false ,
                    msg: ''
                }
            } ,
            // 用户id
            id: null,
            // 头像
            avatar: null,
            // 第三方插件实例
            instance: {},
            // 简单的错误日志
            logs: [],
            // 模式
            mode: '',
            curUser: {} ,
            dom: {}
        };
    } ,
    mounted () {
        let self = this;
        this.dom.shell = G(this.$refs.shell);
        this.dom.avatarContainer = G('.avatar-container' , this.dom.shell.get(0));
        this.instance.image = new UploadImage(this.dom.avatarContainer.get(0) , {
            pluginUrl: topContext.pluginUrl + 'UploadImage/' ,
            mode: 'override' ,
            url:  imageUrl ,
            field: 'image' ,
            before () {

            } ,
            success (json) {
                let data = G.jsonDecode(json);

                if (data.status == 'success') {
                    self.log('上传头像成功');
                    self.log('开始更新用户头像');
                    self.avatar = data.msg.url;
                    let formData = G.formData({
                        id: self.form.id ,
                        avatar: self.avatar
                    });

                    // 更新对应用户图片
                    Api.user.updateAvatar(formData , null , msg => {
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
        this.mode = /user\/edit/.test(this.$_route.path) ? 'edit' : 'add';

        if (this.mode == 'edit') {
            if (G.s.exists(this.$_route.path)) {
                G.assign(this.$data , G.s.json(this.$_route.path));
            }
            this.form.id = this.$_route.query.id ? this.$_route.query.id : this.form.id;
            this.$nextTick(() => {
                this.current();
            });
        }

        // 更新性别
        this.form.sex = 'secret';
    } ,
    updated () {
        G.s.json(this.$_route.path , {
            form: this.form
        });
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
                        name: '用户列表' ,
                        callback () {
                            this.hide();
                            self.$his.to('user/list');
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
            if (this.form.username == '') {
                return {
                    status: false ,
                    msg: {
                        username: '用户名尚未填写'
                    }
                };
            }

            if (this.mode == 'add' && this.form.password == '') {
                return {
                    status: false ,
                    msg: {
                        password: '密码尚未填写'
                    }
                };
            }

            return {
                status: true ,
                msg: ''
            };
        } ,

        clear (k) {
            this.error[k].status = false;
        } ,

        // 事件提交
        submit () {
            this.logs = [];

            let error = (data) => {
                if (G.isString(data)) {
                    return this._end('error' , data);
                }

                let k = null;
                let msg = null;
                let status = false;
                for (k in this.error)
                {
                    status = !G.isUndefined(data[k]);
                    msg    = status ? data[k] : '';
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

            let formData = G.formData(this.form);

            // 成功处理
            let success = (id) => {
                this.log('上传用户基本信息成功');
                this.form.id = id;
                this.uploadImage();
            };

            this.log('上传用户基本信息开始');

            if (this.mode == 'edit') {
                Api.user.edit(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            } else {
                Api.user.add(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            }
        } ,

        // 选择头像
        selectAvatar (e) {
            let file = G(e.currentTarget);
            let files = file.files();
            let image = G('.avatar .image');

            if (files.length === 0) {
                return ;
            }

            G.getBlobUrl(files[0] , (src) => {
                image.attr('src' , src);
            });

            this.avatar = files[0];
        } ,

        // 获取当前编辑用户数据
        current () {
            let send = G.formData({
                id: this.form.id
            });

            Api.user.cur(send , () => {
                this.instance.loading.show();
            } , (data) => {
                this._end('success' , null , false);
                this.curUser = data;
                this.form.username = data.username;
                this.form.sex = data.sex;
                this.form.birthday = data.birthday;
                this.avatar = data.avatar_url;
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
        }
    }

}