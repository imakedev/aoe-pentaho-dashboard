package com.moogle.lbs.ajax;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.moogle.lbs.balancescorecard.domain.KPIChart;
import com.moogle.lbs.balancescorecard.domain.KpiDetailDTO;
import com.moogle.lbs.balancescorecard.domain.KpiresultthresholdTreeDTO;
import com.moogle.lbs.balancescorecard.domain.OverAllDTO;
import com.moogle.lbs.balancescorecard.domain.OwnerresultDTO;
import com.moogle.lbs.balancescorecard.domain.PerspectiveresultDTO;
import com.moogle.lbs.balancescorecard.service.BalanceScorecardService;
import com.moogle.lbs.financedashboard.domain.FinancialIndicationGroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialMixDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPieDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup1GroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialSummaryDTO;
import com.moogle.lbs.financedashboard.domain.FinancialTabDTO;
import com.moogle.lbs.financedashboard.service.FinanceDashboardService;
import com.moogle.lbs.operationdashboard.service.OperationDashboardProcService;
 

public class BalanceScorecardAjax {
	private final BalanceScorecardService balanceScorecardService;
	private final FinanceDashboardService financeDashboardService;
	private final OperationDashboardProcService operationDashboardProcService;
	public BalanceScorecardAjax(){
		WebContext ctx = WebContextFactory.get(); 
		ServletContext servletContext = ctx.getServletContext();
    	WebApplicationContext wac = WebApplicationContextUtils.
    	getRequiredWebApplicationContext(servletContext);
    	balanceScorecardService = (BalanceScorecardService)wac.getBean("balanceScorecardService");
    	financeDashboardService = (FinanceDashboardService)wac.getBean("financeDashboardService"); 
    	operationDashboardProcService= (OperationDashboardProcService)wac.getBean("operationDashboardProcService");
	}     
	public String say(){
		return "";
	}
	public List<Integer> listYears(){
		System.out.println("into listYear");
		return financeDashboardService.listYears();
	}
	public List<FinancialIndicationGroupDTO>getFinancialIndication(int year,int month,String company){
		return financeDashboardService.getFinancialIndication(year, month, company);
	}
	public List<FinancialSummaryDTO> getFinancial_YTD_Monthly_Summary(int year, int month,String sumType){
		return financeDashboardService.getFinancial_YTD_Monthly_Summary(year, month, sumType);
	}
	public List<FinancialTabDTO> getFinancial_YTD_Monthly_Tab(int year, int month,String tab,String sumType){
		return financeDashboardService.getFinancial_YTD_Monthly_Tab(year, month, tab, sumType);
	} 
	public List<FinancialMixDTO> getFD1_2_4(int year, int month,
			String graphType, String sumType,String orgType){
		return financeDashboardService.getFD1_2_4(year, month, graphType, sumType,orgType);
	}
	public List<FinancialMixDTO> getFD1_2_4_percent(int year, int month,
			  String sumType,String orgType){
		return financeDashboardService.getFD1_2_4_percent(year, month,  sumType,orgType);
	}
	public List<FinancialPieDTO> getPile(int year, int month,String sumType){
		return financeDashboardService.getPile(year, month,  sumType);
	}
	public List<Integer> listYear(){
		return balanceScorecardService.listYear();
	} 
	/*public List<String> listDivisions(){
		return balanceScorecardService.listDivisions();
	}*/
	public List<OwnerresultDTO> listOwnerResult(Integer year,int month){
		return balanceScorecardService.listOwnerResult(year, month);
	}
	public List<OverAllDTO> getKPIOverallPopupScore(Integer year,int month,int KPIOwnerKey){
		return balanceScorecardService.getKPIOverallPopupScoreProc(year, month, new BigDecimal(KPIOwnerKey));
	}
	public List<OverAllDTO> getKPIOverallPopup(Integer year,int month,int KPIOwnerKey){
		List list=new ArrayList(2);
		list.add(balanceScorecardService.getKPIOverallPopupProc(year, new BigDecimal(KPIOwnerKey)));
		list.add(balanceScorecardService.getKPIOverallPopupScoreProc(year, month, new BigDecimal(KPIOwnerKey)));
		return list;
	}
	/*public List<OverAllDTO> getPieKPIOverall(Integer year,int month,int kpiOwenerKey){
		return balanceScorecardService.getPieKPIOverall(year, month,new BigDecimal(kpiOwenerKey));
	}*/
	public List<PerspectiveresultDTO> getPerspective(int KPIOwnerKey,Integer year,int month){
		return balanceScorecardService.getPerspectiveProc(new BigDecimal(KPIOwnerKey), year, month);
	} 
	/*public List<KpiresultthresholdGroupDTO> getKPIListLevel0(Integer year,int month,int KPIOwnerKey,int  perspectiveKey){
		List<KpiresultthresholdGroupDTO> list=  balanceScorecardService.getKPIListLevel0(year, month, new BigDecimal(KPIOwnerKey),new Integer(perspectiveKey));
		//System.out.println("xxxxxxxxxx = list "+list.get(0).getKpiresultthresholdDTOs());
		return list;
	}*/
	public  List getKPIListAndChartLevel0(Integer year,int month,int KPIOwnerKey,int  perspectiveKey){ 
		return balanceScorecardService.getKPIListAndChartLevel0(year, month, KPIOwnerKey,perspectiveKey);
	}	
	/*public  List getKPIListAndChart(Integer year,int month,int KPIOwnerKey,int  parentKPIKey){ 
		return balanceScorecardService.getKPIListAndChart(year, month, KPIOwnerKey,parentKPIKey);
	}*/	
/*	public List getKPIListAndChartLevel0(Integer year, int month,
			int KPIOwnerKey, int perspectiveKey){
		return balanceScorecardService.getKPIListAndChartLevel0(year, month, KPIOwnerKey, perspectiveKey);
	}*/
	/*public List<KpiresultthresholdGroupDTO> getKPIList(Integer year,int month,int KPIOwnerKey,Integer kpiKey){
		return balanceScorecardService.getKPIList(year, month, new BigDecimal(KPIOwnerKey), kpiKey);
	}
	public  List<TrendChart> getTrendChart(Integer year,int month,int KPIOwnerKey,Integer kpiKey){
		return balanceScorecardService.getTrendChart(year, month, new BigDecimal(KPIOwnerKey), kpiKey);
	}*/	
	public KpiDetailDTO getKPIDetail(int year,
			int month, String ownerCode, String kpiCode){
		return balanceScorecardService.getKPIDetailProc( year,
				 month,  ownerCode,  kpiCode);
	}
	 	
