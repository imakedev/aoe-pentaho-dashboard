package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class DiscountDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String	discountThisYear;
	private String discountLastYear;
	private String plan;
	public String getDiscountThisYear() {
		return discountThisYear;
	}
	public void setDiscountThisYear(String discountThisYear) {
		this.discountThisYear = discountThisYear;
	}
	public String getDiscountLastYear() {
		return discountLastYear;
	}
	public void setDiscountLastYear(String discountLastYear) {
		this.discountLastYear = discountLastYear;
	}
	public String getPlan() {
		return plan;
	}
	public void setPlan(String plan) {
		this.plan = plan;
	}
	
}
