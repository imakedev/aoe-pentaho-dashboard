package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
@Entity
public class KPIChart implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private KPIChartPK id;
	private String  kpiName;
	private Integer monthNo;
	private String monthName;
	private BigDecimal actualValue;
	private BigDecimal targetValue;
	private BigDecimal accumActualValue;
	private BigDecimal lastYearActual;
	public Integer getMonthNo() {
		return monthNo;
	}
	public void setMonthNo(Integer monthNo) {
		this.monthNo = monthNo;
	}
	public String getMonthName() {
		return monthName;
	}
	public void setMonthName(String monthName) {
		this.monthName = monthName;
	}
	public BigDecimal getActualValue() {
		return actualValue;
	}
	public void setActualValue(BigDecimal actualValue) {
		this.actualValue = actualValue;
	}
	public BigDecimal getTargetValue() {
		return targetValue;
	}
	public void setTargetValue(BigDecimal targetValue) {
		this.targetValue = targetValue;
	}
	public BigDecimal getAccumActualValue() {
		return accumActualValue;
	}
	public void setAccumActualValue(BigDecimal accumActualValue) {
		this.accumActualValue = accumActualValue;
	}
	 
	public BigDecimal getLastYearActual() {
		return lastYearActual;
	}
	public void setLastYearActual(BigDecimal lastYearActual) {
		this.lastYearActual = lastYearActual;
	}
	public KPIChartPK getId() {
		return id;
	}
	public void setId(KPIChartPK id) {
		this.id = id;
	}
	public String getKpiName() {
		return kpiName;
	}
	public void setKpiName(String kpiName) {
		this.kpiName = kpiName;
	}
	 
	
	
}