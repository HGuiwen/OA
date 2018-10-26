<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入c标签 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/pager" prefix="p"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>OA办公管理系统-公告类型列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
<meta http-equiv="description" content="This is my page" />
   <link href="${ctx}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${ctx }/resources/jquery/jquery-1.11.0.min.js"></script>
	<script type="text/javascript" src="${ctx }/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="${ctx }/resources/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript"
	src="${ctx}/resources/easyUI/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${ctx}/resources/easyUI/easyui-lang-zh_CN.js"></script>
<link rel="stylesheet" href="${ctx}/resources/easyUI/easyui.css">
<script type="text/javascript">

$(function(){
	$(".opea").each(function(){
		//代表没有权限
		if("${urls}".indexOf(this.id)==-1){
			$(this).hide().removeAttr("id").html("");
		}
	})
	
	
	/** 添加模块绑定点击事件  */
	$("#addNoticeType").click(function(){
	
		$("#divDialog").dialog({
			title : "添加类型", // 标题
			cls : "easyui-dialog", // class
			width : 600, // 宽度
			height : 310, // 高度
			maximizable : true, // 最大化
			minimizable : false, // 最小化
			collapsible : true, // 可伸缩
			modal : true, // 模态窗口
			onClose : function(){ // 关闭窗口
				window.location = "${ctx}/notice/noticeType/selectNoticeType.jspx?pageIndex=${pageModel.pageIndex}";
			}
		}); 
		
		/** div弹出以后，立即加载界面，并且显示界面  */
 	     $("#iframe").attr("src", "${ctx}/notice/noticeType/showAddNoticeType.jspx").show();
 

	   })
	   
	   
	
   })

</script>

</head>
<body style="overflow: hidden; width: 98%; height: 100%;">
	<div>
	
		<div class="panel panel-primary">
			<!-- 工具按钮区 -->
			<!-- <div style="padding: 5px;">
				<a  id="addEmp" class="btn btn-info">添加</a>
				<a  id="deleteEmp" class="btn btn-danger">删除</a>
				<a  id="updateEmp" class="btn btn-danger">修改</a>
			</div> -->
				<!-- 工具按钮区 -->
		<form class="form-horizontal"
			action="${ctx}/noticeType/type/selectNoticeType.jspx" method="post"
			style="margin-top: 5px;">
			<div class="form-group">
				<div class="col-sm-2">
					<input name="type" type="text" value="${noticeType.type}" class="form-control" placeholder="类型名称">
				</div>

				<div class="col-sm-3">
					<button type="submit" id="selectNoticeType" class="opea btn btn-info">查询</button>
					<a id="addNoticeType" class="opea btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a> 
					<a id="deleteNoticeType" class="opea btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
				</div>
			</div>

		</form>
		
		
			<div class="panel-body">
				<table class="table table-bordered" style="float: right;">
					<thead>
						<tr style="font-size: 12px;" align="center">
							<th style="text-align: center;"><input  id="checkAll" type="checkbox" /></th>
							<th style="text-align: center;">公告类型</th>
							<th style="text-align: center;">备注</th>
							<th style="text-align: center;">创建者</th>
							<th style="text-align: center;">创建时间</th>
							<th style="text-align: center;">修改者</th>
							<th style="text-align: center;">修改时间</th>
							<th style="text-align: center;">操作</th>
						</tr>
					</thead>
					  
                  <c:forEach items="${requestScope.noticeTypes}" var="noticeType" varStatus="stat">
                    <tr id="dataTr_${stat.index}" align="center">
					<td><input type="checkbox" name="box" id="box_${stat.index}" value="${noticeType.id}"/></td>
					<td>${noticeType.type}</td>
					<td>${noticeType.remark}</td>
					<td>${noticeType.creater.name}</td>
					<td><fmt:formatDate value="${noticeType.createDate}" pattern="yyyy年MM月dd日"></fmt:formatDate></td>
					<td>${noticeType.modifier.name}</td>
					<td><fmt:formatDate value="${noticeType.modifyDate}" pattern="yyyy年MM月dd日"></fmt:formatDate></td>
                    <td>
                       	<span class="label label-info"><a href="#" onclick="updateNoticeType('${noticeType.id}')"  style="color: white;">修改</a></span>
				   </tr>
          
                 </c:forEach>	
          
				</table>
					<!-- 分页标签区 -->
				<p:page pageIndex="${pageModel.pageIndex}" pageStyle="flickr" pageSize="${pageModel.pageSize}" recordNum="${pageModel.recordCount}" submitUrl="${ctx}/notice/noticeType/selectNoticeType.jspx?pageIndex={0}"></p:page>
			</div>
			
		</div>
	</div>
    <!-- div作为弹出窗口 -->
    <div id="divDialog" style="overflow: hidden;">
		<iframe id="iframe" scrolling="no" frameborder="0" width="100%" height="100%" style="display:none;"></iframe>
	</div>
	
</body>
</html>