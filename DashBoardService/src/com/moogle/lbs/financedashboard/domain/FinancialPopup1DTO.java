package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialPopup1DTO implements Serializable {
	/**
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private String subCategory;
	private String thisActual;
	public String getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	public String getThisActual() {
		return thisActual;
	}
	public void setThisActual(String thisActual) {
		this.thisActual = thisActual;
	}

}
