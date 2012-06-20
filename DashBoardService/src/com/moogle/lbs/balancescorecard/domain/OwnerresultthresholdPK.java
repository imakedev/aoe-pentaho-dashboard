package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the ownerresultthreshold database table.
 * 
 */
@Embeddable
public class OwnerresultthresholdPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	
	@Column(name="KPIOwnerKey")
	private BigDecimal kpiOwnerKey;
	
	@Column(name="DateKey")
	private BigDecimal dateKey;

	@Column(name="ColorKey")
	private BigDecimal colorKey;

    public OwnerresultthresholdPK() {
    }
	
	public BigDecimal getKpiOwnerKey() {
		return kpiOwnerKey;
	}

	public void setKpiOwnerKey(BigDecimal kpiOwnerKey) {
		this.kpiOwnerKey = kpiOwnerKey;
	}

	public BigDecimal getDateKey() {
		return this.dateKey;
	}
	public void setDateKey(BigDecimal dateKey) {
		this.dateKey = dateKey;
	}
	public BigDecimal getColorKey() {
		return this.colorKey;
	}
	public void setColorKey(BigDecimal colorKey) {
		this.colorKey = colorKey;
	}


}