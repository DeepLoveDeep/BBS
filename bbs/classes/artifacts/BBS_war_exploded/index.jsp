<%@page import="com.bbs.model.Notice" %>
<%@page import="com.bbs.service.NoticeBiz" %>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext" %>
<%@page import="org.springframework.context.ApplicationContext" %>
<%@page import="com.bbs.model.Post" %>
<%@page import="java.util.List" %>
<%@page import="com.bbs.service.PostBiz" %>
<%@page import="com.bbs.model.MainForum" %>
<%@page import="com.bbs.service.MainForumBiz" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>XNECommunity</title>
    <link rel="stylesheet" href="swiper/css/swiper.css" />
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="layer/skin/default/layer.css">
</head>
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
                <p><span class="sapn">XNE</span><span>星体链服务平台</span></p>
                <p>流程简约高效率，资产真是透明</p>
                <p>查看详情</p>
            </div>
        </div>
        <div class="header-xiaotiao">
            <div class="header-xiantiao-center" >
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
<!--header结束-->
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="layer/layer.js"></script>
<script type="text/javascript" src="js/particleground.min.js"></script>
<%-- <jsp:include page="/pages/header.jsp"/>--%>
<%String num = (String) request.getAttribute("num");%>
<script>
    $("#xs").click(function () {
        $(".header-xiantiao-center").hide();
    })
    $(function () {
        var name = "${sessionScope.name}";
        if(name != "" && name != null){
            $("#login").html("欢迎用户 :"+name);
        }
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/more.action",
            data: {"type": 1, "page": 1},
            dataType: "text",
            success: function (data) {
                $("#content").append(data);
                //滚动条到达页面底部自动加载下一页数据
                var i=2;
                $(window ).off("scroll" ).on("scroll",function(){
                    var dh = $(document).height();
                    var end = $(window).height() + $(window ).scrollTop();
                    if(dh==end){
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/more.action",
                            data: {"type":1, "page": i},
                            dataType: "text",
                            success: function (data) {
                                if(data.length!=598){
                                    $("#content").append(data);
                                    i++;
                                }else{
                                    $("#content").append("");
                                    $("#tishi").html("");
                                    $("#tishi").html("亲，已经没有数据要加载了");
                                    return false;
                                }
                            },
                        });
                    }
                });
            },
        });
        /*签到运势*/
        $("#qd").click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                window.location.href = "publish_post.jsp";
            } else {
                window.location.href = "login.jsp";
            }
        });
        /*发文章*/
        $("#ft").click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                window.location.href = "publish_post.jsp";
            } else {
                window.location.href = "login.jsp";
            }
        });
        /*查看公告*/
        $("#gg").click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                window.location.href = "<%=request.getContextPath() %>/more.action?type=-4&&page=1";
            } else {
                window.location.href = "login.jsp";
            }
        })
        /*查看更多精华帖*/
        $("#jh").click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                window.location.href = "<%=request.getContextPath() %>/more.action?type=-2&&page=1";
            } else {
                window.location.href = "login.jsp";
            }
        })
        /*我的消息*/
        $("#xx").click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                layer.open({
                    type: 2,
                    title: '我的消息',
                    maxmin: true,
                    skin: 'layui-layer-lan',
                    shadeClose: true, //点击遮罩关闭层
                    area : ['65%' , '55%'],
                    content:'myMessage.jsp'//弹框显示的url,对应的页面
                });
            } else {
                window.location.href = "login.jsp";
            }
        });
        /*投诉和建议*/
        $("#fk").click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                layer.open({
                    type: 2,
                    title: '投诉与建议',
                    maxmin: true,
                    skin: 'layui-layer-lan',
                    shadeClose: true, //点击遮罩关闭层
                    area : ['600px' , '450px'],
                    content:'pages/advice.jsp'//弹框显示的url,对应的页面
                });
            } else {
                window.location.href = "login.jsp";
            }
        });
       /* /!*获取我的消息的总量*!/
        var userInfo = "${sessionScope.username}";
        if (userInfo != "" && userInfo != null) {
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/num.action",
                data: {"username": userInfo},
                success: function () {
                    <%=num%>
                    $("#num").html();
                },
                error: function () {
                    //alert("系统繁忙！");
                }
            });
        }*/
    })
