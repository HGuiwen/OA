<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入c标签 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"></c:set>
<!-- 引入分页标签 -->
<%@ taglib uri="/pager" prefix="p"%>
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
<link rel="stylesheet" href="${ctx}/css/pager.css">
<script type="text/javascript" src="${ctx}/js/all.js"></script>
<script type="text/javascript" src="${ctx}/resources/blockUI/jquery.blockUI.js"></script>
<script type="text/javascript">
	
    $(function(){
    	
    	$(".opea").each(function(){
    		//代表没有权限
    		if("${urls}".indexOf(this.id)==-1){
    			$(this).hide().removeAttr("id").html("");
    		}
    	})
    	
    	
    	if("${msg}"){
    		parent.$.messager.show({
				title:'信息',
				msg:'${msg}',
				timeout:5000,
				showType:'slide'
			});
   	 }
    	
    	$("input[id^='checkUser_']").switchbutton({
					onChange : function(checked) {
						var status =checked?"1":"0";
						$.ajax({
				    		url:"${ctx}/identity/user/activeUser.jspx?pageIndex=${pageModel.pageIndex}&name=${user.name}&phone=${user.phone}&dept.id=${user.dept.id}&job.code=${user.job.code }&userId="+ this.value+"&status="+status,
				    		type:"post",
				    		error:function(){
				    			$.messager.alert('信息','网络异常','error');
				    		}
				    	})
					
					
					}
				});
    	
    	$.ajax({
    		url:"${ctx}/identity/user/ajaxPost.jspx",
    		type:"post",
    		dataType:"json",
    		success:function(data){
    			var depts = data.depts;
    			
    			$.each(depts,function(){
    				$("<option>").val(this.id).html(this.name).prop("selected",this.id == "${user.dept.id}").appendTo("#deptSelect");
    			})
    			
    			var jobs = data.jobs;
    			
    			$.each(jobs,function(){
    				$("<option>").val(this.code).html(this.name).prop("selected",this.code == "${user.job.code}").appendTo("#jobSelect");
    			})
    			
    		},error:function(){
    			$.messager.alert('信息','网络异常','error');
    		}
    	})
    	
    	
    	//为添加按钮绑定点击事件 
	      $("#addUser").click(function(){
	    	  addDialog({title:'添加用户',
	    		  width:680,
	    		  height:410,
	    		  closeURL:'${ctx}/identity/user/selectUser.jspx?pageIndex=${pageModel.pageIndex}&name=${user.name}&user.phone=${user.phone}&user.dept.id=${user.dept.id}&user.job.code=${user.job.code}',
	    		  iframeURL:'${ctx}/identity/user/showAddUser.jspx'	  
	    	  });
	      })
	      
	      $("#deleteUser").click(function(){
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
			    		   window.location="${ctx}/identity/user/deleteUserById.jspx?id="+arr.join()+"&name=${user.name}&phone=${user.phone}&dept.id=${user.dept.id}&job.code=${user.job.code}&pageIndex=${pageModel.pageIndex}";
		    		  	
		    		  }
	  			});
	    	  }
	      })
    })

    //预览用户信息
	function preUser(userId) {
    	addDialog({title:'预览用户',
  		  width:810,
  		  height:400,
  		 closeURL:"${ctx}/identity/user/selectUser.jspx?pageIndex=${pageModel.pageIndex}&name=${user.name}&phone=${user.phone}&dept.id=${user.dept.id}&job.code=${user.job.code}",
  		  iframeURL:"${ctx}/identity/user/preUser.jspx?userId="+userId,
  	  });
	}
    //为修改按钮绑定事件
			function updateUser(userId){
				addDialog({title:'修改用户',
			  		  width:680,
			  		  height:410,
			  		  closeURL:"${ctx}/identity/user/selectUser.jspx?pageIndex=${pageModel.pageIndex}&name=${user.name}&phone=${user.phone}&dept.id=${user.dept.id}&job.code=${user.job.code}",
			  		  iframeURL:"${ctx}/identity/user/showUpdateUser.jspx?userId="+userId
				});
			}
     
</script>
</head>
<body style="overflow: hidden; width: 98%; height: 100%;" >
   	<!-- 工具按钮区 -->
	<form class="form-horizontal" 
			action="${ctx}/identity/user/selectUser.jspx" method="post" style="padding-left: 5px;" >
			<table class="table-condensed">
					<tbody>
					<tr>
					   <td>
						<input name="name" type="text" class="form-control"
							placeholder="姓名" value="${user.name}" >
						</td>
						<td>	
						<input type="text" name="phone" class="form-control"
							placeholder="手机号码" value="${user.phone}" >
						</td>
