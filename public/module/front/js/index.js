let w = 750;
let f = 100;

G.setRootFontSize(w , f);
G(window).on('resize' , G.setRootFontSize.bind(G , w , f) , true , false);

// 导航栏滚动
let fixTop = G('.fix-top');
let fixMid = G('.fix-mid');
let fixBtm = G('.fix-btm');

let fn = new FunctionNav(fixMid.get(0) , {
    id: 'image' ,
    click (id) {
        sw.id(id);
    }
});

// 设置高度
let setH = () => {
    // 计算 fix-mid 的高度
    let fixMidH = document.documentElement.clientHeight - fixTop.height('border-box') - fixBtm.height('border-box');
    fixMid.css({
        height: fixMidH + 'px'
    });
};

setH();
window.onresize = setH;

let content = G('.content' , fixMid.get(0));
let sw = new Switch(content.get(0) , {
    id: 'image' ,
    switch (id) {
        fn.switch(id);
    } ,
});

let slidebarContainer = G('.slidebar-container');
let s = new Slidebar(slidebarContainer.get(0) , {
    status: 'hide'
});

let pannel = G('.pannel' , fixTop.get(0));

pannel.on('click' , function(){
    s.show();
} , true , false);

// 加载
let image = G(sw.find('image'));
let lt = new LoadTop(image.get(0) , {
    status: 'show' ,
    text: '正在加载' ,
    load: function(){
        window.setTimeout(this.hide.bind(this) , 3000);
    }
});

window.setTimeout(function(){
    // lt.hide();
} , 3000);

let lb = new LoadBtm(image.get(0) , {
    status: 'hide'
});

let timer = null;

// 边界检查
let b = new Boundary(image.get(0) , {
    once: true ,
    top: function(){
        console.log('滚动到顶部');
    } ,
    bottom: function(){
        console.log('滚动到底部');
        lb.show();

        console.log(timer);
        window.clearTimeout(timer);
        timer = window.setTimeout(function(){
            lb.hide();
            console.log('关闭加载');
        } , 3000);
    }
});