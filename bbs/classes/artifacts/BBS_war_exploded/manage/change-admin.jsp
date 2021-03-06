<%@page import="com.bbs.model.Admin"%>
<%@page import="com.bbs.service.AdminBiz"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if (session.getAttribute("adminname") == null){
response.sendRedirect(path+"/manage/admin.jsp");
return ;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">

    <title>My JSP 'change-admin.jsp' starting page</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>

  <body>

  <jsp:include page="/pages/header.jsp"/>

    <div class="container" style="margin-top: 80px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" ><a href="<%=path%>/manage/notice.jsp">发布公告</a></li>
                <li role="presentation" class="active"><a href="<%=path%>/manage/change-admin.jsp">资料修改</a></li>
                <li role="presentation"><a href="<%=path%>/manage/newpost.jsp">查看新帖</a></li>
                <li role="presentation"><a href="<%=path%>/manage/excpost.jsp">查看异常帖</a></li>
                <li role="presentation"><a href="<%=path%>/manage/advice.jsp">查看反馈</a></li>
                <li role="presentation"><a href="<%=path%>/manage/bestpost.jsp">精华帖请求</a></li>
                <li role="presentation"><a href="<%=path%>/manage/limit.jsp">封锁用户</a></li>
                <li role="presentation"><a href="<%=path%>/manage/create_discuss.jsp">创建讨论区</a></li>
            </ul>
        </div>

         <div class="col-md-9">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        个人信息修改
                    </h3>
                </div>
                <div class="panel-body">
  					<form id="form1"  enctype="multipart/form-data">

                    <div class="column">
					<%
					 ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
				 		AdminBiz adminBiz = (AdminBiz)context.getBean("adminBiz");
				 		Admin admin = adminBiz.getAdminById((Integer)session.getAttribute("adminid"));

					 %>

                        <div class="form-group">
                            <img alt="@shishu" class="avatar left" height="70" src="<%=path+"/"+admin.getPhotoUrl() %>" width="70" />
                            请上传你的头像<br/>

                        </div>
                        <input type="file" id="inputfile" accept="image/*" name="photoImg"><br/>

                        <div class="form-group">
                            <label for="name">用户名</label>
                            <input id="username" type="text" class="form-control" name="username" id="name" width="200px" height="80px" value="<%=admin.getUserName() %>"
                                   placeholder="请输入名称"> <p class="help-block"><s:fielderror fieldName="username"></s:fielderror></p>
                        </div>

                        <div class="form-group">
                            <label for="name">性 别</label><br/>
                            <%if (admin.getSex().equals("男")){%>
                            男<input type="radio" name="sex" value="男" checked="checked">
                            &nbsp &nbsp女<input type="radio" name="sex" value="女">
                            <%} else if (admin.getSex().equals("女")){%>
                            男<input type="radio" name="sex" value="男" >
                            &nbsp &nbsp女<input type="radio" name="sex" value="女" checked="checked">
                            <%} else {%>
                            男<input type="radio" name="sex" value="男" >
                            &nbsp &nbsp女<input type="radio" name="sex" value="女">
                            <%} %>
                        </div>


                        <dl class="form-group">
                            <dt><label for="user_profile_blog">邮箱</label></dt>
                            <dd><input id="email" type="email" class="form-control" id="user_profile_blog" name="email" size="30" value="<%=admin.getEmail()%>" />
                                <p class="help-block"><s:fielderror fieldName="email"></s:fielderror></p>
                            </dd>
                        </dl>
                        <dl class="form-group">
                            <dt><label for="admin_profile_company">密码</label></dt>
                            <dd><input class="form-control" id="password" name="password" size="30" type="password" width="200px" /></dd>
                        </dl>
                        <dl class="form-group">
                            <dt><label for="admin_profile_location">重复密码</label></dt>
                            <dd><input class="form-control" id="confirm_password" name="confirm_password" size="30" type="password" width="200px" /></dd>
                        </dl>
                        <input id= "submit" type="button" value="确认修改"> <s:fielderror fieldName="update-result"></s:fielderror>
                    </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>


  </body>
  <script type="text/javascript" src="js/jquery.validate.min.js"></script>
  <script type="text/javascript">
  	$(function(){
  	 	$("#form1").validate({
  	 		rules:{
                    username:{
                        required:true
                    },
                    email:{
                        required:true,
                        email:true
                    },
                    password:{
                        rangelength:[6,20]
                    },
                    confirm_password:{
                        equalTo:"#password"
                    }
                },
                messages:{
                	username:{
                        required:"必填"
                    },
                    email:{
                        required:"必填",
                        email:"E-Mail格式不正确"
                    },
                    password:{
                        rangelength: $.validator.format("密码最小长度:{0}, 最大长度:{1}。")
                    },
                    confirm_password:{
                        equalTo:"两次密码输入不一致"
                    }
                }
  	 	});
        $("#submit").click(function (){
            var formobj =  document.getElementById("form1");
            var formdata = new FormData(formobj);
            var oldName ="<%=admin.getUserName()%>";
            var newName=$("#username").val();
            var password=$("#password").val().length;
            $.ajax({
                url:"${pageContext.request.contextPath}/adminupdate.action",
                type:"post",
                data:formdata,
                cache:false,
                contentType: false, //不设置内容类型
                processData: false, //不处理数据
                success:function(){
                    if((newName==oldName) && password==0){
                        alert("基本信息修改成功");
                        location.reload();
                    }else {
                        alert("用户名或密码已修改，请重新登录！");
                        window.location.href="<%=request.getContextPath()%>/logout.action";
                    }
                },
                error:function(e){
                    alert("错误！！");
                }
            });
        })
  	});
  </script>
  <style type="text/css">
  .error{
    color:red;
  }
  </style>
</html>
