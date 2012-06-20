package com.moogle.lbs.balancescorecard.service;

import java.math.BigDecimal;
import java.util.List;

import com.moogle.lbs.balancescorecard.domain.KPIChart;
import com.moogle.lbs.balancescorecard.domain.KpiDetailDTO;
import com.moogle.lbs.balancescorecard.domain.Kpiresult;
import com.moogle.lbs.balancescorecard.domain.KpiresultPK;
import com.moogle.lbs.balancescorecard.domain.OverAllDTO;
import com.moogle.lbs.balancescorecard.domain.OwnerresultDTO;
import com.moogle.lbs.balancescorecard.domain.PerspectiveresultDTO;

public interface BalanceScorecardService {
	public List<Integer> listYear();
	//public List<String> listDivisions();
	public List<OwnerresultDTO> listOwnerResult(Integer year,int month);
	public List<OverAllDTO> getKPIOverall(Integer year,int month,BigDecimal kpiOwenerKey);
	//public List<OverAllDTO> getPieKPIOverall(Integer year,int month,BigDecimal kpiOwenerKey);
	public List<PerspectiveresultDTO> getPerspective(BigDecimal KPIOwnerKey,Integer year,int month); 
//	public List<KpiresultthresholdGroupDTO> getKPIListLevel0(Integer year,int month, BigDecimal KPIOwnerKey,Integer perspectiveKey);
//	public  List<TrendChart> getTrendChartLevel0(Integer year,int month, BigDecimal KPIOwnerKey,Integer kpiKey);
	
	//public List<KpiresultthresholdGroupDTO> getKPIList(Integer year,int month, BigDecimal KPIOwnerKey,Integer kpiKey);
	//public  List<TrendChart> getTrendChart(Integer year,int month, BigDecimal KPIOwnerKey,Integer kpiKey);
	
	public List getKPIListAndChartLevel0(Integer year,int month,int KPIOwnerKey,int  perspectiveKey);
	//public List getKPIListAndChart(Integer year, int month,int KPIOwnerKey, int parentKpiKey); 
	public Kpiresult getKPIDetail(KpiresultPK id);
//	public  List<PerspectiveresultthresholdDTO> getPerspectiveResult(Integer year, int month,BigDecimal kpiOwenerKey);
	public List<KPIChart> getKPIChart(Integer year, int month,
			 Integer kpiKey,String accumulatedFlag);
	public List getKPIListAndChartRecursive(List results ,Integer year, int month,
			int KPIOwnerKey, int parentKpiKey) ;
	
	//store
	public List<OwnerresultDTO> listOwnerResultProc(Integer year,int month);
	public List<OverAllDTO> getKPIOverallPopupScoreProc(Integer year,int month,BigDecimal kpiOwenerKey);
	public List<OverAllDTO> getKPIOverallPopupProc(Integer year,BigDecimal kpiOwenerKey); 
	
	public List<OverAllDTO> getKPIPerspectiveScoreProc(Integer year,int month,int kpiOwenerKey,int perspectiveKey);
	public List<OverAllDTO> getKPIPerspectiveProc(Integer year,int kpiOwenerKey,int perspectiveKey);
	 
	
	public List<PerspectiveresultDTO> getPerspectiveProc(BigDecimal KPIOwnerKey,Integer year,int month); 
	public List getKPIListAndChartLevel0Proc(Integer year,int month,int KPIOwnerKey,int  perspectiveKey);
	public KpiDetailDTO getKPIDetailProc(int year,
			int month, String ownerCode, String kpiCode);
	public List getKPIListAndChartRecursiveProc(List results ,Integer year, int month,
			int KPIOwnerKey, String parentKpiKey) ;
	public List<KPIChart> getKPIChartProc(Integer year, int month,String bscOwner,
			 String kpiCode,String accumulatedFlag);
}
