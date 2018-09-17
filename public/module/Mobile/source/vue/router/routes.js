import login from '../components/user/login.vue';
import register from '../components/user/register.vue';
import _public_ from '../components/public/public.vue';
import index from '../components/index/index.vue';
import detailForImage from '../components/image/detail.vue';
import comments from '../components/share/comments.vue';
import preview from '../components/image/preview.vue';

export default [
    {
        name: 'login' ,
        path: '/login' ,
        component: login
    } ,
    {
        name: 'register' ,
        path: '/register' ,
        component: register
    } ,
    {
        name: 'home' ,
        path: '/' ,
        component: _public_ ,
        children: [
            {
                name: 'index' ,
                path: 'index' ,
                component: index
            }
        ]
    } ,
    {
        path: '/image/detail/:id' ,
        component: detailForImage
    } ,
    {
        path: '/preview/:image_subject_id/:id' ,
        component: preview
    } ,
    {
        path: '/comment/:id' ,
        component: comments
    } ,
    // {
    //     name: 'user' ,
    //     path: '/user' ,
    //     component: user ,
    //     children: [
    //         {
    //             path: 'index' ,
    //             component: userIndex
    //         }
    //     ]
    // }
];