</script>
<div class="main">
    <div class="main-center view_width">
        <div class="main-left">
            <div class="left-table">
            <%
                ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
                MainForumBiz mainForumBiz = (MainForumBiz) context.getBean("mainForumBiz");
                List<MainForum> mainForums = mainForumBiz.getAllMainForums();
                int size = mainForums.size();
                for (int i = 1; i <= size; i++) {
                    MainForum mainForum = mainForums.get(i - 1);
                    if (i == 1) { %>
            <ul>
                <li id="<%=mainForum.getId() %>"><a class="def" href="javascript:void(0)">
                    <%=mainForum.getTitle() %>
                </a></li>
                <%} else if (i > 1 && i < 7) { %>
                <li id="<%=mainForum.getId() %>"><a class="reb" href="javascript:void(0)">
                    <%=mainForum.getTitle() %>
                </a></li>
                <%} else if (i == 7) {%>
            </ul>
            <ul>
                <li id="<%=mainForum.getId() %>"><a class="reb" href="javascript:void(0)">
                    <%=mainForum.getTitle() %>
                </a></li>
                <%} else {%>
                <li id="<%=mainForum.getId() %>"><a class="reb" href="javascript:void(0)">
                    <%=mainForum.getTitle() %>
                </a></li>
                <% if (i % 4 == 4) {%>
                <%
                        }
                    }
                %>
                <script>
                    $("#<%=mainForum.getId() %>").click(function () {
                        $("ul li a").removeClass();
                        $("ul li a").addClass("reb");//每次点击的时候，先让所有的 ul li标签都还愿
                        $("#<%=mainForum.getId() %> ").children("a").removeClass();
                        $("#<%=mainForum.getId() %> ").children("a").addClass("def");//选中的获取样式
                        $.ajax({
                            type: "POST",
                            url: "${pageContext.request.contextPath}/more.action",
                            data: {"type":<%=mainForum.getId() %>, "page": 1},
                            dataType: "text",
                            success: function (data) {
                                $('#content').html("");
                                $("#content").append(data);
                                //滚动条到达页面底部自动加载下一页数据
                                var i=2;
                                $(window ).off("scroll" ).on("scroll",function(){
                                    var dh = $(document).height();
                                    var end = $(window).height() + $(window ).scrollTop();
                                    if(dh==end){
                                        $.ajax({
                                            type: "POST",
                                            url: "${pageContext.request.contextPath}/more.action",
                                            data: {"type":<%=mainForum.getId() %>, "page": i},
                                            dataType: "text",
                                            success: function (data) {
                                                if(data.length!=598){
                                                    $("#content").append(data);
                                                    i++;
                                                }else{
                                                    $("#content").append("");
                                                    $("#tishi").html("");
                                                    $("#tishi").html("亲，已经没有数据要加载了");
                                                    return false;
                                                }
                                            },
                                        });
                                    }
                                });
                            },
                      });
                    });
                </script>
                <%}%></ul>
        </div>
       <%-- 填充分类数据信息--%>
        <div id="content">

        </div>
            <span id="tishi" class="tishi"></span>
    </div>
        <div class="main-right">
            <div class="main-right-one">
                <ul>
                    <li id="qd" style="cursor:pointer">
                        <img src="img/qd.png" alt="">
                        <p style="margin-top: 5px;">签到运势</p>
                    </li>
                    <li id="ft" style="cursor:pointer">
                        <img src="img/wz.png" alt="" />
                        <p style="margin-top: 5px;">写文章</p>
                    </li>
                    <li id="xx" style="cursor:pointer">
                        <img src="img/xx.png" alt="" />
                        <p>我的消息</p>
                    </li>
                </ul>
            </div>
        <!--活动广告-->
        <div class="main-right-two">
            <div class="main-right-top">
                <div class="main-right-top-o">
                <span>活动广告</span>
               <%-- <span style="cursor:pointer">更多 ></span>--%>
                </div>
            </div>
            <div class="main-right-two-bottom">
                <div class="swiper-container banner_top">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide"><img src="img/gg1.jpg" alt=""></div>
                        <div class="swiper-slide"><img src="img/gg2.jpg" alt=""></div>
                        <div class="swiper-slide"><img src="img/gg3.jpg" alt=""></div>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>
           <%-- 社区公告--%>
            <div class="main-right-three">
                <div class="main-right-three-top">
                    <div class="main-right-three-top-o">
                        <span>社区公告</span>
                        <span style="cursor:pointer" id="gg" class="rta">更多 > </span>
                    </div>
                </div>
                <div class="main-right-three-bottom">
                    <ul class="ul-one">
                     <%
                    NoticeBiz noticeBiz = (NoticeBiz) context.getBean("noticeBiz");
                    List<Notice> notices = noticeBiz.getNotice(1, 4);
                    for (Notice notice : notices) {
                    %>
                    <li id="gao<%=notice.getId()%>" style="cursor:pointer">
                        <%=notice.getTitle()%>
                    </li>
                        <script>
                            /*查看公告帖*/
                            $("#gao"+<%=notice.getId()%>).click(function () {
                                var userInfo = "${sessionScope.username}";
                                if (userInfo != "" && userInfo != null) {
                                    window.location.href='<%=request.getContextPath()%>/pages/notice.jsp?noticeId=<%=notice.getId() %>'
                                } else {
                                    window.location.href = "login.jsp";
                                }
                            })
                        </script>
                    <%} %>
                    </ul>
                    <div class="ul-two">
                        <ul>
                            <li id="fk" style="cursor:pointer">
                                <img src="img/18.png" alt="" />
                                <span>投诉与建议</span>
                            </li>
                            <li>
                                <img src="img/11.png"/>
                            </li>
                            <li style="cursor:pointer">
                                <img src="img/24.png" alt="" />
                                <span>联系我们</span>
                            </li>
                        </ul>

                    </div>
                </div>
        </div>
    <%--<div class="activity">
        <div class="advertising">
            <p class="lta">论坛新帖</p>
            <a href="<%=request.getContextPath() %>/more.action?type=-1&&page=1" class="rta">更多 >> </a>
        </div>
        <ul class="list-group">
            <%
                PostBiz postBiz = (PostBiz)context.getBean("postBiz");
                List<Post> latestPosts = postBiz.getLatestPosts(1,6);
                for (Post post:latestPosts){
            %>
            <a href="<%=request.getContextPath()%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1" class="list-group-item">
                <h4 class="list-group-item-heading">[<%=post.getSubForum().getMainForum().getTitle()%>]</h4>
                <%=post.getTitle() %><span class="badge" style="background-color: #57b5e3;color: green">新</span>
                <p class="text-right" style="float: right;margin-right: 20px">浏览量:<%=post.getViewNum()%>&nbsp;评论量:<%=post.getReplyNum()%>&nbsp;发表日期:<%=post.getTime()%></p>
            </a>
            <%}%>
        </ul>

    </div>--%>


