<%@page import="com.bbs.model.Post"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>更多内容</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/more.css" />
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
                          <li>社区</li>
                          <li>矿机</li>
                          <li>应用服务</li>
                          <li>电子钱包</li>
                          <li>关于我们</li>
                          <li>多语言支持（中英文）</li>
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
                      <li><img src="/img/420685932315535688.png" alt="" /></li>
                  </ul>
              </div>
          </div>
      </div>
  </header>
  <!--header结束-->






            <!-- 帖子列表 -->
            
             <div class="list-group search-list">
    <a href="#" class="list-group-item active">
    
    <%
    	List<Post> posts = (List)request.getAttribute("posts");
    	int pageNum = (Integer)request.getAttribute("page");
    	String typename = (String)request.getAttribute("typename");
    	int type = (Integer)request.getAttribute("type");
    	
    	if (posts.size()>0){
    %>
        <%=typename %>：
    <%}
    	else {
    %>
    抱歉！没有更多的结果
    <%} %>
     </a>
    <%
        	for (Post post:posts){
     %>
    <a href="<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1" class="list-group-item">
            <h4 class="list-group-item-heading">
                [<%=post.getSubForum().getMainForum().getTitle() %>]
            </h4>
            <%=post.getTitle()%>&nbsp;[<%=post.getSubForum().getTitle() %>]
            <p class="text-right post-date">浏览量:<%=post.getViewNum()%>&nbsp;评论量:<%=post.getReplyNum()%>&nbsp;发表日期:<%=post.getTime()%></p>
    </a>
    <%} %>
</div>


<ul class="pagination pagination-lg page-float">
<% if (pageNum>1) { int pageIndex = pageNum -1;%>
    <li><a href="<%=path+"/more.action?type="+type+"&&page="+pageIndex%>">&laquo;</a></li>
    <%}
    	if (pageNum<=5){
    		for (int i=1; i<=5; i++){
    		if (pageNum == i){
     %>
    <li class="active"><a href="<%=path+"/more.action?type="+type+"&&page="+i%>"><%=i%></a></li>
    <%}else {
     %>
    <li><a href="<%=path+"/more.action?type="+type+"&&page="+i%>"><%=i%></a></li>
    <%}
    if (i ==5){
    %>
     <li><a href="<%=path+"/more.action?type="+type+"&&page="+6%>">&raquo;</a></li>
   <%}}}
    if (pageNum >5){
    int maxPage = pageNum+1;
    for (int i=4; i>=0; i--){
    	int pageIndex = pageNum - i;
    	if (i==0){
     %>
     <li class="active"><a href="<%=path+"/more.action?type="+type+"&&page="+pageIndex%>"><%=pageIndex%></a></li>
   
    <%}else {%>
     <li class=""><a href="<%=path+"/more.action?type="+type+"&&page="+pageIndex%>"><%=pageIndex%></a></li>
     <%}}%>
      <li><a href="<%=path+"/more.action?type="+type+"&&page="+maxPage%>">&raquo;</a></li>
    <%}%>
    
   
</ul><br>





  </body>
</html>
