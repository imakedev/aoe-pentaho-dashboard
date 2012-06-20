package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the kpiresultthreshold database table.
 * 
 */
@Embeddable
public class KpiresultthresholdPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="KpiKey")
	private Double kpiKey;

	@Column(name="DateKey")
	private Double dateKey;

	@Column(name="ColorKey")
	private Double colorKey;

    public KpiresultthresholdPK() {
    }
	public Double getKpiKey() {
		return this.kpiKey;
	}
	public void setKpiKey(Double kpiKey) {
		this.kpiKey = kpiKey;
	}
	public Double getDateKey() {
		return this.dateKey;
	}
	public void setDateKey(Double dateKey) {
		this.dateKey = dateKey;
	}
	public Double getColorKey() {
		return this.colorKey;
	}
	public void setColorKey(Double colorKey) {
		this.colorKey = colorKey;
	}

	 
}