	/*public  List<PerspectiveresultthresholdDTO> getPerspectiveResult(Integer year, int month,int kpiOwenerKey){
		return balanceScorecardService.getPerspectiveResult(year, month,new BigDecimal( kpiOwenerKey));
	}*/
	public List<KPIChart> getKPIChart(Integer year, int month,String bscOwner,
			 String kpiCode,String accumulatedFlag){
		return balanceScorecardService.getKPIChartProc(year, month, bscOwner,kpiCode, accumulatedFlag);
	}  
	/* public  List<KpiresultthresholdGroupDTO> getKPIListAndChartRecursive(Integer year,int month,int KPIOwnerKey,int  perspectiveKey){ 
			List level0= balanceScorecardService.getKPIListAndChartLevel0(year, month, KPIOwnerKey,perspectiveKey);
			List results=new ArrayList();
			if(level0!=null && level0.size()>0){
				int size= level0.size();
				for (int i = 0; i < size; i++) {
					KpiresultthresholdGroupDTO kpiresultthresholdGroupDTO = (KpiresultthresholdGroupDTO)level0.get(i); 
					results.add(kpiresultthresholdGroupDTO);
					 List tmp=new ArrayList();
			    	 List childs =   balanceScorecardService.getKPIListAndChartRecursive(tmp,year, month, KPIOwnerKey,kpiresultthresholdGroupDTO.getKpiKey());
			    	   if(childs!=null && childs.size()>0){
			    		   int child_size=childs.size();
			    		   for (int j = 0; j < child_size; j++) { 
			    			   KpiresultthresholdGroupDTO groupChild = (KpiresultthresholdGroupDTO)childs.get(j); 
			    			   results.add(groupChild);
						}
			    	  }
				}
			}
			return results;
	}	
	*/
	 public  List<KpiresultthresholdTreeDTO> getKPIListAndChartRecursive(Integer year,int month,int KPIOwnerKey,int  perspectiveKey){ 
			List level0= balanceScorecardService.getKPIListAndChartLevel0Proc(year, month, KPIOwnerKey,perspectiveKey);
			List resultsAll=new ArrayList(3);
			List results=new ArrayList();
			if(level0!=null && level0.size()>0){
				int size= level0.size();
				for (int i = 0; i < size; i++) {
					KpiresultthresholdTreeDTO treeDTO = (KpiresultthresholdTreeDTO)level0.get(i); 
					results.add(treeDTO);
					 List tmp=new ArrayList();
			    	 List childs =   balanceScorecardService.getKPIListAndChartRecursiveProc(tmp,year, month, KPIOwnerKey,treeDTO.getKpiCode());
			    	   if(childs!=null && childs.size()>0){
			    		   int child_size=childs.size();
			    		   for (int j = 0; j < child_size; j++) { 
			    			   KpiresultthresholdTreeDTO groupChild = (KpiresultthresholdTreeDTO)childs.get(j); 
			    			   results.add(groupChild);
						}
			    	  }
				}
			}
			List result2=balanceScorecardService.getKPIPerspectiveProc(year,KPIOwnerKey,perspectiveKey);
			List result3=balanceScorecardService.getKPIPerspectiveScoreProc(year,month,KPIOwnerKey,perspectiveKey);
			resultsAll.add(results);
			resultsAll.add(result2);
			resultsAll.add(result3);
			return resultsAll;
	}	
	 //public List<OverAllDTO> getKPIPerspectiveProc(Integer year,int month,int KPIOwnerKey,int  perspectiveKey){  
	 public List getKPIPerspectiveProc(Integer year,int month,int KPIOwnerKey,int  perspectiveKey){
	 List resultsAll=new ArrayList(2);
		    List result1= balanceScorecardService.getKPIPerspectiveProc(year,KPIOwnerKey,perspectiveKey); 
			List result2=balanceScorecardService.getKPIPerspectiveScoreProc(year,month,KPIOwnerKey,perspectiveKey);
			resultsAll.add(result1);
			resultsAll.add(result2);
			System.out.println(" ajaxt list "+resultsAll);
			return resultsAll;
	}	
	
