package common.util.webTag;


/**
 * @Version 1.0
 * @Time 2016年3月10日/上午11:25:56
 * @From www.fkjava.org
 *  分页实体 
 */
public class PageModel {
	
	/** 分页中默认一个4条数据 */
	public static final int PAGE_DEFAULT_SIZE = 4;
	
	/** 分页总数据条数  */
	private int recordCount;
	/** 当前页面 */
	private int pageIndex =1;
	/** 每页分多少条数据   */
	private int pageSize = PAGE_DEFAULT_SIZE;
	
	/** 总页数  */
	private int totalSize;

	public int getRecordCount() {
		this.recordCount = this.recordCount <= 0 ? 0:this.recordCount;
		return recordCount;
	}
	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}
	public int getPageIndex() {
		
		
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageSize() {
		this.pageSize = this.pageSize <= PAGE_DEFAULT_SIZE?PAGE_DEFAULT_SIZE:this.pageSize;
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getTotalSize() {
		if(this.getRecordCount() <=0){
			totalSize = 0 ;
		}else{
			totalSize = (this.getRecordCount() -1)/this.getPageSize() + 1;
		}
		return totalSize;
	}
	
	public int getFirstLimitParam(){
		return (this.getPageIndex()-1)*this.getPageSize() ;
	}
	
}
