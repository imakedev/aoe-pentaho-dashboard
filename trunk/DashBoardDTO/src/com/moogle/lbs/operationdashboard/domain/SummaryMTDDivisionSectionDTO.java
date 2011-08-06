package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class SummaryMTDDivisionSectionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String area ;
	private String salesTargetAmt ;
	private String netSalesAmt;
	private String lastNetSalesAmt;
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getSalesTargetAmt() {
		return salesTargetAmt;
	}
	public void setSalesTargetAmt(String salesTargetAmt) {
		this.salesTargetAmt = salesTargetAmt;
	}
	public String getNetSalesAmt() {
		return netSalesAmt;
	}
	public void setNetSalesAmt(String netSalesAmt) {
		this.netSalesAmt = netSalesAmt;
	}
	public String getLastNetSalesAmt() {
		return lastNetSalesAmt;
	}
	public void setLastNetSalesAmt(String lastNetSalesAmt) {
		this.lastNetSalesAmt = lastNetSalesAmt;
	}
	
}
