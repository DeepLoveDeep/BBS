function getzz() {
    var a = $("ul#pls div");
    var zz =new Array(a.length);
    for(var i=0;i <a.length;i++){
        zz[i]=a[i].innerHTML;
    } //div的字符串数组付给zz
    return zz;
}
function change(e){
    $("ul#pls div").hide();
    $("ul#sys li").hide();
    var zz=getzz();
    var pagesize=5; //每页多少条信息
    if(zz.length%pagesize==0){
        var  pageall =zz.length/pagesize ;
    }else{
        var  pageall =parseInt(zz.length/pagesize)+1;
    }   //一共多少页*/
    var pageno=e;
    var pagesize=5; //每页多少条信息
    if(e<1){
        e=1;pageno=1;//就等于第1页 ， 当前页为1
    }
    if(e>pageall){  //如果输入页大于最大页
        e=pageall;pageno=pageall; //输入页和当前页都=最大页
    }
    $("#pl").html("");//全部清空
    var html="";
    for(var i=0;i<pagesize;i++){
        html += zz[(e-1)*pagesize+i];//创建一页的li列表
        if(zz[(e-1)*pagesize+i+1]==null) break;//超出最后的范围跳出
    }
    if(zz[(e-1)*pagesize+i]==undefined){
        $("#pl").html("<li>抱歉，没有更多数据了</li>");
    }else{
        $("#pl").html(html);//给ul列表写入html
    }
}

function getxx() {
    var a = $("ul#sys div");
    var xx =new Array(a.length);
    for(var i=0;i <a.length;i++){
        xx[i]=a[i].innerHTML;
    } //div的字符串数组付给zz
    return xx;
}
function changex(e){
    $("ul#pls li").hide();
    $("ul#sys div").hide();
    var xx=getxx();
    var pagesize=3; //每页多少条信息
    if(xx.length%pagesize==0){
        var  pageall =xx.length/pagesize ;
    }else{
        var  pageall =parseInt(xx.length/pagesize)+1;
    }   //一共多少页*/
    var pageno=e;
    var pagesize=3; //每页多少条信息
    if(e<1){
        e=1;pageno=1;//就等于第1页 ， 当前页为1
    }
    if(e>pageall){  //如果输入页大于最大页
        e=pageall;pageno=pageall; //输入页和当前页都=最大页
    }
    $("#sy").html("");//全部清空
    var html="";
    for(var i=0;i<pagesize;i++){
        html += '<li>' + xx[(e-1)*pagesize+i] +'</li>';//创建一页的li列表
        if(xx[(e-1)*pagesize+i+1]==null) break;//超出最后的范围跳出
    }
    if(xx[(e-1)*pagesize+i]==undefined){
        $("#sy").html("<li>抱歉，没有更多数据了</li>");
    }else{
        $("#sy").html(html);//给ul列表写入html
    }
}
function getp() {
    var a = $("div#plq ul");
    var pp =new Array(a.length);
    for(var i=0;i <a.length;i++){
        pp[i]=a[i].innerHTML;
    } //div的字符串数组付给zz
    return pp;
}
function changep(e){
    $("div#plq ul").hide();
    var pp=getp();
    var pagesize=6; //每页多少条信息
    if(pp.length%pagesize==0){
        var  pageall =pp.length/pagesize ;
    }else{
        var  pageall =parseInt(pp.length/pagesize)+1;
    }   //一共多少页*/
    var pageno=e;
    var pagesize=6; //每页多少条信息
    if(e<1){
        e=1;pageno=1;//就等于第1页 ， 当前页为1
    }
    if(pageall==0){
        return false;
    }
    if(e>pageall){  //如果输入页大于最大页
        $("#tishi").html("");
        $("#tishi").html("亲，已经没有数据要加载了");
        return false;
    }
    var html="";
    for(var i=0;i<pagesize;i++){
        html += '<ul>' + pp[(e-1)*pagesize+i] +'</ul>';//创建一页的li列表
        if(pp[(e-1)*pagesize+i+1]==null){
            break;//超出最后的范围跳出
        }
    }
    if(pp[(e-1)*pagesize+i]==undefined){
        $("#pls").html("<ul></ul>");
    }else{
        $("#pls").append(html);//给div列表写入html
    }
}

function getb() {
    var a = $("div#conts .left-content-one");
    var bb =new Array(a.length);
    for(var i=0;i <a.length;i++){
        bb[i]=a[i].innerHTML;
    } //div的字符串数组付给zz
    return bb;
}
function changeb(e){
    $("div#conts .left-content-one").hide();
    var bb=getb();
    var pagesize=10; //每页多少条信息
    if(bb.length%pagesize==0){
        var  pageall =bb.length/pagesize ;
    }else{
        var  pageall =parseInt(bb.length/pagesize)+1;
    }   //一共多少页*/
    var pageno=e;
    var pagesize=10; //每页多少条信息
    if(e<1){
        e=1;pageno=1;//就等于第1页 ， 当前页为1
    }
    if(pageall==0){
        return false;
    }
    if(e>pageall){  //如果输入页大于最大页
        $("#tishi").html("");
        $("#tishi").html("亲，已经没有数据要加载了");
        return false;
    }
    var html="";
    for(var i=0;i<pagesize;i++){
        html += '<div>' + bb[(e-1)*pagesize+i] +'</div>';//创建一页的li列表
        if(bb[(e-1)*pagesize+i+1]==null){
            break;//超出最后的范围跳出
        }
    }
    if(bb[(e-1)*pagesize+i]==undefined){
        $("#cont").html("<div></div>");
    }else{
        $("#cont").append(html);//给div列表写入html
    }
}


function getn() {
    var a = $("div#nconts .left-content-one");
    var nn =new Array(a.length);
    for(var i=0;i <a.length;i++){
        nn[i]=a[i].innerHTML;
    } //div的字符串数组付给zz
    return nn;
}
function changen(e){
    $("div#nconts .left-content-one").hide();
    var nn=getn();
    var pagesize=10; //每页多少条信息
    if(nn.length%pagesize==0){
        var  pageall =nn.length/pagesize ;
    }else{
        var  pageall =parseInt(nn.length/pagesize)+1;
    }   //一共多少页*/
    var pageno=e;
    var pagesize=10; //每页多少条信息
    if(e<1){
        e=1;pageno=1;//就等于第1页 ， 当前页为1
    }
    if(pageall==0){
        return false;
    }
    if(e>pageall){  //如果输入页大于最大页
        $("#tishi").html("");
        $("#tishi").html("亲，已经没有数据要加载了");
        return false;
    }
    var html="";
    for(var i=0;i<pagesize;i++){
        html += '<div>' + nn[(e-1)*pagesize+i] +'</div>';//创建一页的li列表
        if(nn[(e-1)*pagesize+i+1]==null){
            break;//超出最后的范围跳出
        }
    }
    if(nn[(e-1)*pagesize+i]==undefined){
        $("#ncont").html("<div></div>");
    }else{
        $("#ncont").append(html);//给div列表写入html
    }
}