<!-- 						<td>	 -->
<!-- 						   <input type="text" class="form-control" placeholder="状态"> -->
<!-- 						</td> -->
						<td>	
						<select class="btn btn-default"
							placeholder="部门" id="deptSelect" name="dept.id">
							<option value="0" >==请选择部门==</option>
						</select>
						</td>
						<td>	
						<select class="btn btn-default"
							placeholder="职位" id="jobSelect" name="job.code">
							<option value="0">==请选择职位==</option>
						</select>
						</td>
						<td>	
						<button type="submit" id="selectUser" class="opea btn btn-info"><span class="glyphicon glyphicon-search"></span>&nbsp;查询</button>
						<a  id="addUser" class="opea btn btn-success"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加</a>
					    <a  id="deleteUser" class="opea btn btn-danger"><span class="glyphicon glyphicon-remove"></span>&nbsp;删除</a>
					 </td>
					</tr>
					</tbody>
				</table>
		</form>
 		<div class="panel panel-primary" style="padding-left: 10px;">
 			<div class="panel-heading" style="background-color: #11a9e2;">
				<h3 class="panel-title">用户信息列表</h3>
			</div>
			<div class="panel-body" >
				<table class="table table-bordered">
					<thead>
						<tr style="font-size: 12px;" align="center">
							<th style="text-align: center;"><input id="checkAll" type="checkbox"/></th>
							<th style="text-align: center;">账户</th>
							<th style="text-align: center;">姓名</th>
							<th style="text-align: center;">性别</th>
							<th style="text-align: center;">部门</th>
							<th style="text-align: center;">职位</th>
							<th style="text-align: center;">手机号码</th>
							<th style="text-align: center;">邮箱</th>
							<th id="activeUser" class="opea" style="text-align: center;">激活状态</th>
							<th style="text-align: center;">审核人</th>
							<th style="text-align: center;">操作</th>
						</tr>
					</thead>
					 <c:forEach items="${users}" var="user" varStatus="stat">
					    	<tr id="dataTr_${stat.index}" align="center" style="cursor:pointer;">
							<td><input type="checkbox" name="box" id="box_${stat.index}"
								value="${user.userId}" /></td>
							<td>${user.userId}</td>
							<td>${user.name}</td>
							<td>${user.sex == 1 ? '男' : '女' }</td>
							<td>${user.dept.name}</td>
							<td>${user.job.name}</td>
							<td>${user.phone}</td>
							<td>${user.email}</td>
							<td id="activeUser" class="opea">
								<c:if test="${user.status == 1 }">
									<input id="checkUser_${user.userId}" value="${user.userId}" name="status" class="easyui-switchbutton" data-options="onText:'激活',offText:'冻结'" checked>
								</c:if>
								<c:if test="${user.status != 1 }">
									<input id="checkUser_${user.userId}" value="${user.userId}" name="status" class="easyui-switchbutton" data-options="onText:'激活',offText:'冻结'" >
								</c:if>
						    </td>
								<td><%-- ${user.checker.name} --%></td>
							<td>
							   <span id="updateUser_${stat.index}"  class="opea label label-info"><a href="javascript:updateUser('${user.userId}')" style="color: white;">修改</a></span>
							   <span id="preUser_${stat.index}" class="opea label label-success"><a href="javascript:preUser('${user.userId}')"  style="color: white;">预览</a></span>
							</td>
						</tr>
					 </c:forEach>

				</table>	
			</div>
                 <!--  
        pageIndex:当前页码
        pageSize：每页显示的记录数
        recordNum：总记录数
        submitUrl：提交地址
    -->
       <p:page pageIndex="${pageModel.pageIndex}" pageStyle="flickr" pageSize="${pageModel.pageSize}" recordNum="${pageModel.recordCount}" submitUrl="${ctx}/identity/user/selectUser.jspx?pageIndex={0}&name=${user.name}&phone=${user.phone}&dept.id=${user.dept.id}&job.code=${user.job.code}"></p:page>
    
		</div>
		
		<div id="divDialog" style="display: none;" >
			 <!-- 放置一个添加用户的界面  -->
			 <iframe id="iframe"  frameborder="0" style="width: 100%;height: 100%;"></iframe>
		</div>
	
</body>
</html>