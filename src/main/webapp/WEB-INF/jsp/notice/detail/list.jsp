<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	<!-- 引入c标签 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>OA办公管理系统-公告管理</title>
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


<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/operaPageCss.js"></script>
	
<script type="text/javascript">

$(function(){
	
	//获取页面中所有的权限按钮(增删改查审核等)
	$(".opera").each(function(){

	     if("${pagePperas}".indexOf(this.id) == -1){
	         $(this).hide().removeAttr("id").html("");
	     }
	})
	
	
	$("#addNoticeDetail").click(function() {addDialog({title : "添加公告",width : 780,height : 510,colseUrl : "${pageContext.request.contextPath}/notice/noticeDetail/selectNoticeDetail.jspx?pageIndex=${pageModel.pageIndex}",iframeUrl : "${pageContext.request.contextPath}/notice/noticeDetail/showAddNoticeDetail.jspx"});})

	
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
			action="${ctx }/notice/detail/selectNoticeList.jspx" method="post"
			style="margin-top: 5px;">
			<div class="form-group">
				<div class="col-sm-2">
					<input name="title" type="text" value="${notice.title}" class="form-control" placeholder="标题">
				</div>
				<div class="col-sm-3">
					<button type="submit" id="selectNoticeDetail" class="opera btn btn-info">查询</button>
					<a id="addNoticeDetail" class="opera btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加
					</a> <a id="deleteNoticeDetail" class="opera btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
				</div>
			</div>
		
		</form>
			
			<div class="panel-body">
				<table class="table table-bordered" style="float: right;">
					<thead>
						<tr style="font-size: 12px;" align="center">
							<th style="text-align: center;"><input  id="checkAll" type="checkbox" /></th>
							<th style="text-align: center;">公告名称</th>
							<th style="text-align: center;">公告类型</th>
							<th style="text-align: center;">创建者</th>
							<th style="text-align: center;">创建时间</th>
							<th style="text-align: center;">修改者</th>
							<th style="text-align: center;">修改时间</th>
							<th style="text-align: center;">操作</th>
						</tr>
					</thead>
					  
                  <c:forEach items="${requestScope.notices}" var="notice" varStatus="stat">
                    <tr id="dataTr_${stat.index}" align="center">
					<td><input type="checkbox" name="box" id="box_${stat.index}" value="${notice.id}"/></td>
					<td>${notice.title}</td>
					<td>${notice.noticeType.type}</td>
					<td>${notice.creater.name}</td>
					<td><fmt:formatDate value="${notice.createDate}" pattern="yyyy年MM月dd日"></fmt:formatDate></td>
					<td>${notice.modifier.name}</td>
					<td><fmt:formatDate value="${notice.modifyDate}" pattern="yyyy年MM月dd日"></fmt:formatDate></td>
                    <td>
                        <span class="label label-success"><a href="#" onclick="lookNotice('${employee.id}')" style="color: white;">查看</a></span>&nbsp;
						<span class="label label-info"><a href="#" onclick="updateNotice('${notice.id}')"  style="color: white;">修改</a></span>
                    </td>
				   </tr>
          
                 </c:forEach>	
          
				</table>
			
			</div>
			
		</div>
	</div>
    <!-- div作为弹出窗口 -->
    <div id="divDialog" style="overflow: hidden;">
		<iframe id="iframe" scrolling="no" frameborder="0" width="100%" height="100%"></iframe>
	</div>
	
</body>
</html>