	 // add
	 public List<FinancialPopup1GroupDTO> getPopup1(int year,
				int month, String tab, String sumType){
		 return financeDashboardService.getPopup1(year,month, tab, sumType);
	 }
	 public List<FinancialPopup1GroupDTO> getPopup2(int year,
				int month, String tab, String sumType){
		 return financeDashboardService.getPopup2(year,month, tab, sumType);
	 }
	 public List getPopup3(int year,
				int month, String tab, String sumType){
		 return financeDashboardService.getPopup3(year,month, tab, sumType);
	 }
	 public List<FinancialPieDTO> getBarOfPile(int year, int month,String tab,String sumType){
		 return financeDashboardService.getBarOfPile(year,month, tab, sumType);
	 }
	 public List<String[]> callPROC(String query){
			System.out.println(" into callPROC ");
			List<String[]> result=null;
			try{
				result=operationDashboardProcService.callPROC(query);
			}catch(Exception ex){
				ex.printStackTrace();
			}
			return result;
		}
		public List listCriteria(String query[]){
			System.out.println(" into listCriteria ");
			List result=null; 
			try{
			  result=new ArrayList();
			for (int i = 0; i < query.length; i++) {
				result.add(operationDashboardProcService.callPROC(query[i]));
			}
			}catch(Exception ex){
				ex.printStackTrace();
			}
			return result;
		}
}
