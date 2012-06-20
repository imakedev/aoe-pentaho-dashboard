package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialMixDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	 
	private String sumThisYearActualMonthly;
	private String sumThisYearBudgetMONTHLY;
	private String sumLastYearActualMONTHLY;
	private String percentVarianceMONTHLY;
	private String percentGrowthMONTHLY ;
	public String getSumThisYearActualMonthly() {
		return sumThisYearActualMonthly;
	}
	public void setSumThisYearActualMonthly(String sumThisYearActualMonthly) {
		this.sumThisYearActualMonthly = sumThisYearActualMonthly;
	}
	public String getSumThisYearBudgetMONTHLY() {
		return sumThisYearBudgetMONTHLY;
	}
	public void setSumThisYearBudgetMONTHLY(String sumThisYearBudgetMONTHLY) {
		this.sumThisYearBudgetMONTHLY = sumThisYearBudgetMONTHLY;
	}
	public String getSumLastYearActualMONTHLY() {
		return sumLastYearActualMONTHLY;
	}
	public void setSumLastYearActualMONTHLY(String sumLastYearActualMONTHLY) {
		this.sumLastYearActualMONTHLY = sumLastYearActualMONTHLY;
	}
	public String getPercentVarianceMONTHLY() {
		return percentVarianceMONTHLY;
	}
	public void setPercentVarianceMONTHLY(String percentVarianceMONTHLY) {
		this.percentVarianceMONTHLY = percentVarianceMONTHLY;
	}
	public String getPercentGrowthMONTHLY() {
		return percentGrowthMONTHLY;
	}
	public void setPercentGrowthMONTHLY(String percentGrowthMONTHLY) {
		this.percentGrowthMONTHLY = percentGrowthMONTHLY;
	} 
	

}
