<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="30000kb"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="com.bbs.service.*" %>
<%@ page import="com.bbs.model.*" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style>
    a{
        text-decoration:none;
    }

</style>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>postDetail</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="css/details.css" />
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/jquery.pages.js"></script>
</head>
<%
    //此处写你的txt文件的绝对路径
    Properties prop = new Properties();
    InputStream ins = this.getClass().getResourceAsStream("/resource/properties.properties");
    prop.load(ins);
    String keyPath = prop.getProperty("KEYURL");
    BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(keyPath), "UTF-8"));
    ArrayList<String> arr = new ArrayList<String>();
    String temp = null;
    while((temp = bufferedReader.readLine()) != null) {
        arr.add(temp);
    }
    bufferedReader.close();
    for (String s : arr) {
%>
<script>
    $(function () {
        var content = document.getElementById("con").innerHTML;
        var reg = new RegExp("<%=s%>" , "g");
        if(reg.exec(content)){
            var newstr = content.replace(reg, "<font color='red'><%=s%></font>");
            document.getElementById("con").innerHTML = newstr;
        }
    })
</script>
<%}%>
<%
    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    PostBiz postBiz = (PostBiz)context.getBean("postBiz");
    FollowcardBiz followcardBiz = (FollowcardBiz)context.getBean("followcardBiz");
    CommentBiz commentBiz = (CommentBiz)context.getBean("commentBiz");
    String isFlag = request.getParameter("isFlag");
    String flags = request.getParameter("flags");

    int postId  = 1;
    String pid = request.getParameter("postId");
    if (pid == null)
        postId = (Integer)request.getAttribute("postId");
    else
    postId = Integer.parseInt(pid);
    Post post = postBiz.getPostById(postId);
    Post Upost = postBiz.getUpPostById(postId);
    Post Npost = postBiz.getNextPostById(postId);
    int pageNum  = 1;
    String num = request.getParameter("page");
    if (num != null)
        pageNum = Integer.parseInt(num);
    else
        pageNum = (Integer)request.getAttribute("page");
    //浏览数量
    postBiz.autoIncreaseViewNum(postId);
    List<Followcard> followcards = postBiz.getFollowCards(postId, pageNum, 1000);
    if("1".equals(flags)){
        followcardBiz.readByPostId(postId);
    }
%>
<script>
    $(function () {
        if(<%=followcards.size()<1%>){
            $("#rep").hide();
        }
    })
</script>
<body>
<!--header开始-->
<header>
    <div class="header">
        <div class="header-center">
            <div class="header-top">
                <div class="header-left">
                    <p>世数网络</p>
                </div>
                <div class="header-right">
                    <ul>
                        <li onclick="window.location.href='<%=path%>/index.jsp'">社区</li>
                        <li>矿机</li>
                        <li>应用服务</li>
                        <li>电子钱包</li>
                        <li>关于我们</li>
                        <li>多语言支持（中英文）</li>
                        <li id="login" onclick="window.location.href='<%=path%>/login.jsp'">用户登录</li>
                        <li onclick="window.location.href='<%=path%>/regist.jsp'">新用户注册</li>
                    </ul>
                </div>
            </div>
            <div class="header-bottom">
                <p><span class="sapn">EOS</span><span>星体链服务平台</span></p>
                <p>流程简约高效率，资产真是透明</p>
                <p>查看详情</p>
            </div>
        </div>
        <div class="header-xiaotiao">
            <div class="header-xiantiao-center">
                <ul>
                    <li>联合学院：http：123.hng.com</li>
                    <li>联合学院：http：123.hng.com</li>
                    <li>联合学院：http：123.hng.com</li>
                    <li><img id="xs" src="img/420685932315535688.png" alt=""/></li>
                </ul>
            </div>
        </div>
    </div>
