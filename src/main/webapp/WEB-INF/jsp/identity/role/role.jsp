<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 引入分页标签 -->
<%@ taglib uri="/pager" prefix="p"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>OA办公管理系统-角色管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<link href="${ctx}/fkjava.ico" rel="shortcut icon" type="image/x-icon" />
	<link rel="stylesheet"
	href="${ctx}/resources/bootstrap/css/bootstrap.min.css" />
	<script type="text/javascript"
	src="${ctx}/resources/jquery/jquery-1.11.0.min.js"></script>
	<script type="text/javascript"
	src="${ctx}/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
	<!-- 导入bootStrap的库 -->
	<script type="text/javascript"
	src="${ctx}/resources/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript"
	src="${ctx}/resources/easyUI/jquery.easyui.min.js"></script>
	<script type="text/javascript"
	src="${ctx}/resources/easyUI/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" href="${ctx}/resources/easyUI/easyui.css">
	<link rel="stylesheet"
	href="${ctx}/css/pager.css">
	<script type="text/javascript" src="${ctx}/js/all.js"></script>
	<script type="text/javascript">
	
	      $(function(){
	    	  
	    	  $(".opea").each(function(){
	      		//代表没有权限
	      		if("${urls}".indexOf(this.id)==-1){
	      			$(this).hide().removeAttr("id").html("");
	      		}
	      	})
	    	  
	    	 if("${message}"){
	  			$.messager.show({
	  				title:'温馨提示',
	  				msg:"<font color='red'>${message}</font>",
	  				showType:'show'
	  			});
	  		}
	    	  
	    	//为添加按钮绑定点击事件 
	  		$("#addRole").click(function() {
	  		addDialog({
	  			title : "添加角色",
	  			width : 480,
	  			height : 250,
	  			closeURL : "${ctx}/identity/role/selectRole.jspx?pageIndex=${pageModel.pageIndex}",
	  			iframeURL : "${ctx}/identity/role/showAddRole.jspx"
	  			});
	  		})
	  		

	       //为删除按钮绑定事件
		 $("#deleteRole").click(function(){
		    	 //获取所有的子checkbox
				   var boxs = $("input[type='checkbox'][id^='box_']");	
		    	   
		    	   //获取选中的checkbox
		    	   var checkedBox = boxs.filter(":checked");
		    	   
		    	   if(checkedBox.length == 0 ){
		   			   $.messager.alert("错误提示","请选择需要删除的角色信息！",'error');

		    	   }else{
		    		   
		    		 //给用户提示，是否确认删除
		    		$.messager.confirm('温馨提示', '是否确认删除?', function(flag){
		   				if (flag){
		   				 //创建内存函数 Array的实例，用于封装需要删除的用户信息      Array：在js中代表数组
			    			   var arr = new Array();
			    			   //删除用户信息    用户账号（主键）传递至后台
			    			   $.each(checkedBox,function(){
			    				   //this:dom对象
			    				   arr.push(this.value); 
			    			   })
			    			   //发送请求删除角色信息
			    			   window.location = "${ctx}/identity/role/deleteRole.jspx?roleIds="+arr+"&pageIndex=${pageModel.pageIndex}";  
			    		   
		   				}
		   			});
   
		    	   }
		       })
	      
	      })
	      
	      
	      //为修改按钮绑定事件
	      function updateRole(roleId) {
		     addDialog({title : "修改角色",
		    	 width : 480,
		    	 height : 250,
		    	 closeURL : "${ctx}/identity/role/selectRole.jspx?pageIndex=${pageModel.pageIndex}",
		    	iframeURL : "${ctx}/identity/role/showUpdateRole.jspx?roleId="+roleId
		    			});
	        }
	      
	</script>
</head>
<body style="overflow: hidden;width: 100%;height: 100%;padding: 5px;">
	<div>
		<div class="panel panel-primary">
			<!-- 工具按钮区 -->
			<div style="padding-top: 4px;padding-bottom: 4px;">
				<a  id="addRole" class="opea btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>
				<a  id="deleteRole" class="opea btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
			</div>
			
			<div class="panel-body">
				<table class="table table-bordered" style="float: right;">
					<thead>
					    <tr>
						<th style="text-align: center;"><input type="checkbox" id="checkAll"/></th>
						<th style="text-align: center;">名称</th>
						<th style="text-align: center;">备注</th>
						<th style="text-align: center;">操作</th>
						<th style="text-align: center;">创建日期</th>
						<th style="text-align: center;">创建人</th>
						<th style="text-align: center;">修改日期</th>
						<th style="text-align: center;">修改人</th>
						<th style="text-align: center;">操作</th>
						</tr>
					</thead>
					<c:forEach items="${roles}" var="role" varStatus="stat">
				         <tr align="center" id="dataTr_${stat.index}" style="cursor:pointer">
							<td><input type="checkbox" name="box" id="box_${stat.index}" value="${role.id}"/></td>
							<td>${role.name}</td>
							<td>${role.remark}</td>
							<td><span id="selectRoleUser" class="opea label label-success"><a href="${ctx}/identity/role/selectRoleUser.jspx?id=${role.id}&name=${role.name}" style="color: white;">绑定用户</a></span>&nbsp;
								<span id="selectRoleModule" class="opea label label-info"><a href="${ctx}/identity/popedom/mgrPopedom.jspx?id=${role.id}" style="color: white;">绑定操作</a></span></td>
							<td><fmt:formatDate value="${role.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${role.creater.name}</td>
							<td><fmt:formatDate value="${role.modifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${role.modifier.name}</td>
							<td>   <span id="updateRole" class="opea label label-info"><a href="javascript:updateRole('${role.id}')">修改</a></span></td>
						</tr>
		   			 </c:forEach>
				</table>
				
			</div>
			<!-- 分页标签区 -->
				<p:page pageIndex="${pageModel.pageIndex}" pageStyle="flickr" pageSize="${pageModel.pageSize}" recordNum="${pageModel.recordCount}" submitUrl="${ctx}/identity/role/selectRole.jspx?pageIndex={0}"></p:page>
		</div>
	</div>
    <!-- div作为弹出窗口 -->
    <div id="divDialog" style="overflow: hidden;">
		<iframe id="iframe" scrolling="no" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	
</body>
</html>