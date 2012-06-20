package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class NetSalesByProductGroupDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String	productGroup;
	private String netSales;
	private String vsly;
	private String vsplan;
	public String getProductGroup() {
		return productGroup;
	}
	public void setProductGroup(String productGroup) {
		this.productGroup = productGroup;
	}
	public String getNetSales() {
		return netSales;
	}
	public void setNetSales(String netSales) {
		this.netSales = netSales;
	}
	public String getVsly() {
		return vsly;
	}
	public void setVsly(String vsly) {
		this.vsly = vsly;
	}
	public String getVsplan() {
		return vsplan;
	}
	public void setVsplan(String vsplan) {
		this.vsplan = vsplan;
	}
	
}
