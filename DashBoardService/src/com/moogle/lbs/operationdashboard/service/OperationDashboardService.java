package com.moogle.lbs.operationdashboard.service;

import java.util.List;

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

public interface OperationDashboardService { 
	//Select distinct year from DimDate order by year desc
	public List<Integer> listYears();
	public List<String>  listDivisions();
	public List<String>  listSections();
	public List<String>  listAreas();
	public List<BranchDTO>  listBranch();
	public List<SummaryMTDDTO> getSummaryMTD(int year,int month);//not sure
	public List<SummaryMTDDivisionDTO> getSummaryMTDDivision(String division,int year,int month);
	public List<SummaryMTDDivisionSectionDTO> getSummaryMTDDivisionSection(String section,String division,int year,int month);
	public List<LucreDTO> getLucre(int year,int month ,int limit);
	public List<LossDTO> getLoss(int year,int month ,int limit);
	public List<SalesGrowthDTO> getSalesGrowth(int year,int month,int limit ,String order);
	public List<Sale_Day_PercentGrowthDTO> getSale_Day_PercentGrowth(int year,int month); // ***
	public List<NetSalesByBranchStatusDTO> getNetSalesByBranchStatus(int year,int month);
	public List<NetSalesByProductGroupDTO> getNetSalesByProductGroup(int year,int month);
	public List<NetSalesDTO> getNetSales(int year,int month,String branch,String area,String section,String division);
	public List<CostDTO> getCost(int year,int month,String branch,String area,String section,String division);
	public List<String> getProductCategories();
	public List<String> getProductGroups(String productCategory);
	public List<SalesTrendDTO> getSalesTrend(int year,int month,String branch,String area,String section,String division);
	public List<SalesBySalesTypeDTO> getSalesBySalesType(int year,int month,String branch,String area,String section,String division);
	public List<DiscountDTO> getDiscount(int year,int month,String branch,String area,String section,String division);
	public List<AverageCheckDTO> getAverageCheck(int year,int month,String branch,String area,String section,String division);
	public List<CustomerPerDayDTO> getCustomerPerDay(int year,int month,String branch,String area,String section,String division);
	public List<AverageSalesPerBillDTO>  getAverageSalesPerBill(int year,int month,String branch,String area,String section,String division);
	public List<RegionGrowthDTO> getRegionGrowth(int year,int month);
	public List<GoogleMapDTO> getGoogleMap(int year,int month);
}
