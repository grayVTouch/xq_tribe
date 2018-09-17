/**
 * 这边加载或定义的变量依赖于 globalVars.js 中定义的相关变量
 * 所以是全局变量的子级
 */

import Api from '../../api/api.js';
import components from '../../mapping/component.js';
import mapping from '../../mapping/mapping.js';

// 所有 api 请求
G.assign(window , {
    Api
});

G.assign(topContext , {
    components ,
    mapping
});