export default {
    name: "v-cons" ,
    data () {
        let self = this;
        return {
            dom: {} ,
            val: {} ,
            instance: {} ,
            route: {}
        };
    } ,
    created () {
        this.route = this.$store.state.routes[this.$parent.$id];
    } ,
    mounted () {
        // dom 操作
        this.dom.container = G(this.$refs.cons);
        // 这样获取是为了
        this.dom.pos = G('.pos' , this.dom.container.get(0)).first();
        this.dom.ccons = G('.c-cons' , this.dom.container.get(0));

        // 这边初始化时，高度为 0 所以看不到效果
        this.instance.loading = new Loading(this.dom.container.get(0) , {
            pluginUrl: topContext.pluginUrl + 'Loading/' ,
            status: 'hide'
        });

        // 事件注册
        this.scroll();
        topContext.win.on('scroll' , this.scroll.bind(this) , true , false);
    } ,
    methods: {
        to (route) {
            // 如果是顶级项，不做处理
            if (route.isLink !== 'y') {
                return ;
            }

            this.$parent.$his.to(route.path);
        } ,

        // 滚动事件
        scroll () {
            let y = window.pageYOffset;
            if (y === 0) {
                this.dom.pos.removeClass('scroll');
            } else {
                this.dom.pos.addClass('scroll');
            }
            this.dom.pos.css({
                top: y + 'px'
            });
        } ,
    }
}