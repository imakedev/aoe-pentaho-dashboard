package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class NetSalesByBranchStatusDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String lastNetSales;
	private String netSales;
	private String percentGrowth;
	public String getLastNetSales() {
		return lastNetSales;
	}
	public void setLastNetSales(String lastNetSales) {
		this.lastNetSales = lastNetSales;
	}
	public String getNetSales() {
		return netSales;
	}
	public void setNetSales(String netSales) {
		this.netSales = netSales;
	}
	public String getPercentGrowth() {
		return percentGrowth;
	}
	public void setPercentGrowth(String percentGrowth) {
		this.percentGrowth = percentGrowth;
	}
	
}
