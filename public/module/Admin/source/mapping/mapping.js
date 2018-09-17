/*
 * 路由对照表
 * 功能清单
 */
export default [
    {
        cn: '用户管理' ,
        en: 'User Manager' ,
        path: 'user' ,
        sIco: topContext.resUrl + 'image/function/default/user.png' ,
        bIco: topContext.resUrl + 'image/function/default/user_blue.png' ,
        parent: null ,
        disabed: 'n' ,
        isLink: 'n' ,
        children: [
            {
                cn: '用户列表' ,
                path: 'user/list' ,
                parent: 'user' ,
                disabed: 'n' ,
                isLink: 'y' ,
                children: [
                    {
                        cn: '编辑用户' ,
                        path: 'user/edit' ,
                        parent: 'user/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    } ,
                    {
                        cn: '添加用户' ,
                        path: 'user/add' ,
                        parent: 'user/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    } ,
                    {
                        cn: '查看详情' ,
                        path: 'user/detail' ,
                        parent: 'user/detail' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    }
                ]
            } ,
        ]
    } ,
    {
        cn: '模块管理' ,
        en: 'Module Manager' ,
        path: 'module' ,
        sIco: topContext.resUrl + 'image/function/default/module.png' ,
        bIco: topContext.resUrl + 'image/function/default/module_blue.png' ,
        parent: null ,
        disabed: 'n' ,
        isLink: 'n' ,
        children: [
            {
                cn: '模块列表' ,
                path: 'module/list' ,
                parent: 'module' ,
                disabed: 'n' ,
                isLink: 'y' ,
                children: [
                    {
                        cn: '添加模块' ,
                        path: 'module/add' ,
                        parent: 'module/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    } ,
                    {
                        cn: '编辑模块' ,
                        path: 'module/edit' ,
                        parent: 'module/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    }
                ]
            }
        ]
    } ,
    {
        cn: '标签管理' ,
        en: 'Tag Manager' ,
        path: 'tag' ,
        sIco: topContext.resUrl + 'image/function/default/tag.png' ,
        bIco: topContext.resUrl + 'image/function/default/tag_blue.png' ,
        parent: null ,
        disabed: 'n' ,
        isLink: 'n' ,
        children: [
            {
                cn: '标签列表' ,
                path: 'tag/list' ,
                parent: 'tag' ,
                disabed: 'n' ,
                isLink: 'y' ,
                children: [
                    {
                        cn: '添加标签' ,
                        path: 'tag/add' ,
                        parent: 'tag/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    } ,
                    {
                        cn: '编辑标签' ,
                        path: 'tag/edit' ,
                        parent: 'tag/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    }
                ]
            }
        ]
    } ,
    {
        cn: '图库管理' ,
        en: 'Image Manager' ,
        path: 'image' ,
        sIco: topContext.resUrl + 'image/function/default/image.png' ,
        bIco: topContext.resUrl + 'image/function/default/image_blue.png' ,
        parent: null ,
        disabed: 'n' ,
        isLink: 'n' ,
        children: [
            {
                cn: '图库列表' ,
                path: 'image/list' ,
                parent: 'image' ,
                disabed: 'n' ,
                isLink: 'y' ,
                children: [
                    {
                        cn: '添加图库' ,
                        path: 'image/add' ,
                        parent: 'image/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    } ,
                    {
                        cn: '编辑图库' ,
                        path: 'image/edit' ,
                        parent: 'image/list' ,
                        disabed: 'y' ,
                        isLink: 'y' ,
                        children: []
                    }
                ]
            } ,
            {
                cn: '评论列表' ,
                path: 'image/comment' ,
                parent: 'image' ,
                disabed: 'n' ,
                isLink: 'y' ,
                children: []
            }
        ]
    } ,
    {
        cn: '视频管理' ,
        en: 'Video Manager' ,
        path: 'video' ,
        sIco: topContext.resUrl + 'image/function/default/video.png' ,
        bIco: topContext.resUrl + 'image/function/default/video.png' ,
        parent: null ,
        disabed: 'n' ,
        isLink: 'n' ,
        children: [
            {
                cn: '视频列表' ,
                path: 'video/list' ,
                parent: 'video' ,
                disabed: 'n' ,
                isLink: 'y' ,
                children: []
            }
        ]
    } ,
    {
        cn: '系统设置' ,
        en: 'System Manager' ,
        path: 'system' ,
        sIco: topContext.resUrl + 'image/function/default/system.png' ,
        bIco: topContext.resUrl + 'image/function/default/system_blue.png' ,
        parent: null ,
        disabed: 'n' ,
        isLink: 'n' ,
        children: [
            {
                cn: '分类管理' ,
                path: 'category' ,
                parent: 'system' ,
                disabed: 'n' ,
                isLink: 'n' ,
                children: [
                    {
                        cn: '分类列表' ,
                        path: 'category/list' ,
                        parent: 'category' ,
                        disabed: 'n' ,
                        isLink: 'y' ,
                        children: [
                            {
                                cn: '添加分类' ,
                                path: 'category/add' ,
                                parent: 'category/list' ,
                                disabed: 'y' ,
                                isLink: 'y' ,
                                children: []
                            } ,
                            {
                                cn: '编辑分类' ,
                                path: 'category/edit' ,
                                parent: 'category/list' ,
                                disabed: 'y' ,
                                isLink: 'y' ,
                                children: []
                            }
                        ]
                    }
                ]
            } ,
            {
                cn: '关联主体' ,
                path: 'subject' ,
                parent: 'system' ,
                disabed: 'n' ,
                isLink: 'n' ,
                children: [
                    {
                        cn: '主体列表' ,
                        path: 'subject/list' ,
                        parent: 'subject' ,
                        disabled: 'n' ,
                        isLink: 'y' ,
                        children: [
                            {
                                cn: '添加主体' ,
                                path: 'subject/add' ,
                                parent: 'subject/list' ,
                                disabed: 'y' ,
                                isLink: 'y' ,
                                children: []
                            } ,
                            {
                                cn: '编辑主体' ,
                                path: 'subject/edit' ,
                                parent: 'subject/list' ,
                                disabed: 'y' ,
                                isLink: 'y' ,
                                children: []
                            }
                        ]
                    } ,
                ]
            }
        ]
    } ,
];