<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
if (session.getAttribute("username") == null){
response.sendRedirect(path+"login.jsp");
return ;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我要反馈</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" href="css/advice.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>

  </head>
  
  <body>
  <div class="container">
    <div class="row">
  <div class="col-md-9">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        编写反馈
                    </h3>
                </div>
                <div class="panel-body">


                    <div class="column">
                        <form id="signupForm">
                        <div class="form-group">
                            <label for="name">反馈主题</label>
                            <input required type="text" class="form-control" name="title" id="name" width="200px" height="100px"
                                   placeholder="请输入标题">
                        </div>
                        <dl class="form-group">
                            <dt><label >反馈内容</label></dt>
                            <dd> <textarea id="TextArea1" cols="20" rows="5"  name="content" class="ckeditor"></textarea></dd>
                        </dl>

                        <input type="button" id ="submit" class="btn btn-primary" value="提交反馈">

                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
  </div>
  </body>
  <script type="text/javascript" src="../js/jquery.validate.min.js"></script>
  <script type="text/javascript">
  	$(function(){
        $("#submit").click(function(){
            var content =  $("#TextArea1").val();
            if(content==null ||content==""){
                alert("内容不能为空");
                return false;
            }
            var title = $("#name").val();
            if(title==null ||title=="" ){
                alert("标题不能为空");
                return false;
            }
            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/advice.action",
                data: {"content":content,"title":title},
                dataType:"text",
                success: function () {
                        alert("您的反馈，会使我们做得更好！");
                        parent.location.href="<%=path%>/index.jsp";
                },
                error: function () {
                    alert("您的反馈，会让我们做得更好！");
                }
            });
          })
    });
  </script>
</html>
