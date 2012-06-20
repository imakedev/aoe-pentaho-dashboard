package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialMixPercentDTO  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	 
	private String sumThisYearActualMonthlyPercent;
	private String sumThisYearBudgetMONTHLYPercent;
	private String sumLastYearActualMONTHLYPercent;
	public String getSumThisYearActualMonthlyPercent() {
		return sumThisYearActualMonthlyPercent;
	}
	public void setSumThisYearActualMonthlyPercent(
			String sumThisYearActualMonthlyPercent) {
		this.sumThisYearActualMonthlyPercent = sumThisYearActualMonthlyPercent;
	}
	public String getSumThisYearBudgetMONTHLYPercent() {
		return sumThisYearBudgetMONTHLYPercent;
	}
	public void setSumThisYearBudgetMONTHLYPercent(
			String sumThisYearBudgetMONTHLYPercent) {
		this.sumThisYearBudgetMONTHLYPercent = sumThisYearBudgetMONTHLYPercent;
	}
	public String getSumLastYearActualMONTHLYPercent() {
		return sumLastYearActualMONTHLYPercent;
	}
	public void setSumLastYearActualMONTHLYPercent(
			String sumLastYearActualMONTHLYPercent) {
		this.sumLastYearActualMONTHLYPercent = sumLastYearActualMONTHLYPercent;
	}
 

}
