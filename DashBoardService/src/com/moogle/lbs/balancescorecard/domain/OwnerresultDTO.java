package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class OwnerresultDTO  implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	private BigDecimal kpiOwnerKey;
	private String kpiOwnerName;
	
	public BigDecimal getKpiOwnerKey() {
		return kpiOwnerKey;
	}
	public void setKpiOwnerKey(BigDecimal kpiOwnerKey) {
		this.kpiOwnerKey = kpiOwnerKey;
	}
	public String getKpiOwnerName() {
		return kpiOwnerName;
	}
	public void setKpiOwnerName(String kpiOwnerName) {
		this.kpiOwnerName = kpiOwnerName;
	}
	

}
