<%@ page import="org.springframework.context.support.ClassPathXmlApplicationContext" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bbs.service.SysMessageBiz" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bbs.model.SysMessage" %>
<%@ page import="com.bbs.service.FollowcardBiz" %>
<%@ page import="com.bbs.service.PostBiz" %>
<%@ page import="com.bbs.model.Post" %>
<%@ page import="com.bbs.model.Followcard" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.bbs.model.SysUser" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/9/28 0028
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="css/mymessage.css" />
    <link rel="stylesheet" href="css/myPagination.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery.pages.js"></script>
</head>
<%
    String path = request.getContextPath();
    Integer  userId2 =(Integer)session.getAttribute("userId");
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    if("".equals(userId2)||userId2==null){
        response.sendRedirect(path+"/login.jsp");
    }
%>
    <%
    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        SysMessageBiz sysMessageBiz = (SysMessageBiz) context.getBean("sysMessageBiz");
        PostBiz postBiz = (PostBiz) context.getBean("postBiz");
        FollowcardBiz followcardBiz = (FollowcardBiz) context.getBean("followcardBiz");
        Integer pageNum  = 1;
        String num = request.getParameter("page");
        if (num != null)
            pageNum = Integer.parseInt(num);
        else
            pageNum = (Integer)request.getAttribute("page");
        if(pageNum==null){
            pageNum=1;
        }

        //浏览数量
    %>
<body >
<div class="message">
    <div class="message-center" style="height: 445px">
        <div class="message-biaoti">
            <p>我的消息</p>
            <ul>
                <li class="suibian show" style="float: right">全部已读</li>
                <li></li>
                <li></li>
                <li class="suibian1" style="float: right">全部已读</li>
            </ul>
        </div>
        <div class="message-top">
            <ul>
                <li class="active-color">系统消息<span id="num" class="xiaoxi-shuzi"></span></li>
                <li></li>
                <li></li>
                <li class="plstyle">评论 <span id="pnum" style="margin-left: 32px;" class="xiaoxi-shuzi"></span></li>
               <%-- <li>回复</li>--%>
            </ul>
        </div>
        <div class="message-bottom" style="clear: both">
            <ul class="show" id="sy">
            </ul>
            <ul id="sys">
            </ul>
            <ul id="pls">

            </ul>
            <ul id="pl" >

            </ul>
    </div>
        <!--分页开始-->
       <div id="pagination" class="pagination pagination-active"  style="margin-left: 210px;" > </div>
        <div class="pagination"></div>
        <div class="pagination"></div>
        <div id="pagination1" class="pagination" style="margin-left: 210px;margin-top: -60px;" ></div>
        <!--分页结束-->
    </div>
