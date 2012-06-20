package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.util.List;

public class KpiresultthresholdTreeDTO  implements Serializable{

	/**
	 * 
	 */ 
	private String kpiCode;
	private String parentKpiCode ;
	private String kpiName;
	private String ownerWeighting;
	private String perspectiveWeighting;
	private String frequency;
	private String targetValue;
	private String actualValue;
	private String percentActualVsTarget;
	private String systemScore;
	private String systemColorCode ;
	private String updatedDT;
	private String accumulatedFlag;
	private static final long serialVersionUID = 1L;

	//add
		private String childOf;
	private List<TrendChart> trendChart;
	private List<OverAllDTO> overAllDTO;
	public String getKpiCode() {
		return kpiCode;
	}
	public void setKpiCode(String kpiCode) {
		this.kpiCode = kpiCode;
	}
	public String getParentKpiCode() {
		return parentKpiCode;
	}
	public void setParentKpiCode(String parentKpiCode) {
		this.parentKpiCode = parentKpiCode;
	}
	public String getKpiName() {
		return kpiName;
	}
	public void setKpiName(String kpiName) {
		this.kpiName = kpiName;
	}
	public String getOwnerWeighting() {
		return ownerWeighting;
	}
	public void setOwnerWeighting(String ownerWeighting) {
		this.ownerWeighting = ownerWeighting;
	}
	public String getPerspectiveWeighting() {
		return perspectiveWeighting;
	}
	public void setPerspectiveWeighting(String perspectiveWeighting) {
		this.perspectiveWeighting = perspectiveWeighting;
	}
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getTargetValue() {
		return targetValue;
	}
	public void setTargetValue(String targetValue) {
		this.targetValue = targetValue;
	}
	public String getActualValue() {
		return actualValue;
	}
	public void setActualValue(String actualValue) {
		this.actualValue = actualValue;
	}
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
	public String getSystemColorCode() {
		return systemColorCode;
	}
	public void setSystemColorCode(String systemColorCode) {
		this.systemColorCode = systemColorCode;
	}
	public String getUpdatedDT() {
		return updatedDT;
	}
	public void setUpdatedDT(String updatedDT) {
		this.updatedDT = updatedDT;
	}
	public String getAccumulatedFlag() {
		return accumulatedFlag;
	}
	public void setAccumulatedFlag(String accumulatedFlag) {
		this.accumulatedFlag = accumulatedFlag;
	}
	public String getChildOf() {
		return childOf;
	}
	public void setChildOf(String childOf) {
		this.childOf = childOf;
	}
	public List<TrendChart> getTrendChart() {
		return trendChart;
	}
	public void setTrendChart(List<TrendChart> trendChart) {
		this.trendChart = trendChart;
	}
	public List<OverAllDTO> getOverAllDTO() {
		return overAllDTO;
	}
	public void setOverAllDTO(List<OverAllDTO> overAllDTO) {
		this.overAllDTO = overAllDTO;
	}
	
	
}
