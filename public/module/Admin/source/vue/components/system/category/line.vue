<template>
    <div ref="line" class="line">
        <div class="function" @click="open = !open">
            <div class="left">
                <div class="c-left">
                    <label class='form-label' @click.stop="selectedEvent">
                        <input type="checkbox" class="form-radio" @click.stop :value="category.id">&nbsp;&nbsp;{{ category.name }}
                    </label>
                    <span class='control' v-if="category.children.length > 0">{{ open ? '-' : '+' }}</span>
                </div>
                <div class="c-right">
                    <span>【是否禁用：{{ category.disabled_explain }}】</span>
                    <span>【系统预置：{{ category.system_explain }}】</span>
                    <span>【上级分类：{{ category.parent }}】</span>
                </div>
            </div>
            <div class="right">
                <button class="btn-1" @click.stop>详情</button>
                <button class="btn-1" @click.stop="$root.$his.to($root.$_route.controller + '/edit?id=' + category.id)">编辑</button>
                <button class="btn-1" @click.stop="$root.delEvent" :data-id="category.id">删除</button>
            </div>
        </div>
        <div class="children" v-show="open">
            <v-line v-for="v1 in category.children" :category="v1" :key="v1.id"></v-line>
        </div>
    </div>
</template>

<script>
    export default {
        name: "v-line" ,
        props: {
            category: Object
        } ,
        data () {
            return {
                open: true ,
                dom: {}
            };
        } ,
        mounted () {
            this.dom.line = G(this.$refs.line);
            this.dom.function = G('.function' , this.dom.line.get(0));
            this.dom.children = G('.children' , this.dom.line.get(0));
            this.cRadios = G('.form-radio' , this.dom.children.get(0));
        } ,
        methods: {
            selectedEvent (e) {
                let tar = G(e.currentTarget);
                let radio = G('.form-radio' , tar.get(0));
                let checked = !radio.checked();
                this.cRadios.checked(checked);
            }
        }
    }
</script>

<style scoped src="./css/line.css"></style>