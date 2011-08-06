package com.moogle.lbs.operationdashboard.domain;

import java.io.Serializable;

public class GoogleMapDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	 private String branchCode;
	 private String branchName;
	 private String subDistrict;
	 private String district;
	 private String province;
	 private String region;
	 private String netSalesAmt;
	 private String targetAmt;
	public String getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getSubDistrict() {
		return subDistrict;
	}
	public void setSubDistrict(String subDistrict) {
		this.subDistrict = subDistrict;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getNetSalesAmt() {
		return netSalesAmt;
	}
	public void setNetSalesAmt(String netSalesAmt) {
		this.netSalesAmt = netSalesAmt;
	}
	public String getTargetAmt() {
		return targetAmt;
	}
	public void setTargetAmt(String targetAmt) {
		this.targetAmt = targetAmt;
	}
	 
}
