package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class AverageSalesPerBillDTO  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String salesPerBillLast;
	private String salesPerBillThis;
	private String growth;
	public String getSalesPerBillLast() {
		return salesPerBillLast;
	}
	public void setSalesPerBillLast(String salesPerBillLast) {
		this.salesPerBillLast = salesPerBillLast;
	}
	public String getSalesPerBillThis() {
		return salesPerBillThis;
	}
	public void setSalesPerBillThis(String salesPerBillThis) {
		this.salesPerBillThis = salesPerBillThis;
	}
	public String getGrowth() {
		return growth;
	}
	public void setGrowth(String growth) {
		this.growth = growth;
	}
	

}
