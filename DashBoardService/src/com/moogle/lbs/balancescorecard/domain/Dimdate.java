package com.moogle.lbs.balancescorecard.domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the dimdate database table.
 * 
 */
@Entity
@Table(name="DimDate")
public class Dimdate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="DateKey")
	private BigDecimal dateKey;

	@Column(name="CreatedDT")
	private Timestamp createdDT;

    @Temporal( TemporalType.DATE)
	@Column(name="Date")
	private Date date;

	@Column(name="DayDate")
	private String dayDate;

	@Column(name="DayOfWeek")
	private String dayOfWeek;

	@Column(name="FestivalDateNo")
	private BigDecimal festivalDateNo;

	@Column(name="FestivalName")
	private String festivalName;

	@Column(name="FestivalYear")
	private BigDecimal festivalYear;

	@Column(name="HalfYear")
	private String halfYear;

	@Column(name="MonthName")
	private String monthName;

	@Column(name="MonthNo")
	private BigDecimal monthNo;

	@Column(name="Quarter")
	private String quarter;

	@Column(name="RangeID")
	private BigDecimal rangeID;

	@Column(name="TimeGone")
	private BigDecimal timeGone;

	@Column(name="UpdatedDT")
	private Timestamp updatedDT;

	@Column(name="WeekCalendar")
	private String weekCalendar;

	@Column(name="WeekSunSat")
	private String weekSunSat;

	@Column(name="WeekThuWed")
	private String weekThuWed;

	@Column(name="Year")
	private BigDecimal year;

	public BigDecimal getDateKey() {
		return dateKey;
	}

	public void setDateKey(BigDecimal dateKey) {
		this.dateKey = dateKey;
	}

	public Timestamp getCreatedDT() {
		return createdDT;
	}

	public void setCreatedDT(Timestamp createdDT) {
		this.createdDT = createdDT;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getDayDate() {
		return dayDate;
	}

	public void setDayDate(String dayDate) {
		this.dayDate = dayDate;
	}

	public String getDayOfWeek() {
		return dayOfWeek;
	}

	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}

	public BigDecimal getFestivalDateNo() {
		return festivalDateNo;
	}

	public void setFestivalDateNo(BigDecimal festivalDateNo) {
		this.festivalDateNo = festivalDateNo;
	}

	public String getFestivalName() {
		return festivalName;
	}

	public void setFestivalName(String festivalName) {
		this.festivalName = festivalName;
	}

	public BigDecimal getFestivalYear() {
		return festivalYear;
	}

	public void setFestivalYear(BigDecimal festivalYear) {
		this.festivalYear = festivalYear;
	}

	public String getHalfYear() {
		return halfYear;
	}

	public void setHalfYear(String halfYear) {
		this.halfYear = halfYear;
	}

	public String getMonthName() {
		return monthName;
	}

	public void setMonthName(String monthName) {
		this.monthName = monthName;
	}

	public BigDecimal getMonthNo() {
		return monthNo;
	}

	public void setMonthNo(BigDecimal monthNo) {
		this.monthNo = monthNo;
	}

	public String getQuarter() {
		return quarter;
	}

	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}

	public BigDecimal getRangeID() {
		return rangeID;
	}

	public void setRangeID(BigDecimal rangeID) {
		this.rangeID = rangeID;
	}

	public BigDecimal getTimeGone() {
		return timeGone;
	}

	public void setTimeGone(BigDecimal timeGone) {
		this.timeGone = timeGone;
	}

	public Timestamp getUpdatedDT() {
		return updatedDT;
	}

	public void setUpdatedDT(Timestamp updatedDT) {
		this.updatedDT = updatedDT;
	}

	public String getWeekCalendar() {
		return weekCalendar;
	}

	public void setWeekCalendar(String weekCalendar) {
		this.weekCalendar = weekCalendar;
	}

	public String getWeekSunSat() {
		return weekSunSat;
	}

	public void setWeekSunSat(String weekSunSat) {
		this.weekSunSat = weekSunSat;
	}

	public String getWeekThuWed() {
		return weekThuWed;
	}

	public void setWeekThuWed(String weekThuWed) {
		this.weekThuWed = weekThuWed;
	}

	public BigDecimal getYear() {
		return year;
	}

	public void setYear(BigDecimal year) {
		this.year = year;
	}

	
	 	
}