import form from '../form.vue';

export default {
    name: "v-login" ,
    data () {
        return {
            form: {
                username: '',
                password: ''
            } ,
            val: {
                isRunning: false ,
                btnStatus: {
                    before: '登陆' ,
                    ing: '登陆中...' ,
                }
            } ,
            loginText: '' ,
            error: {
                username: {
                    status: '' ,
                    msg: ''
                } ,
                password: {
                    status: '' ,
                    msg: ''
                }
            }
        };
    } ,

    mounted () {
        this.loginText = this.val.btnStatus.before;
    } ,
    components: {
        'v-form': form
    } ,
    methods: {
        check () {

        } ,

        clear (field) {
            this.error[field] = {
                status: '' ,
                msg: ''
            };
        } ,

        end () {
            layer.closeAll();
            this.val.isRunning = false;
            this.loginText = this.val.btnStatus.before;
        } ,

        submit () {
            if (this.val.isRunning) {
                return layer.alert('表单上传中，请耐心等待...');
            }
            this.val.isRunning = true;
            this.loginText = this.val.btnStatus.ing;

            // 失败
            let fail = (data) => {
                if (G.isString(data)) {
                    return layer.msg(data);
                }
                for (let k in this.error)
                {
                    let cur = this.error[k];
                    let res = data[k];
                    cur.status  = G.isUndefined(res) ? '' : 'error';
                    cur.msg     = G.isUndefined(res) ?  '' : res;
                }
                this.end();
            };

            let data = G.formData(this.form);
            Api.user.login(data , () => {
                layer.load(2);
            } , (data) => {
                G.s.json('app.user' , {
                    login: 'logged' ,
                    token: data.token ,
                    expire: data.expire
                });
                this.$store.dispatch('user');
                this.$store.commit('back');
                this.end();
            } , fail , fail);
        }
    }
}