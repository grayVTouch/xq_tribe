import form from '../form.vue';

export default {
    name: "v-login" ,
    data () {
        return {
            remember: true ,
            code: '' ,
            form: {
                username: '',
                password: '',
                code: '',
                code_key: '' ,
                remember: 'y'
            },
            tip: {
                username: '',
                password: '',
                code: ''
            },
            classname: {
                username: '',
                password: '',
                code: ''
            },
            tips: {
                empty: {
                    username: '用户名尚未填写' ,
                    password: '密码尚未填写' ,
                    code: '验证码尚未填写' ,
                } ,
                length: {

                } ,
                format: {

                }
            } ,
            verifyRes: {

            } ,
        };
    } ,
    watch: {
        remember: function(nv , ov){
            this.form.remember = nv ? 'y' : 'n';
        }
    } ,

    mounted () {
        // 请求二维码
        this.captcha();
    } ,
    components: {
        'v-form': form
    } ,
    methods: {
        // 获取二维码
        captcha () {
            const image = G('.verify-code .code');

            if (image.data('pending') === 'y') {
                return ;
            }

            image.data('pending' , 'y');

            Api.code.code((data) => {
                image.data('pending' , 'n');
                this.form.code_key = data.key;
                image.attr('src' , data.img);
            } , () => {
                image.data('pending' , 'n');
            });
        } ,
        verify () {
            this.verifyName();
            this.verifyPassword();
            this.verifyCode();

            for (let k in this.verifyRes)
            {
                let v = this.verifyRes[k];

                if (!v) {
                    return v;
                }
            }

            return true;
        } ,
        // 更新错误状态
        update (attr , className , msg) {
            if (!G.contain(attr , Object.keys(this.form))) {
                Prompt.alert(msg);
                return ;
            }

            this.classname[attr] = className;
            this.tip[attr] = msg;
        } ,

        verifyName () {
            const attr = 'username';

            if (this.form.username === '') {
                this.update(attr , 'error' , this.tips.empty[attr]);
                this.verifyRes[attr] = false;
                return ;
            }

            this.update(attr , '' , '');
            this.verifyRes[attr] = true;
        } ,

        verifyPassword () {
            const attr = 'password';

            if (this.form.password === '') {
                this.update(attr , 'error' , this.tips.empty[attr]);
                this.verifyRes[attr] = false;
                return ;
            }

            this.update(attr , '' , '');
            this.verifyRes[attr] = true;
        } ,

        verifyCode () {
            const attr = 'code';

            if (this.form.code === '') {
                this.update(attr , 'error' , this.tips.empty[attr]);
                this.verifyRes[attr] = false;
                return ;
            }

            this.update(attr , '' , '');
            this.verifyRes[attr] = true;
        } ,

        submit (e) {
            const self = this;
            const res = this.verify();

            if (!res) {
                Prompt.alert('请按照要求填写表单后再次提交');
                return ;
            }

            const formData = G.formData(this.form);

            Api.admin.login(formData , () => {
                this.$parent.instance.loading.show();
            } , (data) => {
                this.$parent.instance.loading.hide();
                self.captcha();

                // 保存用户信息
                G.s.set('login' , 'logged');
                G.s.set('token' , data.token);
                G.s.set('expire' , data.token_expire);

                // 跳转到后台首页
                // 信息刷新
                this.$router.push({name: 'admin'} , function(){
                    // 正式部署的时候请开启
                    // window.history.go(0);
                });

            } , (data) => {
                this.$parent.instance.loading.hide();
                self.captcha();

                if (G.isObject(data)) {
                    // 提示错误
                    for (let k in data)
                    {
                        let v = data[k];
                        this.update(k , 'error' , v);
                    }
                } else {
                    Prompt.alert(data.msg);
                }
            });
        }
    }
}