<div class="main-right-four">
    <div class="main-right-three-top">
        <div class="main-right-three-top-o">
            <span>精华帖</span>
            <span style="cursor:pointer" id="jh" >查看全部></span>
        </div>
    </div>
            <%
                PostBiz postBiz = (PostBiz) context.getBean("postBiz");
                List<Post> posts = postBiz.getBestPosts(1, 4);
                for (Post post : posts) {
                    String content =post.getCardContent();
                    content=content.replaceAll("<[.[^<]]*>", "");
            %>
            <div class="main-right-four-bottom">
                <ul class="main-four-ul" id="jing<%=post.getId()%>" >
                    <li >
                        <img src="img/51165.png" alt="" />
                    </li>
                    <li>
                        <p  style="height: 30px;cursor:pointer" id="t<%=post.getId()%>"><img src="img/hot.gif" alt="" />
                            <%=post.getTitle() %>
                        </p>
                        <div style="height: 65px;cursor:pointer" id="j<%=post.getId()%>"><%=content%></div>
                    </li>
                </ul>
            </div>
    <script >
        /*查看精华帖*/
        $("#jing"+<%=post.getId()%>).click(function () {
            var userInfo = "${sessionScope.username}";
            if (userInfo != "" && userInfo != null) {
                window.location.href='<%=request.getContextPath()%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1'
            } else {
                window.location.href = "login.jsp";
            }
        })
        function Trim(str)
        {
            return str.replace(/[ ]|[&nbsp;]/g, '');
        }
        $('#j'+<%=post.getId()%>).each(function() {
            var word =$(this).text();
            var words =  Trim(word).length;
            if(words >22){
                $(this).text($(this).text().slice(0,22)+"...");
            }
        });

    </script>
    <%} %>
    </div>
            <div class="main-right-five">
                <div class="main-right-three-top">
                    <div class="main-right-three-top-o">
                        <span>友情链接</span>
                    </div>
                </div>
                <div class="main-right-five-bottom">
                    <ul>
                    <li style="cursor:pointer" href="https://github.com/DeepLoveDeep/BBS">github</li>
                    <li style="cursor:pointer" href="http://www.csdn.net/">csdn</li>
                    <li style="cursor:pointer" href="http://www.oschina.net/">开源中国</li>
                    <li style="cursor:pointer" href="http://stackoverflow.com/">stackflow</li>
                    </ul>
                </div>
            </div>
       </div>
    </div>
</div>
<!--main结束-->
<!--header结束-->
<script type="text/javascript" src="swiper/js/swiper.js"></script>
<script type="text/javascript">
    var swiper1 = new Swiper('.banner_top', {
        autoplay: true,//可选选项，自动滑动
        loop: true,
        effect : 'fade',
        fadeEffect: {
            crossFade: true
        },
        pagination: {
            el: '.swiper-pagination',
            type: 'bullets',
            clickable: true
        },
    });
   /* //页面刷新指定到原先滚动条位置
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
    }
    window.onload = function() {
        if(document.cookie.match(/scrollTop=([^;]+)(;|$)/) != null) {
            var arr = document.cookie.match(/scrollTop=([^;]+)(;|$)/); //cookies中不为空，则读取滚动条位置
            document.documentElement.scrollTop = parseInt(arr[1]);
            document.body.scrollTop = parseInt(arr[1]);
        }
    }*/
</script>
</body>
</html>