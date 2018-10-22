<%@page import="com.bbs.model.Post"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>more</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/more.css" />
  <script type="text/javascript" src="js/jquery.min.js"></script>
      <script src="js/jquery.pages.js"></script>
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
  <!--header结束-->
  <!--main开始-->
  <div class="main">
      <div class="mian-top">
          <span style="cursor: pointer" onclick="window.location.href='<%=path%>/index.jsp'">社区></span>
          <span>更多内容</span>
      </div>
      <div class="main-center view_width">
      <div class="main-left">
          <div class="left-content" id="cont">
          </div>
          <span id="tishi" style="margin-left: 35%;color: #ccc;"></span>
          <div class="left-content" id="conts">
  <%
    	List<Post> posts = (List)request.getAttribute("posts");
    	int pageNum = (Integer)request.getAttribute("page");
    	String typename = (String)request.getAttribute("typename");
    	int type = (Integer)request.getAttribute("type");

    	if (posts.size()>0){
    %>
                      <%}
    	else {
    %>
                  抱歉！没有更多的结果
                      <%} %>
                  </a>
                      <%
        	for (Post post:posts){
                String content =post.getCardContent();
                content=content.replaceAll("<[.[^<]]*>", "");
     %>
      <div class="left-content-one">
          <div class="left-content-one-center" >
              <div class="kfb">
                  <p style="cursor:pointer" onclick="window.location.href='<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1'"><%=post.getTitle()%></p>
                  <p style="cursor:pointer" class="textP" onclick="window.location.href='<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1'"><%=content%>
                  </p>
                  <ul class="kfb-tubiao">
                      <li style="cursor:pointer">
                    <span id="sl<%=post.getId()%>">
                    <img id="i<%=post.getId()%>" src="img/great2.png"  class="animation"/>
                    </span>
                          <span class="animation"  id="g<%=post.getId()%>"><%=post.getGreatNum()%></span>
                      </li>
                      <li style="cursor:pointer" onclick="window.location.href='<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1'">
                          <img src="img/pl.png" alt="" />
                          <span><%=post.getReplyNum()%>条评论</span>
                      </li>
                  </ul>
              </div>
              <div class="kfr">
                  <%   if (post.getPhoto_url()!=null){ %>
                  <img  src="<%=path%>/toshowPic.action?photo_url=<%=post.getPhoto_url().replaceAll("\\\\", "//")%>" >
                  <%}else{ %>
                  <img  src="img/1.jpg" alt="">
                  <%} %>
              </div>
          </div>
          <script>
              $(function(){
                  var name = "${sessionScope.name}";
                  if(name != "" && name != null){
                      $("#login").html("欢迎用户 :  "+name);
                  }

                  $("#sl"+<%=post.getId()%>).click(function(){
                      var praise_img = $("#i"+<%=post.getId()%>);
                      var praise_txt = $("#g"+<%=post.getId()%>);
                      var num=parseInt(praise_txt.text());
                      if(praise_img.attr("src") == ("img/great1.png")){
                          $(this).html("<img src='img/great2.png' id='i<%=post.getId()%>' class='animation' />");
                          praise_txt.removeClass("hover");
                          num -=1;
                          praise_txt.text(num)
                      }else{
                          $(this).html("<img src='img/great1.png' id='i<%=post.getId()%>' class='animation' />");
                          praise_txt.addClass("hover");
                          num +=1;
                          praise_txt.text(num)
                      }
                      $.ajax({
                          type: "POST",
                          url: "${pageContext.request.contextPath}/great.action",
                          data: {"postId": <%=post.getId()%>,"greatNum":num},
                          success: function () {
                          },
                      });
                  });
              })
          </script>
      </div>
  <%} %>
</div>
      <p class="gengduo" id="more">显示更多</p>
  </div>
      <div class="main-bottom-right">
          <div class="main-bottom-right-top">
              <img src="img/pexels-photo-323772.png" alt="" />
              <p class="main-bottom-right-top-one">哈希资本投资EXX，开启ET盛世华</p>
              <p class="main-bottom-right-top-two">哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华</p>
          </div>
          <div class="main-bottom-right-top" style="border-bottom:none">
              <img src="img/pexels-photo-323772.png" alt="" />
              <p class="main-bottom-right-top-one">哈希资本投资EXX，开启ET盛世华</p>
              <p class="main-bottom-right-top-two">哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华</p>
          </div>
      </div>
  </div>
</div>
  <!--main结束-->


  <script src="js/jquery-3.2.1.js"></script>
  <script type="text/javascript">
      $(function () {
          changeb(1);
      })
      if(<%=posts.size()<10%>){
          $("#more").hide();
      }
      $("#xs").click(function () {
          $(".header-xiantiao-center").hide();
      })
      //带textP的class类名,如果她的字符长度超过40个字符的,那么将他后面的所有字符用...代替.
      var str = document.getElementsByClassName("textP");
      for(var i = 0 ; i < str.length ; i++){
          if(str[i].innerHTML.length > 40){
              str[i].innerHTML = str[i].innerHTML.substring(0,40) + "...";
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
              changeb(i);
              i++;
          }
      }

  </script>
  </body>
</html>
