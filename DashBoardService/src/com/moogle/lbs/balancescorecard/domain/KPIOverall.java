package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

public class KPIOverall implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	//OwnerResult
	private BigDecimal actualValue;
	private BigDecimal targetValue;
	private BigDecimal percentActualVsTarget;
	
	//KPIResultThreshold
	private BigDecimal beginThreshold;
	private BigDecimal endThreshold;
	private String colorCode;
	public BigDecimal getActualValue() {
		return actualValue;
	}
	public void setActualValue(BigDecimal actualValue) {
		this.actualValue = actualValue;
	}
	public BigDecimal getTargetValue() {
		return targetValue;
	}
	public void setTargetValue(BigDecimal targetValue) {
		this.targetValue = targetValue;
	}
	public BigDecimal getPercentActualVsTarget() {
		return percentActualVsTarget;
	}
	public void setPercentActualVsTarget(BigDecimal percentActualVsTarget) {
		this.percentActualVsTarget = percentActualVsTarget;
	}
	public BigDecimal getBeginThreshold() {
		return beginThreshold;
	}
	public void setBeginThreshold(BigDecimal beginThreshold) {
		this.beginThreshold = beginThreshold;
	}
	public BigDecimal getEndThreshold() {
		return endThreshold;
	}
	public void setEndThreshold(BigDecimal endThreshold) {
		this.endThreshold = endThreshold;
	}
	public String getColorCode() {
		return colorCode;
	}
	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
	
}
