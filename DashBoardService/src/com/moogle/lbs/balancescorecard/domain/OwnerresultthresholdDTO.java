package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;

@Entity
public class OwnerresultthresholdDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private OwnerresultthresholdDTOPK id;
	private String actualValue;
	private String targetValue;
	private String percentActualVsTarget;
	private String beginThreshold;
	private String endThreshold;
	private String colorCode;
	private String kpiOwnerName;
	
	
	
	public String getKpiOwnerName() {
		return kpiOwnerName;
	}
	public void setKpiOwnerName(String kpiOwnerName) {
		this.kpiOwnerName = kpiOwnerName;
	}
	public OwnerresultthresholdDTOPK getId() {
		return id;
	}
	public void setId(OwnerresultthresholdDTOPK id) {
		this.id = id;
	}
	public String getActualValue() {
		return actualValue;
	}
	public void setActualValue(String actualValue) {
		this.actualValue = actualValue;
	}
	public String getTargetValue() {
		return targetValue;
	}
	public void setTargetValue(String targetValue) {
		this.targetValue = targetValue;
	}
	public String getPercentActualVsTarget() {
		return percentActualVsTarget;
	}
	public void setPercentActualVsTarget(String percentActualVsTarget) {
		this.percentActualVsTarget = percentActualVsTarget;
	}
	public String getBeginThreshold() {
		return beginThreshold;
	}
	public void setBeginThreshold(String beginThreshold) {
		this.beginThreshold = beginThreshold;
	}
	public String getEndThreshold() {
		return endThreshold;
	}
	public void setEndThreshold(String endThreshold) {
		this.endThreshold = endThreshold;
	}
	public String getColorCode() {
		return colorCode;
	}
	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	} 
	

}
