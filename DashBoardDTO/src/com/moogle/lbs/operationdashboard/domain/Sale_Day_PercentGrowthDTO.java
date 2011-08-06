package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class Sale_Day_PercentGrowthDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String branchName;
	private String sales;
	private String lastSales;
	private String diffSales;
	private String percentGrowth;
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getSales() {
		return sales;
	}
	public void setSales(String sales) {
		this.sales = sales;
	}
	public String getLastSales() {
		return lastSales;
	}
	public void setLastSales(String lastSales) {
		this.lastSales = lastSales;
	}
	public String getDiffSales() {
		return diffSales;
	}
	public void setDiffSales(String diffSales) {
		this.diffSales = diffSales;
	}
	public String getPercentGrowth() {
		return percentGrowth;
	}
	public void setPercentGrowth(String percentGrowth) {
		this.percentGrowth = percentGrowth;
	}
	
}
