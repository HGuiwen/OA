<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>办公管理系统-添加公告类型</title>
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

 <!-- 导入dwr相关js文件 -->
    <script type='text/javascript' src='${ctx}/dwr/engine.js'></script>
    <script type='text/javascript' src='${ctx}/dwr/interface/fileUpload.js'></script>
    <script type='text/javascript' src='${ctx}/dwr/util.js'></script>

 <!-- 引入My97 时间控件-->
    <script type='text/javascript' src='${ctx}/resources/My97DatePicker/WdatePicker.js'></script>


		<script type="text/javascript">
			$(function(){
				
				
				
                 $("#btn_submit").click(function(){
	 	 			
	 				var type = $("#type").val(); 
                    var remark = $("#remark").val();

	 				if($.trim(type)==null||$.trim(type)==""){
	 					alert("请输入类型名称！");
	 					$("#title").focus();
	 				}else{
	 					//提交表单
	 					$("#addNoticeTypeForm").submit();
	 				}
				})
				

			});
		</script>
	</head>
<body>
		
	 	<div class="container">
			<form id="addNoticeTypeForm" style="padding: 30px;" class="form-horizontal" action="${ctx}/noticeType/type/addNoticeType.jspx" method="post">

				<div class="form-group">
					<div>
						<input id="type" name="type" type="text" class="form-control" placeholder="请输入公告类型" />
					</div>
				</div>

				<div class="form-group">
					<div >
					     <textarea id="remark" name="remark" class="form-control" rows="3" placeholder="请输入备注信息"></textarea>
					  </div>
				</div>
				
				<div class="form-group text-center">
						<a id="btn_submit" class="btn btn-info">添加</a>
						<button type="reset"  class="btn btn-danger">重置</button>
					   <div >
					  </div>
				</div>
			</form>
		</div>
</body>
</html>	