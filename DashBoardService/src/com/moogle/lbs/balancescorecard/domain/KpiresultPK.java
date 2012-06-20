package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the kpiresult database table.
 * 
 */
@Embeddable
public class KpiresultPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="KpiKey")
	private BigDecimal kpiKey;

	@Column(name="DateKey")
	private BigDecimal dateKey;

    public KpiresultPK() {
    }
	public BigDecimal getKpiKey() {
		return this.kpiKey;
	}
	public void setKpiKey(BigDecimal kpiKey) {
		this.kpiKey = kpiKey;
	}
	public BigDecimal getDateKey() {
		return this.dateKey;
	}
	public void setDateKey(BigDecimal dateKey) {
		this.dateKey = dateKey;
	}

	 
}