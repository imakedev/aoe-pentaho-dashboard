package com.moogle.lbs.ajax;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.directwebremoting.WebContext;
import org.directwebremoting.WebContextFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.moogle.lbs.operationdashboard.domain.AverageCheckDTO;
import com.moogle.lbs.operationdashboard.domain.AverageSalesPerBillDTO;
import com.moogle.lbs.operationdashboard.domain.BranchDTO;
import com.moogle.lbs.operationdashboard.domain.CostDTO;
import com.moogle.lbs.operationdashboard.domain.CustomerPerDayDTO;
import com.moogle.lbs.operationdashboard.domain.DiscountDTO;
import com.moogle.lbs.operationdashboard.domain.GoogleMapDTO;
import com.moogle.lbs.operationdashboard.domain.LossDTO;
import com.moogle.lbs.operationdashboard.domain.LucreDTO;
import com.moogle.lbs.operationdashboard.domain.NetSalesByBranchStatusDTO;
import com.moogle.lbs.operationdashboard.domain.NetSalesByProductGroupDTO;
import com.moogle.lbs.operationdashboard.domain.NetSalesDTO;
import com.moogle.lbs.operationdashboard.domain.RegionGrowthDTO;
import com.moogle.lbs.operationdashboard.domain.Sale_Day_PercentGrowthDTO;
import com.moogle.lbs.operationdashboard.domain.SalesBySalesTypeDTO;
import com.moogle.lbs.operationdashboard.domain.SalesGrowthDTO;
import com.moogle.lbs.operationdashboard.domain.SalesTrendDTO;
import com.moogle.lbs.operationdashboard.domain.SummaryMTDDTO;
import com.moogle.lbs.operationdashboard.domain.SummaryMTDDivisionDTO;
import com.moogle.lbs.operationdashboard.domain.SummaryMTDDivisionSectionDTO;
import com.moogle.lbs.operationdashboard.service.OperationDashboardProcService;
import com.moogle.lbs.operationdashboard.service.OperationDashboardService;

public class OperationDashboardAjax {
	private final OperationDashboardService operationDashboardService;
	private final OperationDashboardProcService operationDashboardProcService;
	public OperationDashboardAjax(){
		//operationDashboardService=null; 
		//System.out.println(" aoe Debug");
		WebContext ctx = WebContextFactory.get(); 
		ServletContext servletContext = ctx.getServletContext();
    	WebApplicationContext wac = WebApplicationContextUtils.
    	getRequiredWebApplicationContext(servletContext);
    	operationDashboardService = (OperationDashboardService)wac.getBean("operationDashboardService"); 
    	operationDashboardProcService= (OperationDashboardProcService)wac.getBean("operationDashboardProcService");
    	//System.out.println(" aoe Debug operationDashboardService "+operationDashboardService);
		
	} 
	
	public List<Integer> listYears(){
		return operationDashboardService.listYears();
	} 
	public List<String>  listDivisions(){
		List list=operationDashboardService.listDivisions();
		//System.out.println(list);
		return list;
	}
	public List<String>  listSections(){
		return operationDashboardService.listSections();
	}
	public List<String>  listAreas(){
		return operationDashboardService.listAreas();
	}
	public List<BranchDTO>  listBranch(){
		return operationDashboardService.listBranch();
	}
	public List<SummaryMTDDTO> getSummaryMTD(int year,int month){//not sure
		return operationDashboardService.getSummaryMTD(year, month);
	}
	public List<SummaryMTDDivisionDTO> getSummaryMTDDivision(String division,int year,int month){
		return operationDashboardService.getSummaryMTDDivision(division, year, month);
	}
	public List<SummaryMTDDivisionSectionDTO> getSummaryMTDDivisionSection(String section,String division,int year,int month){
		return operationDashboardService.getSummaryMTDDivisionSection(section, division, year, month);
	}
	public List<LucreDTO> getLucre(int year,int month ,int limit){
		return operationDashboardService.getLucre(year, month, limit);
	}
	public List<LossDTO> getLoss(int year,int month ,int limit){
		return operationDashboardService.getLoss(year, month, limit);
	}
	public List<SalesGrowthDTO> getSalesGrowth(int year,int month,int limit ,String order){
		return operationDashboardService.getSalesGrowth(year, month, limit, order);
	}
	public List<Sale_Day_PercentGrowthDTO> getSale_Day_PercentGrowth(int year,int month){
		return operationDashboardService.getSale_Day_PercentGrowth(year, month);
	} // ***
	public List<NetSalesByBranchStatusDTO> getNetSalesByBranchStatus(int year,int month){
		return operationDashboardService.getNetSalesByBranchStatus(year, month);
	}
	public List<NetSalesByProductGroupDTO> getNetSalesByProductGroup(int year,int month){
		return operationDashboardService.getNetSalesByProductGroup(year, month);
	}
	public List<NetSalesDTO> getNetSales(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getNetSales(year, month, branch,area ,section,division);
	}
	public List<CostDTO> getCost(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getCost(year, month, branch,area ,section,division);
	}
	public List<String> getProductCategories(){
		return operationDashboardService.getProductCategories();
	}
	public List<String> getProductGroups(String productCategory){
		return operationDashboardService.getProductGroups(productCategory);
	}
	public List<SalesTrendDTO> getSalesTrend(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getSalesTrend(year, month, branch,area ,section,division);
	}
	public List<SalesBySalesTypeDTO> getSalesBySalesType(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getSalesBySalesType(year, month, branch,area ,section,division);
	}
	public List<DiscountDTO> getDiscount(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getDiscount(year, month, branch,area ,section,division);
	}
	public List<AverageCheckDTO> getAverageCheck(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getAverageCheck(year, month, branch,area ,section,division);
	}
	public List<CustomerPerDayDTO> getCustomerPerDay(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getCustomerPerDay(year, month, branch,area ,section,division);
	}
	public List<AverageSalesPerBillDTO>  getAverageSalesPerBill(int year,int month,String branch,String area,String section,String division){
		return operationDashboardService.getAverageSalesPerBill(year, month, branch,area ,section,division);
	}
	public List<RegionGrowthDTO> getRegionGrowth(int year,int month){
		return operationDashboardService.getRegionGrowth(year, month);
	}
	public List<GoogleMapDTO> getGoogleMap(int year,int month){
		return operationDashboardService.getGoogleMap(year, month);
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
