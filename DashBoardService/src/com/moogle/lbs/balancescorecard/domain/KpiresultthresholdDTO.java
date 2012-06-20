package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;

@Entity
public class KpiresultthresholdDTO  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private KpiresultthresholdDTOPK id;
	private BigDecimal perspectiveKey;
	private String perspectiveName;
	private String kpiName;
	private BigDecimal kpiOwnerWeighting;
	private String perspectiveWeighting;
	private String frequency;
	private BigDecimal actualValue;
	private BigDecimal targetValue;
	private BigDecimal percentActualVsTarget;
	private BigDecimal beginThreshold;
	private BigDecimal endThreshold;
	
	private String accumulatedFlag;
	private Date updatedDT;
	//add
	private String childOf;
	 
	public BigDecimal getPerspectiveKey() {
		return perspectiveKey;
	}
	public void setPerspectiveKey(BigDecimal perspectiveKey) {
		this.perspectiveKey = perspectiveKey;
	}
	public String getPerspectiveName() {
		return perspectiveName;
	}
	public void setPerspectiveName(String perspectiveName) {
		this.perspectiveName = perspectiveName;
	}
	public String getKpiName() {
		return kpiName;
	}
	public void setKpiName(String kpiName) {
		this.kpiName = kpiName;
	}
	public BigDecimal getKpiOwnerWeighting() {
		return kpiOwnerWeighting;
	}
	public void setKpiOwnerWeighting(BigDecimal kpiOwnerWeighting) {
		this.kpiOwnerWeighting = kpiOwnerWeighting;
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
	 
	public String getAccumulatedFlag() {
		return accumulatedFlag;
	}
	public void setAccumulatedFlag(String accumulatedFlag) {
		this.accumulatedFlag = accumulatedFlag;
	}
	public Date getUpdatedDT() {
		return updatedDT;
	}
	public void setUpdatedDT(Date updatedDT) {
		this.updatedDT = updatedDT;
	}
	public KpiresultthresholdDTOPK getId() {
		return id;
	}
	public void setId(KpiresultthresholdDTOPK id) {
		this.id = id;
	}
	public String getChildOf() {
		return childOf;
	}
	public void setChildOf(String childOf) {
		this.childOf = childOf;
	}
 
}
