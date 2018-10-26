<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!-- 引入分页标签 -->
<%@ taglib prefix="p" uri="/pager"%>
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
<link rel="stylesheet" href="${ctx }/resources/bootstrap/css/bootstrap.min.css" />
<script type="text/javascript" src="${ctx}/resources/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
<!-- 导入bootStrap的库 -->
<script type="text/javascript" src="${ctx}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/easyUI/easyui-lang-zh_CN.js"></script>
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
	      	
		$("#addModule").click(function(){
			addDialog({
	  			title : "添加模块",
	  			width : 520,
	  			height : 270,
	  			closeURL : "${ctx}/identity/module/getModulesByParent.jspx?pageIndex=${pageModel.pageIndex}&parentCode=${parentCode}",
	  			iframeURL : "${ctx}/identity/module/showAddModule.jspx?parentCode=${parentCode}"
	  			});
			
		});
		
		
		boxes = $("input[type='checkbox'][id^='box_']")
		$("#deleteModule").click(function(){
			  //获取选中的checkbox
	    	  var box = boxes.filter(":checked");
	    	  
	    	  if(box.length==0){
	    		  $.messager.alert('信息','请选中要删除的编号','info');
	    	  }else{
	    		  $.messager.confirm('信息', '确认是否删除?', function(flag){
	    			  if(flag){
		    			  var arr = new Array();
			    		  //得到选中的id
			    		   $.each(box,function(){
			    			   var id = $(this).val();
			    			   arr.push(id);
			    		   })
			    		   window.location="${ctx}/identity/module/deleteModuleById.jspx?id="+arr.join()+"&parentCode=${parentCode}&pageIndex=${pageModel.pageIndex}";
		    		  	
		    		  }
	  			});
	    	  }
			
		})
		
	})
	function updateModule(code){
			addDialog({
	  			title : "修改模块",
	  			width : 520,
	  			height : 270,
	  			closeURL : "${ctx}/identity/module/getModulesByParent.jspx?pageIndex=${pageModel.pageIndex}&parentCode=${parentCode}",
	  			iframeURL : "${ctx}/identity/module/showUpdateModule.jspx?code="+code
	  			});
		}
</script>

</head>
<body style="overflow: hidden; width: 98%; height: 100%;">
	<div>
	
		<div class="panel panel-primary">
			<!-- 工具按钮区 -->
			<div style="padding: 5px;">
				<a  id="addModule" class="opea btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>
				<a  id="deleteModule" class="opea btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
			</div>
			
			<div class="panel-body">
				<table class="table table-bordered" style="float: right;">
					<thead>
						<tr style="font-size: 12px;" align="center" >
							<th style="text-align: center;"><input type="checkbox" id="checkAll"/></th>
							<th style="text-align: center;">编号</th>
							<th style="text-align: center;">名称</th>
<!-- 							<th>备注</th> -->
							<th style="text-align: center;">链接</th>
							<th style="text-align: center;">操作</th>
<!-- 							<th style="text-align: center;">创建日期</th> -->
<!-- 							<th style="text-align: center;">创建人</th> -->
<!-- 							<th>修改日期</th> -->
							<th style="text-align: center;">修改人</th>
							<th style="text-align: center;">操作</th>
						</tr>
					</thead>
					  <c:forEach items="${modules}" var="module" varStatus="stat">
				        <tr align="center" id="dataTr_${stat.index}" style="cursor:pointer">
							<td><input type="checkbox" name="box" id="box_${stat.index}" value="${module.code}"/></td>
							<td>${module.code}</td>
							<td>${module.name.replaceAll("-","")}</td>
<%-- 							<td>${module.remark}</td> --%>
							<td>${module.url}</td>
							<td><span class="label label-success"><a href="${ctx}/identity/module/getModulesByParent.jspx?parentCode=${module.code}" style="color: white;">查看下级</a></span></td>
<%-- 							<td><fmt:formatDate value="${module.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
<%-- 							<td>${module.creater.name }</td> --%>
<%-- 							<td><fmt:formatDate value="${module.modifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
							<td>${module.modifier.name }</td>
							<td><span id="updateModule" class="opea label label-info"><a href="javascript:updateModule('${module.code}');" style="color: white;">修改</a></span></td>
						</tr>
				    </c:forEach>
				</table>
					
			</div>
			<!-- 分页标签区 -->
			<p:page pageIndex="${pageModel.pageIndex}" pageStyle="flickr" pageSize="${pageModel.pageSize}" recordNum="${pageModel.recordCount}" submitUrl="${ctx}/identity/module/getModulesByParent.jspx?pageIndex={0}&parentCode=${parentCode}"></p:page>
		</div>
	</div>
		<div id="divDialog" style="display: none;" >
			 <!-- 放置一个添加用户的界面  -->
			 <iframe id="iframe" frameborder="0" style="width: 100%;height: 100%;"></iframe>
		</div>
	
</body>
</html>