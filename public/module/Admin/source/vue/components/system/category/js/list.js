import line from '../line.vue';
export default {
    name: 'v-list' ,
    data () {
        return {
            dom: {},
            list: [] ,
        };
    } ,
    components: {
        'v-line': line
    } ,
    mounted () {
        this.dom.res = G(this.$refs.res);
        this.$nextTick(() => {
            this.get();
        });
    } ,
    methods: {
        // 获取数据
        get () {
            Api.system.category.list(null , () => {
                this.instance.loading.show();
            } ,  (data) => {
                this.end('success' , null , false);
                this.list = data;
            } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
        } ,
        // 删除事件
        del (idList) {
            let del = () => {
                let data = G.formData({
                    id_list: G.jsonEncode(idList)
                });
                Api.system.category.del(data , () => {
                    this.instance.loading.show();
                } , (data) => {
                    this.end('success' , null , false);
                    this.get();
                } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
            };
            this.$layer.alert('确定删除？' , {
                btn: [
                    {
                        name: '确定' ,
                        callback () {
                            this.hide(del);
                        }
                    } ,
                    {
                        name: '取消' ,
                        callback () {
                            this.hide();
                        }
                    }
                ]
            });
        } ,

        // 获取选中项
        idList () {
            let radios = G('.form-radio' , this.dom.res.get(0));
            let idList = [];
            radios.each((v) => {
                v = G(v);
                if (v.native('checked')) {
                    idList.push(v.native('value'));
                }
            });
            return idList;
        } ,

        delAllEvent () {
            let idList = this.idList();
            this.del(idList);
        } ,

        delEvent (e) {
            let tar = G(e.currentTarget);
            let id = tar.data('id');
            this.del([id]);
        } ,
    }
};