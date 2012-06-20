package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class CustomerPerDayDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String customerPerDayLast;
	private String customerPerDayThis;
	private String growth;
	public String getCustomerPerDayLast() {
		return customerPerDayLast;
	}
	public void setCustomerPerDayLast(String customerPerDayLast) {
		this.customerPerDayLast = customerPerDayLast;
	}
	public String getCustomerPerDayThis() {
		return customerPerDayThis;
	}
	public void setCustomerPerDayThis(String customerPerDayThis) {
		this.customerPerDayThis = customerPerDayThis;
	}
	public String getGrowth() {
		return growth;
	}
	public void setGrowth(String growth) {
		this.growth = growth;
	}
	
	
}
