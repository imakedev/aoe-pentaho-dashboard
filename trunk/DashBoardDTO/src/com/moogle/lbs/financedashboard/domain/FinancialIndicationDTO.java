package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;

public class FinancialIndicationDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String ratioGroupName;
	private String ratioName;
	private String thisPeriodValue;
	private String  trendFlag ;
	public String getRatioGroupName() {
		return ratioGroupName;
	}
	public void setRatioGroupName(String ratioGroupName) {
		this.ratioGroupName = ratioGroupName;
	}
	public String getRatioName() {
		return ratioName;
	}
	public void setRatioName(String ratioName) {
		this.ratioName = ratioName;
	}
	public String getThisPeriodValue() {
		return thisPeriodValue;
	}
	public void setThisPeriodValue(String thisPeriodValue) {
		this.thisPeriodValue = thisPeriodValue;
	}
	public String getTrendFlag() {
		return trendFlag;
	}
	public void setTrendFlag(String trendFlag) {
		this.trendFlag = trendFlag;
	}
	
	
}