</header>
<!--main开始-->
<div class="main">
    <div class="main-center view_width">
        <div class="mian-top">
            <span  style="cursor: pointer" onclick="window.location.href='<%=path%>/index.jsp'">社区></span>
            <span>论帖详情</span>
        </div>
        <div class="main-bottom">
            <div class="main-bottom-left">
                <div class="main-left-content">
                    <p><%=post.getTitle()%></p>
                    <div class="content-oneul">
                        <ul>
                            <li>时间：<%=post.getTime() %></li>
                            <li>作者：<%=post.getUser().getUsername()%></li>
                        </ul>
                        <span>
                               <%String username = (String)session.getAttribute("username");
                                   if ((username != null && post.getUser().getUsername().equals(username))){%>
                                <a style="float:right;margin-right: 20px;margin-top: -54px;color: #e0bd35" href="<%=path%>/editpost.action?postId=<%=post.getId()%>">编辑</a>
                                <%}%>
                          </span>
                    </div>
                    <div class="Content-center">
                        <div class="wenzi" id="con">
                            <%=post.getCardContent()%>
                            <script>
                                $(function () {
                                    $(".wenzi p").removeAttr("style");
                                    $(".wenzi p").addClass("wenzi");
                                    //  $(".wenzi p").attr("style","width:826px;height:78px;");
                                });
                            </script>
                        </div>
                        <div class="Pagination">
                            <ul>
                                <% if(Upost!=null&&!"".equals(Upost)) {%>
                                <li id="up<%=post.getId()%>" style="cursor: pointer" onclick="window.location.href='<%=path%>/pages/post.jsp?postId=<%=Upost.getId()%>&&page=1&&isFlag=1'">上一篇：<%=Upost.getTitle()%></li>
                                <%} else{%>
                                <li></li>
                                <%}%>
                                <% if(Npost!=null&&!"".equals(Npost)) {%>
                                <li id="dw<%=post.getId()%>" style="cursor: pointer" onclick="window.location.href='<%=path%>/pages/post.jsp?postId=<%=Npost.getId()%>&&page=1&&isFlag=1'">下一篇：<%=Npost.getTitle()%></li>
                                <%} else{%>
                                <li></li>
                                <%}%>
                            </ul>
                        </div>
                    </div>
                    <div class="latest-comment">
                        <p>最新评论</p>
                        <form id="frm" >
                            <input type="hidden" name="postId" value="<%=postId%>">
                            <input type="hidden" name="page" value="<%=pageNum%>">
                            <textarea name="content" id="cont" rows="" cols="" placeholder="留下你的看法"></textarea>
                            <div class="anniu">
                                <button id="qx">取消</button>
                                <button id="submit2">发表</button>
                            </div>
                        </form>
                    </div>
                    <div class="Wonderful-comment" id="rep">
                        <div class="wonderful-wenzi" >
                            <%--  <span>精彩评论</span>--%>
                            <span>最新评论</span>
                        </div>
                        <div class="wonderful-pinglun" id="pls">
                        </div>
                        <span id="tishi" style="margin-left: 35%;color: #ccc;"></span>
                        <div class="wonderful-pinglun" id="plq">
                        <%
                            int size = followcards.size();
                            UserBiz userBiz = (UserBiz)context.getBean("userBiz");
                            int floor = 0;
                            for (int i = 0;i<size;i++ ){
                                Followcard followcard = followcards.get(i);
                                String follContent = followcard.getFollowContent();
                                follContent =follContent.replaceAll("<[.[^<]]*>", "");
                                floor = i+5*(pageNum-1)+1;
                                User user = followcard.getUser();
                                User repeatUser = null;
                                if (user.getSex() == null){
                                    repeatUser = userBiz.getUserById(user.getId());
                                    user.setSex(repeatUser.getSex());
                                }
                                if (user.getLevel() == null&&repeatUser!=null){
                                    user.setLevel(repeatUser.getLevel());
                                } %>
                        <% String username1=post.getUser().getEmail();String username2=user.getEmail();
                            String  username3 =(String)session.getAttribute("username");
                            Integer  userId =(Integer)session.getAttribute("userId");
                            GreatRecordBiz greatRecordBiz = (GreatRecordBiz)context.getBean("greatRecordBiz");
                            GreatRecord record=new GreatRecord();
                            record.setUserId(userId);
                            record.setFollowId(followcard.getId());
                            GreatRecord isGreat=greatRecordBiz.queryIsGreatByUserId(record);
                            String src=(isGreat!=null)?"img/great1.png":"img/great2.png";
                        %>
                            <ul>
                                <%if (username2.equals(username1)) {%>
                                <li><span><%=user.getUsername()%>:</span><span> <%=follContent%></span>
                                    <span class="badge" style="background: #e4c53c;color: #ffffff;width: 50px;">楼主</span></li>
                                <li><span style="box-sizing: border-box;padding-right: 525px;"><%=followcard.getTime() %></span><%--<span id="rep<%=followcard.getId()%>">回复 </span>--%>
                                    <span id="dz<%=followcard.getId()%>">
                                      <img id="z<%=followcard.getId()%>" src="<%=src%>" class="animation" /></span>
                                    <span class="animation"  id="g<%=followcard.getId()%>"> <%=followcard.getGreat_num()%></span>
                                    <script>
                                        $(function (){
                                            if(<%=followcard.getGreat_num()==null%>){
                                                $("#dz"+<%=followcard.getId()%>).html("0");
                                            }
                                        })
                                    </script>
                                        <%}else{%>
                                        <% if (floor >0) {%>
                                <li><span><%=user.getUsername()%>:</span><span> <%=follContent%></span><span class="badge" style="margin-right:10px;background: #e4c53c;color: #ffffff;width: 50px;">沙发</span></li>
                                <li><span style="box-sizing: border-box;padding-right: 525px;"><%=followcard.getTime() %></span><%--<span id="rep<%=followcard.getId()%>">回复 </span>--%>
                                    <span id="dz<%=followcard.getId()%>">
                                       <img id="z<%=followcard.getId()%>" src="<%=src%>" class="animation" /></span>
                                    <span class="animation"  id="g<%=followcard.getId()%>"> <%=followcard.getGreat_num()%></span>
                                    <%}%>
                                    <%}%>
                                    <span style="cursor: pointer" id="del<%=followcard.getId()%>">删除</span></li>
                                <li id="hf<%=followcard.getId()%>"></li>
                                <li >
                                    <div class="latest-comment">
                                        <form id="fm<%=followcard.getId()%>" action="<%=path%>/reply2.action"  method="post">
                                            <input type="hidden" name="user_receive" value="<%=followcard.getId()%>">
                                            <input type="hidden" name="postId" value="<%=postId%>">
                                            <input type="hidden" name="user_send" value="<%=userId%>">
                                            <input type="hidden" name="page" value="<%=pageNum%>">
                                            <textarea style="width: 800px;height: 110px;" name="content" id="content" rows="" cols="" placeholder="有什么想对TA说："></textarea>
                                            <div class="anniu">
                                                <button id="qx<%=followcard.getId()%>" class="plqx">取消</button>
                                                <button type="submit">发表</button>
                                            </div>
                                        </form>
                                    </div>
                                </li>
                            <script>
                                $(function () {
                                    /* 评论回复框默认隐藏*/
                                    $("#fm"+<%=followcard.getId()%>).hide();
                                    /* 点击回复展示回复框*/
                                    $("#rep"+<%=followcard.getId()%>).click(function () {
                                        $("#fm"+<%=followcard.getId()%>).show();
                                    })
                                    if(<%=username3!=null&&username3.equals(username1)%>){
                                        $("#del"+<%=followcard.getId()%>).show();
                                    }else{
                                        $("#del"+<%=followcard.getId()%>).hide();
                                    }
                                    if(<%=Upost==null%>){
                                        $("#up"+<%=post.getId()%>).hide();
                                    }
                                    if(<%=Npost==null%>){
                                        $("#dw"+<%=post.getId()%>).hide();
                                    }
                                    $("#del"+<%=followcard.getId()%>).click(function () {
                                        if(confirm("确定要删除此条评论吗？")){
                                            $.ajax({
                                                type: "POST",
                                                url: "<%=path%>/del.action",
                                                data: {"followId":<%=followcard.getId()%>,postId:<%=postId%>},
                                                dataType:"text",
                                                success: function () {
                                                    alert("删除成功");
                                                    window.location.reload();
                                                },
                                                error: function () {
                                                    alert("删除成功");
                                                    window.location.reload();
                                                }
                                            });
                                        }
                                    })
                                    /*  取消发表内容*/
                                    $("#qx").click(function () {
                                        $("#cont").val("");
                                        return false;
                                    });
                                    $("#qx"+<%=followcard.getId()%>).click(function () {
                                        $("#fm"+<%=followcard.getId()%>).hide();
                                        return false;
                                    });
                                    /* /!*发送回复评论内容*!/
                                     $("#sub"+<%=followcard.getId()%>).click(function () {
                                     $.ajax({
                                     type: "POST",
                                     url: "<%=path%>/replay2.action",
                                     data: $("#fm"+<%=followcard.getId()%>).serialize(),
                                     dataType:"text",
                                     success: function () {
                                     alert(1111);
                                     },
                                     });
                                     })*/
                                    <%--在此拼接回复内容--%>
                                    <% List<Comment> comments = commentBiz.findByFollowId(followcard.getId());
                                        if(comments.size()>0){
                                            for(Comment comment:comments){%>
                                    var str= "<div class='wonderful-pinglun-ul'><ul><li><span><%=comment.getUser().getUsername()%>:"
                                        +"</span><span><%=comment.getContent()%></span></li>"
                                        +"  <li><span style='box-sizing: border-box;padding-right: 300px;'><%=comment.getDate() %></span>"/*/!*<span id='repp<%=comment.getId()%>'>回复 </span>*!/*/
                                        +" <span id='dzz<%=comment.getId()%>'>"
                                        +" <img id='zz<%=comment.getId()%>' src='/img/great2.png' class='animation' /></span>"
                                        +" <span class='animation'  id='gg<%=comment.getId()%>'> <%=comment.getGreat_num()%></span>"
                                        +"</ul>";
                                    $("#hf"+<%=followcard.getId()%>).append(str);
                                    //回复评论事件
                                    $("#dzz"+<%=comment.getId()%>).click(function(){
                                        var praise_img = $("#zz"+<%=comment.getId()%>);
                                        var praise_txt = $("#gg"+<%=comment.getId()%>);
                                        var num=parseInt(praise_txt.text());
                                        if(praise_img.attr("src") == ("img/great1.png")){
                                            $(this).html("<img src='img/great2.png' id='zz<%=comment.getId()%>' class='animation' />");
                                            praise_txt.removeClass("hover");
                                            num -=1;
                                            praise_txt.text(num)
                                        }else{
                                            $(this).html("<img src='img/great1.png' id='zz<%=comment.getId()%>' class='animation' />");
                                            praise_txt.addClass("hover");
                                            num +=1;
                                            praise_txt.text(num)
                                        }
                                        $.ajax({
                                            type: "POST",
                                            url: "${pageContext.request.contextPath}/commentGreat.action",
                                            data: {"commentId": <%=comment.getId()%>,"great_num":num},
                                            success: function () {
                                            },
                                        });
                                    });
                                    <%}}else{%>
                                    var  str2 = "";
                                    $("#hf"+<%=followcard.getId()%>).append(str2);
                                    <% }%>
                                    //评论事件
                                    $("#dz"+<%=followcard.getId()%>).click(function(){
                                        var praise_img = $("#z"+<%=followcard.getId()%>);
                                        var praise_txt = $("#g"+<%=followcard.getId()%>);
                                        var num=parseInt(praise_txt.text());
                                        var addOrMinus;
                                        sessionStorage.setItem("flag",num);
                                        if(praise_img.attr("src") == ("img/great1.png")){
                                            $(this).html("<img src='img/great2.png' id='z<%=followcard.getId()%>' class='animation' />");
                                            praise_txt.removeClass("hover");
                                            num -=1;
                                            addOrMinus=0;
                                            praise_txt.text(num)
                                        }else{
                                            $(this).html("<img src='img/great1.png' id='z<%=followcard.getId()%>' class='animation' />");
                                            praise_txt.addClass("hover");
                                            num +=1;
                                            addOrMinus=1;
                                            praise_txt.text(num)
                                        }
                                        $.ajax({
                                            type: "POST",
                                            url: "${pageContext.request.contextPath}/followGreat.action",
                                            data: {"followId": <%=followcard.getId()%>,"great_num":num,"addOrMinus":addOrMinus},
                                            success: function () {
                                            },
                                        });
                                    });
                                    var praise_img = $("#z"+<%=followcard.getId()%>);
                                    var praise_txt = $("#g"+<%=followcard.getId()%>);
                                    var num=parseInt(praise_txt.text());
                                    var great_num =parseInt( sessionStorage.getItem("flag"));
                                    if(great_num<num){
                                        praise_img.attr("src","img/great1.png");
                                        praise_txt.removeClass("hover");
                                    }
                                    if(great_num==num){
                                        praise_img.attr("src","img/great2.png");
                                        praise_txt.removeClass("hover");
                                    }
                                })
                            </script>
                            </ul>
                            <%}%>
                         </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   <%-- <div class="main-bottom-right">
        <div class="main-bottom-right-top">
            <img src="img/pexels-photo-323772.png" alt="" />
            <p class="main-bottom-right-top-one">哈希资本投资EXX，开启ET盛世华</p>
            <p class="main-bottom-right-top-two">哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华</p>
        </div>
        <div class="main-bottom-right-top">
            <img src="img/pexels-photo-323772.png" alt="" />
            <p class="main-bottom-right-top-one">哈希资本投资EXX，开启ET盛世华</p>
            <p class="main-bottom-right-top-two">哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华</p>
        </div>
    </div>--%>
