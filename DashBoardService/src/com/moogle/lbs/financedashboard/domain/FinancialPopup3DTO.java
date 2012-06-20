package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialPopup3DTO  implements Serializable {
	/**
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private String subCategory;
	private String percentActual;
	private String percentBudget;
	private String percentLastPeriodActual;
	public String getPercentActual() {
		return percentActual;
	}
	public void setPercentActual(String percentActual) {
		this.percentActual = percentActual;
	}
	public String getPercentBudget() {
		return percentBudget;
	}
	public void setPercentBudget(String percentBudget) {
		this.percentBudget = percentBudget;
	}
	public String getPercentLastPeriodActual() {
		return percentLastPeriodActual;
	}
	public void setPercentLastPeriodActual(String percentLastPeriodActual) {
		this.percentLastPeriodActual = percentLastPeriodActual;
	}
	public String getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	
}

