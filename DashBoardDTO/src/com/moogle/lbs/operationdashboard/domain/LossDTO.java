package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class LossDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String branchName;
	private String gpamt;
	private String percentGP;
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getGpamt() {
		return gpamt;
	}
	public void setGpamt(String gpamt) {
		this.gpamt = gpamt;
	}
	public String getPercentGP() {
		return percentGP;
	}
	public void setPercentGP(String percentGP) {
		this.percentGP = percentGP;
	}
	
}
