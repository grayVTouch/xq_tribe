export default {
    name: "v-preview" ,
    data () {
        return {
            dom: {} ,
            instance: {
                zoom: []
            } ,
            // 图片专题
            data: {
                // 图片列表
                images: []
            } ,
            index: 1 ,
        };
    } ,
    mounted () {
        this.dom.container = G(this.$refs.preview);
        this.dom.images = this.dom.container.children({class: 'images'});
        this.dom.switch = this.dom.images.children({class: 'switch'});
    } ,

    activated () {
        this.current();
    } ,
    methods: {
        // 初始化
        initialize () {
            let self = this;
            this.instance.zoom = [];
            this.dom.items = this.dom.switch.children({class: 'items'}).children({class: 'item'});
            this.instance.switch = new Switch(this.dom.images.get(0) , {
                id: this.$route.params.id ,
                switch (id) {
                    self.index = this.index(id);
                }
            });
            this.index = this.instance.switch.index(this.$route.params.id);

            this.dom.items.each((dom , index) => {
                dom = G(dom);
                let imageShell = G('.image-shell' , dom.get(0));
                let image = G('.image' , imageShell.get(0));
                // 图片居中
                image.on('load' , (e) => {
                    let tar = e.currentTarget;
                    imageShell.center(dom.get(0));
                    // console.log(tar);
                    let z = new Zoom(imageShell.get(0) , {

                    });

                    this.instance.zoom.push(z);
                });

                // 注册双击事件
                dom.on('dblclick' , ((index) => {
                    let z = this.instance.zoom[index];
                    let status = z.status();

                    switch (status)
                    {
                        case 'up':
                            z.origin();
                            break;
                        case 'down':
                            z.origin();
                            break;
                        default:
                            z.enlarge();
                    }
                }).bind(this , index) , true , false);
            });
        } ,
        current () {
            let complete = (msg , tip) => {
                msg = G.isString(msg) ? msg : '';
                tip = G.isBoolean(tip) ? tip : true;
                layer.closeAll();
                if (tip) {
                    layer.msg(msg);
                }

            };
            let imageSubjectId = this.$route.params.image_subject_id;
            let id = this.$route.params.id;
            let form = G.formData({
                id: imageSubjectId
            });
            Api.image.detail(form , () => {
                layer.load(2);
            } , (data) => {
                complete(null , false);
                this.data = data;
                this.$nextTick(() => {
                    this.initialize();
                });
            } , complete , complete);
        }
    }
}