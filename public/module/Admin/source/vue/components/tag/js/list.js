export default {
    name: "v-list" ,
    data () {
        return {
            sort: '',
            page: {
                page: 1,
                count: 10,
                limit: Config.page.limit,
                limitOpt: Config.page.limitOpt
            },
            filter: {
                id: '',
                name: ''
            },
            data: [],
            selected: false,
            ajax: null,
            dom: {} ,
            idList: []
        };
    } ,
    computed: {

    } ,
    mounted: function(){
        if (G.s.exists(this.$_route.path)) {
            let cache = G.s.json(this.$_route.path);
            // vue 推荐做法，如果使用 G.assign(this.$data , cache)
            // 那么新增的属性则不会触发更新
            G.assign(this.$data , cache);
        }

        this.$nextTick(() => {
            // 按照钩子执行顺序
            // cons.vue -> list.vue -> Vue.mixin 或 Vue.extend 中钩子
            // 这边要等待 Vue.mixin 中的钩子执行完毕后才能进行初始化
            // 所以要放在 $nextTick 等待此次数据更新之后
            this.getList();
        });
    } ,
    updated () {
        G.s.json(this.$_route.path , {
            sort: this.sort ,
            page: this.page ,
            filter: this.filter
        });
    } ,
    methods: {
        // 获取数据列表
        getList () {
            let formData = G.formData(G.assign({
                page: this.page.page ,
                limit: this.page.limit ,
                sort: this.sort
            } , this.filter));

            if (this.ajax !== null) {
                this.ajax.get().abort();
            }

            this.ajax = Api.tag.list(formData , () => {
                this.instance.loading.show();
            } , (data) => {
                this.end('success' , null , false);
                G.assign(this.page , data.page);
                this.data = data.data;
            } , this.end.bind(this , 'error') , this.end.bind(this , 'error'));
        } ,

        // 页码改变事件
        pageChange (page) {
            this.page.page = page;
            this.getList();
        } ,

        pageSizeChange (limit) {
            this.page.limit = limit;
            this.getList();
        } ,

        // 检索条件重置
        reset () {
            this.filter = {
                id: '' ,
                name: '' ,
            };

            this.sort = '';
            this.getList();
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
            this.list.forEach(v => {
                this.selectedLine(v.id);
            });
        } ,

        // 反选所有
        unselecedtAll () {
            this.list.forEach(v => {
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

            Api.tag.del(data , () => {
                this.$refs.cons.instance.loading.show();
            } , (msg) => {
                // 清除已删除 id
                idList.forEach((v) => {
                    this._del(v);
                });

                this.getList();

                this.end('success' , msg);

                if (G.isFunction(callback)) {
                    callback();
                }
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
        }
    }
};