package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class RegionGrowthDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String region;
	private String lastSalesAmt;
	private String thisSalesAmt;
	private String growth;
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getLastSalesAmt() {
		return lastSalesAmt;
	}
	public void setLastSalesAmt(String lastSalesAmt) {
		this.lastSalesAmt = lastSalesAmt;
	}
	public String getThisSalesAmt() {
		return thisSalesAmt;
	}
	public void setThisSalesAmt(String thisSalesAmt) {
		this.thisSalesAmt = thisSalesAmt;
	}
	public String getGrowth() {
		return growth;
	}
	public void setGrowth(String growth) {
		this.growth = growth;
	}
	
}