</div>
<%--<script src="js/jquery-3.2.1.js"></script>--%>
<script src="js/myPagination.js"></script>
<script>
    $(function () {
        //系统消息数量
        <% Integer userid = (Integer) session.getAttribute("userId");
            if(userid==null){%>
             parent.location.href="<%=path%>/login.jsp"
        <% }%>
         <%  Long messageNum = sysMessageBiz.findAll(userid);
           int number =0;
           int number2 =0;
          if(messageNum>0){%>
             $("#num").html(<%=messageNum%>);
                <%}else{%>
            $('.active-color span').hide()
                <%}%>
        //系统消息内容（默认是第一页）
        <%
        List<SysUser> sysUsers =sysMessageBiz.findAllByUserId(userid);
          if(sysUsers.size()>0 ){%>
         var Sys = '';
        <% for(SysUser sysUser:sysUsers){%>
        if(<%=sysUser.getIf_read()==0%>){
            var Str = '<div><span class="hongse-active"><%=sysUser.getSysMessage().getContent()%></span>'
                +'<span><%=sysUser.getSysMessage().getDate()%></span></div>';
            Sys +=Str;
           }else{
            var Str = '<div><span class="hongse-active" style="color:#ccc"><%=sysUser.getSysMessage().getContent()%></span>'
                +'<span><%=sysUser.getSysMessage().getDate()%></span></div>';
            Sys +=Str;
        }
        <%}%>
        $("#sys").html('');
        $("#sys").append(Sys);
        <%}%>
        $("#sys").append("抱歉，没有更多消息");
        changex(1);
        //评论消息内容
        <%
           List<Post> postss =new ArrayList<Post>();
           String ids="";
           if(userid==null){%>
                parent.location.href="<%=path%>/login.jsp"
        <% }
         List<Post> posts =postBiz.getPostByUserId(userid,1,10000);%>
           //查询的帖子为空
             if(<%=posts.size()<=0%>&&<%=sysUsers.size()<=0%>){
                 $("#pls").append("抱歉，没有更多数据");
                 $("#pl").html("<li>抱歉，没有更多数据了</li>");
                 $("#pnum").hide();
                 $(".message-top ul li").click(function(){
                     $(this).addClass("active-color").siblings().removeClass("active-color");
                 })
                 return false;
             }else{
                 //不为空，遍历找到有评论的帖子，并存放到新的集合中
                 <% for(Post post :posts){
                  if(post.getReplyNum()!=0){
                      postss.add(post);
                  }}
                  for(Post post1:postss){
                    ids+=post1.getId()+",";
                  %>
                  //遍历含有评论的帖子，根据帖子id查询所有评论
                 <%  List<Followcard> followcards = followcardBiz.findFollowcardBySendId(post1.getId());
                     /*  获取未读评论的总数量*/
                     Long number1= followcardBiz.findAll(post1.getId());
                     if(number1>0){
                         number2+=number1;
                     }
                    String  email =(String)session.getAttribute("username");
                    if(followcards.size()>0){
                        number+=followcards.size();
                    for(Followcard followcard:followcards){
                    if(followcard.getUser().getEmail().equals(email)){
                        followcard.getUser().setUsername("你自己");
                    }
                    %>
                 if(<%=followcard.getIf_read()==0%>){
                     var str2='<div><li style="cursor:pointer" id="<%=followcard.getFollowDate()%>" onclick=parent.location.href="<%=path%>/pages/post.jsp?postId=<%=post1.getId()%>&&page=1&&flags=1">'
                         +'<span><%=followcard.getUser().getUsername()%>评论了你的文章《<%=post1.getTitle()%>》</span>'
                         +'<span><%=followcard.getFollowDate()%></span></li>'
                      }else{
                     var str2='<div><li style="cursor:pointer;color:#ccc" id="<%=followcard.getFollowDate()%>" onclick=parent.location.href="<%=path%>/pages/post.jsp?postId=<%=post1.getId()%>&&page=1&&flags=1">'
                         +'<span><%=followcard.getUser().getUsername()%>评论了你的文章《<%=post1.getTitle()%>》</span>'
                         +'<span><%=followcard.getFollowDate()%></span></li>'
                       }
                 $("#pls").append(str2);
                 <%}%>
                 <% }%>
                 $("#pls").append("抱歉，没有更多数据");
                 <%}%>
                 var pageno=1; //当前页
                 change(1);
             }
        //评论消息数量
        if(<%=number2!=0%>){
            $("#pnum").html(<%=number2%>);
        }else{
           /* $(".xiaoxi-shuzi").css("display","none");*/
            $('#pnum').hide()
           /* $('<style>span:before{background-color:#8f9091!important;}</style>').appendTo('.message-bottom ul li');*/
        }
    $(".message-top ul li").click(function(){
        var s=$(this).index();
        $(".message-bottom ul").eq(s).addClass("show").siblings().removeClass("show");
        $(".message-biaoti ul li").eq(s).addClass("show").siblings().removeClass("show");
        $(this).addClass("active-color").siblings().removeClass("active-color");
        $(".pagination").eq(s).addClass("pagination-active").siblings().removeClass("pagination-active");
    })
        /*发送系统消息全部已读*/
    $('.suibian').on('click',function(){
        $('.message-bottom ul li span').removeClass('hongse-active');
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/readAll.action",
            data: {"userid":<%=userid%>},
            dataType:"text",
            success: function () {
               /* $('<style> #sy li span:before{background-color:#8f9091;}</style>').appendTo('.message-bottom .show li');*/
                $('<style> #sy li span{color:#ccc;}</style>').appendTo('.message-bottom ul li span');
                $('.active-color span').hide();
            },
        });
     })
        /*/!*发送评论全部已读*!/*/
        $(".suibian1").click(function () {
         $(".active-color span").hide()
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/readAllBySendId.action",
                data: {"ids":"<%=ids%>"},
                dataType:"text",
                success: function () {
                 /*   $('<style> #pl li span:before{background-color:#8f9091;}</style>').appendTo('.message-bottom .show li');*/
                    $('<style> #pl li span{color:#ccc;}</style>').appendTo('.message-bottom ul li span');
                },
            });
        })
    })
   window.onload = function () {
        var num  ;
        if(<%=sysUsers.size()%3==0%>){
            num=<%=sysUsers.size()/3%>;
            if(<%=sysUsers.size()==0%>){
                num=1;
                $("#pagination").hide();
            }
        }else{
            num=<%=sysUsers.size()/3%>+1;
        }
        var num1  ;
        if(<%=number%5==0%>){
            num1=<%=number/5%>
            if(<%=number==0%>){
                num1 = 1;
                $("#pagination1").hide();
            }
        }else{
            num1=<%=number/5%>+1;
        }
        new myPagination({
            id: 'pagination',
            curPage:1, //初始页码
            pageTotal: num, //总页数
            pageAmount:3,  //每页多少条
            dataTotal: <%=sysUsers.size()%>, //总共多少条数据
            pageSize: 5, //可选,分页个数
            showPageTotalFlag:true, //是否显示数据统计
            showSkipInputFlag:true, //是否支持跳转
            getPage: function (page) {
                changex(page);
            }
        })

      new myPagination({
            id: 'pagination1',
            curPage:1, //初始页码
            pageTotal: num1, //总页数
            pageAmount:5,  //每页多少条
            dataTotal: <%=number%>, //总共多少条数据
            pageSize: 5, //可选,分页个数
            showPageTotalFlag:true, //是否显示数据统计
            showSkipInputFlag:true, //是否支持跳转
            getPage: function (page) {
            change(page);
            }
        })
      }

</script>
</body>
</html>
