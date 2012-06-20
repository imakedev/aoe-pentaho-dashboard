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
 * The persistent class for the ownerresultthreshold database table.
 * 
 */
@Entity
@Table(name="ownerresultthreshold")
public class Ownerresultthreshold implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private OwnerresultthresholdPK id;

	@Column(name="BeginThreshold")
	private BigDecimal beginThreshold;

	@Column(name="ColorCode")
	private String colorCode;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="CreatedDT")
	private Date createdDT;

	@Column(name="EndThreshold")
	private BigDecimal endThreshold;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="UpdatedDT")
	private Date updatedDT;

    public Ownerresultthreshold() {
    }

	public OwnerresultthresholdPK getId() {
		return this.id;
	}

	public void setId(OwnerresultthresholdPK id) {
		this.id = id;
	}
	
	public BigDecimal getBeginThreshold() {
		return this.beginThreshold;
	}

	public void setBeginThreshold(BigDecimal beginThreshold) {
		this.beginThreshold = beginThreshold;
	}

	public String getColorCode() {
		return this.colorCode;
	}

	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}

	public Date getCreatedDT() {
		return this.createdDT;
	}

	public void setCreatedDT(Date createdDT) {
		this.createdDT = createdDT;
	}

	public BigDecimal getEndThreshold() {
		return this.endThreshold;
	}

	public void setEndThreshold(BigDecimal endThreshold) {
		this.endThreshold = endThreshold;
	}

	public Date getUpdatedDT() {
		return this.updatedDT;
	}

	public void setUpdatedDT(Date updatedDT) {
		this.updatedDT = updatedDT;
	}

}