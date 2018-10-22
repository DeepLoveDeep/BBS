<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'skip_login.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="refresh" content="5";url="<%=path%>/login.jsp">
      <link rel="stylesheet" href="css/more.css" />
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

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

  <span style="margin-top: 20px"> ${message}</span> <br>

  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script>
      $("#xs").click(function () {
          $(".header-xiantiao-center").hide();
      })
  </script>
  </body>
</html>
