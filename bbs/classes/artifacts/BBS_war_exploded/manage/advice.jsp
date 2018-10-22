<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.bbs.service.AdviceBiz" %>
<%@ page import="com.bbs.model.Advice" %>
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
    
    <title>My JSP 'advice.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script type="text/javascript" src="/js/jquery.min.js"></script>
  </head>
  
  <body>
  
     <jsp:include page="/pages/header.jsp"/>
   
   <div class="container" style="margin-top: 80px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" ><a href="<%=path%>/manage/notice.jsp">发布公告</a></li>
                <li role="presentation" ><a href="<%=path%>/manage/change-admin.jsp">资料修改</a></li>
                <li role="presentation" ><a href="<%=path%>/manage/newpost.jsp">查看新帖</a></li>
                <li role="presentation"><a href="<%=path%>/manage/excpost.jsp">查看异常帖</a></li>
                <li role="presentation"class="active"><a href="<%=path%>/manage/advice.jsp">查看反馈</a></li>
                <li role="presentation"><a href="<%=path%>/manage/bestpost.jsp">精华帖请求</a></li>
                <li role="presentation"><a href="<%=path%>/manage/limit.jsp">封锁用户</a></li>
                <li role="presentation"><a href="<%=path%>/manage/create_discuss.jsp">创建讨论区</a></li>
            </ul>
        </div>

        <div class="col-md-9">

             <ul class="list-group">
                <a class="list-group-item active">
                    用户反馈
                </a>

               <% ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
                  	   AdviceBiz adviceBiz = (AdviceBiz)context.getBean("adviceBiz");
                  	   String pageNumStr = request.getParameter("page");
                  	   int pageNum = 1;
                  	   if (pageNumStr != null)
                  	   pageNum = Integer.parseInt(pageNumStr);
                  	   List<Advice> advices=  adviceBiz.getAdvice(pageNum, 10);
                  	   for (Advice advice:advices){
                %>
                <div class="list-group-item">
                    <a href="<%=path%>/pages/lookadvice.jsp?adviceId=<%=advice.getId()%>&&page=1" style="color:grey">
                        <%=advice.getTitle() %>
                    </a>
                    <button id="<%=advice.getId() %>" style="float: right">删除</button>
                    <p style="float: right;margin-right: 50px">反馈用户:<%=advice.getUser().getUsername()%>&nbsp;发表日期:<%=advice.getAdviceDate()%></p>
                </div>
                 <script type="text/javascript">
                     $(function(){
                         $("#<%=advice.getId() %>").click(function(){
                             if(confirm("确定要删除此条数据吗？")){
                                 $.ajax({
                                     type: "POST",
                                     url: "${pageContext.request.contextPath}/advicedelete.action",
                                     data: {"adviceId": <%=advice.getId() %>},
                                     dataType:"text",
                                     success: function () {
                                         alert("删除成功！");
                                         window.location.reload();
                                     },
                                     error: function () {
                                         alert("删除失败");
                                     }
                                 });
                             }
                         })
                     });
                 </script>
 				<%} %>
 				 <ul class="pagination pagination-lg" style="float:right">
<% if (pageNum>1) { int pageIndex = pageNum -1;%>
    <li><a href="<%=path+"/manage/advice.jsp?page="+pageIndex%>">&laquo;</a></li>
    <%}
    	if (pageNum<=5){
    		for (int i=1; i<=5; i++){
    		if (pageNum == i){
     %>
    <li class="active"><a href="<%=path+"/manage/advice.jsp?page="+i%>"><%=i%></a></li>
    <%}else {
     %>
    <li><a href="<%=path+"/manage/advice.jsp?page="+i%>"><%=i%></a></li>
    <%}
    if (i ==5){
    %>
     <li><a href="<%=path+"/manage/advice.jsp?page="+6%>">&raquo;</a></li>
   <%}}}
    if (pageNum >5){
    int maxPage = pageNum+1;
    for (int i=4; i>=0; i--){
    	int pageIndex = pageNum - i;
    	if (i==0){
     %>
     <li class="active"><a href="<%=path+"/manage/advice.jsp?page="+pageIndex%>"><%=pageIndex%></a></li>
   
    <%}else {%>
     <li class=""><a href="<%=path+"/manage/advice.jsp?page="+pageIndex%>"><%=pageIndex%></a></li>
     <%}}%>
      <li><a href="<%=path+"/manage/advice.jsp?page="+maxPage%>">&raquo;</a></li>
    <%}%>
</ul><br>
        </div>
    </div>
</div>
  
  </body>
</html>
