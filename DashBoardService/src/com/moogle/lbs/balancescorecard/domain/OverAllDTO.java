package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;

public class OverAllDTO implements Serializable { 
	private static final long serialVersionUID = 1L;
	private String percentActualVsTarget;
    private String systemScore;
    private String maxSystemScore; 
    private String BeginThreshold; 
    private String EndThreshold;
    private String SystemColorCode;
	public String getPercentActualVsTarget() {
		return percentActualVsTarget;
	}
	public void setPercentActualVsTarget(String percentActualVsTarget) {
		this.percentActualVsTarget = percentActualVsTarget;
	}
	public String getSystemScore() {
		return systemScore;
	}
	public void setSystemScore(String systemScore) {
		this.systemScore = systemScore;
	}
	public String getMaxSystemScore() {
		return maxSystemScore;
	}
	public void setMaxSystemScore(String maxSystemScore) {
		this.maxSystemScore = maxSystemScore;
	}
	public String getBeginThreshold() {
		return BeginThreshold;
	}
	public void setBeginThreshold(String beginThreshold) {
		BeginThreshold = beginThreshold;
	}
	public String getEndThreshold() {
		return EndThreshold;
	}
	public void setEndThreshold(String endThreshold) {
		EndThreshold = endThreshold;
	}
	public String getSystemColorCode() {
		return SystemColorCode;
	}
	public void setSystemColorCode(String systemColorCode) {
		SystemColorCode = systemColorCode;
	}
    
}
