<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String username = request.getParameter("username");
    if(username==null){
        username="";
    }
    String password = request.getParameter("password");
    if(password==null){
        password="";
    }
    String email = request.getParameter("email");
    if(email==null){
        email="";
    }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
  <head>
      <head>
          <meta charset="UTF-8">
          <title>regist</title>
          <link rel="stylesheet" href="css/register.css">
      </head>
<body>
  <div class="register">
      <div class="register-header">
          <h3 class="register-title" id="modal-register-label">注册<span>REGISTER</span></h3>
      </div>
      <div class="register-body">

          <form role="form"  action="<%=path%>/regist.action"  method="post" id="registForm" class="registration-form" name="myform">
              <div class="form-group">
                  <label class="sr-only" for="email">邮箱</label>
                  <input type="text" name="email" value="<%=email%>" placeholder="请输入有效邮箱" onfocus="if(placeholder=='请输入有效邮箱') {placeholder=''}" onblur="if (value=='') {placeholder='请输入有效邮箱'}" class="form-email form-control" id="email">
                  <span id="you" style="color: #ee5135;font-size: 7px;position: absolute; top: 0; right: -72px;"><s:fielderror fieldName="email"></s:fielderror></span>
                  <span id="usernameInfo"></span>
              </div>
              <div class="form-group">
                  <label class="sr-only" for="name">昵称</label>
                  <input type="text" name="username" value="<%=username%>" placeholder="请输入昵称" onfocus="if(placeholder=='请输入昵称') {placeholder=''}" onblur="if (value=='') {placeholder='请输入昵称'}" class="form-name form-control" id="name">
                  <span style="color: #ee5135;font-size: 7px;position: absolute; top: 0; right: -72px;"><s:fielderror fieldName="username"></s:fielderror></span>
                  <span id="nameInfo"></span>
              </div>
              <div class="form-group">
                  <label class="sr-only" for="password">密码</label>
                  <input type="password" name="password" value="<%=password%>" placeholder="请输入密码" onfocus="if(placeholder=='请输入有效密码') {placeholder=''}" onblur="if (value=='') {placeholder='请输入有效密码'}" class="form-password form-control" id="password">
                  <span id="passwordInfo"></span>
              </div>
              <div class="form-group">
                  <label class="sr-only" for="password2">确认密码</label>
                  <input type="password" name="password2" value="<%=password%>" placeholder="请再次输入密码" onfocus="if(placeholder=='请再次输入密码') {placeholder=''}" onblur="if (value=='') {placeholder='请再次输入密码'}" class="form-passworeto form-control" id="password2">
                  <span id="password2Info"></span>
              </div>
              <div class="form-group">
                  <label class="sr-only" for="code">验证码</label>
                  <input type="text" name="code" placeholder="请输入验证码" onfocus="if(placeholder=='请输入验证码') {placeholder=''}" onblur="if (value=='') {placeholder='请输入验证码'}" class="form-code form-control" id="code">
                  <input type="button" name="codes" id="checkCode" class="code" onclick="createCode()" />
                  <span id="codeInfo"></span>
              </div>
              <p class="body-title"><a href="<%=path%>/login.action">《返回登录</a></p>
              <button id="sub" class="btn">注册</button>
          </form>

      </div>
  </div>
</body>
</html>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/checkCode.js"></script>
<script type="text/javascript" src="js/gVerify.js"></script>
<script>
    $(function () {
        $("#email").blur(function () {
            var value =$("#usernameInfo").val('value')
            if(value!=null||value!=""){
                $("#you").hide();
            }
        })
      $("#sub").click(function () {
          var value =$("#usernameInfo").val('value')
          if(value!=null||value!=""){
              $("#you").hide();
          }
          var flag =tijiao()
        if(flag==false){
            return false;
           /* $.ajax({
                type: "POST",
                url: "<%=path%>/regist.action",
                data: $("#registForm").serialize(),
                dataType: "text",
                success: function () {
                    window.location.href="<%=path%>/login.action";
                },
            });*/
         }else{
            $("#sub").submit();
        }
      })
    })
</script>

