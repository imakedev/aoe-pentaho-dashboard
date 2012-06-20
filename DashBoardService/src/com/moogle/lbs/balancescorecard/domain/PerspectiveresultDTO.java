package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class PerspectiveresultDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	private String id;
	private BigDecimal perspectiveKey;
	private String perspectiveName;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	

}
