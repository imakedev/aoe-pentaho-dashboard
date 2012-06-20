package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the kpiresult database table.
 * 
 */
@Entity
@Table(name="KpiResult")
public class Kpiresult implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private KpiresultPK id;

	@Column(name="AccumActualValue")
	private Double accumActualValue;

	@Column(name="AccumTargetValue")
	private Double accumTargetValue;

	@Column(name="AccumulatedFlag")
	private String accumulatedFlag;

	@Column(name="ActualValue")
	private Double actualValue;

    @Temporal( TemporalType.TIMESTAMP)
	@Column(name="CreatedDT")
	private Date createdDT;

	@Column(name="DataSource")
	private String dataSource;

	@Column(name="DisplayFlag")
	private String displayFlag;

   /* @Temporal( TemporalType.TIMESTAMP)
	@Column(name="Field28")
	private Date field28;*/

	@Column(name="FormulaDesc")
	private String formulaDesc;

	@Column(name="Frequency")
	private String frequency;

	@Column(name="KpiDesc")
	private String kpiDesc;

	@Column(name="KpiName")
	private String kpiName;

	@Column(name="KPIOwnerKey")
	private Double kpiOwnerKey;

	@Column(name="KPIOwnerName")
	private String pkiOwnerName;

	@Column(name="KPIOwnerWeighting")
	private Double kpiOwnerWeighting;

	@Column(name="LastRevisedDT")
	private String lastRevisedDT;

	@Column(name="Objective")
	private String objective;

	@Column(name="ParentKpiKey")
	private Double parentKpiKey;

	@Column(name="ParentKpiName")
	private String parentKpiName;

	@Column(name="PercentActualVsTarget")
	private Double percentActualVsTarget;

	@Column(name="PerspectiveKey")
	private Double perspectiveKey;

	@Column(name="PerspectiveName")
	private String perspectiveName;

	@Column(name="PerspectiveWeighting")
	private String perspectiveWeighting;

	@Column(name="TargetRangeDesc")
	private String targetRangeDesc;

	@Column(name="TargetValue")
	private Double targetValue;

	@Column(name="UOM")
	private String uom;

    public Kpiresult() {
    }

	public KpiresultPK getId() {
		return this.id;
	}

	public void setId(KpiresultPK id) {
		this.id = id;
	}
	
	public Double getAccumActualValue() {
		return this.accumActualValue;
	}

	public void setAccumActualValue(Double accumActualValue) {
		this.accumActualValue = accumActualValue;
	}

	public Double getAccumTargetValue() {
		return this.accumTargetValue;
	}

	public void setAccumTargetValue(Double accumTargetValue) {
		this.accumTargetValue = accumTargetValue;
	}

	public String getAccumulatedFlag() {
		return this.accumulatedFlag;
	}

	public void setAccumulatedFlag(String accumulatedFlag) {
		this.accumulatedFlag = accumulatedFlag;
	}

	public Double getActualValue() {
		return this.actualValue;
	}

	public void setActualValue(Double actualValue) {
		this.actualValue = actualValue;
	}

	public Date getCreatedDT() {
		return this.createdDT;
	}

	public void setCreatedDT(Date createdDT) {
		this.createdDT = createdDT;
	}

	public String getDataSource() {
		return this.dataSource;
	}

	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}

	public String getDisplayFlag() {
		return this.displayFlag;
	}

	public void setDisplayFlag(String displayFlag) {
		this.displayFlag = displayFlag;
	}

/*	public Date getField28() {
		return this.field28;
	}

	public void setField28(Date field28) {
		this.field28 = field28;
	}*/

	public String getFormulaDesc() {
		return this.formulaDesc;
	}

	public void setFormulaDesc(String formulaDesc) {
		this.formulaDesc = formulaDesc;
	}

	public String getFrequency() {
		return this.frequency;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public String getKpiDesc() {
		return this.kpiDesc;
	}

	public void setKpiDesc(String kpiDesc) {
		this.kpiDesc = kpiDesc;
	}

	public String getKpiName() {
		return this.kpiName;
	}

	public void setKpiName(String kpiName) {
		this.kpiName = kpiName;
	}

	 

	public Double getKpiOwnerKey() {
		return kpiOwnerKey;
	}

	public void setKpiOwnerKey(Double kpiOwnerKey) {
		this.kpiOwnerKey = kpiOwnerKey;
	}

	 

	public Double getKpiOwnerWeighting() {
		return kpiOwnerWeighting;
	}

	public String getPkiOwnerName() {
		return pkiOwnerName;
	}

	public void setPkiOwnerName(String pkiOwnerName) {
		this.pkiOwnerName = pkiOwnerName;
	}

	public void setKpiOwnerWeighting(Double kpiOwnerWeighting) {
		this.kpiOwnerWeighting = kpiOwnerWeighting;
	}

	public String getLastRevisedDT() {
		return this.lastRevisedDT;
	}

	public void setLastRevisedDT(String lastRevisedDT) {
		this.lastRevisedDT = lastRevisedDT;
	}

	public String getObjective() {
		return this.objective;
	}

	public void setObjective(String objective) {
		this.objective = objective;
	}

	public Double getParentKpiKey() {
		return this.parentKpiKey;
	}

	public void setParentKpiKey(Double parentKpiKey) {
		this.parentKpiKey = parentKpiKey;
	}

	public String getParentKpiName() {
		return this.parentKpiName;
	}

	public void setParentKpiName(String parentKpiName) {
		this.parentKpiName = parentKpiName;
	}

	public Double getPercentActualVsTarget() {
		return this.percentActualVsTarget;
	}

	public void setPercentActualVsTarget(Double percentActualVsTarget) {
		this.percentActualVsTarget = percentActualVsTarget;
	}

	public Double getPerspectiveKey() {
		return this.perspectiveKey;
	}

	public void setPerspectiveKey(Double perspectiveKey) {
		this.perspectiveKey = perspectiveKey;
	}

	public String getPerspectiveName() {
		return this.perspectiveName;
	}

	public void setPerspectiveName(String perspectiveName) {
		this.perspectiveName = perspectiveName;
	}

	public String getPerspectiveWeighting() {
		return this.perspectiveWeighting;
	}

	public void setPerspectiveWeighting(String perspectiveWeighting) {
		this.perspectiveWeighting = perspectiveWeighting;
	}

	public String getTargetRangeDesc() {
		return this.targetRangeDesc;
	}

	public void setTargetRangeDesc(String targetRangeDesc) {
		this.targetRangeDesc = targetRangeDesc;
	}

	public Double getTargetValue() {
		return this.targetValue;
	}

	public void setTargetValue(Double targetValue) {
		this.targetValue = targetValue;
	}

	public String getUom() {
		return this.uom;
	}

	public void setUom(String uom) {
		this.uom = uom;
	}

}