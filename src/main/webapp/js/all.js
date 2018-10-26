(function(){
	 $(function(){
		 
		//得到所有checkbox
	    	var boxes = $("input[type='checkbox'][id^='box_']")
	    	
	    	$("tr[id^=dataTr_]").hover(function(){
	    			$(this).css("backgroundColor","gray");
	    		
	    	},function(){
	    		var trId = this.id;
	    		var boxId = trId.replace("dataTr","box");
	    		
	    		var flag = $("#"+boxId).prop("checked");
	    		if(!flag){
	    			$(this).css("backgroundColor","while");
	    		}
	    	}).click(function(){
	    		var trId = this.id;
	    		var boxId = trId.replace("dataTr","box");
	    		
	    		$("#"+boxId).prop("checked",!$("#"+boxId).prop("checked"));
	    		 //判断全选是否需要选中
		      $("#checkAll").prop("checked",boxes.length == boxes.filter(":checked").length);
	    	})
	    	
	    	//全选
	    	$("#checkAll").click(function(){
	    		  boxes.prop("checked",$(this).prop("checked"));
	    		  $("tr[id^='dataTr_']").trigger(this.checked?"mouseover":"mouseout");
	    	})
	    	
	    	
	    	boxes.click(function(e){
	    		e.stopPropagation();
	    		$("#checkAll").prop("checked",boxes.length==boxes.filter(":checked").length)
	    	})
	 })
	 
	
})()

 function addDialog(jsonObj){
	    	  
	    	  $("#divDialog").dialog({
	    			title : jsonObj.title, // 标题
	    			cls : "easyui-dialog", // class
	    			width : jsonObj.width, // 宽度
	    			height : jsonObj.height, // 高度
	    			maximizable : true, // 最大化
	    			minimizable : false, // 最小化
	    			collapsible : true, // 可伸缩
	    			modal : true, // 模态窗口   
	    			onClose : function(){ // 关闭窗口
	    				//窗口关闭之后，继续查询用户列表
	    				window.location = jsonObj.closeURL;
	    			},
	    		});
	    	  $("#iframe").attr("src",jsonObj.iframeURL);
	      }