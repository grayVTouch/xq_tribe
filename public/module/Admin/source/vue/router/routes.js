import login from '../components/user/login.vue';
import register from '../components/user/register.vue';
import _public_ from '../components/public/public.vue';

export default [
    {
        name: 'home' ,
        path: '/' ,
        redirect: {name: 'admin'}
    } ,
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
        name: 'admin' ,
        path: '/admin' ,
        component: _public_
    }
];