
export default {
    name: "v-public" ,
    data () {
        return {
            dom: {} ,
            instance: {} ,
            user: {}
        };
    } ,
    created () {

    } ,
    mounted () {
        this.dom.container = G(this.$refs.public);
        this.dom.slidebarContainer = G('.slidebar-container' , this.dom.container.get(0));
        this.dom.main = G('.main' , this.dom.container.get(0)).first();
        this.dom.fixTop = G('.fix-top' , this.dom.main.get(0)).first();
        this.dom.fixMid = G('.fix-mid' , this.dom.main.get(0)).first();
        this.dom.fixBtm = G('.fix-btm' , this.dom.main.get(0)).first();
        this.dom.pannel = G('.pannel' , this.dom.fixTop.get(0));

        this.instance.slidebar = new Slidebar(this.dom.slidebarContainer.get(0) , {
            status: 'hide'
        });
    } ,
    methods: {
        pannel: function(){
            this.instance.slidebar.show();
        } ,

        userEvent () {
            let self = this;
            if (this.$store.state.login) {
                layer.alert('查看用户信息' , {
                    btn: ['确定' , '注销'] ,
                    btn1 (index) {
                        layer.close(index);
                    } ,
                    btn2 (index) {
                        self.$store.commit('user' , {
                            user: {} ,
                            login: false
                        });
                        G.s.del('app.user');
                        layer.close(index);
                    }
                });
            } else {
                this.$store.commit('next' , '/login');
            }
        } ,
    }
}
