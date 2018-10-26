package common.util.webTag;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @author CHUNLONG.LUO
 * @email 584614151@qq.com
 * @date 2017年10月25日
 * @version 1.0
 * 网站: <a href="http://www.crazyit.org">疯狂Java联盟</a>
 */
public class PageTag extends TagSupport {

	private Integer pageIndex;//当前页码
	private Integer pageSize;//每页显示的记录数  
	private Integer recordNum;//总记录数             
	private String submitUrl;//提交地址   index.action?pageIndex={0}
	private String pageStyle = "digg";
	
	

	@Override
	public int doStartTag() throws JspException {
		// TODO Auto-generated method stub
		//JspWriter：用于将指定的信息，输出值jsp页面
		try {
			
		JspWriter out = this.pageContext.getOut();

		//创建StringBuffer:用于拼接页码信息
		StringBuffer pager = new StringBuffer();
		
		//判断总记录数是否大于0  
		if(this.getRecordNum() >0){
			
			StringBuffer pageBuffer = new StringBuffer();
			
			//计算总页码
			int totalPageNum = this.recordNum % this.pageSize == 0 ? this.recordNum / this.pageSize : (this.recordNum / this.pageSize)+1;
			
			//用于指定最终跳转地址
			String  jumpUrl = "";
			
			//判断当前页码是第一页
			if(this.pageIndex == 1){
				pageBuffer.append("<span class='disabled'>上一页</span>");
			
				 //计算中间页码  1 - 100
                 calcMiddlePage(pageBuffer,totalPageNum);
				
				
				if(this.pageIndex == totalPageNum){
					//当前页码是第一页，并且等于总页码，因此总共就一页，下一页不能点
					pageBuffer.append("<span class='disabled'>下一页</span>");
				}else{
					jumpUrl = submitUrl.replace("{0}", String.valueOf(this.pageIndex + 1));
					//下一页可以点击
					pageBuffer.append("<a href='"+jumpUrl+"'>下一页</a>");
				}
				
			
		     //当前页码是最后一页
			}else if(this.pageIndex == totalPageNum){
				jumpUrl = submitUrl.replace("{0}", String.valueOf(this.pageIndex - 1));
				pageBuffer.append("<a href='"+jumpUrl+"'>上一页</a>");
				
				//计算中间页码
				calcMiddlePage(pageBuffer,totalPageNum);
				
				pageBuffer.append("<span class='disabled'>下一页</span>");
				
				
			}else{
				//当前页码既不是首页，也不是尾页
				jumpUrl = submitUrl.replace("{0}", String.valueOf(this.pageIndex - 1));
				pageBuffer.append("<a href='"+jumpUrl+"'>上一页</a>");
				
				//计算中间页码
				calcMiddlePage(pageBuffer,totalPageNum);
				
				
				jumpUrl = submitUrl.replace("{0}", String.valueOf(this.pageIndex + 1));
				//下一页可以点击
				pageBuffer.append("<a href= '"+jumpUrl+"'>下一页</a>");
				
			}
			
			int startSize = (this.pageIndex - 1) * this.pageSize +1;
			int endSize = this.pageIndex == totalPageNum ? this.recordNum : this.pageIndex * this.pageSize;
		
			
			pager.append("<table class='"+this.getPageStyle()+"' style='width:100%;font-size:16px;'><tr><td>"+pageBuffer.toString()+" 跳转到<input type='text' size='2' id='jump_num'/><input type='button' id='jump_page' value='跳转'/></td></tr>");
			pager.append("<tr><td>总共<font color='red'>"+this.recordNum+"</font>条记录,当前显示"+startSize+"-"+endSize+"条记录</td></tr>");
			pager.append("</table>");
			
			pager.append("<script type='text/javascript'>");
			pager.append("document.getElementById('jump_page').onclick = function(){");
			pager.append("var value = document.getElementById('jump_num').value;");
			pager.append("if(!/^[1-9]\\d*$/.test(value)||value > "+totalPageNum+"){");
			pager.append("alert('请输入[1-"+totalPageNum+"]之间的页码值！');");
			pager.append("}else{");
			// index.action?pageIndex = {0}
			pager.append("var submiturl = '"+this.submitUrl+"';");
			pager.append("submiturl = submiturl.replace('{0}',value);");
			pager.append("window.location = submiturl;");
			
			pager.append("}");
			
			pager.append("}");
			
			
			
			pager.append("</script>");
		}else{
			
			//没有对应的记录，无需画分页标签
			pager.append("<table class='"+this.getPageStyle()+"' style='width:100%;font-size:16px;'><tr><td>总共<font color='red'>0</font>条记录,当前显示0-0条记录</td></tr></table>");
			
		}
			//将数据通过  JspWriter写出至指定的页面
			out.write(pager.toString());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		
		return SKIP_BODY;
	}
	
	
	
    //计算中间页码   
	public void calcMiddlePage(StringBuffer pageBuffer,int totalPageNum) {
		// TODO Auto-generated method stub
		//定义最终跳转的地址
		String jumpUrl = "";
		//如果总页码小于等于10页，则全部显示  1 2 3 4 5 6 7 8 9 10
		if(totalPageNum <= 10){
			for (int i = 1; i <= totalPageNum; i++) {
				//判断i是否等于当前页码，因为当前页码不能点击
				if(i==this.pageIndex){
					pageBuffer.append("<span class='current'>"+i+"</span>");
				}else{
					jumpUrl = this.submitUrl.replace("{0}", String.valueOf(i));
					pageBuffer.append("<a href='"+jumpUrl+"'>"+i+"</a>");
				}
				
			}
		}else{
			//当前页码靠近首页  1 2 3 4 5 6 7 8  ... 100
			if(this.pageIndex <=8){
				//判断i是否等于当前页码，因为当前页码不能点击
				for (int i = 1; i <= 9; i++) {
					
					if(i==this.pageIndex){
						pageBuffer.append("<span class='current'>"+i+"</span>");
					}else{
						jumpUrl = this.submitUrl.replace("{0}", String.valueOf(i));
						pageBuffer.append("<a href='"+jumpUrl+"'>"+i+"</a>");
					}
				}
				
				pageBuffer.append("....");
				
				//拼装尾页
				jumpUrl = this.submitUrl.replace("{0}", String.valueOf(totalPageNum));
				pageBuffer.append("<a href='"+jumpUrl+"'>"+totalPageNum+"</a>");
				
			}else if(this.pageIndex +8 >= totalPageNum){
				//当前页码靠近尾页 1 ...  92 93 94 95 96 97 98 99 100
				//拼装第一页
				jumpUrl = this.submitUrl.replace("{0}", String.valueOf(1));
				pageBuffer.append("<a href='"+jumpUrl+"'>"+totalPageNum+"</a>");
				
				pageBuffer.append("...");
				
				
				for (int i = totalPageNum - 9; i <= totalPageNum; i++) {
					if(i==this.pageIndex){
						pageBuffer.append("<span class='current'>"+i+"</span>");
					}else{
						jumpUrl = this.submitUrl.replace("{0}", String.valueOf(i));
						pageBuffer.append("<a href='"+jumpUrl+"'>"+i+"</a>");
					}
				}
			}else{
				
				//当前页码靠近中间   1 ... 41 42 43 44 45 46 47 48 49 ... 100
				//拼装第一页
				jumpUrl = this.submitUrl.replace("{0}", String.valueOf(1));
				pageBuffer.append("<a href='"+jumpUrl+"'>"+1+"</a>");
				
				pageBuffer.append("...");
				
				
				for (int i = this.pageIndex-4; i <= this.pageIndex+4; i++) {
					if(i==this.pageIndex){
						pageBuffer.append("<span class='current'>"+i+"</span>");
					}else{
						jumpUrl = this.submitUrl.replace("{0}", String.valueOf(i));
						pageBuffer.append("<a href='"+jumpUrl+"'>"+i+"</a>");
					}
				}
				
				pageBuffer.append("...");
				//拼装尾页
				jumpUrl = this.submitUrl.replace("{0}", String.valueOf(totalPageNum));
				pageBuffer.append("<a href='"+jumpUrl+"'>"+totalPageNum+"</a>");
			}
			
			
			
		}
		
	}




	public Integer getPageIndex() {
		return pageIndex;
	}


	public void setPageIndex(Integer pageIndex) {
		System.out.println("pageIndex:"+pageIndex);
		if(pageIndex == null){
			pageIndex = 1;
		}
		this.pageIndex = pageIndex;
	}


	public Integer getPageSize() {
		return pageSize;
	}


	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}


	public Integer getRecordNum() {
		return recordNum;
	}


	public void setRecordNum(Integer recordNum) {
		this.recordNum = recordNum;
	}


	public String getSubmitUrl() {
		return submitUrl;
	}


	public void setSubmitUrl(String submitUrl) {
		this.submitUrl = submitUrl;
	}



	public String getPageStyle() {
		return pageStyle;
	}



	public void setPageStyle(String pageStyle) {
		this.pageStyle = pageStyle;
	}
	
	
	
    
	
}
