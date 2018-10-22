<%@page import="com.bbs.model.Post"%>
<%@page import="org.apache.struts2.components.Else"%>
<%@page import="com.bbs.model.SubForum"%>
<%@page import="com.bbs.model.MainForum"%>
<%@page import="com.bbs.service.MainForumBiz"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.context.support.ClassPathXmlApplicationContext"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>publish</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="component/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="js/publish-post.js"></script>
    <script src="component/ckeditor/config.js"></script>
    <script src="component/ckeditor/ckeditor_basic_source.js"></script>
    <script src="component/ckeditor/ckeditor_source.js"></script>
    <script src="component/ckeditor/ckeditor.js"></script>
    <script src="component/ckeditor/ckeditor_basic.js"></script>
    <script type="text/javascript">
    </script>
    <link rel="stylesheet" href="css/publish_post.css">
</head>
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
<!--header结束-->
<body>
<div class="main">
<div class="mian-top">
    <span style="cursor:pointer"  onclick="window.location.href='<%=path%>/index.jsp'">社区></span>
    <span>发表文章</span>
</div>
    <div class="main-center view_width">
 <table class="tb" cellspacing="0" cellpadding="3">
  <%Post post = (Post)request.getAttribute("post"); %>
  <%if (post== null) {%>
  <form id="postForm" enctype="multipart/form-data" method="post" action="<%=path%>/publish.action">
  <%}else{ %>
   <form id="postForm"  method="post" action="<%=path%>/updatepost.action?postId=<%=post.getId()%>">
  <%} %>
       <input type="hidden" id="hid" name="photo_url" value=""/>
       <tr class="first-tr">
           <th style="color:black;font-size: 18px;font-weight: 500">文章标题</th>
           <%   if (post!=null){ %>
           <td class="biaoti">
           <input required type="text" id="textfile" name="title" value="<%=post.getTitle()%>" maxlength="30"/>
           </td>
           <%}else{ %>
           <td class="biaoti">
               <input type="text" class="text-header" placeholder="输入您的标题" id="textfile" name="title">
               <s:fielderror fieldName="limit"></s:fielderror>
               <span style="margin-left: 50px;float: right">此处可以输入30个字符</span>
           </td>
           <%} %>
       </tr>
       <tr style="height: 160px;">
           <th style="color:black;font-size: 18px;">标题配图</th>
           <td>
               <div class="lccid" >
                   <%   if (post!=null){ %>
                   <img  class="img">
                   <input type="file" class="file"  placeholder="ICCID" id="fil" name="photo1"  accept="img/*" capture="camera" value="<%=post.getPhoto_url()%>">
                   <%}else{ %>
                   <img  class="img">
                   <input type="file" class="file" style="width: 200px"  placeholder="ICCID" id="fil" name="photo1"  accept="img/*" capture="camera">
                   <%} %>
               </div>
           </td>
       </tr>
       <tr>
           <th style="color:black;font-size: 18px;">文章内容</th>
           <td>
               <%   if (post!=null){ %>
               <textarea type="text" class="" name="content" id="ckeditor" ><%=post.getCardContent()%></textarea>
               <%}else{ %>
               <textarea type="text" class="" name="content" id="ckeditor"></textarea>
               <%} %>
               <span style="float: right;">此处可以输入30000个字符</span>
           </td>
       </tr>
       <tr>
           <th style="color:black;font-size: 18px;">选择版块</th>
           <td>
               <div id="change" style="float:left">
                   <select id="mainforum" name="mainForum" onchange="onselected(this)">
                       <%
                           ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
                           MainForumBiz mainForumBiz = (MainForumBiz)context.getBean("mainForumBiz");
                           List<MainForum> mainForums = mainForumBiz.getAllMainForums();
                           for (MainForum mainForum:mainForums){
                       %>
                       <option value=<%=mainForum.getId()%>><%=mainForum.getTitle() %></option>
                       <%} %>
                   </select>
                   <% int i=0;
                       for (MainForum mainForum:mainForums){
                           if ( i==0){
                   %>
                   <select name="subForum" id="<%=mainForum.getId()%>">
                       <%}else{ %>
                       <select name="sub" id="<%=mainForum.getId()%>" style="display: none;">
                           <%} %>
                           <%
                               Set<SubForum> subforms = mainForum.getSubForums();
                               for (SubForum subForum:subforms){
                           %>
                           <option value="<%=subForum.getId()%>"><%=subForum.getTitle()%></option>
                           <%}%>
                       </select>
                       <% i++;} %>
                       <span style="float:right;line-height:35px;">请选择所要发帖的版块</span>
                   </select>
               </div>
           </td>
       </tr>
       <tr>
           <th></th>
           <td>
               <input class="enter" style="background-color: #CD9C1B;border: none;border-radius: 5px;width: 100px;margin-left: 309px;height: 30px;color: white" type="submit" id="submit"  value="提交"/>
           </td>
       </tr>
   </form>
 </table>
        <script type="text/javascript">
            $(function () {
                $("#submit").click(function () {
                    var title =$("#textfile").val();
                   var conts= CKEDITOR.instances.ckeditor.getData();
                    var length = conts.length;
                    if(title==null||title==""||title==undefined){
                        alert("标题不能为空");
                        return false;
                    }
                    if(conts==null||conts==""||conts==undefined){
                        alert("内容不能为空");
                        return false;
                    }

                    if(length>30000){
                        alert("对不起，您上传的内容太大");
                        return false;
                    }
                })
            })
            $("#xs").click(function () {
                $(".header-xiantiao-center").hide();
            })
        CKEDITOR.replace('ckeditor', { allowedContent: true });
        $(".lccid").on("change", "input[name=photo1]", function() {
            $(this).prev().css("opacity","1")
            var filePath = $(this).val();//读取图片路径
            //将图片的URL赋值与hidden标签内
            var fr = new FileReader();//创建new FileReader()对象
           var imgObj = this.files.item(0);//获取图片
           fr.readAsDataURL(imgObj);//将图片读取为DataURL*/
            var obj = $(this).prev()[0];//
            var arr = filePath.split('\\');
            var fileName = arr[arr.length - 1];
            $(this).parent().next().show();
            fr.onload = function() {
                obj.src = this.result;
                //将base64编码后的图片赋值到hidden标签内
                $("#hid").val(obj.src);
            };
        });
    </script>
</div>
</div>
</body>
	<script type="text/javascript" src="js/jquery.validate.min.js"></script>
  <script type="text/javascript">
      $(function(){
          var name = "${sessionScope.name}";
          if(name != "" && name != null){
              $("#login").html("欢迎用户 :  "+name);
          }

            $("#submit").click(function () {
                var path = $("#fil").val();//读取图片路径
                if(path.trim()==""){

                }else{
                    var len = path.substring(path.lastIndexOf(".")+1,path.length);
                    len = len.toLocaleLowerCase();//处理大小写
                    if(len!="bmp" && len!="jpg"&&len!="gif"&&len!="png"&&len!="jpeg"){
                        alert("图片格式不正确！");
                        return false;
                    }else{
                        var imagSize =  document.getElementById("fil").files[0].size;
                        if(imagSize>1024*1024*2){
                            alert("图片不能大于2M！");
                            return false;
                        }
                  };
                }
             });

	  	});
  </script>
<%--<script>
    ClassicEditor
        .create( document.querySelector( '#ckeditor' ) )
        .catch( error => {
        console.error( error );
    } );
</script>--%>
</html>