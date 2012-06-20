package com.moogle.lbs.ajax;

import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.moogle.lbs.financedashboard.domain.FinancialIndicationGroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialMixDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPieDTO;
import com.moogle.lbs.financedashboard.domain.FinancialSummaryDTO;
import com.moogle.lbs.financedashboard.domain.FinancialTabDTO;
import com.moogle.lbs.financedashboard.service.FinanceDashboardService;


public class FinanceDashboardAjax {
	private final FinanceDashboardService financeDashboardService;
    public FinanceDashboardAjax(){
		WebContext ctx = WebContextFactory.get(); 
		ServletContext servletContext = ctx.getServletContext();
    	WebApplicationContext wac = WebApplicationContextUtils.
    	getRequiredWebApplicationContext(servletContext);
    	financeDashboardService = (FinanceDashboardService)wac.getBean("financeDashboardService"); 
        } 
	public String say(){
		return "";
	}
	public List<Integer> listYears(){
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
	
}
