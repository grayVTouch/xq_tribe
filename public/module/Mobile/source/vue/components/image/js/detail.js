import comment from '_vue_/components/share/comment.vue';
import comments from '_vue_/components/share/comments.vue';

export default {
    name: "v-detail" ,
    components: {
        'v-comment': comment ,
        'v-comments': comments
    } ,
    data () {
        return {
            data: {
                user: {}
            } ,
            comment: {
                isLoading: false ,
                page: {} ,
                data: {
                    count: 0,
                    comment: []
                }
            } ,
            // 发布
            send: {
                isShowPannel: true ,
                form: {
                    image_subject_id: this.$route.params.id ,
                    content: '' ,
                    pid: 0
                }
            } ,
            dom: {} ,
            instance: {} ,

            // 传递给组件的数据
            // child component data <=> cpData
            cpData: {
                subject: {
                    thumb: '',
                    name: ''
                },
                comment: {
                    user: {}
                },
                reply: {
                    page: {
                        page: 0 ,
                        max_page: 1
                    } ,
                    data: []
                }
            } ,
            status: {
                isLoadReply: false
            }
        };
    } ,
    mounted () {
        let self = this;
        this.dom.container = G(this.$refs.detail);
        this.dom.con = this.dom.container.children().filter({class: 'con'});
        this.dom.btm = this.dom.con.children().filter({class: 'btm'});

        this.instance.loadBtm = new LoadBtm(this.dom.btm.get(0) , {
            status: 'hide'
        });

        this.instance.boundary = new Boundary(this.dom.container.get(0) , {
            bottom () {
                if (self.comment.page.page >= self.comment.page.max_page) {
                    return ;
                }
                self.comments(++self.comment.page.page , 'append');
            }
        });
    } ,
    activated () {
        // 加载数据
        this.image();
        this.comments(1 , 'overrite');
    } ,
    methods: {
        end () {

        } ,

        // 获取专题数据
        image () {
            let form = G.formData({
                id: this.$route.params.id ,
            });

            let error = (msg) => {
                layer.closeAll();
                layer.msg(msg);
            };

            Api.image.detail(form , () => {
                layer.load(2);
            } , data => {
                this.data = data;

                // 填充详情数据
                this.cpData.subject = {
                    thumb: data.thumb_url ,
                    name: data.name
                };
                layer.closeAll();
            } , error , error);
        } ,
        // 评论
        comments (page , mode) {
            if (this.comment.isLoading) {
                return ;
            }

            if (page > this.comment.page.max_page) {
                return ;
            }

            let form = G.formData({
                id: this.$route.params.id ,
                page
            });

            let error = (msg) => {
                this.comment.isLoading = false;
                this.instance.loadBtm.hide();
                layer.msg(msg);
            };

            Api.image.comments(form , () => {
                this.comment.isLoading = true;
                this.instance.loadBtm.show();
            } , data => {
                if (mode === 'overrite') {
                    this.comment = data;
                } else {
                    let page    = data.page;
                    let comment = data.data;

                    this.comment.page = page;
                    this.comment.data.count = comment.count;
                    comment.comment.forEach(v => {
                        this.comment.data.comment.push(v);
                    });
                }

                // 回复原状
                this.comment.isLoading = false;
                this.instance.loadBtm.hide();
            } , error , error);
        } ,

        // 发布评论
        _addComment (form , fn) {
            let self = this;
            // 检查用户是否登录
            if (!this.$store.state.login) {
                return layer.alert('您尚未登录！' , {
                    btn: ['登录' , '取消'] ,
                    btn1 (index) {
                        layer.close(index);
                        self.$store.commit('next' , '/login');
                    }
                });
            }
            let complete = (msg , isTip) => {
                layer.closeAll();
                msg = G.isString(msg) ? msg : '';
                isTip = G.isBoolean(isTip) ? isTip : true;
                if (isTip) {
                    layer.msg(msg);
                }
            };
            let formData = G.formData(form);
            Api.image.addComment(formData , () => {
                layer.load(2);
            } , data => {
                complete(null , false);
                if (G.isFunction(fn)) {
                    fn(data);
                }
            } , complete , complete);
        } ,

        // 正常情况下添加评论
        addComment () {
            this._addComment(this.send.form , (data) => {
                this.comment.data.comment.unshift(data);
                this.send.isShowPannel = true;
                this.dom.btm.scrollIntoView(this.dom.container.get(0));
                // 状态还原
                this.send.form.content = '';
                this.send.form.pid = 0;
                layer.msg('评论成功');
            });
        } ,

        // 获取评论数据
        replys (id , mode , page) {
            if (this.status.isLoadReply) {
                return ;
            }

            if (page > this.cpData.reply.page.max_page) {
                return ;
            }

            let modeRange = ['overrite' , 'append'];
            mode = G.contain(mode , modeRange) ? mode : 'overrite';
            page = G.isInt(page) ? page : 1;

            let form = G.formData({
                id ,
                page
            });

            let complete = (msg , isTip) => {
                msg = G.isString(msg) ? msg : '';
                isTip = G.isBoolean(isTip) ? isTip : true;
                this.$refs.comments.hideLoading();
                this.status.isLoadReply = false;
                if (isTip) {
                    layer.msg(msg);
                }
            };

            Api.image.reply(form , () => {
                this.status.isLoadReply = true;
                this.$refs.comments.showLoading();
            } , (data) => {
                complete(null , false);
                if (mode === 'overrite') {
                    this.cpData.reply = data;
                } else {
                    let page = data.page;
                    data = data.data;
                    this.cpData.reply.page = page;
                    data.forEach(v => {
                        this.cpData.reply.data.push(v);
                    });
                }
            } , complete , complete);
        } ,

        // 回复评论
        showComments (comment) {
            this.cpData.comment = comment;
            this.replys(comment.id , 'overrite' , 1);
            // 显示内容
            this.$refs.comments.show();
        } ,

        // 关闭评论详情
        closeComments () {
            this.$refs.comments.hide();
        } ,

        loadMoreReply (id , page) {
            this.replys(id , 'append' , page);
        } ,

        // 回复用户
        reply (form) {
            form['image_subject_id'] = this.data.id;

            this._addComment(form , (data) => {
                this.cpData.reply.data.unshift(data);
                this.$refs.comments.origin();
                // todo 新增评论滚动到可视位置
                layer.msg('评论成功');
            })
        } ,
        // 查看图片详情
        preview (imageSubjectId , id) {
            this.$store.commit('next' , '/preview/' + imageSubjectId + '/' + id);
        }
    } ,
}