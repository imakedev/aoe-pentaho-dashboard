package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Entity;

@Entity
public class KpiresultthresholdGroupDTO implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;
	private Integer kpiKey;
	private String kpiCode;
	private Integer dateKey;
	private Integer perspectiveKey;
	private String kpiName;
	private String childOf;
	//private List<KpiresultthresholdDTO> kpiresultthresholdDTOs;
	private List kpiresultthresholdDTOs;
	private TrendChart trendChart;
	public Integer getKpiKey() {
		return kpiKey;
	}
	public void setKpiKey(Integer kpiKey) {
		this.kpiKey = kpiKey;
	}
	public Integer getDateKey() {
		return dateKey;
	}
	public void setDateKey(Integer dateKey) {
		this.dateKey = dateKey;
	}
	public Integer getPerspectiveKey() {
		return perspectiveKey;
	}
	public void setPerspectiveKey(Integer perspectiveKey) {
		this.perspectiveKey = perspectiveKey;
	}
	public String getKpiName() {
		return kpiName;
	}
	public void setKpiName(String kpiName) {
		this.kpiName = kpiName;
	}
	/*public List<KpiresultthresholdDTO> getKpiresultthresholdDTOs() {
		return kpiresultthresholdDTOs;
	}
	public void setKpiresultthresholdDTOs(
			List<KpiresultthresholdDTO> kpiresultthresholdDTOs) {
		this.kpiresultthresholdDTOs = kpiresultthresholdDTOs;
	}
	*/
	public List getKpiresultthresholdDTOs() {
		return kpiresultthresholdDTOs;
	}
	public void setKpiresultthresholdDTOs(List kpiresultthresholdDTOs) {
		this.kpiresultthresholdDTOs = kpiresultthresholdDTOs;
	}
	public TrendChart getTrendChart() {
		return trendChart;
	}
	public void setTrendChart(TrendChart trendChart) {
		this.trendChart = trendChart;
	}
	public String getChildOf() {
		return childOf;
	}
	public void setChildOf(String childOf) {
		this.childOf = childOf;
	}
	public String getKpiCode() {
		return kpiCode;
	}
	public void setKpiCode(String kpiCode) {
		this.kpiCode = kpiCode;
	}
	
	
}
