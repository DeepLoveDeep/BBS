<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
      <meta charset="UTF-8">
      <title>login</title>
      <link rel="stylesheet" href="css/login1.css">
  </head>
<body>
 <div class="login">
     <div class="login-header">
         <h3 class="login-title" id="modal-register-label">登录<span>SING IN</span></h3>
     </div>
     <div class="login-body">
         <form role="form" action="<%=path%>/login.action" method="post" class="registration-form">
             <div class="form-group">
                 <label class="sr-only" for="username">账号</label>
                 <input type="text" name="username" placeholder="请输入有效邮箱" onfocus="if(placeholder=='请输入有效邮箱') {placeholder=''}" onblur="if (value=='') {placeholder='请输入有效邮箱'}" class="form-first-name form-control" id="username">
                 <span style="color:red;margin-right: -71px;margin-top: -20px;"><s:fielderror fieldName="username"></s:fielderror></span>
                 <span id="usernameInfo"></span>
             </div>
             <div class="form-group">
                 <label class="sr-only" for="password">密码</label>
                 <input type="password" name="password" placeholder="请输入密码" onfocus="if(placeholder=='请输入密码') {placeholder=''}" onblur="if (value=='') {placeholder='请输入密码'}" class="form-last-name form-control" id="password">
                 <span style="color:red;margin-right: -71px;margin-top: -20px;"><s:fielderror fieldName="password"></s:fielderror></span>
                 <span id="passwordInfo"></span>
             </div>
             <p class="body-title"><a href="<%=path%>/regist.jsp">立即注册 ？</a></p>
             <button type="submit" class="btn">登录</button>
         </form>
     </div>
 </div>
  </body>
</html>
<script src="js/gVerify.js"></script>
