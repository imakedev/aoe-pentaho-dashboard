package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialSummaryDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mno;
	private String mname;
	private String sumThisYearActualMonthly;
	private String sumThisYearBudgetMONTHLY;
	private String sumLastYearActualMONTHLY;
	private String percentVarianceMONTHLY;
	private String percentGrowthMONTHLY ;
	public String getMno() {
		return mno;
	}
	public void setMno(String mno) {
		this.mno = mno;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
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
