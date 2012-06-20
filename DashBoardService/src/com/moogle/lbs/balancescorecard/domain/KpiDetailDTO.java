package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;

public class KpiDetailDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String kpiName;
	private String objective;
	private String formulaDesc;
	private String kpiDesc;
	private String uom;
	private String dataSource;
	private String targetRangeDesc;
	private String lastRevisedDT;
	
	public KpiDetailDTO(String kpiName, String objective, String formulaDesc,
			String kpiDesc, String uom, String dataSource,
			String targetRangeDesc, String lastRevisedDT) {
		super();
		this.kpiName = kpiName;
		this.objective = objective;
		this.formulaDesc = formulaDesc;
		this.kpiDesc = kpiDesc;
		this.uom = uom;
		this.dataSource = dataSource;
		this.targetRangeDesc = targetRangeDesc;
		this.lastRevisedDT = lastRevisedDT;
	}
	public String getKpiName() {
		return kpiName;
	}
	public void setKpiName(String kpiName) {
		this.kpiName = kpiName;
	}
	public String getObjective() {
		return objective;
	}
	public void setObjective(String objective) {
		this.objective = objective;
	}
	public String getFormulaDesc() {
		return formulaDesc;
	}
	public void setFormulaDesc(String formulaDesc) {
		this.formulaDesc = formulaDesc;
	}
	public String getKpiDesc() {
		return kpiDesc;
	}
	public void setKpiDesc(String kpiDesc) {
		this.kpiDesc = kpiDesc;
	}
	public String getUom() {
		return uom;
	}
	public void setUom(String uom) {
		this.uom = uom;
	}
	public String getDataSource() {
		return dataSource;
	}
	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}
	public String getTargetRangeDesc() {
		return targetRangeDesc;
	}
	public void setTargetRangeDesc(String targetRangeDesc) {
		this.targetRangeDesc = targetRangeDesc;
	}
	public String getLastRevisedDT() {
		return lastRevisedDT;
	}
	public void setLastRevisedDT(String lastRevisedDT) {
		this.lastRevisedDT = lastRevisedDT;
	} 
	
}
