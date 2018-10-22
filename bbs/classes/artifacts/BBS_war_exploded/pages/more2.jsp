<%@page import="com.bbs.model.Post"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="stylesheet" href="css/index.css">
  </head>
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/particleground.min.js"></script>
  <body>
  <div class="left-content">
      <div class="left-content-one">
    <%
        //获取用户信息
        String  email =(String)session.getAttribute("username");
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
    <%
        	for (Post post:posts){
        	    String content =post.getCardContent();
                content=content.replaceAll("<[.[^<]]*>", "");
     %>
  <div class="left-content-one-center">
    <%--<div class="lt Stick tudo">置顶</div>--%>
      <p class="wenzi"><%=post.getSubForum().getMainForum().getTitle() %></p>
        <div class="kfb">
            <p style="height: 60px;width: 322.19px;cursor:pointer" id="bt<%=post.getId()%>" ><%=post.getTitle()%></p>
            <p class="textP" style="height: 65px;cursor:pointer" id="nr<%=post.getId()%>" ><%=content%>
            </p>
            <ul class="kfb-tubiao">
                <li style="cursor:pointer">
                    <span id="ss<%=post.getId()%>">
                    <img id="i<%=post.getId()%>" src="img/great2.png"  class="animation"/>
                    </span>
                    <span class="animation"  id="g<%=post.getId()%>"><%=post.getGreatNum()%></span>
                </li>
                <li style="cursor:pointer">
                    <img src="img/pl.png" alt="" id="r<%=post.getId()%>" />
                    <span  id="pl<%=post.getId()%>"><%=post.getReplyNum()%>条评论</span>
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
    </div>
          <script>
              //点击评论触发登录
              $("#pl"+<%=post.getId()%>).click(function () {
                  if(<%=email==null%>){
                      window.location.href="<%=path%>/login.jsp"
                  }else{
                      window.location.href="<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1";
                  }
              })
              //点击文章标题触发登录
              $("#bt"+<%=post.getId()%>).click(function () {
                  if(<%=email==null%>){
                      window.location.href="<%=path%>/login.jsp";
                  }else{
                      window.location.href="<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1";
                  }
              })
              //点击文章内容触发登录
              $("#nr"+<%=post.getId()%>).click(function () {
                  if(<%=email==null%>){
                      window.location.href="<%=path%>/login.jsp";
                  }else{
                      window.location.href="<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1";
                  }
              })
            /* if($('#'+<%=post.getId()%>).find("img").length!=0){
                  /!*提取img标签的src值*!/
                 var url = $('#'+<%=post.getId()%>).find("img").attr("src")
                  /!*赋值给指定标签内*!/
                  $('#s'+<%=post.getId()%>).attr("src",url);
                  /!*设置图片宽和高*!/
                  $('#s'+<%=post.getId()%>).width(206).height(136);
                  /!*隐藏之前的img标签*!/
                  $('#'+<%=post.getId()%>).find("img").hide();
              }*/
             /* $('#'+<%=post.getId()%>).find("img").hide();*/
               //带textP的class类名,如果她的字符长度超过40个字符的,那么将他后面的所有字符用...代替.
               var str = document.getElementsByClassName("textP");
               for(var i = 0 ; i < str.length ; i++){
               if(str[i].innerHTML.length > 40){
               str[i].innerHTML = str[i].innerHTML.substring(0,40) + "...";
               }
               }
              $(function(){
                  $("#r"+<%=post.getId()%>).click(function(){
                      window.location="<%=path%>/pages/post.jsp?postId=<%=post.getId()%>&&page=1";
                  });
                  $("#ss"+<%=post.getId()%>).click(function(){
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
          <%} %>
      <%--分页实现--%>
         <%-- <ul style="margin-left: 10px;">
              <% if (pageNum>1) { int pageIndex = pageNum -1;%>
              <li  onclick="bt(<%=type%>,<%=pageIndex%>)"><a>&laquo;</a></li>
              <%}
                  if (pageNum<=5){
                      for (int i=1; i<=5; i++){
                          if (pageNum == i){
              %>
              <li class="active" onclick="bt(<%=type%>,<%=i%>)"><button><%=i%></button></li>
              <%}else {
              %>
              <li onclick="bt(<%=type%>,<%=i%>)"><button><%=i%></button></li>
              <%}
                  if (i ==5){
              %>
              <li onclick="bt(<%=type%>,6)"><button>&raquo;</button></li>
              <%}}}
                  if (pageNum >5){
                      int maxPage = pageNum+1;
                      for (int i=4; i>=0; i--){
                          int pageIndex = pageNum - i;
                          if (i==0){
              %>
              <li class="active" onclick="bt(<%=type%>,<%=pageIndex%>)" ><button><%=pageIndex%></button></li>

              <%}else {%>
              <li onclick="bt(<%=type%>,<%=pageIndex%>)"><button><%=pageIndex%></button></li>
              <%}}%>
              <li onclick="bt(<%=type%>,<%=maxPage%>)"><button>&raquo;</button></li>
              <%}%>
          </ul><br>
          <script>
              function bt(type,page) {
                  $.ajax({
                      type: "POST",
                      url: "${pageContext.request.contextPath}/more.action",
                      data: {"type":type, "page": page},
                      dataType: "text",
                      success: function (data) {
                          $('#content').html("");
                          $("#content").append(data);
                      }
                  });
              }
          </script>--%>
      </div>
  </body>
</html>