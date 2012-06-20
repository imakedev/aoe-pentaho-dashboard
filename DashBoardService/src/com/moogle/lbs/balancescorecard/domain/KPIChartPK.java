package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Embeddable;

@Embeddable
public class KPIChartPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
 
	private BigDecimal kpiKey; 
	private BigDecimal dateKey;
	public BigDecimal getKpiKey() {
		return kpiKey;
	}
	public void setKpiKey(BigDecimal kpiKey) {
		this.kpiKey = kpiKey;
	}
	public BigDecimal getDateKey() {
		return dateKey;
	}
	public void setDateKey(BigDecimal dateKey) {
		this.dateKey = dateKey;
	}

}
