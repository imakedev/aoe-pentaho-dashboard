package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class CostDTO  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String	productGroup;
	private String costAmt; 
	private String costAmtLastYear;
	public String getProductGroup() {
		return productGroup;
	}
	public void setProductGroup(String productGroup) {
		this.productGroup = productGroup;
	}
	public String getCostAmt() {
		return costAmt;
	}
	public void setCostAmt(String costAmt) {
		this.costAmt = costAmt;
	}
	public String getCostAmtLastYear() {
		return costAmtLastYear;
	}
	public void setCostAmtLastYear(String costAmtLastYear) {
		this.costAmtLastYear = costAmtLastYear;
	}
	
}
