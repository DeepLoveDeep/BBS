<%@page import="com.bbs.service.NoticeBiz"%>
<%@page import="com.bbs.service.UserBiz"%>
<%@page import="com.bbs.service.PostBiz"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" autoFlush="false" buffer="1000kb"%>
<%@ page import="com.bbs.service.NoticeFollowcardBiz" %>
<%@ page import="com.bbs.model.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>noticeDetail</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
      <link rel="stylesheet" href="css/details.css" />
      <script type="text/javascript" src="js/jquery.min.js"></script>
      <script src="js/jquery.pages.js"></script>
  </head>

  <%

      ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
      NoticeBiz noticeBiz = (NoticeBiz)context.getBean("noticeBiz");
      NoticeFollowcardBiz noticeFollowcardBiz = (NoticeFollowcardBiz)context.getBean("noticeFollowcardBiz");
      int noticeId  = 1;
      String pid = request.getParameter("noticeId");
      if (pid == null)
          noticeId = (Integer)request.getAttribute("noticeId");
      else
          noticeId = Integer.parseInt(pid);

      Notice notice = noticeBiz.getNoticeById(noticeId);
      List<NoticeFollowcard> noticeFollowcards= noticeFollowcardBiz.findFollowcardBySendId(noticeId);
      if (notice == null)
          return ;
  %>
  <script>
      $(function () {
          if(<%=noticeFollowcards.size()<1%>){
              $("#rep").hide();
          }
      })
  </script>
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
  <!--main开始-->
  <div class="main">
      <div class="main-center view_width">
          <div class="mian-top">
              <span style="cursor: pointer" onclick="window.location.href='<%=request.getContextPath() %>/index.jsp'">社区></span>
              <span>公告详情</span>
          </div>
          <div class="main-bottom">
              <div class="main-bottom-left">
                  <div class="main-left-content">
                      <p><%=notice.getTitle()%></p>
                      <div class="content-oneul" >
                          <ul>
                              <li>时间：<%=notice.getNoticeDate() %></li>
                              <li>发布者：<%=notice.getAdmin().getUserName()%></li>
                          </ul>
                          <span>
                               <%String adminname = (String)session.getAttribute("adminname");
                                   if ((adminname != null &&notice.getAdmin().getUserName().equals(adminname))){%>
                                <a style="float:right;margin-right: 20px;margin-top: -54px;color: #e0bd35" href="<%=path%>/editNotice.action?postId=<%=notice.getId()%>">编辑</a>
                                <%}%>
                          </span>
                      </div>
                      <div class="Content-center">
                          <div class="wenzi" id="con">
                              <%=notice.getContent()%>
                              <script>
                                  $(function () {
                                      $(".wenzi p").removeAttr("style");
                                      $(".wenzi p").addClass("wenzi");
                                      //  $(".wenzi p").attr("style","width:826px;height:78px;");
                                  });
                              </script>
                          </div>
                      </div>

                      <div class="latest-comment" style="margin-top: 100px" >
                          <p>最新评论</p>
                          <form id="frm" action="<%=path%>/follow.action" method="post">
                              <input type="hidden" name="noticeId" value="<%=notice.getId()%>">
                              <textarea name="content" id="cont" rows="" cols="" placeholder="留下你的看法"></textarea>
                              <div class="anniu">
                                  <button id="qx">取消</button>
                                  <button type="submit">发表</button>
                              </div>
                          </form>
                      </div>
                      <div class="Wonderful-comment" id="rep">
                          <div class="wonderful-wenzi" >
                              <%--  <span>精彩评论</span>--%>
                              <span>最新评论</span>
                          </div>
                          <div class="wonderful-pinglun" id="pls">
                          </div>
                          <span id="tishi" style="margin-left: 35%;color: #ccc;"></span>
                          <div class="wonderful-pinglun" id="plq">
                              <% for(NoticeFollowcard noticeFollowcard:noticeFollowcards){%>
                              <ul>
                                  <li><span><%=noticeFollowcard.getUser().getUsername()%>:</span><span> <%=noticeFollowcard.getContent()%></span></li>
                                  <li><span style="box-sizing: border-box;padding-right: 525px;"><%=noticeFollowcard.getDate()%></span><%--<span id="rep<%=followcard.getId()%>">回复 </span>--%>
                                      <span id="dz<%=noticeFollowcard.getId()%>">
                                      <img id="z<%=noticeFollowcard.getId()%>" src="img/great2.png" class="animation" /></span>
                                      <span class="animation"  id="g<%=noticeFollowcard.getId()%>"> <%=noticeFollowcard.getGreat_num()%></span>
                                      <script>
                                          $(function () {
                                              //评论事件
                                              $("#dz"+<%=noticeFollowcard.getId()%>).click(function(){
                                                  var praise_img = $("#z"+<%=noticeFollowcard.getId()%>);
                                                  var praise_txt = $("#g"+<%=noticeFollowcard.getId()%>);
                                                  var num=parseInt(praise_txt.text());
                                                  sessionStorage.setItem("flag",num);
                                                  if(praise_img.attr("src") == ("img/great1.png")){
                                                      $(this).html("<img src='img/great2.png' id='z<%=noticeFollowcard.getId()%>' class='animation' />");
                                                      praise_txt.removeClass("hover");
                                                      num -=1;
                                                      praise_txt.text(num)
                                                  }else{
                                                      $(this).html("<img src='img/great1.png' id='z<%=noticeFollowcard.getId()%>' class='animation' />");
                                                      praise_txt.addClass("hover");
                                                      num +=1;
                                                      praise_txt.text(num)
                                                  }
                                                  $.ajax({
                                                      type: "POST",
                                                      url: "${pageContext.request.contextPath}/noticeGreat.action",
                                                      data: {"noticeId": <%=noticeFollowcard.getId()%>,"great_num":num},
                                                      success: function () {
                                                      },
                                                  });
                                              });
                                              var praise_img = $("#z"+<%=noticeFollowcard.getId()%>);
                                              var praise_txt = $("#g"+<%=noticeFollowcard.getId()%>);
                                              var num=parseInt(praise_txt.text());
                                              var great_num =parseInt( sessionStorage.getItem("flag"));
                                              if(great_num<num){
                                                  praise_img.attr("src","img/great1.png");
                                                  praise_txt.removeClass("hover");
                                              }
                                              if(great_num==num){
                                                  praise_img.attr("src","img/great2.png");
                                                  praise_txt.removeClass("hover");
                                              }
                                          })
                                      </script>
                              </ul>
                              <%}%>
                          </div>
                      </div>
                  </div>
              </div>
              <div class="main-bottom-right">
                  <div class="main-bottom-right-top">
                      <img src="img/pexels-photo-323772.png" alt="" />
                      <p class="main-bottom-right-top-one">哈希资本投资EXX，开启ET盛世华</p>
                      <p class="main-bottom-right-top-two">哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华</p>
                  </div>
                  <div class="main-bottom-right-top">
                      <img src="img/pexels-photo-323772.png" alt="" />
                      <p class="main-bottom-right-top-one">哈希资本投资EXX，开启ET盛世华</p>
                      <p class="main-bottom-right-top-two">哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华哈希资本投资EXX，开启ET盛世华</p>
                  </div>
              </div>
          </div>
      </div>
  </div>
  </body>
  <script>
      $(function () {
          //默认加载第一页
          changep(1);
          var name = "${sessionScope.name}";
          if(name != "" && name != null){
              $("#login").html("欢迎用户 :  "+name);
          }else{
              window.location.href="<%=path%>/login.jsp";
          }
      })
      $("#xs").click(function () {
          $(".header-xiantiao-center").hide();
      })
      /*取消时清空表单内容*/
      $("#qx").click(function () {
          $("#cont").val("");
          return false;
      });
    /* /!* 发表回复内容*!/
      $("#submit2").click(function () {
          //发表评论
          $.ajax({
              type: "POST",
              url: "<%=path%>/follow.action",
              data: $("#frm").serialize(),
              dataType: "text",
              success: function () {

              }
          });
      });*/
      //页面刷新指定到原先滚动条位置
      window.onbeforeunload = function() {
          var scrollPos;
          if(typeof window.pageYOffset != 'undefined') {
              scrollPos = window.pageYOffset;
          } else if(typeof document.compatMode != 'undefined' &&
              document.compatMode != 'BackCompat') {
              scrollPos = document.documentElement.scrollTop;
          } else if(typeof document.body != 'undefined') {
              scrollPos = document.body.scrollTop;
          }
          document.cookie = "scrollTop=" + scrollPos; //存储滚动条位置到cookies中
      }
      window.onload = function() {
          if(document.cookie.match(/scrollTop=([^;]+)(;|$)/) != null) {
              var arr = document.cookie.match(/scrollTop=([^;]+)(;|$)/); //cookies中不为空，则读取滚动条位置
              document.documentElement.scrollTop = parseInt(arr[1]);
              document.body.scrollTop = parseInt(arr[1]);
          }
      }

        /*  获取滚动条当前的位置*/
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
              changep(i);
              i++;
          }
      }
  </script>
</html>
