package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the perspectiveresult database table.
 * 
 */
@Embeddable
public class PerspectiveresultPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	
	@Column(name="KPIOwenerKey")
	private BigDecimal kpiOwenerKey;

	@Column(name="PerspectiveKey")
	private BigDecimal perspectiveKey;

	@Column(name="DateKey")
	private BigDecimal dateKey;

    public PerspectiveresultPK() {
    }
 
	public BigDecimal getKpiOwenerKey() {
		return kpiOwenerKey;
	}

	public void setKpiOwenerKey(BigDecimal kpiOwenerKey) {
		this.kpiOwenerKey = kpiOwenerKey;
	}

	public BigDecimal getPerspectiveKey() {
		return this.perspectiveKey;
	}
	public void setPerspectiveKey(BigDecimal perspectiveKey) {
		this.perspectiveKey = perspectiveKey;
	}
	public BigDecimal getDateKey() {
		return this.dateKey;
	}
	public void setDateKey(BigDecimal dateKey) {
		this.dateKey = dateKey;
	}

	 
}