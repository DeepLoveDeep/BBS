<%@page import="com.bbs.service.UserBiz"%>
<%@page import="com.bbs.model.User"%>
<%@page import="com.bbs.model.Followcard"%>
<%@page import="com.bbs.model.Post"%>
<%@page import="com.bbs.service.PostBiz"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="1000kb"%>
<%@ page import="com.bbs.service.AdviceBiz" %>
<%@ page import="com.bbs.model.Advice" %>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>反馈浏览</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
     <link href="css/post-detail.css" rel="stylesheet">
     <script type="text/javascript" src="ckeditor/ckeditor.js"></script>

  </head>
  
  <body>
<div style="height:100%">
  
   <jsp:include page="/pages/header.jsp"/>
  	 <div class="container" style="margin-top: 50px">
  	<%
  		
  		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
  		 AdviceBiz adviceBiz = (AdviceBiz)context.getBean("adviceBiz");
  		 int adviceId  = 1;
  		 String aid = request.getParameter("adviceId");
  		 if (aid == null)
  		 adviceId = (Integer)request.getAttribute("adviceId");
  		 else
             adviceId = Integer.parseInt(aid);
  		 Advice advice = adviceBiz.getAdviceById(adviceId);
  		 int pageNum  = 1;
  		 String num = request.getParameter("page");
  		 if (num != null)
  		    pageNum = Integer.parseInt(num);
  		 else 
  		 	pageNum = (Integer)request.getAttribute("page");
  		    System.out.println("adviceId"+adviceId+"pageNum:"+pageNum);
  	 %>
  	 
  
    <div class="row">
       <div class="col-md-1 post-border">
       </div>
        <div class="col-md-2 post-head">
                <!--<img src="img/tm-bg-slide-1.jpg" width="80px" height="80px" class="img-responsive img-circle">-->
            <img  alt="" class="img-responsive img-circle" src="<%=path+"/"+advice.getUser().getPhotoUrl() %>"
                  style="margin:1px 1px;width: 120px;height: 120px;margin: 30px auto;"/>

                <span class="user-info">
                            <span class="badge" style="background: #f1c40f;margin-top: 5px">反馈者</span>
                            :<span class="badge" style="background: #f1c40f;margin-top: 5px"><%=advice.getUser().getUsername()%></span>
                        </span><br/>
                        <span class="user-info">
                            <span class="badge" style="background: #2ecc71;margin-top: 5px">性别</span>
                            :<span class="badge" style="background: #2ecc71;margin-top: 5px"><%=advice.getUser().getSex()%></span>
                        </span><br/>
                        <span class="user-info">
                             <span class="badge" style="background: #ff6927;margin-top: 5px">论坛等级</span>:
                            <span class="badge" style="background: #ff6927;margin-top: 5px">LV<%=advice.getUser().getLevel()%></span>
                        </span>
            <br>
        </div>
        <div class="col-md-8 post-content">

            <div class="post-title">
                <div style="margin-left:20px" >

                    <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;<%=advice.getTitle() %> &nbsp;|&nbsp;<span>发表于:<%=advice.getAdviceDate() %></span>
                    <%String username = (String)session.getAttribute("username");
                    if ((username != null && advice.getUser().getUsername().equals(username))||(String)session.getAttribute("adminname")!=null){%>
					<%}%>
                </div>
                <strong style=" float:right;margin-right:10px;margin-top: 10px">
                    <span class="badge" style="background: #ff6927;width: 50px;">楼主</span></strong>

            </div>
            <div style="margin: 20px">
               <%=advice.getContent()%>
            </div>

        </div>
         <div class="col-md-1 post-border">
       </div>
    </div>
    </div>
    <!-- 反馈内容 -->
     <%
  	 	 UserBiz userBiz = (UserBiz)context.getBean("userBiz");
		User user = advice.getUser();
  	  %>
  	 <div class="container">
    <div class="row" style="margin-top: 5px">
        <div class="col-md-1 reply-border">
        </div>
        <div class="col-md-2 reply-head">
            <img  alt="" class="img-responsive img-circle" src="<%=path+"/"+advice.getUser().getPhotoUrl() %>"
                  style="margin:1px 1px;width: 120px;height: 120px;margin: 30px auto;"/>

            <span class="user-info">
                        <span class="badge" style="background: #f1c40f;margin-top: 5px">姓名</span>
                        :<span class="badge" style="background: #f1c40f;margin-top: 5px"><%=user.getUsername()%></span>
                    </span><br/>
                    <span class="user-info">
                        <span class="badge" style="background: #2ecc71;margin-top: 5px">性别</span>
                        :<span class="badge" style="background: #2ecc71;margin-top: 5px"><%=user.getSex()%></span>
                    </span><br/>
                    <span class="user-info">
                         <span class="badge" style="background: #ff6927;margin-top: 5px">论坛等级</span>:
                        <span class="badge" style="background: #ff6927;margin-top: 5px">LV<%=user.getLevel()%></span>
                    </span>
            <br>


        </div>
        <div class="col-md-8 reply-content">
            <div style="margin: 20px;">
                <%=advice.getContent()%>
            </div>


        </div>
      </div>
     </div>
  	 <ul class="pagination pagination-lg" style="float: right;margin-right: 20px;">
<% if (pageNum>1) { int pageIndex = pageNum -1;%>
    <li><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+pageIndex%>">&laquo;</a></li>
    <%}
    	if (pageNum<=5){
    		for (int i=1; i<=5; i++){
    		if (pageNum == i){
     %>
    <li class="active"><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+i%>"><%=i%></a></li>
    <%}else {
     %>
    <li><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+i%>"><%=i%></a></li>
    <%}
    if (i ==5){
    %>
     <li><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+6%>">&raquo;</a></li>
   <%}}}
    if (pageNum >5){
    int maxPage = pageNum+1;
    for (int i=4; i>=0; i--){
    	int pageIndex = pageNum - i;
    	if (i==0){
     %>
     <li class="active"><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+pageIndex%>"><%=pageIndex%></a></li>
   
    <%}else {%>
     <li class=""><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+pageIndex%>"><%=pageIndex%></a></li>
     <%}}%>
      <li><a href="<%=path+"/pages/lookadvice.jsp?adviceId="+adviceId+"&&page="+maxPage%>">&raquo;</a></li>
    <%}%>
    
   
</ul><br>

</div>
    
  </body>
</html>
