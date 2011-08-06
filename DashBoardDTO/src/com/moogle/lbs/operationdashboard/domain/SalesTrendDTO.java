package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class SalesTrendDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String	salesDate;
	private String actualVSTarget;
	private String	target;
	private String	netSalesLast;
	private String growth;
	public String getSalesDate() {
		return salesDate;
	}
	public void setSalesDate(String salesDate) {
		this.salesDate = salesDate;
	}
	public String getActualVSTarget() {
		return actualVSTarget;
	}
	public void setActualVSTarget(String actualVSTarget) {
		this.actualVSTarget = actualVSTarget;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getNetSalesLast() {
		return netSalesLast;
	}
	public void setNetSalesLast(String netSalesLast) {
		this.netSalesLast = netSalesLast;
	}
	public String getGrowth() {
		return growth;
	}
	public void setGrowth(String growth) {
		this.growth = growth;
	}
	
}
