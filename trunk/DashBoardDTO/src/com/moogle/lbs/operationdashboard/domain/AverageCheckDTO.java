package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;
public class AverageCheckDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String	avgCheckLast;
	private String avgCheckThis;
	private String growth;
	public String getAvgCheckLast() {
		return avgCheckLast;
	}
	public void setAvgCheckLast(String avgCheckLast) {
		this.avgCheckLast = avgCheckLast;
	}
	public String getAvgCheckThis() {
		return avgCheckThis;
	}
	public void setAvgCheckThis(String avgCheckThis) {
		this.avgCheckThis = avgCheckThis;
	}
	public String getGrowth() {
		return growth;
	}
	public void setGrowth(String growth) {
		this.growth = growth;
	}
	
}
