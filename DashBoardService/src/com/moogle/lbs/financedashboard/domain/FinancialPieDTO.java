package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialPieDTO  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String thisActual;
    private String thisBudget;
    private String lastActual;
    private String lastBudget;
    private String twoLastActual;
    private String revenueGroupDesc;
	public String getThisActual() {
		return thisActual;
	}
	public void setThisActual(String thisActual) {
		this.thisActual = thisActual;
	}
	public String getThisBudget() {
		return thisBudget;
	}
	public void setThisBudget(String thisBudget) {
		this.thisBudget = thisBudget;
	}
	public String getLastActual() {
		return lastActual;
	}
	public void setLastActual(String lastActual) {
		this.lastActual = lastActual;
	}
	public String getLastBudget() {
		return lastBudget;
	}
	public void setLastBudget(String lastBudget) {
		this.lastBudget = lastBudget;
	}
	public String getTwoLastActual() {
		return twoLastActual;
	}
	public void setTwoLastActual(String twoLastActual) {
		this.twoLastActual = twoLastActual;
	}
	public String getRevenueGroupDesc() {
		return revenueGroupDesc;
	}
	public void setRevenueGroupDesc(String revenueGroupDesc) {
		this.revenueGroupDesc = revenueGroupDesc;
	}
    
}
