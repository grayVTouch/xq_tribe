export default {
    name: "v-image" ,
    data () {
        return {
            dom: {},
            instance: {},
            page: {
                page: 1,
                max_page: 10 ,
                count: 0
            },
            data: [] ,
            init: {
                val: {
                    scrollTop: 0
                }
            } ,
            isLoading: false
        };
    } ,
    created () {
        this.images('none' , 1 , null);
    } ,
    // 组件激活
    activated () {
        this.dom.container.vScroll(0 , this.init.val.scrollTop);
    } ,
    // 组件失活
    deactivated () {
        this.init.val.scrollTop = this.dom.container.scrollTop();
    } ,
    mounted () {
        let self = this;
        this.dom.container = G(this.$refs.image);
        this.instance.loadTop = new LoadTop(this.dom.container.get(0) , {
            status: 'hide' ,
            load () {
                self.images('newest');
            }
        });

        this.instance.loadBtm = new LoadBtm(this.dom.container.get(0) , {
            status: 'hide'
        });

        let timer = null;
        // 边界检查
        this.instance.boundary = new Boundary(this.dom.container.get(0) , {
            once: true ,
            top: function(){

            } ,
            bottom: function(){
                if (self.page.page === self.page.max_page) {
                    return ;
                }
                self.images('more' , ++self.page.page);
            }
        });
    } ,
    methods: {
        // 获取图片数据
        images (type , page , fn) {
            if (this.isLoading) {
                return ;
            }
            page = G.isInt(page) ? page : 1;

            let typeRange = ['newest' , 'more' , 'none'];
            type = G.contain(type , typeRange) ? type : 'none';
            if (type === 'more' && page >= this.page.max_page) {
                return ;
            }
            let id = null;
            switch (type)
            {
                case 'newest':
                    id = this.data[0].id;
                    break;
                case 'more':
                    id = this.data[this.data.length - 1].id;
                    this.instance.loadBtm.show();
                    break;
            }
            let response = (msg , isTip) => {
                isTip = G.isBoolean(isTip) ? isTip : true;
                this.isLoading = false;
                this.instance.loadTop.hide();
                this.instance.loadBtm.hide();
                if (isTip) {
                    layer.msg(msg);
                }
            };
            // type newest more none
            let form = G.formData({
                page ,
                type ,
                id
            });
            Api.image.list(form , () => {
                this.isLoading = true;
            } , (data) => {
                response(null , false);
                let page = data.page;
                    data = data.data;

                if (type !== 'newest') {
                    this.page = page;
                }

                data = data.map((v) => {
                    switch (v.images.length)
                    {
                        case 0:
                            v.type = 'none';
                            break;
                        case 1:
                            v.type = 'one';
                            break;
                        case 2:
                            v.type = 'two';
                            break;
                        default:
                            v.type = 'three';
                    }
                    return v;
                });
                if (type === 'newest') {
                    // 最新的
                    data.reverse().forEach(v => {
                        this.data.unshift(v);
                    });
                } else if (type === 'more') {
                    // 加载更多
                    data.forEach(v => {
                        this.data.push(v);
                    });
                } else {
                    this.data = data;
                }

                if (G.isFunction(fn)) {
                    fn();
                }
            } , response , response);
        } ,

        preview (imageSubjectId , id) {
            this.$store.commit('next' , '/preview/' + imageSubjectId + '/' + id);
        } ,
    }
}