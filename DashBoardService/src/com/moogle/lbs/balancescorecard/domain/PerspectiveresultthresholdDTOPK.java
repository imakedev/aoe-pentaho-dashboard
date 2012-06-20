package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Embeddable;

@Embeddable
public class PerspectiveresultthresholdDTOPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	private BigDecimal kpiOwnerKey;

	private BigDecimal perspectiveKey;

	private BigDecimal dateKey;

	private BigDecimal colorKey;

	public BigDecimal getKpiOwnerKey() {
		return kpiOwnerKey;
	}

	public void setKpiOwnerKey(BigDecimal kpiOwnerKey) {
		this.kpiOwnerKey = kpiOwnerKey;
	}

	public BigDecimal getPerspectiveKey() {
		return perspectiveKey;
	}

	public void setPerspectiveKey(BigDecimal perspectiveKey) {
		this.perspectiveKey = perspectiveKey;
	}

	public BigDecimal getDateKey() {
		return dateKey;
	}

	public void setDateKey(BigDecimal dateKey) {
		this.dateKey = dateKey;
	}

	public BigDecimal getColorKey() {
		return colorKey;
	}

	public void setColorKey(BigDecimal colorKey) {
		this.colorKey = colorKey;
	}
	
	
}
