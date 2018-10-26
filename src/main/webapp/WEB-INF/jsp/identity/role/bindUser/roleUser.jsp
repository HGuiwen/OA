<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<!-- 引入分页标签 -->
<%@ taglib  uri="/pager" prefix="p"%>
<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>OA办公管理系统-用户管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
<link rel="stylesheet"
	href="${ctx }/resources/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript"
	src="${ctx }/resources/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="${ctx }/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
<!-- 导入bootStrap的库 -->
<script type="text/javascript"
	src="${ctx}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/easyUI/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="${ctx}/resources/easyUI/easyui.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/pager.css">
<script type="text/javascript" src="${ctx}/js/all.js"></script>
<script type="text/javascript">


    $(function(){
    	
    	if("${msg}"){
  			$.messager.show({
  				title:'温馨提示',
  				msg:"<font color='red'>${msg}</font>",
  				showType:'show'
  			});
  		}
    	
    	//为解绑用户绑定点击事件
    	$("#unBindUser").click(function(){
    		
    		 //获取所有的子checkbox
			   var boxs = $("input[type='checkbox'][id^='box_']");	
	    	   
	    	   //获取选中的checkbox
	    	   var checkedBoxs = boxs.filter(":checked");
	    	   
	    	   if(checkedBoxs.length == 0 ){
	   			   $.messager.alert("错误提示","请选择需要解绑的用户信息！",'error');

	    	   }else{
	    		   $.messager.confirm('温馨提示', '是否确认解绑?', function(flag){
		   				if (flag){
		   				 var arr = new Array();
			    		   //遍历checkedBoxs，发送请求解绑用户
			    		   for(var i=0;i<checkedBoxs.length;i++){
			    			   arr.push(checkedBoxs[i].value);
			    		   }
			    		   //发送请求解绑用户信息
			    		   window.location = "${ctx}/identity/role/unbindUser.jspx?pageIndex=${pageModel.pageIndex}&id=${role.id}&name=${role.name}&userIds="+arr;
		   				}})
	    	   }
    	})
    	
    	//为绑定用户 按钮绑定点击事件
    	$("#bindUser").on("click",function(){
    		
	  		addDialog({title : "绑定用户",
	  			width : 850,
	  			height : 350,
	  			closeURL : "${ctx}/identity/role/selectRoleUser.jspx?id=${role.id}&name=${role.name}&pageIndex=${pageModel.pageIndex}",
	  			iframeURL : "${ctx}/identity/role/showNotBindUser.jspx?id=${role.id}&name=${role.name}"});

    	})
    })
     
</script>
</head>
<body style="overflow: hidden; width: 98%; height: 100%;" >
		<!-- 工具按钮区 -->
		
 		<div class="panel panel-primary" style="padding-left: 5px;">
 			<div style="padding-top: 4px;padding-bottom: 4px;">
				<a  id="back" class="btn btn-primary" onclick="history.go(-1)"><span class="glyphicon glyphicon-hand-left"></span>&nbsp;返回</a>
				<a  id="bindUser" class="btn btn-success"><span class="glyphicon glyphicon-copy"></span>&nbsp;绑定用户</a>
				<a  id="unBindUser" class="btn btn-danger"><span class="glyphicon glyphicon-paste"></span>&nbsp;解绑用户</a>
			    
			 
			</div>
 			<div class="panel-heading" style="background-color: #11a9e2;">
				<h3 class="panel-title"><label style="color: white;font-size: 15px;"><span class="glyphicon glyphicon-user"></span>&nbsp;${role.name}</label></h3>
			</div>
			<div class="panel-body" >
				<table class="table table-bordered">
					<thead>
						<tr style="font-size: 12px;" align="center">
							<th style="text-align: center;"><input id="checkAll"
								type="checkbox" /></th>
							<th style="text-align: center;">账户</th>
							<th style="text-align: center;">姓名</th>
							<th style="text-align: center;">性别</th>
							<th style="text-align: center;">部门</th>
							<th style="text-align: center;">职位</th>
							<th style="text-align: center;">手机号码</th>
							<th style="text-align: center;">邮箱</th>
							<th style="text-align: center;">审核人</th>
						</tr>
					</thead>
					<c:forEach items="${users}" var="user"
						varStatus="stat">
						<tr id="dataTr_${stat.index}" align="center" style="cursor:pointer">
							<td><input type="checkbox" name="box" id="box_${stat.index}"
								value="${user.userId}" /></td>
							<td>${user.userId}</td>
							<td>${user.name}</td>
							<td>${user.sex == 1 ? '男' : '女' }</td>
							<td>${ user.dept.name}</td>
							<td>${ user.job.name}</td>
							<td>${user.phone}</td>
							<td>${user.email}</td>
							<td>${user.checker.name}</td>
						</tr>
					</c:forEach>
				</table>
				
			</div>
			
			<!-- 分页标签区 -->
			<p:page pageIndex="${pageModel.pageIndex}" pageStyle="flickr" pageSize="${pageModel.pageSize}" recordNum="${pageModel.recordCount}" submitUrl="${ctx}/identity/role/selectRoleUser.jspx?pageIndex={0}&id=${role.id}&name=${role.name}"></p:page>
		</div>
		
		<div id="divDialog" style="display: none;" >
			 <!-- 放置一个添加用户的界面  -->
			 <iframe id="iframe" frameborder="0" style="width: 100%;height: 100%;"></iframe>
		</div>
	
</body>
</html>