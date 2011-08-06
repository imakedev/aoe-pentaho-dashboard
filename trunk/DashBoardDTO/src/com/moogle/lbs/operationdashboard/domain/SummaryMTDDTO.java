package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class SummaryMTDDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String division;
	private String salesTargetAmt;
	private String netSalesAmt;
	private String lastNetSalesAmt ;
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
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
