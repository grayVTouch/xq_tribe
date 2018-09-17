export default {
    name: "v-user" ,
    data () {
        return {
            form: {
                id: '' ,
                pid: '' ,
                name: '' ,
                desc: '' ,
                sort: 50 ,
                disabled: 'n' ,
                system: 'n'
            },
            // 错误的表单
            error: {
                id: {
                    id: 'key-id' ,
                    status: 'success' ,
                    msg: ''
                } ,
                name: {
                    id: 'key-name' ,
                    status: 'success',
                    msg: ''
                } ,
                pid: {
                    id: 'key-pid' ,
                    status: 'success',
                    msg: ''
                }
            } ,
            instance: {},
            category: [] ,
            logs: [],
            mode: '',
            dom: {} ,
            html: {
                category: ''
            }
        };
    } ,
    mounted () {
        let self = this;
        this.dom.shell = G(this.$refs.shell);

        // 模式
        this.mode = this.$_route.action;

        if (this.mode == 'edit') {
            if (G.s.exists(this.$_route.path)) {
                G.assign(this.$data , G.s.json(this.$_route.path));
            }
            this.form.id = this.$_route.query.id ? this.$_route.query.id : this.form.id;
            this.$nextTick(() => {
                this.current();
            });
        }

        // 获取所有数据分类
        this.getCategory();
    } ,
    updated () {
        G.s.json(this.$_route.path , {
            form: this.form
        });
    } ,
    methods: {
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
                            self.$his.to('category/list');
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

        // 数据验证
        check () {
            if (this.form.name === '') {
                return {
                    status: false ,
                    msg: {
                        name: '名称尚未填写'
                    }
                };
            }

            if (this.form.pid === '') {
                return {
                    status: false ,
                    msg: {
                        pid: '上级分类尚未选择'
                    }
                };
            }

            if (this.mode === 'edit' && this.form.id === '') {
                return {
                    status: false ,
                    msg: 'id 尚未提供'
                };
            }

            return {
                status: true ,
                msg: ''
            };
        } ,

        // 清除表单状态
        clear (k) {
            if (!G.isUndefined(this.error[k])) {
                this.error[k].status = '';
            }
        } ,

        // 事件提交
        submit () {
            let error = (data) => {
                if (G.isString(data)) {
                    return this._end('error' , data);
                }

                let k = null;
                let msg = null;
                let status = false;
                for (k in this.error)
                {
                    let cur = data[k];
                    status = G.isUndefined(cur) ? '' : 'error';
                    msg    = status ? cur : '';
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
                this.form.id = id;
                this._end('success');
            };

            if (this.mode == 'edit') {
                Api.system.category.edit(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            } else {
                Api.system.category.add(formData , () => {
                    this.instance.loading.show();
                } , success , error , error);
            }
        } ,

        // 获取当前编辑用户数据
        current () {
            let send = G.formData({
                id: this.form.id
            });

            Api.system.category.cur(send , () => {
                this.instance.loading.show();
            } , (data) => {
                this._end('success' , null , false);
                G.assign(this.form , {
                    id: data.id ,
                    name: data.name ,
                    sort: data.sort ,
                    pid: data.pid ,
                    desc: data.desc ,
                    disabled: data.disabled ,
                    system: data.system
                });
            } , msg => {
                this._end('error' , msg);
            } , msg => {
                this._end('error' , msg);
            });
        } ,

        // 获取所有分类
        getCategory () {
            Api.system.category.list(null , null , (data) => {
                this.category = data;
                this.genOptions();
            } , null , null);
        } ,
        genOptions () {
            let html = [
                '<option value="">请选择</option>' ,
                '<option value="0">顶级分类</option>' ,
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
            gen(this.category , 1);
            // 浪费感情
            this.html.category = html.join('');
        } ,
    } ,
    watch:{
        logs (v) {
            this.instance.loading.text(v);
        }
    }
}