</div>
</body>
<script>
    <!-- 回复内容 -->
    $(function () {
        var name = "${sessionScope.name}";
        if(name != "" && name != null){
            $("#login").html("欢迎用户 :  "+name);
        }else{
            window.location.href = "login.jsp";
        }
        //默认加载第一页
         changep(1);
        $("#submit2").click(function () {
            //发表评论
            $.ajax({
                type: "POST",
                url: "<%=path%>/reply.action",
                data: $("#frm").serialize(),
                dataType: "text",
                success: function () {

                }
            });
        });
    })
    $("#xs").click(function () {
        $(".header-xiantiao-center").hide();
    })
    //页面刷新指定到原先滚动条位置
    window.onbeforeunload = function() {
        var scrollPos;
        if(typeof window.pageYOffset != 'undefined') {
            scrollPos = window.pageYOffset;
        } else if(typeof document.compatMode != 'undefined' &&
            document.compatMode != 'BackCompat') {
            scrollPos = document.documentElement.scrollTop;
        } else if(typeof document.body != 'undefined') {
            scrollPos = document.body.scrollTop;
        }
        document.cookie = "scrollTop=" + scrollPos; //存储滚动条位置到cookies中
        document.cookie='loginCount=1;expires='+new Date()+';path=/';//设置cookie过期时间为10s
        }
        window.onload = function() {
            if(document.cookie.match(/scrollTop=([^;]+)(;|$)/) != null&&<%=isFlag%>==null) {
                var arr = document.cookie.match(/scrollTop=([^;]+)(;|$)/); //cookies中不为空，则读取滚动条位置
                document.documentElement.scrollTop = parseInt(arr[1]);
                document.body.scrollTop = parseInt(arr[1]);
              }
        }

    //获取滚动条当前的位置
    function getScrollTop() {
        var scrollTop = 0;
        if(document.documentElement && document.documentElement.scrollTop) {
            scrollTop = document.documentElement.scrollTop;
        } else if(document.body) {
            scrollTop = document.body.scrollTop;
        }
        return scrollTop;
    }
    //获取当前可视范围的高度
    function getClientHeight() {
        var clientHeight = 0;
        if(document.body.clientHeight && document.documentElement.clientHeight) {
            clientHeight = Math.min(document.body.clientHeight, document.documentElement.clientHeight);
        } else {
            clientHeight = Math.max(document.body.clientHeight, document.documentElement.clientHeight);
        }
        return clientHeight;
    }
    //获取文档完整的高度
    function getScrollHeight() {
        return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
    }
    //评论下拉拼接
    var i=2;
    //滚动事件触发
    window.onscroll = function() {
        if(getScrollTop() + getClientHeight() == getScrollHeight()) {
            changep(i);
            i++;
        }
    }
</script>
</html>
