import image from '../image.vue';

export default {
    name: "v-index" ,
    data () {
        return {
            dom: {},
            instance: {
                // 图片
                image: {}
            } ,
            id: 'image' ,
            image: {
                page: {},
                data: []
            }
        };
    } ,
    components: {
        'v-image': image
    } ,
    mounted () {
        let self = this;
        this.dom.container = G(this.$refs._fixMid_);
        this.dom.content = G('.content' , this.dom.container.get(0));

        this.instance.functionNav = new FunctionNav(this.dom.container.get(0) , {
            id: this.id ,
            click (id) {
                self.instance.switch.id(id);
            }
        });

        this.instance.switch = new Switch(this.dom.content.get(0) , {
            id: this.id ,
            switch (id) {
                self.instance.functionNav.switch(id);
            }
        });

        topContext.win.on('resize' , this.setH.bind(this) , true , false);

        this.$store.state.bgColor = 'gray';

        this.$nextTick(() => {
            this.setH();
        });
    } ,
    methods: {
        // 设置内容高度
        setH () {
            let maxH = topContext.doc.clientHeight();
            let topH = this.$parent.dom.fixTop.height('border-box');
            let btmH = this.$parent.dom.fixBtm.height('border-box');
            let midH = maxH - topH - btmH;
            this.$parent.dom.fixMid.css({
                height: midH + 'px'
            });
        } ,
    }
}