import functions from '../functions.vue';
import cons from '../cons.vue';
export default {
    name: "v-public" ,
    data () {
        return {
            // 实例
            instance: {},
            // dom 合集
            dom: {},
            // 值集合
            val: {
                functionsH: 0,
                functionsExtraH: 10
            },
            // 针对每一个标签项需要维护一个历史记录
            history: {} ,
            // 内容切换列表
            cons: {} ,
            // 层级内切换列表
            level: {}
        };
    } ,
    components: {
        'v-functions': functions
    } ,

    mounted () {
        let self = this;

        // 注册相关变量
        this.dom.public     = G(this.$refs.public);
        this.dom.menus      = G('.menus' , this.dom.public.get(0));
        this.dom.top        = G('.top' , this.dom.menus.get(0));
        this.dom.middle     = G('.middle' , this.dom.menus.get(0));
        this.dom.btm        = G('.btm' , this.dom.menus.get(0));
        this.dom.cons       = G('.cons' , this.dom.public.get(0));
        this.dom.topNav     = G('.top-nav' , this.dom.cons.get(0));
        this.dom.user       = G('.top .right .user' , this.dom.topNav.get(0));
        this.dom.functions  = G('.functions' , this.dom.user.get(0));
        this.dom.content = G('.content' , this.dom.public.get(0));
        this.dom.multipleTabContainer = G('.multiple-tab-container' , this.dom.topNav.get(0));

        // 初始化高度
        this.setH();
        topContext.win.on('resize' , self.setH.bind(this) , true , false);

        // 值
        this.val.functionsH = this.dom.functions.height('border-box');
        // 初始化
        this.dom.functions.css({
            bottom: -(this.val.functionsH + this.val.functionsExtraH) + 'px'
        });

        this.dom.functions.addClass('hide');

        // 实例化多标签页
        this.instance.tab = new MultipleTab(this.dom.multipleTabContainer.get(0) , {
            ico: topContext.logo ,
            created (tab , id) {
                tab = G(tab);

                let path = tab.data('path');
                self.append(id , path);
            } ,
            deleted (tab , id) {
                self.delete(id);
            } ,
            click (tab , id) {
                self.highlight(id);
            }
        });

        this.$nextTick(() => {
            // 一定要放在 $nextTick 中执行
            // 因为钩子执行顺序是子组件 -> 父组件
            this.instance.loading = this.$parent.instance.loading;
        });
    } ,
    methods: {
        // 更新当前位置
        updatePos (id , path) {
            this.$store.commit('parse' , {
                id ,
                path
            });
        } ,

        // 设置高度
        setH () {
            let clientH = topContext.doc.clientHeight();

            const minH      = 400;
            const maxH      = Math.max(minH , clientH);
            const consH     = maxH;
            const menusH    = maxH;
            const topNavH   = this.dom.topNav.height('border-box');
            const contentH  = consH - topNavH;
            const topH      = this.dom.top.height('border-box');
            const btmH     = this.dom.btm.height('border-box');
            const middleH  = menusH - topH - btmH;

            this.dom.middle.css({
                height: middleH + 'px'
            });

            this.dom.content.css({
                minHeight: contentH + 'px'
            });

        } ,
        // 选择项
        select (name) {
            // 跳转到指定路由
            this.$store.commit('routerNext' , {
                path: '/' + name
            });
        } ,
        // 注销
        loginOut (e) {
            let tar = G(e.currentTarget);
            let self = this;
            const isPending = tar.data('isPending');

            if (isPending === 'y') {
                return Prompt.alert('请求中，请耐心等待');
            }

            tar.data('isPending' , 'y');

            Api.admin.loginOut(() => {
                this.$parent.instance.loading.show();
            } , (msg) => {
                let self = this;
                tar.data('isPending' , 'n');

                // 删除登录状态
                G.s.del('login');
                G.s.del('token');
                G.s.del('expire');

                Prompt.alert(msg , {
                    closeBtn: false ,
                    confirm () {
                        self.$parent.instance.loading.hide();
                        self.$store.commit('routerBack' , {name: 'login'});
                    }
                });
            } , (msg) => {
                tar.data('isPending' , 'n');
                Prompt.alert(msg);
            } , (msg) => {
                tar.data('isPending' , 'n');
                Prompt.alert(msg);
            });
        } ,
        // 鼠标经过
        mouseOverForUser () {
            this.dom.functions.removeClass('hide');

            this.dom.functions.animate({
                opacity: 1 ,
                bottom: -this.val.functionsH + 'px'
            });
        } ,

        mouseOutForUser () {
            this.dom.functions.animate({
                opacity: 0 ,
                bottom: -(this.val.functionsH + this.val.functionsExtraH) + 'px'
            } , () => {
                this.dom.functions.addClass('hide');
            });
        } ,

        // 标签变化
        append (id , path) {
            let component = this.component(id , path);
            // 创建项容器
            let container = G(document.createElement('div'));
            // 创建组件渲染容器
            let render = document.createElement('div');

            container.append(render);
            container.addClass('item');
            container.data('id' , id);

            this.cons[id] = container.get(0);

            // 添加项容器到文档
            this.dom.content.append(container.get(0));
            // 高亮显示
            this.highlight(id);

            // 实例化组件并挂载到渲染容器
            component.$mount(render);
        } ,

        // 获取项集合
        items () {
            return this.dom.content.children().filter({
                class: 'item' ,
                tagName: 'div'
            }).get();
        } ,

        // 获取项
        item (id) {
            let items = G(this.items());

            for (let i = 0; i < items.length; ++i)
            {
                let cur = items.jump(i , true);
                if (cur.data('id') == id) {
                    return cur.get(0);
                }
            }

            throw new Error('未找到当前提供id：' + id + '对应项');
        } ,

        // 高亮显示
        highlight (id) {
            let item = G(this.item(id));
            item.highlight('hide' , this.items() , true);
        } ,

        delete (id) {
            let items = G(this.items());
            items.each((dom) => {
                dom = G(dom);
                let _id = dom.data('id');

                if (id == _id) {
                    this.dom.content.remove(dom.get(0));
                }
            });
        } ,
        // 查找路由组件
        find (path) {
            for (let i = 0; i < topContext.components.length; ++i)
            {
                let cur = topContext.components[i];
                if (cur.path === path) {
                    return cur.component;
                }
            }

            throw new Error('未找到当前提供路由' + path + '对应组件');
        } ,

        // 生成id
        genId () {
            return G.randomArr(100 , 'mixed' , true);
        } ,

        // 跳转
        go (id , index) {

        } ,

        // 后退
        back (id) {

        } ,

        // 前进
        next (id) {

        } ,

        // 重新加载
        reload (id) {
            // 获取当前路由
            // 进行跳转
            let routes = this.$store.state.routes[id];
            this.to(id , routes.cur.path , false);
        } ,

        // 跳转
        to (id , path , multiplexing) {
            if (!G.isString(path) || path.length === 0) {
                return ;
            }

            multiplexing = G.isBoolean(multiplexing) ? multiplexing : false;

            let item    = G(this.item(id));
            let render  = null;

            if (G.isUndefined(this.level[id])) {
                this.level[id] = {};
            }

            // 当前显示的 node
            let cons = item.children().filter({
                class: 'cons' ,
                tagName: 'div'
            });
            item.remove(cons.get(0));

            if (!multiplexing || G.isUndefined(this.level[id][path])) {
                render  = G.create('div');
                item.append(render.get(0));
                this.component(id , path).$mount(render.get(0));
                // 组件实例化之前混入当前路由
                this.level[id][path] = item.children().filter({
                    class: 'cons' ,
                    tagName: 'div'
                }).get(0);
            } else {
                item.append(this.level[id][path]);
            }
        } ,

        // 记录历史记录
        saveHistory (id , path) {
            let hisId = G.randomArr(100 , 'mixed' , true);
            let his = {
                id: id ,
                hisId: hisId ,
                path: path
            };

            if (!G.isArray(this.history[id])) {
                this.history[id] = [];
            }
            this.history[id].push(his);
            return his;
        } ,

        // 查询当前历史记录
        findHistory (id , hisId) {
            let his = this.history[id];
            for (let i = 0; i < his.length; ++i)
            {
                let cur = his[i];
                if (cur.id === hisId) {
                    return cur;
                }
            }

            throw new Error('没有当前记录id: ' + hisId + '对应的记录数据');
        } ,

        // 获取上一条历史记录
        prevHistory (id , hisId) {
            let his = this.history[id];
            for (let i = 0; i < his.length; ++i)
            {
                let cur = his[i];
                if (cur.id === hisId) {
                    return i - 1 <= 0 ? cur : his[i - 1];
                }
            }

            throw new Error('没有当前记录id: ' + hisId + '上一条记录数据');
        } ,

        // 获取上一条历史记录
        nextHistory (id , hisId) {
            let his = this.history[id];
            for (let i = 0; i < his.length; ++i)
            {
                let cur = his[i];
                if (cur.id === hisId) {
                    return i + 1 >= his.length ? cur : his[i + 1];
                }
            }

            throw new Error('没有当前记录id: ' + hisId + '下一条记录数据');
        } ,

        // 解析出控制器 & 方法
        parseCA (path) {
            let res = path.split('/');
            if (res.length !== 2) {
                throw new Error('无法解析控制器+动作，请检查当前提供路径是否正确：' + path);
            }
            return {
                controller: res[0] ,
                action: res[1]
            };
        } ,

        // 混入 $_route
        component (id , path) {
            let self = this;
            let route = G.parse(path);
            let CA = this.parseCA(route.path);
            G.assign(route , CA);
            // 更新路由
            this.updatePos(id , route.path);
            // 记录历史记录
            let his = this.saveHistory(id , path);
            // 获取当前路由
            let routes = this.$store.state.routes[id];
            // 更新标签标题
            this.instance.tab.title(id , routes.top.cn + '-' + routes.cur.cn);
            let data = {
                val: {} ,
                dom: {} ,
                instance: {
                    // 必须是 Loading 的实例
                    loading: null
                } ,
                '$dom': this.dom ,
                '$id': id ,
                // 历史记录 id
                '$hisId': his.id ,
                // 路由
                '$_route': route ,
                // 记录导航
                '$his': {
                    go (index) {
                        self.go(id , index);
                    } ,
                    back () {
                        self.back(id);
                    } ,
                    reload () {
                        self.reload(id);
                    } ,
                    to (path , multiplexing) {
                        self.to(id , path , multiplexing);
                    }
                } ,
                '$topDom': this.$parent.dom ,
                // 完整路由
                '$routes': routes ,
            };

            let component = this.find(route.path);
            let _component = {
                extends: component ,
                data () {
                    let self = this;
                    return G.assign(data , {
                        // 彈窗
                        '$layer': {
                            alert (msg , opt) {
                                opt = G.isValid(opt) && G.isObject(opt) ? opt : {};
                                opt.container = self.dom.$container.get(0);
                                return Prompt.alert(msg , opt);
                            }
                        } ,
                    });
                } ,
                mounted () {
                    this.instance.loading = this.$refs.cons.instance.loading;
                    this.dom.$container  = this.$refs.cons.dom.container;
                    this.val.extra = this.$extra;
                } ,
                methods: {
                    end (status , msg , tip , opt) {
                        if (!(this.instance.loading instanceof Loading)) {
                            throw new TypeError('instance.loading 不是 Loading 的实例');
                        }
                        let self = this;
                        const statusRange = ['success' , 'error'];
                        tip = G.isBoolean(tip) ? tip : true;
                        if (!G.contain(status , statusRange)) {
                            throw new Error('不支持的状态');
                        }
                        msg = status === 'error' ? (msg ? msg : '发生未知错误，请稍后再试') : (msg ? msg : '操作成功');
                        this.instance.loading.hide();
                        if (tip) {
                            this.$layer.alert(msg , opt);
                        }
                    } ,
                } ,
                components: {
                    cons
                }
            };
            let myComponent = Vue.extend(_component);
            let vueComponent = new myComponent();

            // 扩展方法
            // 以下方法是非响应式的
            // vue 规定无法在实例化的对象上新增根级响应式属性
            // 只能向嵌套的对象新增响应式属性
            // 既然如此，我为了书写方便，打破常规
            // 手动添加根级属性，但是非响应式属性
            G.assign(vueComponent , data);

            return vueComponent;
        }
    }
}
