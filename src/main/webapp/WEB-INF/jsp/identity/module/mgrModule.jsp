<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>办公管理系统-菜单管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate" />
<meta name="Keywords" content="keyword1,keyword2,keyword3" />
<meta name="Description" content="网页信息的描述" />
<meta name="Author" content="fkjava.org" />
<meta name="Copyright" content="All Rights Reserved." />
<link href="${ctx}/fkjava.ico" rel="shortcut icon" type="image/x-icon" />

<link rel="stylesheet" href="${ctx}/resources/easyUI/easyui.css">
<script type="text/javascript" src="${ctx }/resources/jquery/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="${ctx }/resources/jquery/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/easyUI/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/resources/dtree/dtree.css"/>
<script type="text/javascript" src="${ctx}/resources/dtree/dtree.js"></script>
<script type="text/javascript">

   $(function(){
	   
	   resh();
   })
   
   function resh(){
	   
	   d = new dTree('d','${ctx}');
		// d.add("自已的id", "父级id", "树节点显示的名称");
		// code: 0001-- "0" code: 00010001 -- > "0001"
		// [{"id" : "0001", "pId" : "根据code长度计算出来", "name" : ""}]
		d.add("0",-1,'系统模块树');
		d.add("1","0","全部","javascript:refurbishRight('')");
		
		$.ajax({
			method:'post',
			url:'${ctx}/identity/module/ajaxModule.jspx',
			dataType:'json',
			success:function(data){
				$.each(data,function(){
					d.add(this.code,this.pcode,this.name,"javascript:refurbishRight('"+this.code+"')",this.name);
				})
				$("#tree").html(d.toString());
			},error:function(){
				$.messager.alert('信息','网络异常','error');
			}
		})
	   
   }
   
   //改变iframe属性，用于重新加载右侧页面
   function refurbishRight(code){
	   
	   $("#sonModules").prop("src","${ctx}/identity/module/getModulesByParent.jspx?parentCode="+code);
   }

</script>
</head>
    <body class="easyui-layout" style="width:100%;height:100%;">
			<div id="tree" data-options="region:'west'" title="菜单模块树" style="width:20%;padding:10px">
				 <!-- 展示所有的模块树  -->
				
			</div>
			
			<div data-options="region:'center'" title="模块菜单"  >
			     <!-- 展示当前模块下的子模块  -->
			     <iframe src="${ctx}/identity/module/getModulesByParent.jspx" frameborder="0" id="sonModules"  width="100%" height="100%" ></iframe>
			</div>
	</body>
</html>
