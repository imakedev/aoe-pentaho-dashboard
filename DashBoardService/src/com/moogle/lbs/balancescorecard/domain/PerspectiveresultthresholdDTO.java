package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
@Entity
public class PerspectiveresultthresholdDTO  implements Serializable{

	/**
	 * 
	 */
  
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId	
	private PerspectiveresultthresholdDTOPK id; 
	private String perspectiveName;
	private BigDecimal actualValue;
	private BigDecimal targetValue;
	private BigDecimal percentActualVsTarget;
	private BigDecimal beginThreshold;
	private BigDecimal endThreshold;
	private String colorCode;
	 
	public String getPerspectiveName() {
		return perspectiveName;
	}
	public void setPerspectiveName(String perspectiveName) {
		this.perspectiveName = perspectiveName;
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
	public String getColorCode() {
		return colorCode;
	}
	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
	public PerspectiveresultthresholdDTOPK getId() {
		return id;
	}
	public void setId(PerspectiveresultthresholdDTOPK id) {
		this.id = id;
	} 
	
}
