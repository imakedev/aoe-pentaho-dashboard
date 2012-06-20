package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the ownerresult database table.
 * 
 */
@Entity
@Table(name="OwnerResult")
public class Ownerresult implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private OwnerresultPK id;

	@Column(name="ActualValue")
	private BigDecimal actualValue;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="CreatedDT")
	private Date createdDT;

    @Column(name="KPIOwnerName")
	private String kpiOwnerName;

	@Column(name="PercentActualVsTarget")
	private BigDecimal percentActualVsTarget;

	@Column(name="TargetValue")
	private BigDecimal targetValue;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="UpdatedDT")
	private Date updatedDT;

    public Ownerresult() {
    }

	public OwnerresultPK getId() {
		return this.id;
	}

	public void setId(OwnerresultPK id) {
		this.id = id;
	}
	
	public BigDecimal getActualValue() {
		return this.actualValue;
	}

	public void setActualValue(BigDecimal actualValue) {
		this.actualValue = actualValue;
	}

	public Date getCreatedDT() {
		return this.createdDT;
	}

	public void setCreatedDT(Date createdDT) {
		this.createdDT = createdDT;
	}

	 
	public String getKpiOwnerName() {
		return kpiOwnerName;
	}

	public void setKpiOwnerName(String kpiOwnerName) {
		this.kpiOwnerName = kpiOwnerName;
	}

	public BigDecimal getPercentActualVsTarget() {
		return this.percentActualVsTarget;
	}

	public void setPercentActualVsTarget(BigDecimal percentActualVsTarget) {
		this.percentActualVsTarget = percentActualVsTarget;
	}

	public BigDecimal getTargetValue() {
		return this.targetValue;
	}

	public void setTargetValue(BigDecimal targetValue) {
		this.targetValue = targetValue;
	}

	public Date getUpdatedDT() {
		return this.updatedDT;
	}

	public void setUpdatedDT(Date updatedDT) {
		this.updatedDT = updatedDT;
	}

}