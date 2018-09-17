// 如果引入的是目录，表明加载该目录下的 index.js
import router from '../router';

export default {
    // 路由定向跳跃，后退效果
    routerBack (state , route , completed , aborted) {
        // state.trans = '_slide-left';
        state.trans = '_ease-in-out';
        router.push(route , completed , aborted);
    } ,
    // 路由定向跳跃，前进效果
    routerNext (state , route , completed , aborted) {
        // state.trans = '_slide-right';
        state.trans = '_ease-in-out';
        router.push(route , completed , aborted);
    } ,
    // 路由后退
    back (state) {
        // state.trans = '_slide-left';
        state.trans = '_ease-in-out';
        window.history.go(-1);
    } ,
    forward (state) {
        // state.trans = '_slide-right';
        state.trans = '_ease-in-out';
        window.history.go(1);
    } ,
    // 解析 url
    parse (state , info) {
        let {id , path} = info;
        let res = [];
        // 找到当前想
        let current = (path , mapping) => {
            let cur = null;
            for (let i = 0; i < mapping.length; ++i)
            {
                cur = mapping[i];
                if (cur.path == path) {
                    return cur;
                }
                if (G.isArray(cur.children) && cur.children.length > 0) {
                    let res = current(path , cur.children);
                    if (res) {
                        return res;
                    }
                }
            }
            return false;
        };
        // 当前项
        let cur = current(path , topContext.mapping);

        if (!cur) {
            console.log('未找到当前路径映射：' + path);
            state.routes[id] = {
                routes: [] ,
                curRoute: {} ,
                topRoute: {}
            };
            return ;
        }

        // 关系树
        let parents = function(v){
            res.push(v);
            if (G.isNull(v.parent)) {
                return ;
            }
            let cur = current(v.parent , topContext.mapping);
            parents(cur);
        };
        parents(cur);
        // 修正层级顺序
        res.reverse();

        res.forEach((v , k , a) => {
            v.link = v.path;
        });

        // 路由路径
        state.routes[id] = {
            routes: res ,
            top: res[0] ,
            cur: res[res.length - 1]
        };
    }

}
