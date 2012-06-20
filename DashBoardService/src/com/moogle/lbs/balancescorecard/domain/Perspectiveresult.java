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
 * The persistent class for the perspectiveresult database table.
 * 
 */
@Entity
@Table(name="PerspectiveResult")
public class Perspectiveresult implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PerspectiveresultPK id;

	@Column(name="ActualValue")
	private BigDecimal actualValue;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="CreatedDT")
	private Date createdDT;

    @Column(name="KPIOwenerName")
	private String kpiOwenerName;

	@Column(name="PercentActualVsTarget")
	private BigDecimal percentActualVsTarget;

	@Column(name="PerspectiveName")
	private String perspectiveName;

	@Column(name="TargetValue")
	private BigDecimal targetValue;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="UpdatedDT")
	private Date updatedDT;

    public Perspectiveresult() {
    }

	public PerspectiveresultPK getId() {
		return this.id;
	}

	public void setId(PerspectiveresultPK id) {
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
 

	public String getKpiOwenerName() {
		return kpiOwenerName;
	}

	public void setKpiOwenerName(String kpiOwenerName) {
		this.kpiOwenerName = kpiOwenerName;
	}

	public BigDecimal getPercentActualVsTarget() {
		return this.percentActualVsTarget;
	}

	public void setPercentActualVsTarget(BigDecimal percentActualVsTarget) {
		this.percentActualVsTarget = percentActualVsTarget;
	}

	public String getPerspectiveName() {
		return this.perspectiveName;
	}

	public void setPerspectiveName(String perspectiveName) {
		this.perspectiveName = perspectiveName;
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