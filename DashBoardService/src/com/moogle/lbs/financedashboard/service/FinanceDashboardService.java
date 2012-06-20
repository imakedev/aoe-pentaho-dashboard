package com.moogle.lbs.financedashboard.service;

import java.util.List;

import com.moogle.lbs.financedashboard.domain.FinancialIndicationGroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialMixDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPieDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup1GroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup3DTO;
import com.moogle.lbs.financedashboard.domain.FinancialSummaryDTO;
import com.moogle.lbs.financedashboard.domain.FinancialTabDTO;

public interface FinanceDashboardService { 
	//Select distinct year from DimDate order by year desc
	public List<Integer> listYears();
	public List<FinancialIndicationGroupDTO>getFinancialIndication(int year,int month,String company);
	public List<FinancialSummaryDTO> getFinancial_YTD_Monthly_Summary(int year, int month,String sumType);
	public List<FinancialTabDTO> getFinancial_YTD_Monthly_Tab(int year, int month,String tab,String sumType);
	public List<FinancialMixDTO> getFD1_2_4(int year, int month,String graphType,String sumType,String orgType);
	public List<FinancialMixDTO> getFD1_2_4_percent(int year, int month,String sumType,String orgType);
	public List<FinancialPieDTO> getPile(int year, int month,String sumType);
	public List<FinancialPopup1GroupDTO> getPopup1(int year,
			int month, String tab, String sumType);
	public List<FinancialPopup1GroupDTO> getPopup2(int year,
			int month, String tab, String sumType);
	public List getPopup3(int year,
			int month, String tab, String sumType);
	public List<FinancialPieDTO> getBarOfPile(int year, int month,String tab,String sumType);
	public List test();
	/*public List<FinancialRestaurantDTO> getFinancialRestaurant(int year,int month);
	public List<FinancialBakeryDTO> getFinancialBakery(int year,int month);
	public List<FinancialSpecialtyDTO> getFinancialSpecialty(int year,int month);
	public List<FinancialTradingDTO> getFinancialTrading(int year,int month);
	public List<FinancialCatermanDTO> getFinancialCaterman(int year,int month);
	public List<FinancialOtherDTO> getFinancialOther(int year,int month); 
	*/
	/*public List<String>  listDivisions();
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
	public List<GoogleMapDTO> getGoogleMap(int year,int month);*/
}
