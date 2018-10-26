<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set  value="${pageContext.request.contextPath}"  var="ctx"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>办公管理系统-添加公告</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/>
		<meta name="Keywords" content="keyword1,keyword2,keyword3"/>
		<meta name="Description" content="网页信息的描述" />
		<meta name="Author" content="fkjava.org" />
		<meta name="Copyright" content="All Rights Reserved." />
   <link href="${ctx}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${ctx }/resources/jquery/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="${ctx }/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${ctx }/resources/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript"
	src="${ctx}/resources/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/easyUI/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="${ctx}/resources/easyUI/easyui.css">
<!-- 富文本编辑器js文件 -->
 <script type="text/javascript" src="${ctx}/resources/tiny_mce/tiny_mce.js"></script> 


		<script type="text/javascript">
		
	 	tinyMCE.init({
			// General options
			mode : "textareas",//匹配模式
			theme : "advanced",//主题样式   advanced：高级   simple简单的
			language : "zh-cn",//语言
			plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave",

			// 
			theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
			theme_advanced_buttons2 : "paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
			theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
			theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft",
			theme_advanced_toolbar_location : "top",
		    theme_advanced_toolbar_align : "left",
			theme_advanced_statusbar_location : "bottom",
			theme_advanced_resizing : false,//是否可以拖动

			
		}); 
		
		
		
			$(function(){
				
				
				//通过ajax异步请求获取部门以及职位信息
				$.post("${pageContext.request.contextPath}/notice/noticeDetail/ajaxLoadNoticeType.jspx",
						function(data) {

						   var types = data.types;
						   
						   $.each(types,function(){
							   $("<option>").val(this.id).text(this.name).appendTo("#noticeType");
						   })

						}, "json");
				
		
				
				$("#btn_submit").click(function(){
	 	 			
					//获取标题信息
	 				var title = $("#title").val(); 
					//获取公告内容
	 				var content = tinyMCE.get('content').getContent()
					
					alert(title+"=="+content);
                    var noticeType = $("#noticeType").val();

	 				if($.trim(title)==null||$.trim(title)==""){
	 					alert("请输入公告标题！");
	 					$("#title").focus();
	 				}else if($.trim(content)==null||$.trim(content)==""){
	 					alert("请输入公告内容！");
	 				}else if(noticeType==0){
	 					alert("请选择公告类型！");
	 				}else{
	 					//提交表单
	 					$("#addNoticeForm").submit();
	 				}
				})
				
			})
			
			
		</script>
	</head>
<body>
		
	 	<div class="container">
			<form id="addNoticeForm" style="padding: 30px;" class="form-horizontal" action="${ctx }/notice/detail/addNoticeDetail.jspx" method="post">

				<div class="form-group">
					<div>
						<input id="title" name="title" type="text" class="form-control" placeholder="请输入公告名称" />
					</div>
				</div>

				<div class="form-group">
					<div >
                       <select name="noticeType.id" class="btn btn-default" id="noticeType">
							<option value="0">请选择公告类型</option>
						</select>					  
					</div>
				</div>
				
				<div class="form-group">
					<div >
					     <textarea id="content" name="content" class="form-control" rows="3" placeholder="请输入公告内容"></textarea>
					  </div>
				</div>
				
				
				<div class="form-group text-center">
						<a id="btn_submit" class="btn btn-info" >添加</a>
						<button type="reset"  class="btn btn-danger" >取消</button>
					   <div >
					  </div>
				</div>
			</form>
		</div>
</body>
</html>	