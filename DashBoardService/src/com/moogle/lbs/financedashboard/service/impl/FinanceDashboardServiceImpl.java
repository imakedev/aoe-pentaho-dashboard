package com.moogle.lbs.financedashboard.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.moogle.lbs.financedashboard.domain.FinancialIndicationDTO;
import com.moogle.lbs.financedashboard.domain.FinancialIndicationGroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialMixDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPieDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup1DTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup1GroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup3DTO;
import com.moogle.lbs.financedashboard.domain.FinancialPopup3GroupDTO;
import com.moogle.lbs.financedashboard.domain.FinancialSummaryDTO;
import com.moogle.lbs.financedashboard.domain.FinancialTabDTO;
import com.moogle.lbs.financedashboard.service.FinanceDashboardService;

/**
 * @author Chatchai Pimtun
 */
@Repository
@Transactional
public class FinanceDashboardServiceImpl implements FinanceDashboardService {

	private final String[] shortmonthNameG={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	private SessionFactory sessionAnnotationFactoryOP;

	public SessionFactory getSessionAnnotationFactoryOP() {
		return sessionAnnotationFactoryOP;
	}

	public void setSessionAnnotationFactoryOP(
			SessionFactory sessionAnnotationFactoryOP) {
		this.sessionAnnotationFactoryOP = sessionAnnotationFactoryOP;
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	public List<Integer> listYears() {
		// TODO Auto-generated method stub
		String sql="select distinct dimdate.year from Dimdate as dimdate   order by dimdate.year desc ";
		System.out.println(" debug sql listYears===>"+sql);
		List<Integer> list = null;
		try{
		Session session = this.sessionAnnotationFactoryOP.getCurrentSession();
		
		list = session
				.createQuery(
						sql)
				.list();
		System.out.println(list);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<FinancialIndicationGroupDTO> getFinancialIndication(int year,
			int month, String company) {
		// TODO Auto-generated method stub
		List groupList=null;
		try{
		 groupList=new ArrayList<FinancialIndicationGroupDTO>();
		String sqlGroup = "select rr.RatioGroupName from FinancialRatioResult as rr "
				+ " left join  DimDate as dd on rr.DateKey = dd.DateKey"
				+ "  where dd.Year  =:year and dd.MonthNo = :month "
				+ " and rr.Company =:company  group by   rr.RatioGroupName  Order by rr.Seqno ";
		SQLQuery queryGroup = this.sessionAnnotationFactoryOP
				.getCurrentSession().createSQLQuery(sqlGroup);
		queryGroup.setParameter("year", year);
		queryGroup.setParameter("month", month);
		queryGroup.setParameter("company", company);
		List resultGroup = queryGroup.list();
		int sizeGroup = resultGroup.size();
		for (int i = 0; i < sizeGroup; i++) {
			String sql = "";
			String objGroup = (String) resultGroup.get(i);
			FinancialIndicationGroupDTO group=new FinancialIndicationGroupDTO();
			sql = " Select "
					+ " rr.RatioGroupName as ratioGroupName, rr.RatioName as ratioName, rr.ThisPeriodValue as thisPeriodValue, "
					+ " rr.TrendFlag as trendFlag " + " From  "
					+ " FinancialRatioResult as rr, DimDate as dd " + " Where  "
					+ " rr.DateKey = dd.DateKey and " + " dd.Year =:year and "
					+
					" dd.MonthNo =:month and "
					+
					" rr.Company =:company  and"
					+ " rr.RatioGroupName=:ratioGroupName" + " Order by Seqno ";
           // System.out.println("sql="+sql);
			SQLQuery query = this.sessionAnnotationFactoryOP
					.getCurrentSession().createSQLQuery(sql);
			query.setParameter("year", year);
			query.setParameter("month", month);
			query.setParameter("company", company);
			query.setParameter("ratioGroupName", objGroup);
			group.setRatioGroupName(objGroup);
			List result = query.list();
			int size = result.size();
			for (int j = 0; j < size; j++) {
				Object[] obj = (Object[]) result.get(j);
				FinancialIndicationDTO financialIndicationDTO = new FinancialIndicationDTO();
				/*financialIndicationDTO
						.setRatioGroupName(obj[0] != null ? obj[0] + "" : "");*/
				financialIndicationDTO.setRatioName(obj[1] != null ? obj[1]
						+ "" : "");
				financialIndicationDTO
						.setThisPeriodValue(obj[2] != null ? obj[2] + "" : "");
				financialIndicationDTO.setTrendFlag(obj[3] != null ? obj[3]
						+ "" : "");
				result.set(j, financialIndicationDTO);
			}
			group.setFinancialIndicationDTO(result);
			groupList.add(group);
		}
		}catch (Exception ex) {
			// TODO: handle exception
			ex.printStackTrace();
		}
		return groupList;
	}

	@Override
	public List<FinancialSummaryDTO> getFinancial_YTD_Monthly_Summary(int year,
			int month, String sumType) { 
		String sql=
				"select M_No, M_Name, sum(ThisYearActualMonthly)/1000, sum(ThisYearBudgetMONTHLY)/1000, sum(LastYearActualMONTHLY)/1000,"+
                " ((sum(ThisYearActualMONTHLY) - sum(ThisYearBudgetMONTHLY))/sum(ThisYearBudgetMONTHLY)) * 100 as PercentVarianceMONTHLY,"+
                " ((sum(ThisYearActualMONTHLY) - sum(LastYearActualMONTHLY))/sum(LastYearActualMONTHLY)) * 100 as PercentGrowthMONTHLY"+  
                " from"+
                " (select dd1.MonthNo as M_No, dd1.MonthName as M_Name,"+ 
                " sum(fcs1.BalanceAmount) as ThisYearActualMONTHLY,"+
                " sum(fcs1.BudgetAmount) as ThisYearBudgetMONTHLY,"+
                " 0 as LastYearActualMONTHLY"+
                " from FinCompanySummary as fcs1 , DimDate as dd1" +
                //", DimAccount as da1,   MapAccountProductGroup as map1, DimOrg as do1"+
                " where fcs1.DateKey = dd1.DateKey and"+
                " dd1.Year = :year and"+
                " dd1.MonthNo between 1 and :month  and"+
                " fcs1.ItemID = 3"+
                " group by dd1.MonthNo, dd1.MonthName"+ 
               /* " where fab1.DateKey = dd1.DateKey and"+
                " fab1.OrgKey = do1.OrgKey and"+
                " fab1.AccountKey = da1.AccountKey and"+
                " da1.CompanyCode = map1.CompanyCode and"+
                " da1.AccountCode = map1.AccountCode and"+
                " da1.SubsidiaryCode = map1.SubsidiaryCode and"+
                " dd1.Year = :year  and "+
                " dd1.MonthNo between 1 and :month and"+ 
                " do1.CompanyCode = '00100' and"+
                " da1.CompanyCode = '00100' and"+
                " map1.TemplateID = 1 and"+
                " map1.CompanyCode = '00100' and"+
                " map1.AccountGroup in ('SS', 'DS')"+
                " group by dd1.MonthNo"+*/
                
                " union"+
                " select dd2.MonthNo as M_No, dd2.MonthName as M_Name, 0 as ThisYearActualMONTHLY, 0 as ThisYearBudgetMONTHLY,"+
                " sum(fcs2.BalanceAmount) as LastYearActualMONTHLY"+
                " from FinCompanySummary as fcs2, DimDate as dd2 " +
                //", DimAccount as da2,   MapAccountProductGroup as map2, DimOrg as do2"+
                " where fcs2.DateKey = dd2.DateKey and " +
                " dd2.Year =:year- 1 and " +
                " dd2.MonthNo between 1 and :month  and " +
                " fcs2.ItemID = 3  " +
                " group by dd2.MonthNo, dd2.MonthName) as result " +
                " group by M_No, M_Name  " +
                " order by M_No " ;
               /* " where fcs2.DateKey = dd2.DateKey and"+
                " fab2.OrgKey = do2.OrgKey and"+
                " fab2.AccountKey = da2.AccountKey and"+
                " da2.CompanyCode = map2.CompanyCode and"+
                " da2.AccountCode = map2.AccountCode and"+
                " da2.SubsidiaryCode = map2.SubsidiaryCode and"+
                " dd2.Year =:year - 1 and"+
                " dd2.MonthNo between 1 and :month and"+
                " do2.CompanyCode = '00100' and"+
                " da2.CompanyCode = '00100' and"+
                " map2.TemplateID = 1 and"+
                " map2.CompanyCode = '00100' and"+
                " map2.AccountGroup in ('SS', 'DS')"+
                " group by dd2.MonthNo) as result"+
                " group by M_No, M_Name "+
                " order by M_No";*/
		//System.out.println("query is ==> " + sql);
		SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
				.createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj = (Object[]) result.get(i);
			FinancialSummaryDTO financialsummarydto = new FinancialSummaryDTO();
			financialsummarydto.setMno(obj[0] != null ? obj[0] + "" : "");
			financialsummarydto.setMname(obj[1] != null ? obj[1] + "" : "");
			financialsummarydto
					.setSumThisYearActualMonthly(obj[2] != null ? obj[2] + ""
							: "");
			financialsummarydto
					.setSumThisYearBudgetMONTHLY(obj[3] != null ? obj[3] + ""
							: "");
			financialsummarydto
					.setSumLastYearActualMONTHLY(obj[4] != null ? obj[4] + ""
							: "");
			financialsummarydto
					.setPercentVarianceMONTHLY(obj[5] != null ? obj[5] + ""
							: "");
			financialsummarydto.setPercentGrowthMONTHLY(obj[6] != null ? obj[6]
					+ "" : "");
			result.set(i, financialsummarydto);
		}
		return result;
	}

	@Override
	public List<FinancialTabDTO> getFinancial_YTD_Monthly_Tab(int year,
			int month, String tab, String sumType) {
		// sumType 6 ==>YTD , 7 ==>Monthly
		/****
		*** ถ้าเลือก tab Restaurant
 do1.RevenueGroupDesc = 'Restaurant' 

*** ถ้าเลือก tab Bakery
 do1.RevenueGroupDesc = 'Shop'  

*** ถ้าเลือก tab Specialty
do1.RevenueGroupDesc = 'Specialty'

 *** ถ้าเลือก tab Trading
do1.RevenueGroupDesc = 'Trading'

*** ถ้าเลือก tab Caterman
do1.RevenueGroupDesc = 'Caterman'  

*** ถ้าเลือก tab Other
do1.RevenueGroupDesc = 'Other'

*** ถ้าเลือก tab Restaurant
 do2.RevenueGroupDesc = 'Restaurant' 

*** ถ้าเลือก tab Bakery
 do2.RevenueGroupDesc = 'Shop'  

*** ถ้าเลือก tab Specialty
do2.RevenueGroupDesc = 'Specialty'

 *** ถ้าเลือก tab Trading
do2.RevenueGroupDesc = 'Trading'

*** ถ้าเลือก tab Caterman
do2.RevenueGroupDesc = 'Caterman'  

*** ถ้าเลือก tab Other
do2.RevenueGroupDesc = 'Other'
		*/
		 
		String q1 = "";
		String q2 = "";
		if (tab.equals("Restaurant")) {
			q1 = " do1.RevenueGroupDesc = 'Restaurant'  ";
			q2 = " do2.RevenueGroupDesc = 'Restaurant'  ";
		} else if (tab.equals("Bakery")) {
			q1 = " do1.RevenueGroupDesc = 'Shop'  ";
			q2 = " do2.RevenueGroupDesc = 'Shop'  ";
		} else if (tab.equals("Specialty")) {
			q1 = " do1.RevenueGroupDesc = 'Specialty'  ";
			q2 = " do2.RevenueGroupDesc = 'Specialty'  ";
			/*q1 = " do1.Cate20 between '017' and '022' and do1.Cate20 between '060' and '061' ";
			q2 = " do2.Cate20 between '017' and '022' and do2.Cate20 between '060' and '061' ";*/
		} else if (tab.equals("Trading")) {
			q1 = " do1.RevenueGroupDesc = 'Trading'  ";
			q2 = " do2.RevenueGroupDesc = 'Trading'  ";
			/*q1 = " do1.Cate20 between '028' and '030' ";
			q2 = " do2.Cate20 between '028' and '030' ";*/
		} else if (tab.equals("Caterman")) {
			q1 = " do1.RevenueGroupDesc = 'Caterman'  ";
			q2 = " do2.RevenueGroupDesc = 'Caterman'  ";
			/*q1 = " do1.Cate20 = '033' ";
			q2 = " do2.Cate20 = '033'  ";*/
		} else if (tab.equals("Other")) {
			q1 = " do1.RevenueGroupDesc = 'Other'  ";
			q2 = " do2.RevenueGroupDesc = 'Other'  ";
			/*q1 = " do1.Cate20 between '045' and '059' ";
			q2 = " do2.Cate20 between '045' and '059' ";*/

		} 
		String sql=" select M_No, M_Name, sum(ThisYearActualMonthly)/1000, sum(ThisYearBudgetMONTHLY)/1000, sum(LastYearActualMONTHLY)/1000, "+
				" ((sum(ThisYearActualMONTHLY) - sum(ThisYearBudgetMONTHLY))/sum(ThisYearBudgetMONTHLY)) * 100 as PercentVarianceMONTHLY, "+
				" ((sum(ThisYearActualMONTHLY) - sum(LastYearActualMONTHLY))/sum(LastYearActualMONTHLY)) * 100 as PercentGrowthMONTHLY "+
				" from "+
				" (select dd1.MonthNo as M_No, dd1.MonthName as M_Name, "+  
				" sum(fos1.BalanceAmount) as ThisYearActualMONTHLY,"+
				" sum(fos1.BudgetAmount) as ThisYearBudgetMONTHLY,"+
				" 0 as LastYearActualMONTHLY"+
				" from FinOrgSummary as fos1 , DimDate as dd1" +
				//" ,DimAccount as da1,   MapAccountProductGroup as map1" +
				", DimOrg as do1"+
				"  where fos1.DateKey = dd1.DateKey and "+
				"  fos1.OrgKey = do1.OrgKey and  "+
				"  dd1.Year =:year and"+
				"  dd1.MonthNo between 1 and :month  and "+
				"  fos1.ItemID = 3 and "+

				/*" where fab1.DateKey = dd1.DateKey and"+
				" fab1.OrgKey = do1.OrgKey and"+
				" fab1.AccountKey = da1.AccountKey and"+
				" da1.CompanyCode = map1.CompanyCode and"+
				" da1.AccountCode = map1.AccountCode and"+
				" da1.SubsidiaryCode = map1.SubsidiaryCode and"+
				" dd1.Year =:year and"+
				" dd1.MonthNo between 1 and :month and"+
				" do1.CompanyCode = '00100' and "+
				" da1.CompanyCode = '00100' and"+
				" map1.TemplateID = 1 and"+
				" map1.CompanyCode = '00100' and"+
				" map1.AccountGroup in ('SS', 'DS') and "+*/
				 q1 +
				" group by dd1.MonthNo"+
				" union"+
				" select dd2.MonthNo as M_No, dd2.MonthName as M_Name, 0 as ThisYearActualMONTHLY, 0 as ThisYearBudgetMONTHLY,"+
				" sum(fos2.BalanceAmount) as LastYearActualMONTHLY"+
				" from FinOrgSummary as fos2 , DimDate as dd2" +
				//", DimAccount as da2,   MapAccountProductGroup as map2
				" , DimOrg as do2"+
				" where fos2.DateKey = dd2.DateKey and "+ 
				" fos2.OrgKey = do2.OrgKey and "+
				" dd2.Year = :year-1 and "+
				" dd2.MonthNo between 1 and :month and "+
				" fos2.ItemID = 3 and "+
				/*" where fab2.DateKey = dd2.DateKey and"+
				" fab2.OrgKey = do2.OrgKey and"+
				" fab2.AccountKey = da2.AccountKey and"+
				" da2.CompanyCode = map2.CompanyCode and"+
				" da2.AccountCode = map2.AccountCode and"+
				" da2.SubsidiaryCode = map2.SubsidiaryCode and"+
				" dd2.Year =:year -1 and"+
				" dd2.MonthNo between 1 and :month  and"+
				" do2.CompanyCode = '00100' and "+
				" da2.CompanyCode = '00100' and"+
				" map2.TemplateID = 1 and"+
				" map2.CompanyCode = '00100' and"+
				" map2.AccountGroup in ('SS','DS') and "+*/
				q2 +
				" 		group by dd2.MonthNo, dd2.MonthName) as result"+
				" group by M_No, M_Name "+
				" order by M_No";
		/*String sql = " select M_No ,M_Name, sum(ThisYearActualMonthly) as sumThisYearActualMonthly, sum(ThisYearBudgetMONTHLY) as sumThisYearBudgetMONTHLY, sum(LastYearActualMONTHLY) as sumLastYearActualMONTHLY, "
				+ "  ((sum(ThisYearActualMONTHLY) - sum(ThisYearBudgetMONTHLY))/sum(ThisYearBudgetMONTHLY)) * 100 as percentVarianceMONTHLY, "
				+ "  ((sum(ThisYearActualMONTHLY) - sum(LastYearActualMONTHLY))/sum(LastYearActualMONTHLY)) * 100 as percentGrowthMONTHLY "
				+ "  from "
				+ "  (select dd1.MonthNo as M_No, dd1.MonthName as M_Name, "
				+ "  sum(fab1.BalanceAmount) as ThisYearActualMONTHLY, "
				+ "  sum(fab1.BudgetAmount) as ThisYearBudgetMONTHLY, "
				+ "  0 as LastYearActualMONTHLY "
				+ "  from factaccountbalance fab1, dimdate dd1, dimaccount da1, mapaccountproductgroup map1, dimorg do1 "
				+ "  where fab1.DateKey = dd1.DateKey and "
				+ "  fab1.OrgKey = do1.OrgKey and "
				+ "  fab1.AccountKey = da1.AccountKey and "
				+ "  da1.CompanyCode = map1.CompanyCode and "
				+ "  da1.AccountCode = map1.AccountCode and "
				+ "  da1.SubsidiaryCode = map1.SubsidiaryCode and  "
				+
				" year(dd1.Date) =:year and "
				+
				"  month(dd1.Date) between 1 and :month and "
				+ "  do1.CompanyCode = '100' and " + ""
				+ q1
				+ ""
				+
				"  da1.CompanyCode = '100' and "
				+ "  map1.CompanyCode = '100' and "
				+ "  map1.AccountFlag = 'S' "
				+ "  group by dd1.MonthNo "
				+ "  union "
				+ "  select dd2.MonthNo as M_No, dd2.MonthName as M_Name, 0 as ThisYearActualMONTHLY, 0 as ThisYearBudgetMONTHLY,  "
				+ "  sum(fab2.BalanceAmount) as LastYearActualMONTHLY "
				+ "  from factaccountbalance fab2, dimdate dd2, dimaccount da2, mapaccountproductgroup map2, dimorg do2 "
				+ "  where fab2.DateKey = dd2.DateKey and "
				+ "  fab2.OrgKey = do2.OrgKey and "
				+ "  fab2.AccountKey = da2.AccountKey and "
				+ "  da2.CompanyCode = map2.CompanyCode and "
				+ "  da2.AccountCode = map2.AccountCode and "
				+ "  da2.SubsidiaryCode = map2.SubsidiaryCode and "
				+
				" year(dd2.Date) =:year-1 and "
				+
				"  month(dd2.Date) between 1 and :month and "
				+ "  do2.CompanyCode = '100' and "
				+ ""
				+ q2
				+ ""
				+
				"  da2.CompanyCode = '100' and  "
				+ "  map2.CompanyCode = '100' and  "
				+ "  map2.AccountFlag = 'S'  "
				+ "  group by dd2.MonthNo) as result " + "  order by M_No ";*/
		//System.out.println("query is ==> " + sql);
		SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
				.createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj = (Object[]) result.get(i);
			FinancialTabDTO financialTabDTO = new FinancialTabDTO();
			financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
			financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");
			financialTabDTO.setSumThisYearActualMonthly(obj[2] != null ? obj[2]
					+ "" : "");
			financialTabDTO.setSumThisYearBudgetMONTHLY(obj[3] != null ? obj[3]
					+ "" : "");
			financialTabDTO.setSumLastYearActualMONTHLY(obj[4] != null ? obj[4]
					+ "" : "");
			financialTabDTO.setPercentVarianceMONTHLY(obj[5] != null ? obj[5]
					+ "" : "");
			financialTabDTO.setPercentGrowthMONTHLY(obj[6] != null ? obj[6]
					+ "" : "");
			result.set(i, financialTabDTO);
		}
		return result;
		/*
		 * query.addEntity("financialTabDTO", FinancialTabDTO.class); return
		 * (List<FinancialTabDTO>)query.list();
		 */
	}

	@Override
	public List<FinancialMixDTO> getFD1_2_4(int year, int month,
			String graphType, String sumType,String orgType) {
		// sumType 6 ==>YTD , 7 ==>Monthly
		try{
		/****
		 
		*/
	
		String q1 = "";
		String q2 = "";
		String q1_type = "";
		String q2_type = "";
		String sumtype1 = "";
		String sumtype2 = "";
		boolean haveOrgType=false;
		if(orgType!=null && orgType.length()>0 && !orgType.equals("null")){
			haveOrgType=true;
			if (orgType.equals("Restaurant")) {
				q1_type = " do1.RevenueGroupDesc = 'Restaurant' and ";
				q2_type = " do2.RevenueGroupDesc = 'Restaurant' and ";
			} else if (orgType.equals("Bakery")) {
				q1_type = " do1.RevenueGroupDesc = 'Shop' and ";
				q2_type = " do2.RevenueGroupDesc = 'Shop'  and ";
			} else if (orgType.equals("Specialty")) {
				q1_type = " do1.RevenueGroupDesc = 'Specialty' and  ";
				q2_type = " do2.RevenueGroupDesc = 'Specialty' and ";
				/*q1 = " do1.Cate20 between '017' and '022' and do1.Cate20 between '060' and '061' ";
				q2_type = " do2.Cate20 between '017' and '022' and do2.Cate20 between '060' and '061' ";*/
			} else if (orgType.equals("Trading")) {
				q1_type = " do1.RevenueGroupDesc = 'Trading' and ";
				q2_type = " do2.RevenueGroupDesc = 'Trading'  and ";
				/*q1 = " do1.Cate20 between '028' and '030' ";
				q2 = " do2.Cate20 between '028' and '030' ";*/
			} else if (orgType.equals("Caterman")) {
				q1_type = " do1.RevenueGroupDesc = 'Caterman' and ";
				q2_type = " do2.RevenueGroupDesc = 'Caterman' and ";
				/*q1 = " do1.Cate20 = '033' ";
				q2 = " do2.Cate20 = '033'  ";*/
			} else if (orgType.equals("Other")) {
				q1_type = " do1.RevenueGroupDesc = 'Other' and ";
				q2_type = " do2.RevenueGroupDesc = 'Other' and ";
				/*q1 = " do1.Cate20 between '045' and '059' ";
				q2 = " do2.Cate20 between '045' and '059' ";*/

			}
		} 
		if (graphType.equals("0")) {  			
			q1=" fcs1.ItemID = 3 and ";
			q2=" fcs2.ItemID = 3 and ";
			/*q1 = " map1.AccountGroup in ('SS', 'DS') and ";
			q2 = " map2.AccountGroup in ('SS', 'DS') and  ";*/
		} else if (graphType.equals("1")) {
			/*q1 = " map1.AccountGroup in  ('SS', 'DS', 'CS') and ";
			q2 = " map2.AccountGroup in ('SS', 'DS', 'CS') and  ";*/
			q1=" fcs1.ItemID = 5 and ";
			q2=" fcs2.ItemID = 5 and ";
		} else if (graphType.equals("2")) {			
			/*q1 = " map1.AccountGroup    in ('SS', 'DS', 'CS', 'ES') and ";
			q2 = " map2.AccountGroup    in ('SS', 'DS', 'CS', 'ES') and ";*/
			q1=" fcs1.ItemID = 9 and ";
			q2=" fcs2.ItemID = 9 and ";
		} else if (graphType.equals("3")) {
			 
			/*q1 = "   ";
			q2 = "  ";*/
			q1=" fcs1.ItemID = 18 and ";
			q2=" fcs2.ItemID = 18 and ";
		} 
		// query sumType
	 
		
		if (sumType.equals("1")) {//YTD vs Last YTD
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"  ";
			sumtype2 = " dd2.Year ="+year+" - 1 and"+
                       " dd2.MonthNo between 1 and "+month+"   ";  
		 
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			 
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+" ";*/
			sumtype2="dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
					" dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
					" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" ";
			sumtype2 = " dd2.Year = "+year+" - 1 and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" ";
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+" "; 
			sumtype2 =" dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month ) ";*/
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+" ";
		 
			 sumtype2 = " dd2.Year = "+year+" - 1 and"+
					 " dd2.MonthNo = "+month+"";
	   } 
		/*Select
		FORMAT((sum(ThisActual)/1000000),2)*/
		 
		String sql=" select  sum(ThisActual)/1000000, sum(ThisBudget)/1000000, sum(LastActual)/1000000,"+
				" FORMAT( (((sum(ThisActual) - sum(ThisBudget))/sum(ThisBudget)) * 100),2) as PercentVariance,"+
				" FORMAT( (((sum(ThisActual) - sum(LastActual))/sum(LastActual)) * 100),2 ) as PercentGrowth"+ 
				" from"+
				" (select sum(fcs1.BalanceAmount) as ThisActual,"+
				" sum(fcs1.BudgetAmount) as ThisBudget,"+
				" 0 as LastActual"+
				  (haveOrgType?" from FinOrgSummary fcs1 ":" from FinCompanySummary fcs1 ")+
				//" from FinCompanySummary as fcs1, DimDate as dd1 " +
				  " , DimDate as  dd1 "+
				(haveOrgType?", DimOrg do1 ":" ")+
				//", DimAccount as da1,   MapAccountProductGroup as map1, DimOrg as do1"+
				" where fcs1.DateKey = dd1.DateKey and"+
				 (haveOrgType?"  fcs1.OrgKey = do1.OrgKey and   ":" ")+
				/*" fab1.OrgKey = do1.OrgKey and"+
				" fab1.AccountKey = da1.AccountKey and"+
				" da1.CompanyCode = map1.CompanyCode and"+
				" da1.AccountCode = map1.AccountCode and"+
				" da1.SubsidiaryCode = map1.SubsidiaryCode and"+
				" da1.CompanyCode = '00100' and"+
				" map1.TemplateID = 1 and"+
				" map1.CompanyCode = '00100' and "+*/
			//	" map1.AccountGroup in ('SS', 'DS') " +
				q1+
				q1_type+
				// " and"+
				//" do1.CompanyCode = '00100' and "+ 
                //            -- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
               /* " dd1.Year ="+year+" and"+
                " dd1.MonthNo between 1 and "+month+" "+*/
                sumtype1+
/*
*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
 dd1.Year = ?Year Parameter and
 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter

*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
dd1.Year = ?Year Parameter and
 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter

*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
 dd1.Year = ?Year Parameter and
 dd1.MonthNo = ?Month Parameter

*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
 dd1.Year = ?Year Parameter and
 dd1.MonthNo = ?Month Parameter
*/
              
                " union "+
                " select 0 as ThisActual, 0 as ThisBudget,"+
                " sum(fcs2.BalanceAmount) as LastActual"+
                (haveOrgType?" from FinOrgSummary fcs2 ":" from FinCompanySummary fcs2 ")+
                " , DimDate as dd2 "+
                //" from FinCompanySummary as fcs2, DimDate as dd2" +
            	(haveOrgType?", DimOrg do2 ":" ")+
                //", DimAccount as da2,   MapAccountProductGroup as map2, DimOrg as do2"+
                " where fcs2.DateKey = dd2.DateKey and"+
                (haveOrgType?"  fcs2.OrgKey = do2.OrgKey and   ":" ")+
               /* " fab2.OrgKey = do2.OrgKey and"+
                " fab2.AccountKey = da2.AccountKey and"+
                " da2.CompanyCode = map2.CompanyCode and"+
                " da2.AccountCode = map2.AccountCode and"+
                " da2.SubsidiaryCode = map2.SubsidiaryCode and"+
                " da2.CompanyCode = '00100' and"+
                " map2.TemplateID = 1 and"+
                " map2.CompanyCode = '00100' and "+*/
              //  " map2.AccountGroup in ('SS', 'DS') " +
                 q2+
                 q2_type+
              //  " and"+
              //  " do2.CompanyCode = '00100' and "+

//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
                sumtype2+
               /* " dd2.Year ="+year+" - 1 and"+
                " dd2.MonthNo between 1 and "+month+" "+*/
/*
*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
 dd2.Year = ?Year Parameter and
 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month)/3)*3-2,'-1')), '%c') and ?Month Parameter

*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
dd2.Year = ?Year Parameter - 1 and
 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter

*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
 dd2.Year = ?Year Parameter and
 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 1 month) 

*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
 dd2.Year = ?Year Parameter - 1 and
 dd2.MonthNo = ?Month Parameter
*/
                " ) as result";

		System.out.println("query is ==> " + sql);
		SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
				.createSQLQuery(sql);
		/*query.setParameter("year", year);
		query.setParameter("month", month);*/
		List result = query.list();
		//System.out.println("xxxxxxxxxxxxxxxxxxxxxx = "+result);
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj = (Object[]) result.get(i); 
			FinancialMixDTO financialMixDTO = new FinancialMixDTO();
			/*financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
			financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");*/
			financialMixDTO.setSumThisYearActualMonthly(obj[0] != null ? obj[0]
					+ "" : "");
			financialMixDTO.setSumThisYearBudgetMONTHLY(obj[1] != null ? obj[1]
					+ "" : "");
			financialMixDTO.setSumLastYearActualMONTHLY(obj[2] != null ? obj[2]
					+ "" : "");
			financialMixDTO.setPercentVarianceMONTHLY(obj[3] != null ? obj[3]
					+ "" : "");
			financialMixDTO.setPercentGrowthMONTHLY(obj[4] != null ? obj[4]
					+ "" : "");
			result.set(i, financialMixDTO);
		}
		return result;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
		 
	}
	public List<FinancialMixDTO> getFD1_2_4_percent(int year, int month,String sumType,String orgType){
    // sumType 6 ==>YTD , 7 ==>Monthly
		try{
	List resultPercent=new ArrayList(2);
	  for(int j=0;j<3;j++){
		String q1 = "";
		String q2 = "";
		String sumtype1 = "";
		String sumtype2 = ""; 
		String q1_type = "";
		String q2_type = ""; 
		boolean haveOrgType=false;
		if(j==0){  //ยอดขาย
		  /*  q1 = " map1.AccountGroup in ('SS', 'DS') and ";
			q2 = " map2.AccountGroup in ('SS', 'DS') and  ";*/
			q1=" fcs1.ItemID = 3 and ";
			q2=" fcs2.ItemID = 3 and ";
		}else if(j==1){ // - หาต้นทุน ใช้ query เดียวกับยอดขาย เปลี่ยน 
		/*	q1 = " map1.AccountGroup = 'CS' and ";
			q2 = " map2.AccountGroup = 'CS' and  ";*/
			q1=" fcs1.ItemID = 4 and ";
			q2=" fcs2.ItemID = 4 and ";
		}else if(j==2){ //- หาค่าใช้จ่าย ใช้ query เดียวกับยอดขาย เปลี่ยน 
			/*q1 = " map1.AccountGroup in ('ES', 'ESS', 'ESB') and ";
			q2 = " map2.AccountGroup in ('ES', 'ESS', 'ESB') and  ";*/
			q1=" fcs1.ItemID in (6,7) and ";
			q2=" fcs2.ItemID in (6,7) and ";
		}
		// query sumType
		if(orgType!=null && orgType.length()>0 && !orgType.equals("null")){
			haveOrgType=true;
			if (orgType.equals("Restaurant")) {
				q1_type = " do1.RevenueGroupDesc = 'Restaurant' and ";
				q2_type = " do2.RevenueGroupDesc = 'Restaurant' and ";
			} else if (orgType.equals("Bakery")) {
				q1_type = " do1.RevenueGroupDesc = 'Shop' and ";
				q2_type = " do2.RevenueGroupDesc = 'Shop'  and ";
			} else if (orgType.equals("Specialty")) {
				q1_type = " do1.RevenueGroupDesc = 'Specialty' and  ";
				q2_type = " do2.RevenueGroupDesc = 'Specialty' and ";
				/*q1 = " do1.Cate20 between '017' and '022' and do1.Cate20 between '060' and '061' ";
				q2_type = " do2.Cate20 between '017' and '022' and do2.Cate20 between '060' and '061' ";*/
			} else if (orgType.equals("Trading")) {
				q1_type = " do1.RevenueGroupDesc = 'Trading' and ";
				q2_type = " do2.RevenueGroupDesc = 'Trading'  and ";
				/*q1 = " do1.Cate20 between '028' and '030' ";
				q2 = " do2.Cate20 between '028' and '030' ";*/
			} else if (orgType.equals("Caterman")) {
				q1_type = " do1.RevenueGroupDesc = 'Caterman' and ";
				q2_type = " do2.RevenueGroupDesc = 'Caterman' and ";
				/*q1 = " do1.Cate20 = '033' ";
				q2 = " do2.Cate20 = '033'  ";*/
			} else if (orgType.equals("Other")) {
				q1_type = " do1.RevenueGroupDesc = 'Other' and ";
				q2_type = " do2.RevenueGroupDesc = 'Other' and ";
				/*q1 = " do1.Cate20 between '045' and '059' ";
				q2 = " do2.Cate20 between '045' and '059' ";*/

			}
		} 
		
		if (sumType.equals("1")) {//YTD vs Last YTD
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"  ";
			sumtype2 = " dd2.Year ="+year+" - 1 and"+
                       " dd2.MonthNo between 1 and "+month+"   ";
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype2="dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
					" dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
					" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+" ";*/
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" ";
			sumtype2 = " dd2.Year = "+year+" - 1 and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" ";
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+" "; 
			sumtype2 =" dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) "; 
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+" ";
		 
			 sumtype2 = " dd2.Year = "+year+" - 1 and"+
					 " dd2.MonthNo = "+month+"";
	   } 
		String sql=" select  sum(ThisActual)/1000000, sum(ThisBudget)/1000000, sum(LastActual)/1000000,"+
				" ((sum(ThisActual) - sum(ThisBudget))/sum(ThisBudget)) * 100 as PercentVariance,"+
				" ((sum(ThisActual) - sum(LastActual))/sum(LastActual)) * 100 as PercentGrowth"+
				" from"+
				/*" (select sum(fab1.BalanceAmount*map1.AccountSign) as ThisActual,"+
				" sum(fab1.BudgetAmount*map1.AccountSign) as ThisBudget,"+*/
				" (select sum(fcs1.BalanceAmount) as ThisActual,"+
				" sum(fcs1.BudgetAmount) as ThisBudget,"+
				" 0 as LastActual"+
			//	" from FinCompanySummary as fcs1, DimDate as dd1" +
			(haveOrgType?" from FinOrgSummary fcs1 ":" from FinCompanySummary fcs1 ")+
			" , DimDate as dd1 "+
				(haveOrgType?", DimOrg do1 ":" ")+
				//", DimAccount as da1,   MapAccountProductGroup as map1, DimOrg as do1"+
				" where fcs1.DateKey = dd1.DateKey and "+
				(haveOrgType?"  fcs1.OrgKey = do1.OrgKey and   ":" ")+
				/*" where fab1.DateKey = dd1.DateKey and"+
				" fab1.OrgKey = do1.OrgKey and"+
				" fab1.AccountKey = da1.AccountKey and"+
				" da1.CompanyCode = map1.CompanyCode and"+
				" da1.AccountCode = map1.AccountCode and"+
				" da1.SubsidiaryCode = map1.SubsidiaryCode and"+
				" da1.CompanyCode = '00100' and"+
				" map1.TemplateID = 1 and"+
				" map1.CompanyCode = '00100' and "+ */
				q1+
				q1_type+ 
				//" do1.CompanyCode = '00100' and "+  
                sumtype1+ 
                " union "+
                " select 0 as ThisActual, 0 as ThisBudget,"+
               // " sum(fab2.BalanceAmount*map2.AccountSign) as LastActual"+
               " sum(fcs2.BalanceAmount) as LastActual"+
               (haveOrgType?" from FinOrgSummary fcs2 ":" from FinCompanySummary fcs2 ")+
               //   " from FinCompanySummary as fcs2, DimDate as dd2" +
               " , DimDate as dd2 "+
                (haveOrgType?", DimOrg do2 ":" ")+
                //", DimAccount as da2,   MapAccountProductGroup as map2, DimOrg as do2"+
                " where fcs2.DateKey = dd2.DateKey and "+
                (haveOrgType?"  fcs2.OrgKey = do2.OrgKey and   ":" ")+
              /*  " where fab2.DateKey = dd2.DateKey and"+
                " fab2.OrgKey = do2.OrgKey and"+
                " fab2.AccountKey = da2.AccountKey and"+
                " da2.CompanyCode = map2.CompanyCode and"+
                " da2.AccountCode = map2.AccountCode and"+
                " da2.SubsidiaryCode = map2.SubsidiaryCode and"+
                " da2.CompanyCode = '00100' and"+
                " map2.TemplateID = 1 and"+
                " map2.CompanyCode = '00100' and "+ */
                 q2+
                  q2_type+ 
              //  " do2.CompanyCode = '00100' and "+ 
                sumtype2+
                " ) as result";

		 System.out.println("query["+j+"] is ==> " + sql);
		SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
				.createSQLQuery(sql); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj = (Object[]) result.get(i); 
			FinancialMixDTO financialMixDTO = new FinancialMixDTO();
			/*financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
			financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");*/
			financialMixDTO.setSumThisYearActualMonthly(obj[0] != null ? obj[0]
					+ "" : "");
			financialMixDTO.setSumThisYearBudgetMONTHLY(obj[1] != null ? obj[1]
					+ "" : "");
			financialMixDTO.setSumLastYearActualMONTHLY(obj[2] != null ? obj[2]
					+ "" : "");
			financialMixDTO.setPercentVarianceMONTHLY(obj[3] != null ? obj[3]
					+ "" : "");
			financialMixDTO.setPercentGrowthMONTHLY(obj[4] != null ? obj[4]
					+ "" : "");
			SQLQuery query2 = this.sessionAnnotationFactoryOP.getCurrentSession()
					.createSQLQuery(sql);
			result.set(i, financialMixDTO);
		}
		resultPercent.add(j,result);
		//return result;
		 
	  }
	  // ยอดขาย
	  // ต้นทุน
	  //ค่าใช้จ่าย
	  if(resultPercent!=null && resultPercent.size()==3){
		  if(resultPercent.get(0)!=null && resultPercent.get(1)!=null && resultPercent.get(2)!=null){
			 List<FinancialMixDTO> financialMixs_1= (List<FinancialMixDTO>) resultPercent.get(0);
			 List<FinancialMixDTO> financialMixs_2= (List<FinancialMixDTO>) resultPercent.get(1);
			 List<FinancialMixDTO> financialMixs_3= (List<FinancialMixDTO>) resultPercent.get(2);
			 if(financialMixs_1.size()>0 && financialMixs_2.size()>0 && financialMixs_2.size()>0){
				 FinancialMixDTO dto1=financialMixs_1.get(0);
				 FinancialMixDTO dto2=financialMixs_2.get(0);
				 FinancialMixDTO dto3=financialMixs_3.get(0);
				 List resultReturn=new ArrayList(3);
				 resultReturn.add(dto1);
				 resultReturn.add(dto2);
				 resultReturn.add(dto3);
				 //System.out.println("xxxxxxxxxxxx="+resultReturn);
				 return resultReturn;
				/* FinancialMixPercentDTO percent1=new FinancialMixPercentDTO();
				 if(dto1.getSumLastYearActualMONTHLY()!=null && dto1.getSumLastYearActualMONTHLY().length()>0){
					 
				 }
				 //sumThisYearActualMonthly;
					private String sumThisYearBudgetMONTHLY;
					private String sumLastYearActualMONTHLY;
				// จากนั้น นำ (ต้นทุน/ ยอดขาย)*100 
 
				// จากนั้น นำ (ค่าใช้จ่าย/ ยอดขาย)*100 
*/			 }
		  }
			  
	  }
	/*  System.out.println("ยอดขาย="+resultPercent.get(0));
	  System.out.println("ต้นทุน="+resultPercent.get(1));
	  System.out.println("ค่าใช้จ่าย="+resultPercent.get(1));*/
	  return resultPercent;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	} 
	public List<FinancialPieDTO> getBarOfPile_bk(int year, int month,String tab,String sumType){
 
//	String[] sumType={"0","1","2","3","4"};
	//String[] graphType={"Restaurant","Bakery","Specialty","Trading","Caterman","Other"};
		try{
	List list =new ArrayList();
	//for (int k = 0; k < graphType.length; k++) { 
		String q1 = "";
		String q2 = "";
		String q3 = "";
		String sumtype1 = "";
		String sumtype2 = "";
		String sumtype3 = "";
	if(tab!=null){
		if (tab.equals("Restaurant")) {
			q1 = " and do1.RevenueGroupDesc = 'Restaurant'  ";
			q2 = " and do2.RevenueGroupDesc = 'Restaurant'  ";
			q3 = " and do3.RevenueGroupDesc = 'Restaurant'  ";
		} else if (tab.equals("Bakery")) {
			q1 = " and do1.RevenueGroupDesc = 'Shop'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Shop'  ";
			q3 = "  and do3.RevenueGroupDesc = 'Shop'  ";
		} else if (tab.equals("Specialty")) {
			q1 = " and  do1.RevenueGroupDesc = 'Specialty'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Specialty'  ";
			q3 = " and  do3.RevenueGroupDesc = 'Specialty'  ";
			/*q1 = " do1.Cate20 between '017' and '022' and do1.Cate20 between '060' and '061' ";
			q2 = " do2.Cate20 between '017' and '022' and do2.Cate20 between '060' and '061' ";*/
		} else if (tab.equals("Trading")) {
			q1 = " and  do1.RevenueGroupDesc = 'Trading'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Trading'  ";
			q3 = " and  do3.RevenueGroupDesc = 'Trading'  ";
			/*q1 = " do1.Cate20 between '028' and '030' ";
			q2 = " do2.Cate20 between '028' and '030' ";*/
		} else if (tab.equals("Caterman")) {
			q1 = " and  do1.RevenueGroupDesc = 'Caterman'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Caterman'  ";
			q3 = " and  do3.RevenueGroupDesc = 'Caterman'  ";
			/*q1 = " do1.Cate20 = '033' ";
			q2 = " do2.Cate20 = '033'  ";*/
		} else if (tab.equals("Other")) {
			q1 = " and  do1.RevenueGroupDesc = 'Other'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Other'  ";
			q3= " and  do3.RevenueGroupDesc = 'Other'  ";
			/*q1 = " do1.Cate20 between '045' and '059' ";
			q2 = " do2.Cate20 between '045' and '059' ";*/

		}
	}	 
				
		// query sumType
	 
		
		if (sumType.equals("1")) {//YTD vs Last YTD
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"   ";
			sumtype2 = " dd2.Year ="+year+" - 1  and "+
                       " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3=" dd3.Year ="+year+" - 2 and"+
					" dd3.MonthNo between 1 and "+month+"   ";
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month)/3)*3-2,'-1')), '%c') and "+month+"  ";
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype2 = " dd2.Year = "+year+" - 1 and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" - 2 and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month )  ";
			sumtype3 = " dd3.Year = "+year+" and "+
					 " dd3.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 2 month )  ";
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
		 
			 sumtype2 = " dd2.Year = "+year+" - 1 and"+
					 " dd2.MonthNo = "+month+"  ";
			 sumtype3 = " dd3.Year = "+year+" - 2 and"+
					 " dd3.MonthNo = "+month+"  ";
	   } 
		String sql=" select FORMAT((sum(ThisActual)/1000000),2), FORMAT((sum(ThisBudget) /1000000),2), " +
				" FORMAT((sum(LastActual) /1000000),2), FORMAT((sum(LastBudget) /1000000),2), FORMAT((sum(TwoLastActual) /1000000),2)"+ 
	            "    from"+
	            "      (select sum(fab1.BalanceAmount*map1.AccountSign) as ThisActual,"+
				"      sum(fab1.BudgetAmount*map1.AccountSign) as ThisBudget, 0 as LastActual, 0 as LastBudget, 0 as TwoLastActual"+
				"      from FactAccountBalance fab1, DimDate dd1, DimAccount da1,   MapAccountProductGroup map1, DimOrg do1"+
				"      where fab1.DateKey = dd1.DateKey and"+
				"      fab1.OrgKey = do1.OrgKey and"+
				"      fab1.AccountKey = da1.AccountKey and"+
				"      da1.CompanyCode = map1.CompanyCode and"+
				"      da1.AccountCode = map1.AccountCode and"+
				"      da1.SubsidiaryCode = map1.SubsidiaryCode and"+
				"      da1.CompanyCode = '00100' and"+
				"      map1.TemplateID = 1 and"+
				"      map1.CompanyCode = '00100' and"+
				"      map1.AccountGroup in ('SS', 'CS') and"+
				"      do1.CompanyCode = '00100' and "+
	// -- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
				/*"      dd1.Year = 2011 and
				"      dd1.MonthNo between 1 and 12  and
*/	
				sumtype1+
				/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd1.Year = ?Year Parameter and
	 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo = ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo = ?Month Parameter and
	*/
	// -- *** ยอดขายของประเภทธุรกิจ Restaurant
	 //do1.Cate20 between '001' and '003' 
				q1+

	"      union"+
	 "      select 0 as ThisActual, 0 as ThisBudget,"+ 
	 "      sum(fab2.BalanceAmount*map2.AccountSign) as LastActual,"+
	 "      sum(fab2.BudgetAmount*map2.AccountSign) as LastBudget, 0 as TwoLastActual"+
	"      from FactAccountBalance fab2, DimDate dd2, DimAccount da2,   MapAccountProductGroup map2, DimOrg do2"+
	 "      where fab2.DateKey = dd2.DateKey and"+
	 "      fab2.OrgKey = do2.OrgKey and"+
	 "      fab2.AccountKey = da2.AccountKey and"+
	 "      da2.CompanyCode = map2.CompanyCode and"+
	 "      da2.AccountCode = map2.AccountCode and"+
	 "      da2.SubsidiaryCode = map2.SubsidiaryCode and"+
	 "      da2.CompanyCode = '00100' and"+
	 "      map2.TemplateID = 1 and"+
	 "      map2.CompanyCode = '00100' and"+
	 "      map2.AccountGroup in ('SS', 'CS')  and"+
	 "      do2.CompanyCode = '00100' and"+

	//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	 //"      dd2.Year = 2011 - 1 and
	 //"      dd2.MonthNo between 1 and 12 and
				sumtype2+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month)/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd2.Year = ?Year Parameter - 1 and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 1 month) and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd2.Year = ?Year Parameter - 1 and
	 dd2.MonthNo = ?Month Parameter and

	*** ยอดขายของประเภทธุรกิจ Restaurant
	*/
	// do2.Cate20 between '001' and '003'
				q2+

	" union"+
	"  select 0 as ThisActual, 0 as ThisBudget, 0 as LastActual,"+
	 " 0 as LastBudget, sum(fab3.BalanceAmount*map3.AccountSign) as TwoLastActual"+
" 	from FactAccountBalance fab3, DimDate dd3, DimAccount da3,   MapAccountProductGroup map3, DimOrg do3"+
	"  where fab3.DateKey = dd3.DateKey and"+
	 " fab3.OrgKey = do3.OrgKey and"+
	 " fab3.AccountKey = da3.AccountKey and"+
	 " da3.CompanyCode = map3.CompanyCode and"+
	 " da3.AccountCode = map3.AccountCode and"+
	 " da3.SubsidiaryCode = map3.SubsidiaryCode and"+
	 " da3.CompanyCode = '00100' and"+
	 " map3.TemplateID = 1 and"+
	 " map3.CompanyCode = '00100' and"+
	 " map3.AccountGroup in ('SS', 'CS') and"+
	 " do3.CompanyCode = '00100' and"+
	 
	// -- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	 /*dd3.Year = 2011 - 2 and
	 dd3.MonthNo between 1 and 12 and*/
				sumtype3+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 6 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 6 month)/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd2.Year = ?Year Parameter - 2 and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 2 month) and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd2.Year = ?Year Parameter - 2 and
	 dd2.MonthNo = ?Month Parameter and
	*/
	//-- *** ยอดขายของประเภทธุรกิจ Restaurant
	//do3.Cate20 between '001' and '003'
				q3+
	" ) as result ";

	/* ** ยอดขายของ Bakery ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '006' and '016'

	*** ยอดขายของ Specialty ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '017' and '022' and
	Cate20 between '060' and '061'

	*** ยอดขายของ Trading ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '028' and '030'

	*** ยอดขายของ Caterman ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 = '033' 

	*** ยอดขายของ Other ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '045' and '059'";
*/
		//System.out.println("query is ==> " + sql);
		SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
				.createSQLQuery(sql);
		/*query.setParameter("year", year);
		query.setParameter("month", month);*/
		
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj = (Object[]) result.get(i); 
			FinancialPieDTO financialPieDTO = new FinancialPieDTO();
			/*financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
			financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");*/
			
			financialPieDTO.setThisActual(obj[0] != null ? obj[0]
					+ "" : "");
			financialPieDTO.setThisBudget(obj[1] != null ? obj[1]
					+ "" : "");
			financialPieDTO.setLastActual(obj[2] != null ? obj[2]
					+ "" : "");
			financialPieDTO.setLastBudget(obj[3] != null ? obj[3]
					+ "" : "");
			financialPieDTO.setTwoLastActual(obj[4] != null ? obj[4]
					+ "" : "");
			result.set(i, financialPieDTO);
		}
		//return result;
	list.add(result.get(0)); 
	return list;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	@Override
	public List<FinancialPieDTO> getBarOfPile(int year, int month,String tab,String sumType){
  
		try{
//	List list =new ArrayList();
	//for (int k = 0; k < graphType.length; k++) { 
		String q1 = "";
		String q2 = "";
		String q3 = "";
		String sumtype1 = "";
		String sumtype2 = "";
		String sumtype3 = "";
	if(tab!=null){
		if (tab.equals("Restaurant")) {
			q1 = " and do1.RevenueGroupDesc = 'Restaurant'  ";
			q2 = " and do2.RevenueGroupDesc = 'Restaurant'  ";
			q3 = " and do3.RevenueGroupDesc = 'Restaurant'  ";
		} else if (tab.equals("Bakery")) {
			q1 = " and do1.RevenueGroupDesc = 'Shop'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Shop'  ";
			q3 = "  and do3.RevenueGroupDesc = 'Shop'  ";
		}
		 else if (tab.equals("Shop")) {
				q1 = " and do1.RevenueGroupDesc = 'Shop'  ";
				q2 = " and  do2.RevenueGroupDesc = 'Shop'  ";
				q3 = "  and do3.RevenueGroupDesc = 'Shop'  ";
			}
	 else if (tab.equals("Specialty")) {
			q1 = " and  do1.RevenueGroupDesc = 'Specialty'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Specialty'  ";
			q3 = " and  do3.RevenueGroupDesc = 'Specialty'  ";
			/*q1 = " do1.Cate20 between '017' and '022' and do1.Cate20 between '060' and '061' ";
			q2 = " do2.Cate20 between '017' and '022' and do2.Cate20 between '060' and '061' ";*/
		} else if (tab.equals("Trading")) {
			q1 = " and  do1.RevenueGroupDesc = 'Trading'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Trading'  ";
			q3 = " and  do3.RevenueGroupDesc = 'Trading'  ";
			/*q1 = " do1.Cate20 between '028' and '030' ";
			q2 = " do2.Cate20 between '028' and '030' ";*/
		} else if (tab.equals("Caterman")) {
			q1 = " and  do1.RevenueGroupDesc = 'Caterman'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Caterman'  ";
			q3 = " and  do3.RevenueGroupDesc = 'Caterman'  ";
			/*q1 = " do1.Cate20 = '033' ";
			q2 = " do2.Cate20 = '033'  ";*/
		} else if (tab.equals("Other")) {
			q1 = " and  do1.RevenueGroupDesc = 'Other'  ";
			q2 = " and  do2.RevenueGroupDesc = 'Other'  ";
			q3= " and  do3.RevenueGroupDesc = 'Other'  ";
			/*q1 = " do1.Cate20 between '045' and '059' ";
			q2 = " do2.Cate20 between '045' and '059' ";*/

		}
	}	 
				
		// query sumType
	 
		
		if (sumType.equals("1")) {//YTD vs Last YTD
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"   ";
			sumtype2 = " dd2.Year ="+year+" - 1  and "+
                       " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3=" dd3.Year ="+year+" - 2 and"+
					" dd3.MonthNo between 1 and "+month+"   ";
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month)/3)*3-2,'-1')), '%c') and "+month+"  ";
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype2 = " dd2.Year = "+year+" - 1 and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" - 2 and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month )  ";
			sumtype3 = " dd3.Year = "+year+" and "+
					 " dd3.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 2 month )  ";
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
		 
			 sumtype2 = " dd2.Year = "+year+" - 1 and"+
					 " dd2.MonthNo = "+month+"  ";
			 sumtype3 = " dd3.Year = "+year+" - 2 and"+
					 " dd3.MonthNo = "+month+"  ";
	   } 
		
		String sql=" select FORMAT((sum(ThisActual)/1000000),2), FORMAT((sum(ThisBudget) /1000000),2), " +
				" FORMAT((sum(LastActual) /1000000),2), FORMAT((sum(LastBudget) /1000000),2), FORMAT((sum(TwoLastActual) /1000000),2)"+ 			 
				" from (select sum(fos1.BalanceAmount) as ThisActual, sum(fos1.BudgetAmount) as ThisBudget, " +
				" 0 as LastActual, 0 as LastBudget, 0 as TwoLastActual " +
	           " from FinOrgSummary fos1, DimDate dd1" +
	           //", DimAccount da1,   MapAccountProductGroup map1" +
	           ", DimOrg do1 " +
	          " where fos1.DateKey = dd1.DateKey and  " +
	          "  fos1.OrgKey = do1.OrgKey and  " +
	          "  fos1.ItemID = 3 and  " +
	          /* " where fos1.DateKey = dd1.DateKey and fab1.OrgKey = do1.OrgKey and" +
	           "  fab1.AccountKey = da1.AccountKey and da1.CompanyCode = map1.CompanyCode and da1.AccountCode = map1.AccountCode and da1.SubsidiaryCode = map1.SubsidiaryCode and" +
	           " da1.CompanyCode = '00100' and map1.TemplateID = 1 and map1.CompanyCode = '00100' and map1.AccountGroup in ('SS', 'CS') and do1.CompanyCode = '00100' and "+*/
		/*String sql=" select (sum(ThisActual)/1000000), (sum(ThisBudget) /1000000), " +
				" (sum(LastActual) /1000000), (sum(LastBudget) /1000000), (sum(TwoLastActual) /1000000) "+ 
	           " from (select sum(fab1.BalanceAmount*map1.AccountSign) as ThisActual, sum(fab1.BudgetAmount*map1.AccountSign) as ThisBudget, 0 as LastActual, 0 as LastBudget, 0 as TwoLastActual" +
	           " from FactAccountBalance fab1, DimDate dd1, DimAccount da1,   MapAccountProductGroup map1, DimOrg do1 where fab1.DateKey = dd1.DateKey and fab1.OrgKey = do1.OrgKey and" +
	           "  fab1.AccountKey = da1.AccountKey and da1.CompanyCode = map1.CompanyCode and da1.AccountCode = map1.AccountCode and da1.SubsidiaryCode = map1.SubsidiaryCode and" +
	           " da1.CompanyCode = '00100' and map1.TemplateID = 1 and map1.CompanyCode = '00100' and map1.AccountGroup in ('SS', 'CS') and do1.CompanyCode = '00100' and "+*/
	           // -- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
				/*"      dd1.Year = 2011 and
				"      dd1.MonthNo between 1 and 12  and
*/	
				sumtype1+
				/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd1.Year = ?Year Parameter and
	 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo = ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo = ?Month Parameter and
	*/
	// -- *** ยอดขายของประเภทธุรกิจ Restaurant
	 //do1.Cate20 between '001' and '003' 
				q1+ 
	"     union select 0 as ThisActual, 0 as ThisBudget, sum(fos2.BalanceAmount) as LastActual, sum(fos2.BudgetAmount) as LastBudget," +
	"  0 as TwoLastActual" +
	" from FinOrgSummary fos2, DimDate dd2 " +
	//", DimAccount da2,   MapAccountProductGroup map2" +
	", DimOrg do2 " +
	" where fos2.DateKey = dd2.DateKey and  " +
	" fos2.OrgKey = do2.OrgKey and  " +
	" fos2.ItemID = 3 and  " +
	/*"where fab2.DateKey = dd2.DateKey and fab2.OrgKey = do2.OrgKey and" +
	" fab2.AccountKey = da2.AccountKey and da2.CompanyCode = map2.CompanyCode and da2.AccountCode = map2.AccountCode and da2.SubsidiaryCode = map2.SubsidiaryCode and da2.CompanyCode = '00100' and" +
	" map2.TemplateID = 1 and map2.CompanyCode = '00100' and map2.AccountGroup in ('SS', 'CS')  and do2.CompanyCode = '00100' and  "+*/

	//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	 //"      dd2.Year = 2011 - 1 and
	 //"      dd2.MonthNo between 1 and 12 and
				sumtype2+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month)/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd2.Year = ?Year Parameter - 1 and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 1 month) and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd2.Year = ?Year Parameter - 1 and
	 dd2.MonthNo = ?Month Parameter and

	*** ยอดขายของประเภทธุรกิจ Restaurant
	*/
	// do2.Cate20 between '001' and '003'
				q2+

	"  union select 0 as ThisActual, 0 as ThisBudget, 0 as LastActual, 0 as LastBudget, " +
	" sum(fos3.BalanceAmount) as TwoLastActual from FinOrgSummary fos3, DimDate dd3" +
	//", DimAccount da3,   MapAccountProductGroup map3" +
	", DimOrg do3" +
	" where fos3.DateKey = dd3.DateKey and " +
	"  fos3.OrgKey = do3.OrgKey and " +
	"  fos3.ItemID = 3 and " +
	/*"  where fab3.DateKey = dd3.DateKey and fab3.OrgKey = do3.OrgKey and fab3.AccountKey = da3.AccountKey and da3.CompanyCode = map3.CompanyCode and da3.AccountCode = map3.AccountCode and" +
	"  da3.SubsidiaryCode = map3.SubsidiaryCode and da3.CompanyCode = '00100' and map3.TemplateID = 1 and map3.CompanyCode = '00100' and map3.AccountGroup in ('SS', 'CS') and do3.CompanyCode = '00100' and "+*/	 
	// -- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	 /*dd3.Year = 2011 - 2 and
	 dd3.MonthNo between 1 and 12 and*/
				sumtype3+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 6 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 6 month)/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd2.Year = ?Year Parameter - 2 and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 2 month) and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd2.Year = ?Year Parameter - 2 and
	 dd2.MonthNo = ?Month Parameter and
	*/
	//-- *** ยอดขายของประเภทธุรกิจ Restaurant
	//do3.Cate20 between '001' and '003'
				q3+
	" ) as result ";

	/* ** ยอดขายของ Bakery ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '006' and '016'

	*** ยอดขายของ Specialty ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '017' and '022' and
	Cate20 between '060' and '061'

	*** ยอดขายของ Trading ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '028' and '030'

	*** ยอดขายของ Caterman ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 = '033' 

	*** ยอดขายของ Other ***
	เหมือนของ Restaurant เปลี่ยน where เป็น 
	Cate20 between '045' and '059'";
*/
	//	System.out.println("query is ==> " + sql);
		SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
				.createSQLQuery(sql);
		/*query.setParameter("year", year);
		query.setParameter("month", month);*/
		
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj = (Object[]) result.get(i); 
			FinancialPieDTO financialPieDTO = new FinancialPieDTO();
			/*financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
			financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");*/
			
			financialPieDTO.setThisActual(obj[0] != null ? obj[0]
					+ "" : "");
			financialPieDTO.setThisBudget(obj[1] != null ? obj[1]
					+ "" : "");
			financialPieDTO.setLastActual(obj[2] != null ? obj[2]
					+ "" : "");
			financialPieDTO.setLastBudget(obj[3] != null ? obj[3]
					+ "" : "");
			financialPieDTO.setTwoLastActual(obj[4] != null ? obj[4]
					+ "" : "");
			result.set(i, financialPieDTO);
		}
		return result;
	//list.add(result.get(0)); 
	//return list;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	}
	public List<FinancialPieDTO> getPile_bk(int year, int month,String sumType){
		 
//		String[] sumType={"0","1","2","3","4"};
		try{
		String[] graphType={"Restaurant","Bakery","Specialty","Trading","Caterman","Other"};
		List list =new ArrayList(graphType.length);
		for (int k = 0; k < graphType.length; k++) { 
			String q1 = "";
			String q2 = "";
			String q3 = "";
			String sumtype1 = "";
			String sumtype2 = "";
			String sumtype3 = "";
			if (graphType[k].equals("Restaurant")) {  
				q1 = " do1.RevenueGroupDesc = 'Restaurant'  ";
				q2 = " do2.RevenueGroupDesc = 'Restaurant'  ";
				q3 = " do3.RevenueGroupDesc = 'Restaurant'  ";
			} else if (graphType[k].equals("Bakery")) {
				q1 = " do1.RevenueGroupDesc = 'Bakery'  ";
				q2 = " do2.RevenueGroupDesc = 'Bakery'  "; 
				q3 = " do3.RevenueGroupDesc = 'Bakery'  "; 
			} else if (graphType[k].equals("Specialty")) {			
				q1 =  " do1.RevenueGroupDesc = 'Specialty'  ";
				q2 =  " do2.RevenueGroupDesc = 'Specialty'  ";
				q3 =  " do3.RevenueGroupDesc = 'Specialty'  ";
			} else if (graphType[k].equals("Trading")) {
				q1 = " do1.RevenueGroupDesc = 'Trading'  ";
				q2 =  " do2.RevenueGroupDesc = 'Trading'  ";
				q3 =  " do3.RevenueGroupDesc = 'Trading'  ";
			}
			 else if (graphType[k].equals("Caterman")) {
				 q1 =  " do1.RevenueGroupDesc = 'Caterman'  ";
				 q2 =  " do2.RevenueGroupDesc = 'Caterman'  ";
				 q3 =  " do3.RevenueGroupDesc = 'Caterman'  ";
		   }
			 else if (graphType[k].equals("Other")) {
				 q1 =  " do1.RevenueGroupDesc = 'Other'  ";
				 q2 =  " do2.RevenueGroupDesc = 'Other'  ";
				 q3 = " do3.RevenueGroupDesc = 'Other'  ";
			}
			 
					
			// query sumType
		 
			
			if (sumType.equals("1")) {//YTD vs Last YTD
				sumtype1 = " dd1.Year ="+year+" and"+
	                       " dd1.MonthNo between 1 and "+month+"  and ";
				sumtype2 = " dd2.Year ="+year+" - 1 and"+
	                       " dd2.MonthNo between 1 and "+month+"  and ";
				sumtype3=" dd3.Year ="+year+" - 2 and"+
						" dd3.MonthNo between 1 and "+month+"  and ";
			} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
				sumtype1 = " dd1.Year ="+year+"  and" +
						   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  and ";
				sumtype2 = "dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and  "+
						" dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and  "+ 
						" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2  ";

			/*	sumtype2 = " dd2.Year = "+year+" and "+
						 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+" and "; */
				sumtype3 = "dd3.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month)  and "+
" dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month)/3)*3-2,'-1')), '%c') and "+  
" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 6 month)/3)*3-2,'-1')), '%c')+2 ";
			} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
				sumtype1 = " dd1.Year ="+year+" and "+
						 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" and ";
				sumtype2 = " dd2.Year = "+year+" - 1 and "+
						 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" and ";
				sumtype3 = " dd3.Year = "+year+" - 2 and "+
						 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" and ";
			} else if (sumType.equals("4")) { //Monthly vs Last Monthly
				sumtype1 =" dd1.Year ="+year+" and "+
						 " dd1.MonthNo = "+month+" and "; 
				sumtype2 = "dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
                           " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) and ";
				sumtype3 = " dd3.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+", \"%d-%b-%Y\") -interval 1 month)  and" +
						"  dd3.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+", \"%d-%b-%Y\") -interval 2 month) and ";
			} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
				sumtype1 = " dd1.Year = "+year+" and"+
						 " dd1.MonthNo = "+month+" and ";
			 
				 sumtype2 = " dd2.Year = "+year+" - 1 and"+
						 " dd2.MonthNo = "+month+" and ";
				 sumtype3 = " dd3.Year = "+year+" - 2 and"+
						 " dd3.MonthNo = "+month+" and ";
		   } 
			String sql=" select FORMAT((sum(ThisActual)/1000000),2),FORMAT((sum(ThisBudget)/1000000),2)," +
					" FORMAT((sum(LastActual)/1000000),2), FORMAT((sum(LastBudget)/1000000),2), FORMAT((sum(TwoLastActual)/1000000),2) "+
					" from"+
					" (select sum(fab1.BalanceAmount*map1.AccountSign) as ThisActual,"+
					" sum(fab1.BudgetAmount*map1.AccountSign) as ThisBudget, 0 as LastActual, 0 as LastBudget, 0 as TwoLastActual"+
					" from FactAccountBalance as fab1, DimDate as dd1, DimAccount as da1,   MapAccountProductGroup as map1, DimOrg as do1"+
					" where fab1.DateKey = dd1.DateKey and"+
					" fab1.OrgKey = do1.OrgKey and"+
					" fab1.AccountKey = da1.AccountKey and"+
					" da1.CompanyCode = map1.CompanyCode and"+
					" da1.AccountCode = map1.AccountCode and"+
					" da1.SubsidiaryCode = map1.SubsidiaryCode and"+
					" da1.CompanyCode = '00100' and"+
					" map1.TemplateID = 1 and"+
					" map1.CompanyCode = '00100' and"+
					" map1.AccountGroup in ('SS', 'CS') and"+
					" do1.CompanyCode = '00100' and"+
	//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	              /*  " dd1.Year = 2011 and"+
	                " dd1.MonthNo between 1 and 12 and"+*/
	                sumtype1+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd1.Year = ?Year Parameter and
	 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo = ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd1.Year = ?Year Parameter and
	 dd1.MonthNo = ?Month Parameter and
	*/
	//-- *** ยอดขายของประเภทธุรกิจ Restaurant
	               // " do1.Cate20 between '001' and '003'"+ 
	                q1+
	                " union"+
	                " select 0 as ThisActual, 0 as ThisBudget,"+ 
	                " sum(fab2.BalanceAmount*map2.AccountSign) as LastActual,"+
	                " sum(fab2.BudgetAmount*map2.AccountSign) as LastBudget, 0 as TwoLastActual"+
	                " from FactAccountBalance as fab2, DimDate as dd2, DimAccount as da2,   MapAccountProductGroup as map2, DimOrg as do2"+
	                " where fab2.DateKey = dd2.DateKey and"+
	                " fab2.OrgKey = do2.OrgKey and"+
	                " fab2.AccountKey = da2.AccountKey and"+
	                " da2.CompanyCode = map2.CompanyCode and"+
	                " da2.AccountCode = map2.AccountCode and"+
	                " da2.SubsidiaryCode = map2.SubsidiaryCode and"+
	                " da2.CompanyCode = '00100' and"+
	                " map2.TemplateID = 1 and"+
	                " map2.CompanyCode = '00100' and"+
	                " map2.AccountGroup in ('SS', 'CS')  and"+
	                " do2.CompanyCode = '00100' and"+

	//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	               /* " dd2.Year = 2011 - 1 and"+
	                " dd2.MonthNo between 1 and 12 and"+*/
	                sumtype2+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 3 month)/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd2.Year = ?Year Parameter - 1 and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 1 month) and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd2.Year = ?Year Parameter - 1 and
	 dd2.MonthNo = ?Month Parameter and
	*/
	//-- *** ยอดขายของประเภทธุรกิจ Restaurant
	            //    " do2.Cate20 between '001' and '003' "+
	                q2+

	                " union"+
	                " select 0 as ThisActual, 0 as ThisBudget, 0 as LastActual,"+
	                " 0 as LastBudget, sum(fab3.BalanceAmount*map3.AccountSign) as TwoLastActual"+
	                " from FactAccountBalance as fab3, DimDate as dd3, DimAccount as da3,   MapAccountProductGroup as map3, DimOrg as do3"+
	                " where fab3.DateKey = dd3.DateKey and"+
	                " fab3.OrgKey = do3.OrgKey and"+
	                " fab3.AccountKey = da3.AccountKey and"+
	                " da3.CompanyCode = map3.CompanyCode and"+
	                " da3.AccountCode = map3.AccountCode and"+
	                " da3.SubsidiaryCode = map3.SubsidiaryCode and"+
	                " da3.CompanyCode = '00100' and"+
	                "  map3.TemplateID = 1 and"+
	                " map3.CompanyCode = '00100' and"+
	                " map3.AccountGroup in ('SS', 'CS') and"+
	                " do3.CompanyCode = '00100' and"+
	 
	//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	               /* " dd3.Year =2011 - 2 and"+
	                " dd3.MonthNo between 1 and 12 and"+*/
	                sumtype3+
	/*
	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 6 month),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 6 month)/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
	dd2.Year = ?Year Parameter - 2 and
	 dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
	 dd2.Year = ?Year Parameter and
	 dd2.MonthNo = month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y") -interval 2 month) and

	*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
	 dd2.Year = ?Year Parameter - 2 and
	 dd2.MonthNo = ?Month Parameter and
	*/
	// -- *** ยอดขายของประเภทธุรกิจ Restaurant
	        //    " do3.Cate20 between '001' and '003' "+
	       q3+
	            " ) as result";

		//	System.out.println("query is ==> " + sql);
			SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
					.createSQLQuery(sql);
			/*query.setParameter("year", year);
			query.setParameter("month", month);*/
			List result = query.list();
			int size = result.size();
			for (int i = 0; i < size; i++) {
				Object[] obj = (Object[]) result.get(i); 
				FinancialPieDTO financialPieDTO = new FinancialPieDTO();
				/*financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
				financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");*/
				
				financialPieDTO.setThisActual(obj[0] != null ? obj[0]
						+ "" : "");
				financialPieDTO.setThisBudget(obj[1] != null ? obj[1]
						+ "" : "");
				financialPieDTO.setLastActual(obj[2] != null ? obj[2]
						+ "" : "");
				financialPieDTO.setLastBudget(obj[3] != null ? obj[3]
						+ "" : "");
				financialPieDTO.setTwoLastActual(obj[4] != null ? obj[4]
						+ "" : "");
				result.set(i, financialPieDTO);
			}
			//return result;
			list.add(result.get(0));
		}
		return list;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
		}
	public List<FinancialPieDTO> getPile(int year, int month,String sumType){
		 
//		String[] sumType={"0","1","2","3","4"};
		try{
		//String[] graphType={"Restaurant","Bakery","Specialty","Trading","Caterman","Other"};
		//List list =new ArrayList(graphType.length);
		//	List list =new ArrayList();
			//for (int k = 0; k < graphType.length; k++) { 
			 
			String sumtype1 = "";
			
					
			// query sumType
			
			/*
			 * -- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
			 dd1.Year = 2011 and
			 dd1.MonthNo between 1 and 3 
			*** ถ้าเลือก Parameter สรุปตามเป็น Quarter vs Last Quarter
			 dd1.Year = ?Year Parameter and
			 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter

			*** ถ้าเลือก Parameter สรุปตามเป็น Quarter vs Last Year Same Quarter
			dd1.Year = ?Year Parameter and
			 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter 

			*** ถ้าเลือก Parameter สรุปตามเป็น Monthly vs Last Monthly
			 dd1.Year = ?Year Parameter and
			 dd1.MonthNo = ?Month Parameter 

			*** ถ้าเลือก Parameter สรุปตามเป็น Monthly vs Last Year Same Monthly
			 dd1.Year = ?Year Parameter and
			 dd1.MonthNo = ?Month Parameter 
			*/
			if (sumType.equals("1")) {//YTD vs Last YTD
				sumtype1 = " dd1.Year ="+year+" and"+
	                       " dd1.MonthNo between 1 and "+month+"   "; 
			} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
				sumtype1 = " dd1.Year ="+year+"  and" +
						   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			
			} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
				sumtype1 = " dd1.Year ="+year+" and "+
						 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
				
			} else if (sumType.equals("4")) { //Monthly vs Last Monthly
				sumtype1 =" dd1.Year ="+year+" and "+
						 " dd1.MonthNo = "+month+" "; 
				
			} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
				sumtype1 = " dd1.Year = "+year+" and"+
						 " dd1.MonthNo = "+month+"  ";
			 
				
		   }  
			String sql=" select do1.RevenueGroupDesc,  FORMAT(sum(fos1.BalanceAmount),2)  as ThisActual " +
					" from FinOrgSummary fos1, DimDate dd1" +
					//", DimAccount da1,   MapAccountProductGroup map1" +
					", DimOrg do1 " +
					"  where fos1.DateKey = dd1.DateKey and " +
					"  fos1.OrgKey = do1.OrgKey and " +
					"  fos1.ItemID = 3 and " +
					"  do1.RevenueGroupDesc in ('Caterman','Other','Restaurant','Shop','Specialty','Trading') and " +

				/*	" where fab1.DateKey = dd1.DateKey and  fab1.OrgKey = do1.OrgKey and  fab1.AccountKey = da1.AccountKey and" +
					" da1.CompanyCode = map1.CompanyCode and da1.AccountCode = map1.AccountCode and da1.SubsidiaryCode = map1.SubsidiaryCode and" +
					" da1.CompanyCode = '00100' and map1.TemplateID = 1 and map1.CompanyCode = '00100' and map1.AccountGroup in ('SS', 'CS') and" +
					" do1.CompanyCode = '00100' and do1.RevenueGroupDesc in ('Caterman','Other','Restaurant','Shop','Specialty','Trading') and" +*/
					" "+
	//-- *** ถ้าเลือก Parameter สรุปตามเป็น YTD vs Last YTD
	              /*  " dd1.Year = 2011 and"+
	                " dd1.MonthNo between 1 and 12 and"+*/
	                sumtype1+
	
	            " group by do1.RevenueGroupDesc ";

		//	System.out.println("query is ==> " + sql);
			SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
					.createSQLQuery(sql);
			/*query.setParameter("year", year);
			query.setParameter("month", month);*/
			List result = query.list();
			int size = result.size();
			for (int i = 0; i < size; i++) {
				Object[] obj = (Object[]) result.get(i); 
				FinancialPieDTO financialPieDTO = new FinancialPieDTO();
				/*financialTabDTO.setMno(obj[0] != null ? obj[0] + "" : "");
				financialTabDTO.setMname(obj[1] != null ? obj[1] + "" : "");*/
				System.out.println("obj[0]==============>"+obj[0]);
				financialPieDTO.setRevenueGroupDesc(obj[0] != null ? obj[0]
						+ "" : "");
				financialPieDTO.setThisActual(obj[1] != null ? obj[1]
						+ "" : "");
				/*financialPieDTO.setThisBudget(obj[1] != null ? obj[1]
						+ "" : "");
				financialPieDTO.setLastActual(obj[2] != null ? obj[2]
						+ "" : "");
				financialPieDTO.setLastBudget(obj[3] != null ? obj[3]
						+ "" : "");
				financialPieDTO.setTwoLastActual(obj[4] != null ? obj[4]
						+ "" : "");*/
				result.set(i, financialPieDTO);
			}
			return result;
			//list.add(result.get(0));
	 
	//	return list;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
		}

	@Override
	public List<FinancialPopup1GroupDTO> getPopup1(int year,
			int month, String tab, String sumType) {
		try{
		// sumType 6 ==>YTD , 7 ==>Monthly
		/****
		// -- *** ถ้าเลือก tab Restaurant
		 do1.Cate20 between '001' and '003' 
		 
		*** ถ้าเลือก tab Bakery
		 do1.Cate20 between '006' and '016'  

		*** ถ้าเลือก tab Specialty
		 do1.Cate20 between '017' and '022' and
		do1.Cate20 between '060' and '061'

		 *** ถ้าเลือก tab Trading
		do1.Cate20 between '028' and '030'

		*** ถ้าเลือก tab Caterman
		 do1.Cate20 = '033'  

		*** ถ้าเลือก tab Other
		 do1.Cate20 between '045' and '059'
		 ==========================================================
		  
		*** ถ้าเลือก tab Bakery
		 do2.Cate20 between '006' and '016'  

		*** ถ้าเลือก tab Specialty
		do2.Cate20 between '017' and '022' and
		do2.Cate20 between '060' and '061'

		 *** ถ้าเลือก tab Trading
		do2.Cate20 between '028' and '030'

		*** ถ้าเลือก tab Caterman
		 do2.Cate20 = '033'  

		*** ถ้าเลือก tab Other
		 do2.Cate20 between '045' and '059'
		*/
		 
		String q1 = "";
	//	String q2 = "";
		String sumtype1="";
		//String sumtype2="";
	boolean	haveOrgType=false;
	if(tab!=null && tab.length()>0 && !tab.equals("null")) {
		haveOrgType=true;
		if (tab.equals("Restaurant")) {
			q1 = " and do1.RevenueGroupDesc = 'Restaurant'  ";
		} else if (tab.equals("Bakery")) {
			q1 = " and do1.RevenueGroupDesc = 'Shop'  ";
		} else if (tab.equals("Specialty")) {
			q1 = " and do1.RevenueGroupDesc = 'Specialty'  ";
		} else if (tab.equals("Trading")) {
			q1 = " and do1.RevenueGroupDesc = 'Trading'  ";
		} else if (tab.equals("Caterman")) {
			q1 = " and do1.RevenueGroupDesc = 'Caterman'  ";
		} else if (tab.equals("Other")) {
			q1 = " and do1.RevenueGroupDesc = 'Other'  ";
		}
		}
		if (sumType.equals("1")) {//YTD vs Last YTD
		 
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"    ";
			/*sumtype2 = " dd2.Year ="+year+" - 1 and"+
                       " dd2.MonthNo between 1 and "+month+"   "; */
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+" and ";*/
		
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			 

			/*		sumtype2 = " dd2.Year = "+year+" - 1 and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" and ";*/
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month ) and ";*/
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
		 
			/* sumtype2 = " dd2.Year = "+year+" - 1 and"+
					 " dd2.MonthNo = "+month+" and ";*/
	   } 
		//String sqlGroup=" select fos1.CategoryName as Cate  "+
		String sqlGroup=" select fos1.CategoryName   "+
				  (haveOrgType?" from FinOrgSummary fos1 ":" from FinCompanySummary fos1 ")+
				//" from FinOrgSummary fos1, DimDate dd1, DimOrg do1  "+
				  " , DimDate dd1 "+
				  (haveOrgType?" , DimOrg do1 ":" ")+
				" where fos1.DateKey = dd1.DateKey and  "+
				 (haveOrgType?"  fos1.OrgKey = do1.OrgKey and   ":" ")+
				//" fos1.OrgKey = do1.Orgkey and  "+
				" fos1.ItemID = 3 and "+
		
          sumtype1+
          q1+
       "  group by fos1.CategoryName ";
          
   System.out.println(" query group="+sqlGroup);
		SQLQuery queryGroup = this.sessionAnnotationFactoryOP
				.getCurrentSession().createSQLQuery(sqlGroup);
		 
		List resultGroup = queryGroup.list();
		List groupList =new ArrayList<FinancialPopup1GroupDTO>();
		int sizeGroup = resultGroup.size();
	 	for (int i = 0; i < sizeGroup; i++) {
			String sql = "";
			FinancialPopup1GroupDTO group=new FinancialPopup1GroupDTO();
			String objGroup = (String) resultGroup.get(i);
			//sql=" select fos1.CategoryName as Cate, fos1.SubCategoryName as SubCate, sum(fos1.BalanceAmount)/1000 as ThisActual "+
			sql=" select fos1.CategoryName , fos1.SubCategoryName , sum(fos1.BalanceAmount)/1000 as ThisActual "+
					  (haveOrgType?" from FinOrgSummary fos1 ":" from FinCompanySummary fos1 ")+
					//" from FinOrgSummary fos1, DimDate dd1, DimOrg do1  "+
					    " , DimDate dd1 "+
					    (haveOrgType?" , DimOrg do1 ":" ")+
					" where fos1.DateKey = dd1.DateKey and  "+
					 (haveOrgType?"  fos1.OrgKey = do1.OrgKey and   ":" ")+
				//	" fos1.OrgKey = do1.Orgkey and  "+
					" fos1.ItemID = 3 and " +
					sumtype1+ 
					q1+
				 " and fos1.CategoryName=:Category "+ 
            	" group by fos1.CategoryName, fos1.SubCategoryName ";
		 	group.setGroupName(objGroup);
			 System.out.println("query is inner ==> " + sql);
				SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
						.createSQLQuery(sql);
		 		query.setParameter("Category", objGroup); 
				List result = query.list();
				int size = result.size(); 
				for (int j = 0; j < size; j++) {
					Object[] obj = (Object[]) result.get(j);
					FinancialPopup1DTO financialPopup1DTO = new FinancialPopup1DTO();
					/*financialPopup1DTO
							.setRatioGroupName(obj[0] != null ? obj[0] + "" : "");*/
					financialPopup1DTO.setSubCategory(obj[1] != null ? obj[1]
							+ "" : "");
					financialPopup1DTO
							.setThisActual(obj[2] != null ? obj[2] + "" : "");
					/*financialPopup1DTO.setSubCategory(obj[0] != null ? obj[0]
							+ "" : "");
					financialPopup1DTO
							.setThisActual(obj[1] != null ? obj[1] + "" : "");*/
					result.set(j, financialPopup1DTO);
				}
				group.setFinancialPopup1DTO(result);
				groupList.add(group);  
		}
		
		
/*
*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last QTD
 dd1.Year = ?Year Parameter and
 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter 

*** ถ้าเลือก Parameter สรุปตามเป็น QTD vs Last Year QTD
dd1.Year = ?Year Parameter and
 dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y")),'-',ceil(month(str_to_date('01-' ?Month Parameter'-?Year Parameter, "%d-%b-%Y"))/3)*3-2,'-1')), '%c') and ?Month Parameter 

*** ถ้าเลือก Parameter สรุปตามเป็น MTD vs Last MTD
 dd1.Year = ?Year Parameter and
 dd1.MonthNo = ?Month Parameter and

*** ถ้าเลือก Parameter สรุปตามเป็น MTD  vs Last Year MTD
 dd1.Year = ?Year Parameter and
 dd1.MonthNo = ?Month Parameter 
*/
 
		
		return groupList;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
		/*
		 * query.addEntity("financialTabDTO", FinancialTabDTO.class); return
		 * (List<FinancialTabDTO>)query.list();
		 */
	}
	@Override
	public List<FinancialPopup1GroupDTO> getPopup2(int year,
			int month, String tab, String sumType) {
		// sumType 6 ==>YTD , 7 ==>Monthly
		try{
		String q1 = "";
	//	String q2 = "";
		String sumtype1="";
		//String sumtype2="";
	boolean	haveOrgType=false;
	if(tab!=null && tab.length()>0 && !tab.equals("null")) {
		haveOrgType=true;
		if (tab.equals("Restaurant")) {
			q1 = " and  do1.RevenueGroupDesc = 'Restaurant'  ";
		} else if (tab.equals("Bakery")) {
			q1 = " and do1.RevenueGroupDesc = 'Shop'  ";
		} else if (tab.equals("Specialty")) {
			q1 = " and  do1.RevenueGroupDesc = 'Specialty'  ";
		} else if (tab.equals("Trading")) {
			q1 = " and do1.RevenueGroupDesc = 'Trading'  ";
		} else if (tab.equals("Caterman")) {
			q1 = " and  do1.RevenueGroupDesc = 'Caterman'  ";
		} else if (tab.equals("Other")) {
			q1 = " and  do1.RevenueGroupDesc = 'Other'  ";
		}
		}
		if (sumType.equals("1")) {//YTD vs Last YTD
		 
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"    ";
			/*sumtype2 = " dd2.Year ="+year+" - 1 and"+
                       " dd2.MonthNo between 1 and "+month+"   "; */
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+month+" and ";*/
		
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			 

			/*		sumtype2 = " dd2.Year = "+year+" - 1 and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+" and ";*/
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			/*sumtype2 = " dd2.Year = "+year+" and "+
					 " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month ) and ";*/
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
		 
			/* sumtype2 = " dd2.Year = "+year+" - 1 and"+
					 " dd2.MonthNo = "+month+" and ";*/
	   }  
		String sqlGroup=" select fos1.CategoryName    "+
	            (haveOrgType?" from FinOrgSummary fos1 ":" from FinCompanySummary fos1 ")+
	         //   from FinCompanySummary fcs1, DimDate dd1
	            " , DimDate dd1 "+
				//" from FinOrgSummary fos1, DimDate dd1, DimOrg do1  "+
				  (haveOrgType?" , DimOrg do1 ":" ")+
				" where fos1.DateKey = dd1.DateKey and  "+
				  (haveOrgType?"  fos1.OrgKey = do1.OrgKey and   ":" ")+
				//" fos1.OrgKey = do1.OrgKey and  "+
				" fos1.ItemID = 5 and "+
            sumtype1+
        q1+
        " group by fos1.CategoryName ";
		SQLQuery queryGroup = this.sessionAnnotationFactoryOP
				.getCurrentSession().createSQLQuery(sqlGroup);
		 
		List resultGroup = queryGroup.list();
		List groupList =new ArrayList<FinancialPopup1GroupDTO>();
		int sizeGroup = resultGroup.size();
	 	for (int i = 0; i < sizeGroup; i++) {
			String sql = "";
			FinancialPopup1GroupDTO group=new FinancialPopup1GroupDTO();
		 
			
			String objGroup = (String) resultGroup.get(i);
			sql=" select fos1.CategoryName , sum(fos1.BalanceAmount)/1000 "+
					(haveOrgType?" from FinOrgSummary fos1 ":" from FinCompanySummary fos1 ")+
					//	" from FinOrgSummary fos1, DimDate dd1, DimOrg do1  "+
					  " , DimDate dd1 "+
					  (haveOrgType?" , DimOrg do1 ":" ")+
					" where fos1.DateKey = dd1.DateKey and  "+
					  (haveOrgType?"  fos1.OrgKey = do1.OrgKey and   ":" ")+
					//	" fos1.OrgKey = do1.OrgKey and  "+
					" fos1.ItemID = 5 and "+
					sumtype1+ 
					q1+
				 " and fos1.CategoryName=:Category "+ 
   "  group by fos1.CategoryName , fos1.SubCategoryName ";
		 	group.setGroupName(objGroup);
				SQLQuery query = this.sessionAnnotationFactoryOP.getCurrentSession()
						.createSQLQuery(sql);
		 		query.setParameter("Category", objGroup); 
				List result = query.list();
				int size = result.size(); 
				for (int j = 0; j < size; j++) {
					Object[] obj = (Object[]) result.get(j);
					FinancialPopup1DTO financialPopup1DTO = new FinancialPopup1DTO();
					/*financialPopup1DTO
							.setRatioGroupName(obj[0] != null ? obj[0] + "" : "");*/
					/*financialPopup1DTO.setSubCategory(obj[1] != null ? obj[1]
							+ "" : "");
					financialPopup1DTO
							.setThisActual(obj[2] != null ? obj[2] + "" : "");*/
					financialPopup1DTO.setSubCategory(obj[0] != null ? obj[0]
							+ "" : "");
					financialPopup1DTO
							.setThisActual(obj[1] != null ? obj[1] + "" : "");
					result.set(j, financialPopup1DTO);
				}
				group.setFinancialPopup1DTO(result);
				groupList.add(group);  
		}
		return groupList;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return null;
	} 
	public List<FinancialPopup3GroupDTO> getPopup3BK(int year,
			int month, String tab, String sumType) {
		Session session=this.sessionAnnotationFactoryOP
		.getCurrentSession();
try{
		// sumType 6 ==>YTD , 7 ==>Monthly
		String q1 = "";
		String q2 = "";
		String q3 = "";
		String sumtype1="";
		String sumtype2="";
		String sumtype3="";
	if(tab!=null){
		if (tab.equals("Restaurant")) {
			q1 = " do1.RevenueGroupDesc = 'Restaurant'  ";
		} else if (tab.equals("Bakery")) {
			q1 = " do1.RevenueGroupDesc = 'Shop'  ";
		} else if (tab.equals("Specialty")) {
			q1 = " do1.RevenueGroupDesc = 'Specialty'  ";
		} else if (tab.equals("Trading")) {
			q1 = " do1.RevenueGroupDesc = 'Trading'  ";
		} else if (tab.equals("Caterman")) {
			q1 = " do1.RevenueGroupDesc = 'Caterman'  ";
		} else if (tab.equals("Other")) {
			q1 = " do1.RevenueGroupDesc = 'Other'  ";
		}
	}
		if (sumType.equals("1")) {//YTD vs Last YTD
		 
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"    ";
			sumtype2 = " dd2.Year ="+year+" - 1 and"+
                       " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3 = " dd3.Year ="+year+" - 1 and"+
                    " dd3.MonthNo between 1 and "+month+"   "; 
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype2 = " dd2.Year ="+year+"  and" +
					   " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype3 = " dd3.Year ="+year+"  and" +
					   " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype2 = " dd2.Year ="+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year ="+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			sumtype2 =" dd2.Year ="+year+" and "+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3 =" dd3.Year ="+year+" and "+
					 " dd3.MonthNo = "+month+"  "; 
		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
			sumtype2 = " dd2.Year = "+year+" and"+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" and"+
					 " dd3.MonthNo = "+month+"  ";
	   }  
		
		String sqlGroup=" Select Cate  " +
				//", "+
      // "  (sum(ThisPeriodActualCost)/sum(ThisPeriodActualSales))*100 as PercentActual, "+
	   // "  (sum(ThisPeriodBudgetCost)/sum(ThisPeriodBudgetSales))*100 as PercentBudget "+
				"  From  "+
				"  (select map1.RunningID as RID, map1.Category as Cate, "+ 
				"  map1.SubCategory as SubCate,  dd1.Year as Yr, dd1.MonthNo as M_No, "+ 
				"  sum(fab1.BalanceAmount*map1.AccountSign) as ThisPeriodActualCost,  "+
				"  sum(fab1.BudgetAmount*map1.AccountSign) as ThisPeriodBudgetCost "+
				"  from FactAccountBalance fab1, DimDate dd1, DimAccount da1,  "+
				"  MapAccountProductGroup map1, DimOrg do1 "+
				"  where fab1.DateKey = dd1.DateKey and "+
				"  fab1.OrgKey = do1.OrgKey and "+
				"  fab1.AccountKey = da1.AccountKey and "+
				"  da1.CompanyCode = map1.CompanyCode and "+
				"  da1.AccountCode = map1.AccountCode and "+
				"  da1.SubsidiaryCode = map1.SubsidiaryCode and "+
				"  da1.CompanyCode = '00100' and "+
				"  map1.TemplateID = 1 and "+
				"  map1.CompanyCode = '00100' and "+
				"  map1.AccountGroup = 'CS' and "+
				"  do1.CompanyCode = '00100' and  "+ 
                sumtype1+
                q1+
                "  group by RID, Cate, SubCate, Yr, M_No) cs  "+
                "  join  "+
                "  (select rim.RID as RID, sum(ns.ActualNetSales) as ThisPeriodActualSales, "+ 
                "  sum(ns.BudgetNetSales) as ThisPeriodBudgetSales "+
                "  from  "+
                "  (select ss.RID as RID, "+ 
                "  (COALESCE(ss.ActualSalesAmt,0)+COALESCE(ds.ActualDiscAmt,0)) as ActualNetSales, "+
                "  (COALESCE(ss.BudgetSalesAmt,0)+COALESCE(ds.BudgetDiscAmt,0)) as BudgetNetSales "+
                "  from "+
                "  ( (select map2.RunningID as RID, map2.ProductGroupCode as pGroup, "+ 
                "  COALESCE(sum(fab2.BalanceAmount*map2.AccountSign),0) as ActualSalesAmt, "+
                "  COALESCE(sum(fab2.BudgetAmount*map2.AccountSign),0) as BudgetSalesAmt "+
                "  from FactAccountBalance fab2, DimDate dd2, DimOrg do2, DimAccount da2,  "+
                "  MapAccountProductGroup map2 "+
                "  where fab2.DateKey = dd2.DateKey and "+
                "  fab2.OrgKey = do2.OrgKey and "+
                "  fab2.AccountKey = da2.AccountKey and "+
                "  da2.CompanyCode = map2.CompanyCode and "+
                "  da2.AccountCode = map2.AccountCode and "+
                "  da2.SubsidiaryCode = map2.SubsidiaryCode and "+
                "  da2.CompanyCode = '00100' and "+
                "  map2.TemplateID = 1 and "+
                "  map2.CompanyCode = '00100' and "+
                "  map2.AccountGroup = 'SS' and "+
                "  map2.ProductGroupCode is not null and "+
                "  do2.CompanyCode = '00100' and "+
		    
                sumtype2+
                q2+
                 "  group by RID, pGroup) ss "+
                 "  LEFT JOIN  "+
                 "  (select map3.ProductGroupCode as pGroup, "+ 
                 "  COALESCE(sum(fab3.BalanceAmount*map3.AccountSign),0) as ActualDiscAmt, "+
                 "  COALESCE(sum(fab3.BudgetAmount*map3.AccountSign),0) as BudgetDiscAmt "+
                 "  from FactAccountBalance fab3, DimDate dd3, DimOrg do3, DimAccount da3,  "+
                 "  MapAccountProductGroup map3 "+
                 "  where fab3.DateKey = dd3.DateKey and "+
                 "  fab3.OrgKey = do3.OrgKey and "+
                 "  fab3.AccountKey = da3.AccountKey and "+
                 "  da3.CompanyCode = map3.CompanyCode and "+
                 "  da3.AccountCode = map3.AccountCode and "+
                 "  da3.SubsidiaryCode = map3.SubsidiaryCode and "+
                 "  da3.CompanyCode = '00100' and "+
                 "  map3.TemplateID = 1 and "+
                 "  map3.CompanyCode = '00100' and "+
                 "  map3.AccountGroup = 'DS' and "+
                 "  map3.ProductGroupCode is not null and "+
                 "  do3.CompanyCode = '00100' and "+
 
                 sumtype3+
                 q3+
                    "  group by pGroup) ds on ss.pGroup = ds.pGroup "+
                    "  )) ns "+
                    "  join "+
                    "  ( select RunningID as RID, MappingID as MID "+ 
                    "  from RunningIdMapping "+
                    "  where TemplateID = 1 "+
                    "  ) rim on ns.RID = rim.MID "+
                    "  group by rim.RID) ns on cs.RID = ns.RID "+ 
                    "  group by Cate ";
                   // "  , SubCate ";
           
/*//" group by map1.Category";
        " group by map1.RunningID, map1.ProductGroupCode, map1.Category, "+
		" map1.SubCategory, dd1.Year, dd1.MonthNo) as result "+
		" group by Cate "; */
//System.out.println(" query group="+sqlGroup);
		SQLQuery queryGroup = session.createSQLQuery(sqlGroup);
		 
		List resultGroup = queryGroup.list();
		List groupList =new ArrayList<FinancialPopup3GroupDTO>();
		int sizeGroup = resultGroup.size();
		System.out.println(" grou sizeeeeeeeeeeeeeeeee="+sizeGroup);
	 	for (int i = 0; i < sizeGroup; i++) {
			String sql = "";
			FinancialPopup3GroupDTO group=new FinancialPopup3GroupDTO();
			String objGroup = (String) resultGroup.get(i);
			sql=" Select Cate  , SubCate ,"+
				       "  (sum(ThisPeriodActualCost)/sum(ThisPeriodActualSales))*100 as PercentActual, "+
					    "  (sum(ThisPeriodBudgetCost)/sum(ThisPeriodBudgetSales))*100 as PercentBudget "+
								"  From  "+
								"  (select map1.RunningID as RID, map1.Category as Cate, "+ 
								"  map1.SubCategory as SubCate,  dd1.Year as Yr, dd1.MonthNo as M_No, "+ 
								"  sum(fab1.BalanceAmount*map1.AccountSign) as ThisPeriodActualCost,  "+
								"  sum(fab1.BudgetAmount*map1.AccountSign) as ThisPeriodBudgetCost "+
								"  from FactAccountBalance fab1, DimDate dd1, DimAccount da1,  "+
								"  MapAccountProductGroup map1, DimOrg do1 "+
								"  where fab1.DateKey = dd1.DateKey and "+
								"  fab1.OrgKey = do1.OrgKey and "+
								"  fab1.AccountKey = da1.AccountKey and "+
								"  da1.CompanyCode = map1.CompanyCode and "+
								"  da1.AccountCode = map1.AccountCode and "+
								"  da1.SubsidiaryCode = map1.SubsidiaryCode and "+
								"  da1.CompanyCode = '00100' and "+
								"  map1.TemplateID = 1 and "+
								"  map1.CompanyCode = '00100' and "+
								"  map1.AccountGroup = 'CS' and "+
								"  do1.CompanyCode = '00100' and  "+ 
				                sumtype1+
				                q1+
				                "  group by RID, Cate, SubCate, Yr, M_No) cs  "+
				                "  join  "+
				                "  (select rim.RID as RID, sum(ns.ActualNetSales) as ThisPeriodActualSales, "+ 
				                "  sum(ns.BudgetNetSales) as ThisPeriodBudgetSales "+
				                "  from  "+
				                "  (select ss.RID as RID, "+ 
				                "  (COALESCE(ss.ActualSalesAmt,0)+COALESCE(ds.ActualDiscAmt,0)) as ActualNetSales, "+
				                "  (COALESCE(ss.BudgetSalesAmt,0)+COALESCE(ds.BudgetDiscAmt,0)) as BudgetNetSales "+
				                "  from "+
				                "  ( (select map2.RunningID as RID, map2.ProductGroupCode as pGroup, "+ 
				                "  COALESCE(sum(fab2.BalanceAmount*map2.AccountSign),0) as ActualSalesAmt, "+
				                "  COALESCE(sum(fab2.BudgetAmount*map2.AccountSign),0) as BudgetSalesAmt "+
				                "  from FactAccountBalance fab2, DimDate dd2, DimOrg do2, DimAccount da2,  "+
				                "  MapAccountProductGroup map2 "+
				                "  where fab2.DateKey = dd2.DateKey and "+
				                "  fab2.OrgKey = do2.OrgKey and "+
				                "  fab2.AccountKey = da2.AccountKey and "+
				                "  da2.CompanyCode = map2.CompanyCode and "+
				                "  da2.AccountCode = map2.AccountCode and "+
				                "  da2.SubsidiaryCode = map2.SubsidiaryCode and "+
				                "  da2.CompanyCode = '00100' and "+
				                "  map2.TemplateID = 1 and "+
				                "  map2.CompanyCode = '00100' and "+
				                "  map2.AccountGroup = 'SS' and "+
				                "  map2.ProductGroupCode is not null and "+
				                "  do2.CompanyCode = '00100' and "+ 
				                sumtype2+
				                q2+
				                 "  group by RID, pGroup) ss "+
				                 "  LEFT JOIN  "+
				                 "  (select map3.ProductGroupCode as pGroup, "+ 
				                 "  COALESCE(sum(fab3.BalanceAmount*map3.AccountSign),0) as ActualDiscAmt, "+
				                 "  COALESCE(sum(fab3.BudgetAmount*map3.AccountSign),0) as BudgetDiscAmt "+
				                 "  from FactAccountBalance fab3, DimDate dd3, DimOrg do3, DimAccount da3,  "+
				                 "  MapAccountProductGroup map3 "+
				                 "  where fab3.DateKey = dd3.DateKey and "+
				                 "  fab3.OrgKey = do3.OrgKey and "+
				                 "  fab3.AccountKey = da3.AccountKey and "+
				                 "  da3.CompanyCode = map3.CompanyCode and "+
				                 "  da3.AccountCode = map3.AccountCode and "+
				                 "  da3.SubsidiaryCode = map3.SubsidiaryCode and "+
				                 "  da3.CompanyCode = '00100' and "+
				                 "  map3.TemplateID = 1 and "+
				                 "  map3.CompanyCode = '00100' and "+
				                 "  map3.AccountGroup = 'DS' and "+
				                 "  map3.ProductGroupCode is not null and "+
				                 "  do3.CompanyCode = '00100' and "+ 
				                 sumtype3+
				                 q3+
				                    "  group by pGroup) ds on ss.pGroup = ds.pGroup "+
				                    "  )) ns "+
				                    "  join "+
				                    "  ( select RunningID as RID, MappingID as MID "+ 
				                    "  from RunningIdMapping "+
				                    "  where TemplateID = 1 "+
				                    "  ) rim on ns.RID = rim.MID "+
				                    "  group by rim.RID) ns on cs.RID = ns.RID "+ 
				                    " where Cate='"+objGroup+"' "+
				                    "  group by Cate ,SubCate "; 
		 	group.setGroupName(objGroup);
			 System.out.println("query is inner ==> " + sql);
				/*SQLQuery query3 = session
						.createSQLQuery(sql);*/
						queryGroup=session
								.createSQLQuery(sql);
		 	//	query.setParameter("Category", objGroup); 
		 		
				List result = queryGroup.list();
				System.out.println("xxxxxxxxxxxxxxxx result="+result);
				int size = result.size();
				System.out.println("xxxxxxxxxxxxxxxx ="+objGroup+",size="+size);
				for (int j = 0; j < size; j++) {
					Object[] obj = (Object[]) result.get(j);
					FinancialPopup3DTO financialPopup3DTO = new FinancialPopup3DTO();
					/*financialPopup1DTO
							.setRatioGroupName(obj[0] != null ? obj[0] + "" : "");*/
					financialPopup3DTO.setSubCategory(obj[1] != null ? obj[1]
							+ "" : "");
					financialPopup3DTO
							.setPercentActual(obj[2] != null ? obj[2] + "" : "");
					financialPopup3DTO
					.setPercentBudget(obj[3] != null ? obj[3] + "" : "");
					/*financialPopup1DTO.setSubCategory(obj[0] != null ? obj[0]
							+ "" : "");
					financialPopup1DTO
							.setThisActual(obj[1] != null ? obj[1] + "" : "");*/
					
					String sql2 = "Select Cate , SubCate, (sum(LastPeriodActualCost)/sum(LastPeriodActualSales))*100 as PercentLastPeriodActual" +
							" From " +
							" (select map1.RunningID as RID, map1.Category as Cate, map1.SubCategory as SubCate," + 
							" dd1.Year as Yr, dd1.MonthNo as M_No, " +
							" sum(fab1.BalanceAmount*map1.AccountSign) as LastPeriodActualCost" +
							" from FactAccountBalance fab1, DimDate dd1, DimAccount da1, " +
							" MapAccountProductGroup map1, DimOrg do1" +
							" where fab1.DateKey = dd1.DateKey and" +
							" fab1.OrgKey = do1.OrgKey and" +
							" fab1.AccountKey = da1.AccountKey and" +
							" da1.CompanyCode = map1.CompanyCode and" +
							" da1.AccountCode = map1.AccountCode and" +
							" da1.SubsidiaryCode = map1.SubsidiaryCode and" +
							" da1.CompanyCode = '00100' and" +
							" map1.TemplateID = 1 and" +
							" map1.CompanyCode = '00100' and" +
							" map1.AccountGroup = 'CS' and" +
							" do1.CompanyCode = '00100' and" +
							 sumtype1+
			                 q1+ 
                            " group by RID, Cate, SubCate, Yr, M_No) cs" +
                            " join" +
                            " (select rim.RID as RID, sum(ns.ActualNetSales) as LastPeriodActualSales" +
                            " from " +
                            " (select ss.RID as RID," + 
                            " (COALESCE(ss.ActualSalesAmt,0)+COALESCE(ds.ActualDiscAmt,0)) as ActualNetSales" +
                            " from" +
                            " ( (select map2.RunningID as RID, map2.ProductGroupCode as pGroup," + 
                            " COALESCE(sum(fab2.BalanceAmount*map2.AccountSign),0) as ActualSalesAmt" +
                            " from FactAccountBalance fab2, DimDate dd2, DimOrg do2, DimAccount da2, " +
                            " MapAccountProductGroup map2" +
                            " where fab2.DateKey = dd2.DateKey and" +
                            " fab2.OrgKey = do2.OrgKey and" +
                            " fab2.AccountKey = da2.AccountKey and" +
                            " da2.CompanyCode = map2.CompanyCode and" +
                            " da2.AccountCode = map2.AccountCode and" +
                            " da2.SubsidiaryCode = map2.SubsidiaryCode and" +
                            " da2.CompanyCode = '00100' and" +
                            " map2.TemplateID = 1 and" +
                            " map2.CompanyCode = '00100' and" +
                            " map2.AccountGroup = 'SS' and" +
                            " map2.ProductGroupCode is not null and" +
                            " do2.CompanyCode = '00100' and" +
                            sumtype2+
                            q2+
                            "   group by RID, pGroup) ss" +
                            " LEFT JOIN " +
                            " (select map3.ProductGroupCode as pGroup," + 
                            " COALESCE(sum(fab3.BalanceAmount*map3.AccountSign),0) as ActualDiscAmt" +
                            " from FactAccountBalance fab3, DimDate dd3, DimOrg do3, DimAccount da3, " +
                            " MapAccountProductGroup map3" +
                            " where fab3.DateKey = dd3.DateKey and" +
                            " fab3.OrgKey = do3.OrgKey and" +
                            " fab3.AccountKey = da3.AccountKey and" +
                            " da3.CompanyCode = map3.CompanyCode and" +
                            " da3.AccountCode = map3.AccountCode and" +
                            " da3.SubsidiaryCode = map3.SubsidiaryCode and" +
                            " da3.CompanyCode = '00100' and" +
                            " map3.TemplateID = 1 and" +
                            " map3.CompanyCode = '00100' and" +
                            " map3.AccountGroup = 'DS' and" +
                            " map3.ProductGroupCode is not null and" +
                            " do3.CompanyCode = '00100' and" +
                            sumtype3+
                            q3+
                            " group by pGroup) ds on ss.pGroup = ds.pGroup" +
                            " )) ns" +
                            " join" +
                            " ( select RunningID as RID, MappingID as MID" + 
                            " from RunningIdMapping" +
                            " where TemplateID = 1" +
                            " ) rim on ns.RID = rim.MID" +
                            " group by rim.RID) ns on cs.RID = ns.RID" + 
                            " where Cate=:Cate  and SubCate=:SubCate '" +
                            " group by Cate" +
                            " , SubCate ";
					System.out.println("sql inner2="+sql2);
					/*SQLQuery query2 = session.createSQLQuery(sql2);
			 		query2.setParameter("Cate", objGroup); 
			 		query2.setParameter("SubCate", financialPopup3DTO.getSubCategory());
					List result2 = query2.list();
					int size2 = result2.size(); 
					for (int k = 0; k < size2; k++) {
						Object[] obj2 = (Object[]) result2.get(k);
						financialPopup3DTO
						.setPercentLastPeriodActual(obj2[2] != null ? obj2[2] + "" : "");
					}*/
					result.set(j, financialPopup3DTO);
				}
				group.setFinancialPopup3DTO(result);
				groupList.add(group);  
		}
		return groupList;
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
		return null;
	}
	@Override
	public List getPopup3(int year,
			int month, String tab, String sumType) {
		Session session=this.sessionAnnotationFactoryOP
		.getCurrentSession();
try{
		// sumType 6 ==>YTD , 7 ==>Monthly
		String q1 = "";
		String q2 = "";
		String q3 = "";
		String sumtype1="";
		String sumtype2="";
		String sumtype3="";
		String sumtype1_2="";
		String sumtype2_2="";
		String sumtype3_2="";
		boolean haveOrgType =false;
	if(tab!=null && tab.length()>0 && !tab.equals("null")) {
		haveOrgType=true;
		if (tab.equals("Restaurant")) {
			q1 = " do1.RevenueGroupDesc = 'Restaurant' and ";
			q2 = " do2.RevenueGroupDesc = 'Restaurant' and ";
			q3 = " do3.RevenueGroupDesc = 'Restaurant' and ";
		} else if (tab.equals("Bakery")) {
			q1 = " do1.RevenueGroupDesc = 'Shop'  and ";
			q2 = " do2.RevenueGroupDesc = 'Shop' and ";
			q3 = " do3.RevenueGroupDesc = 'Shop' and ";
		} else if (tab.equals("Specialty")) {
			q1 = " do1.RevenueGroupDesc = 'Specialty'  and ";
			q2 = " do2.RevenueGroupDesc = 'Specialty' and ";
			q3 = " do3.RevenueGroupDesc = 'Specialty' and ";
		} else if (tab.equals("Trading")) {
			q1 = " do1.RevenueGroupDesc = 'Trading' and ";
			q2 = " do2.RevenueGroupDesc = 'Trading' and ";
			q3 = " do3.RevenueGroupDesc = 'Trading' and ";
		} else if (tab.equals("Caterman")) {
			q1 = " do1.RevenueGroupDesc = 'Caterman' and ";
			q2 = " do2.RevenueGroupDesc = 'Caterman' and ";
			q3 = " do3.RevenueGroupDesc = 'Caterman' and ";
		} else if (tab.equals("Other")) {
			q1 = " do1.RevenueGroupDesc = 'Other' and  ";
			q2 = " do2.RevenueGroupDesc = 'Other' and  ";
			q3 = " do3.RevenueGroupDesc = 'Other' and  ";
		}
	}
		if (sumType.equals("1")) {//YTD vs Last YTD
		 
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"    ";
			sumtype2 = " dd2.Year ="+year+"  and"+
                       " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3 = " dd3.Year ="+year+" and"+
                    " dd3.MonthNo between 1 and "+month+"   "; 
			
			sumtype1_2 = " dd1.Year ="+year+"-1 and"+
                    " dd1.MonthNo between 1 and "+month+"    ";
			sumtype2_2 = " dd2.Year ="+year+" - 1 and"+
                    " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3_2 = " dd3.Year ="+year+" - 1 and"+
                 " dd3.MonthNo between 1 and "+month+"   "; 			
					
							  
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype2 = " dd2.Year ="+year+"  and" +
					   " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype3 = " dd3.Year ="+year+"  and" +
					   " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
					   
			sumtype1_2 = " dd1.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
			" dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
			" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";
			
			sumtype2_2 = " dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
					" dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
					" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";

			sumtype3_2 = " dd3.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
					" dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
					" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype2 = " dd2.Year ="+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year ="+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype1_2 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  "; 
			sumtype2_2 = " dd2.Year ="+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3_2 = " dd3.Year ="+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
		
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			sumtype2 =" dd2.Year ="+year+" and "+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3 =" dd3.Year ="+year+" and "+
					 " dd3.MonthNo = "+month+"  "; 
			sumtype1_2= " dd1.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					  " dd1.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";
			sumtype2_2= " dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					  " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";  
			sumtype3_2= " dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					  " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";

		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
			sumtype2 = " dd2.Year = "+year+" and"+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" and"+
					 " dd3.MonthNo = "+month+"  ";
			
			sumtype1_2 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
			sumtype2_2 = " dd2.Year = "+year+" and"+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3_2 = " dd3.Year = "+year+" and"+
					 " dd3.MonthNo = "+month+"  ";
	   }  
		String sqlPercentActual_PercentBudget="Select c.CateName, "+
				" (c.ThisPeriodActualCost/s.ThisPeriodActualSales)*100 as PercentActual, "+
				" (c.ThisPeriodBudgetCost/s.ThisPeriodBudgetSales)*100 as PercentBudget "+
				" from "+
				" (select fos1.CategoryCode as CateCode, fos1.CategoryName as CateName, "+
				" sum(fos1.BalanceAmount) as ThisPeriodActualCost, "+
				" sum(fos1.BudgetAmount) as ThisPeriodBudgetCost "+
				((haveOrgType)?(" from FinOrgSummary fos1  "):(" from FinCompanySummary fos1 "))+ //"FinCompanySummary "+				
				", DimDate dd1 "+
				((haveOrgType)?(", DimOrg do1"):(""))+ //", DimOrg do1 "+
				" where fos1.DateKey = dd1.DateKey and "+
				((haveOrgType)?(" fos1.OrgKey = do1.Orgkey and "):(""))+ //" fos1.OrgKey = do1.Orgkey and "+
				" fos1.ItemID = 4 and "+
		 
		   q1+		
           sumtype1+
             //   " group by RID, Cate, Yr, M_No) cs "+
           " group by fos1.CategoryCode, fos1.CategoryName) c "+
           " join  "+
           " (select fos2.CategoryCode as CateCode, fos2.CategoryName as CateName,  "+
           " sum(fos2.BalanceAmount) as ThisPeriodActualSales,  "+
           " sum(fos2.BudgetAmount) as ThisPeriodBudgetSales  "+
       	((haveOrgType)?(" from FinOrgSummary fos2  "):(" from FinCompanySummary fos2 "))+ //"FinCompanySummary "+
       			
       //    " from FinOrgSummary fos2, DimDate dd2 " +
       		", DimDate dd2 "+
           ((haveOrgType)?(", DimOrg do2"):(""))+ //", DimOrg do1 "+
           " where fos2.DateKey = dd2.DateKey and  "+
       	  ((haveOrgType)?(" fos2.OrgKey = do2.Orgkey and "):(""))+ //  " fos2.OrgKey = do2.OrgKey and  "+
           " fos2.ItemID = 3 and  "+
        
		   q2+		 
           sumtype2+   
          " group by fos2.CategoryCode, fos2.CategoryName) s on c.CateCode = s.CateCode ";
        		 
		SQLQuery queryPercentActual_PercentBudget = session.createSQLQuery(sqlPercentActual_PercentBudget);
		 
		List resultGroup = queryPercentActual_PercentBudget.list();
		List groupList =new ArrayList(2);
		List popup3 =new ArrayList<FinancialPopup3DTO>();
		int sizeGroup = resultGroup.size();
		System.out.println("  sql PercentActual_PercentBudget ="+sqlPercentActual_PercentBudget);
		System.out.println(" grou sizeeeeeeeeeeeeeeeee="+sizeGroup);
	 	for (int i = 0; i < sizeGroup; i++) { 
			FinancialPopup3DTO group=new FinancialPopup3DTO();
			Object[] objGroup = (Object[]) resultGroup.get(i); 
			group
			.setSubCategory(objGroup[0] != null ? objGroup[0] + "" : "");
			group
			.setPercentActual(objGroup[1] != null ? objGroup[1] + "" : "");
			group
			.setPercentBudget(objGroup[2] != null ? objGroup[2] + "" : "");
			popup3.add(group);  
		}
	 	
	 		String sql_PercentLastPeriodActual="Select c.CateName, "+
	 				" (c.LastPeriodActualCost/s.LastPeriodActualSales)*100 as PercentLastPeriodActual  "+
	 				" from  "+
	 				" (select fos1.CategoryCode as CateCode, fos1.CategoryName as CateName,  "+
	 				" sum(fos1.BalanceAmount) as LastPeriodActualCost  "+
	 				((haveOrgType)?(" from FinOrgSummary fos1  "):(" from FinCompanySummary fos1 "))+ //"FinCompanySummary "+
	 			//	" from FinOrgSummary fos1, DimDate dd1" +
	 				", DimDate dd1"+
	 				((haveOrgType)?(", DimOrg do1"):(""))+ //", DimOrg do1 "+
	 				" where fos1.DateKey = dd1.DateKey and  "+
	 				((haveOrgType)?(" fos1.OrgKey = do1.Orgkey and "):(""))+ //" fos1.Orgkey = do1.OrgKey and  "+
	 				" fos1.ItemID = 4 and "+ 
	
			     q1+		 
	         sumtype1_2+  
	          //  "    group by RID, Cate, Yr, M_No) cs "+
	          " group by fos1.CategoryCode, fos1.CategoryName) c "+
	            "    join "+
	            "  (select fos2.CategoryCode as CateCode, fos2.CategoryName as CateName, "+
	            "  	 sum(fos2.BalanceAmount) as LastPeriodActualSales "+
	        	((haveOrgType)?(" from FinOrgSummary fos2  "):(" from FinCompanySummary fos2 "))+ //"FinCompanySummary "+
	            //"  	 from FinOrgSummary fos2, DimDate dd2" +
	        	" , DimDate dd2 "+
	            ((haveOrgType)?(", DimOrg do2"):(""))+ //", DimOrg do2 "+
	            "  	 where fos2.DateKey = dd2.DateKey and "+
	            ((haveOrgType)?(" fos2.OrgKey = do2.Orgkey and "):(""))+ // "  	 fos2.OrgKey = do2.Orgkey and "+
	            "  	 fos2.ItemID = 3 and "+
	          
			   q2+		
	           sumtype2_2+  
	           " group by fos2.CategoryCode, fos2.CategoryName) s on c.CateCode = s.CateCode ";
				 System.out.println("sql PercentLastPeriodActual ==> " + sql_PercentLastPeriodActual);
					SQLQuery query_PercentLastPeriodActual = session
							.createSQLQuery(sql_PercentLastPeriodActual);  
					List result2 = query_PercentLastPeriodActual.list();
					System.out.println("xxxxxxxxxxxxxxxx result2="+result2.size());
					System.out.println(" haveOrgType ="+haveOrgType);
					System.out.println(" tab ="+tab);
					int size = result2.size(); 
					List popup3_2 =new ArrayList<FinancialPopup3DTO>();
					for (int j = 0; j < size; j++) {
						Object[] obj2=(Object[])result2.get(j);
						FinancialPopup3DTO group=new FinancialPopup3DTO(); 
						group
						.setSubCategory(obj2[0] != null ? obj2[0] + "" : "");
						group
						.setPercentLastPeriodActual(obj2[1] != null ? obj2[1] + "" : "");
						System.out.println("=====================setPercentLastPeriodActual"+group.getPercentLastPeriodActual());
						popup3_2.add(group);  
					}
					groupList.add(popup3);
					groupList.add(popup3_2);
		return groupList;
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
		return null;
	}
	
	public List getPopup3_BK2(int year,
			int month, String tab, String sumType) {
		Session session=this.sessionAnnotationFactoryOP
		.getCurrentSession();
try{
		// sumType 6 ==>YTD , 7 ==>Monthly
		String q1 = "";
		String q2 = "";
		String q3 = "";
		String sumtype1="";
		String sumtype2="";
		String sumtype3="";
		String sumtype1_2="";
		String sumtype2_2="";
		String sumtype3_2="";
	if(tab!=null){
		if (tab.equals("Restaurant")) {
			q1 = " do1.RevenueGroupDesc = 'Restaurant' and ";
			q2 = " do2.RevenueGroupDesc = 'Restaurant' and ";
			q3 = " do3.RevenueGroupDesc = 'Restaurant' and ";
		} else if (tab.equals("Bakery")) {
			q1 = " do1.RevenueGroupDesc = 'Shop'  and ";
			q2 = " do2.RevenueGroupDesc = 'Shop' and ";
			q3 = " do3.RevenueGroupDesc = 'Shop' and ";
		} else if (tab.equals("Specialty")) {
			q1 = " do1.RevenueGroupDesc = 'Specialty'  and ";
			q2 = " do2.RevenueGroupDesc = 'Specialty' and ";
			q3 = " do3.RevenueGroupDesc = 'Specialty' and ";
		} else if (tab.equals("Trading")) {
			q1 = " do1.RevenueGroupDesc = 'Trading' and ";
			q2 = " do2.RevenueGroupDesc = 'Trading' and ";
			q3 = " do3.RevenueGroupDesc = 'Trading' and ";
		} else if (tab.equals("Caterman")) {
			q1 = " do1.RevenueGroupDesc = 'Caterman' and ";
			q2 = " do2.RevenueGroupDesc = 'Caterman' and ";
			q3 = " do3.RevenueGroupDesc = 'Caterman' and ";
		} else if (tab.equals("Other")) {
			q1 = " do1.RevenueGroupDesc = 'Other' and  ";
			q2 = " do2.RevenueGroupDesc = 'Other' and  ";
			q3 = " do3.RevenueGroupDesc = 'Other' and  ";
		}
	}
		if (sumType.equals("1")) {//YTD vs Last YTD
		 
			sumtype1 = " dd1.Year ="+year+" and"+
                       " dd1.MonthNo between 1 and "+month+"    ";
			sumtype2 = " dd2.Year ="+year+"  and"+
                       " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3 = " dd3.Year ="+year+" and"+
                    " dd3.MonthNo between 1 and "+month+"   "; 
			
			sumtype1_2 = " dd1.Year ="+year+"-1 and"+
                    " dd1.MonthNo between 1 and "+month+"    ";
			sumtype2_2 = " dd2.Year ="+year+" - 1 and"+
                    " dd2.MonthNo between 1 and "+month+"   ";
			sumtype3_2 = " dd3.Year ="+year+" - 1 and"+
                 " dd3.MonthNo between 1 and "+month+"   "; 			
					
							  
		} else if (sumType.equals("2")) { //Quarter vs Last Quarter 
			sumtype1 = " dd1.Year ="+year+"  and" +
					   " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype2 = " dd2.Year ="+year+"  and" +
					   " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
			sumtype3 = " dd3.Year ="+year+"  and" +
					   " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+" -"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"   ";
					   
			sumtype1_2 = " dd1.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
			" dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
			" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";
			
			sumtype2_2 = " dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
					" dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
					" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";

			sumtype3_2 = " dd3.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)  and "+
					" dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c') and "+ 
					" DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 3 month)/3)*3-2,'-1')), '%c')+2 ";
		} else if (sumType.equals("3")) {//Quarter vs Last Year same Quarter
			sumtype1 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype2 = " dd2.Year ="+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3 = " dd3.Year ="+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype1_2 = " dd1.Year ="+year+" and "+
					 " dd1.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  "; 
			sumtype2_2 = " dd2.Year ="+year+" and "+
					 " dd2.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
			sumtype3_2 = " dd3.Year ="+year+" and "+
					 " dd3.MonthNo between DATE_FORMAT(date(concat(year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\")),'-',ceil(month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\"))/3)*3-2,'-1')), '%c') and "+month+"  ";
		
		} else if (sumType.equals("4")) { //Monthly vs Last Monthly
			sumtype1 =" dd1.Year ="+year+" and "+
					 " dd1.MonthNo = "+month+"  "; 
			sumtype2 =" dd2.Year ="+year+" and "+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3 =" dd3.Year ="+year+" and "+
					 " dd3.MonthNo = "+month+"  "; 
			sumtype1_2= " dd1.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					  " dd1.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";
			sumtype2_2= " dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					  " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";  
			sumtype3_2= " dd2.Year = year(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month)  and "+
					  " dd2.MonthNo = month(str_to_date('01-"+shortmonthNameG[month-1]+"-"+year+"', \"%d-%b-%Y\") -interval 1 month) ";

		} else if (sumType.equals("5")) { //Monthly vs Last Year same Monthly
			sumtype1 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
			sumtype2 = " dd2.Year = "+year+" and"+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3 = " dd3.Year = "+year+" and"+
					 " dd3.MonthNo = "+month+"  ";
			
			sumtype1_2 = " dd1.Year = "+year+" and"+
					 " dd1.MonthNo = "+month+"  ";
			sumtype2_2 = " dd2.Year = "+year+" and"+
					 " dd2.MonthNo = "+month+"  ";
			sumtype3_2 = " dd3.Year = "+year+" and"+
					 " dd3.MonthNo = "+month+"  ";
	   }  
		String sqlGroup="Select c.CateName, "+
				" (c.ThisPeriodActualCost/s.ThisPeriodActualSales)*100 as PercentActual, "+
				" (c.ThisPeriodBudgetCost/s.ThisPeriodBudgetSales)*100 as PercentBudget "+
				" from "+
				" (select fos1.CategoryCode as CateCode, fos1.CategoryName as CateName, "+
				" sum(fos1.BalanceAmount) as ThisPeriodActualCost, "+
				" sum(fos1.BudgetAmount) as ThisPeriodBudgetCost "+
				" from FinOrgSummary fos1, DimDate dd1, DimOrg do1 "+
				" where fos1.DateKey = dd1.DateKey and "+
				" fos1.OrgKey = do1.Orgkey and "+
				" fos1.ItemID = 4 and "+
		/*String sqlGroup="Select Cate, "+
                " (sum(ThisPeriodActualCost)/sum(ThisPeriodActualSales))*100 as PercentActual, "+
                " (sum(ThisPeriodBudgetCost)/sum(ThisPeriodBudgetSales))*100 as PercentBudget "+
                " From  "+
                " (select map1.RunningID as RID, map1.Category as Cate, "+ 
                " dd1.Year as Yr, dd1.MonthNo as M_No,  "+
                " sum(fab1.BalanceAmount*map1.AccountSign) as ThisPeriodActualCost, "+ 
                " sum(fab1.BudgetAmount*map1.AccountSign) as ThisPeriodBudgetCost "+ 
                " from FactAccountBalance fab1, DimDate dd1, DimAccount da1,  "+
                " MapAccountProductGroup map1, DimOrg do1 "+
                " where fab1.DateKey = dd1.DateKey and "+
                " fab1.OrgKey = do1.OrgKey and "+
                " fab1.AccountKey = da1.AccountKey and "+
                " da1.CompanyCode = map1.CompanyCode and "+
                " da1.AccountCode = map1.AccountCode and "+
                " da1.SubsidiaryCode = map1.SubsidiaryCode and "+
                " da1.CompanyCode = '00100' and "+
                " map1.TemplateID = 1 and "+
                " map1.CompanyCode = '00100' and "+
                " map1.AccountGroup = 'CS' and "+
                " do1.CompanyCode = '00100' and "+*/
		   q1+		
           sumtype1+
             //   " group by RID, Cate, Yr, M_No) cs "+
           " group by fos1.CategoryCode, fos1.CategoryName) c "+
           " join  "+
           " (select fos2.CategoryCode as CateCode, fos2.CategoryName as CateName,  "+
           " sum(fos2.BalanceAmount) as ThisPeriodActualSales,  "+
           " sum(fos2.BudgetAmount) as ThisPeriodBudgetSales  "+
           " from FinOrgSummary fos2, DimDate dd2, DimOrg do2  "+
           " where fos2.DateKey = dd2.DateKey and  "+
           " fos2.OrgKey = do2.OrgKey and  "+
           " fos2.ItemID = 3 and  "+
               /* " join "+
                " (select rim.RID as RID, sum(ns.ActualNetSales) as ThisPeriodActualSales, "+ 
                " sum(ns.BudgetNetSales) as ThisPeriodBudgetSales "+
                " from  "+
                " (select ss.RID as RID, "+ 
                " (COALESCE(ss.ActualSalesAmt,0)+COALESCE(ds.ActualDiscAmt,0)) as ActualNetSales, "+
                " (COALESCE(ss.BudgetSalesAmt,0)+COALESCE(ds.BudgetDiscAmt,0)) as BudgetNetSales "+
                " from "+
                " ( (select map2.RunningID as RID, map2.ProductGroupCode as pGroup, "+ 
                " COALESCE(sum(fab2.BalanceAmount*map2.AccountSign),0) as ActualSalesAmt, "+
                " COALESCE(sum(fab2.BudgetAmount*map2.AccountSign),0) as BudgetSalesAmt "+
                " from FactAccountBalance fab2, DimDate dd2, DimOrg do2, DimAccount da2,  "+
                " MapAccountProductGroup map2 "+
                " where fab2.DateKey = dd2.DateKey and "+
                " fab2.OrgKey = do2.OrgKey and "+
                " fab2.AccountKey = da2.AccountKey and "+
                " da2.CompanyCode = map2.CompanyCode and "+
                " da2.AccountCode = map2.AccountCode and "+
                " da2.SubsidiaryCode = map2.SubsidiaryCode and "+
                " da2.CompanyCode = '00100' and "+
                " map2.TemplateID = 1 and "+
                " map2.CompanyCode = '00100' and "+
                " map2.AccountGroup = 'SS' and "+
                " map2.ProductGroupCode is not null and "+
                " do2.CompanyCode = '00100' and "+*/
		   q2+		 
           sumtype2+   
          " group by fos2.CategoryCode, fos2.CategoryName) s on c.CateCode = s.CateCode ";
        		   /*     " group by RID, pGroup) ss "+
                " LEFT JOIN  "+
                " (select map3.ProductGroupCode as pGroup, "+ 
                " COALESCE(sum(fab3.BalanceAmount*map3.AccountSign),0) as ActualDiscAmt, "+
                " COALESCE(sum(fab3.BudgetAmount*map3.AccountSign),0) as BudgetDiscAmt "+
                " from FactAccountBalance fab3, DimDate dd3, DimOrg do3, DimAccount da3,  "+
                " MapAccountProductGroup map3 "+
                " where fab3.DateKey = dd3.DateKey and "+
                " fab3.OrgKey = do3.OrgKey and "+
                " fab3.AccountKey = da3.AccountKey and "+
                " da3.CompanyCode = map3.CompanyCode and "+
                " da3.AccountCode = map3.AccountCode and "+
                " da3.SubsidiaryCode = map3.SubsidiaryCode and "+
                " da3.CompanyCode = '00100' and "+
                " map3.TemplateID = 1 and "+
                " map3.CompanyCode = '00100' and "+
                " map3.AccountGroup = 'DS' and "+
                " map3.ProductGroupCode is not null and "+
                " do3.CompanyCode = '00100' and "+
			   q3+		
	           sumtype3+      
                " group by pGroup) ds on ss.pGroup = ds.pGroup "+
                " )) ns "+
                " join "+
                " ( select RunningID as RID, MappingID as MID "+ 
                " from RunningIdMapping "+
                " where TemplateID = 1 "+
                " ) rim on ns.RID = rim.MID "+
                " group by rim.RID) ns on cs.RID = ns.RID "+ 
                " group by Cate  order by Cate"+
                " ";*/
  
		SQLQuery queryGroup = session.createSQLQuery(sqlGroup);
		 
		List resultGroup = queryGroup.list();
		List groupList =new ArrayList(2);
		List popup3 =new ArrayList<FinancialPopup3DTO>();
		int sizeGroup = resultGroup.size();
		System.out.println("  sqlGroup sql ="+sqlGroup);
		System.out.println(" grou sizeeeeeeeeeeeeeeeee="+sizeGroup);
	 	for (int i = 0; i < sizeGroup; i++) { 
			FinancialPopup3DTO group=new FinancialPopup3DTO();
			Object[] objGroup = (Object[]) resultGroup.get(i); 
			group
			.setSubCategory(objGroup[0] != null ? objGroup[0] + "" : "");
			group
			.setPercentActual(objGroup[1] != null ? objGroup[1] + "" : "");
			group
			.setPercentBudget(objGroup[2] != null ? objGroup[2] + "" : "");
			popup3.add(group);  
		}
	 	
	 		String sql="Select c.CateName, "+
	 				" (c.LastPeriodActualCost/s.LastPeriodActualSales)*100 as PercentLastPeriodActual  "+
	 				" from  "+
	 				" (select fos1.CategoryCode as CateCode, fos1.CategoryName as CateName,  "+
	 				" sum(fos1.BalanceAmount) as LastPeriodActualCost  "+
	 				" from FinOrgSummary fos1, DimDate dd1, DimOrg do1  "+
	 				" where fos1.DateKey = dd1.DateKey and  "+
	 				" fos1.Orgkey = do1.OrgKey and  "+
	 				" fos1.ItemID = 4 and "+ 
	 /*	String sql=" Select Cate, "+
	            "    (sum(LastPeriodActualCost)/sum(LastPeriodActualSales))*100 as PercentLastPeriodActual "+
	            "    From  "+
	            "    (select map1.RunningID as RID, map1.Category as Cate, "+ 
	            "    dd1.Year as Yr, dd1.MonthNo as M_No,  "+
	            "    sum(fab1.BalanceAmount*map1.AccountSign) as LastPeriodActualCost "+
	            "    from FactAccountBalance fab1, DimDate dd1, DimAccount da1,  "+
	            "    MapAccountProductGroup map1, DimOrg do1 "+
	            "    where fab1.DateKey = dd1.DateKey and "+
	            "    fab1.OrgKey = do1.OrgKey and "+
	            "    fab1.AccountKey = da1.AccountKey and "+
	            "    da1.CompanyCode = map1.CompanyCode and "+
	            "    da1.AccountCode = map1.AccountCode and "+
	            "    da1.SubsidiaryCode = map1.SubsidiaryCode and "+
	            "    da1.CompanyCode = '00100' and "+
	            "    map1.TemplateID = 1 and "+
	            "    map1.CompanyCode = '00100' and "+
	            "    map1.AccountGroup = 'CS' and "+
	            "    do1.CompanyCode = '00100' and "+*/
			     q1+		 
	         sumtype1_2+  
	          //  "    group by RID, Cate, Yr, M_No) cs "+
	          " group by fos1.CategoryCode, fos1.CategoryName) c "+
	            "    join "+
	            "  (select fos2.CategoryCode as CateCode, fos2.CategoryName as CateName, "+
	            "  	 sum(fos2.BalanceAmount) as LastPeriodActualSales "+
	            "  	 from FinOrgSummary fos2, DimDate dd2, DimOrg do2 "+
	            "  	 where fos2.DateKey = dd2.DateKey and "+
	            "  	 fos2.OrgKey = do2.Orgkey and "+
	            "  	 fos2.ItemID = 3 and "+
	           /* "    (select rim.RID as RID, sum(ns.ActualNetSales) as LastPeriodActualSales "+
	            "    from  "+
	            "    (select ss.RID as RID, "+ 
	            "    (COALESCE(ss.ActualSalesAmt,0)+COALESCE(ds.ActualDiscAmt,0)) as ActualNetSales "+
	            "    from "+
	            "    ( (select map2.RunningID as RID, map2.ProductGroupCode as pGroup, "+ 
	            "    COALESCE(sum(fab2.BalanceAmount*map2.AccountSign),0) as ActualSalesAmt "+
	            "    from FactAccountBalance fab2, DimDate dd2, DimOrg do2, DimAccount da2,  "+
	            "    MapAccountProductGroup map2 "+
	            "    where fab2.DateKey = dd2.DateKey and "+
	            "    fab2.OrgKey = do2.OrgKey and "+
	            "    fab2.AccountKey = da2.AccountKey and "+
	            "    da2.CompanyCode = map2.CompanyCode and "+
	            "    da2.AccountCode = map2.AccountCode and "+
	            "    da2.SubsidiaryCode = map2.SubsidiaryCode and "+
	            "    da2.CompanyCode = '00100' and "+
	            "    map2.TemplateID = 1 and "+
	            "    map2.CompanyCode = '00100' and "+
	            "    map2.AccountGroup = 'SS' and "+
	            "    map2.ProductGroupCode is not null and "+
	            "    do2.CompanyCode = '00100' and "+*/
			   q2+		
	           sumtype2_2+  
	           " group by fos2.CategoryCode, fos2.CategoryName) s on c.CateCode = s.CateCode ";
	          /* "    group by RID, pGroup) ss "+
	           "    LEFT JOIN  "+
	           "    (select map3.ProductGroupCode as pGroup, "+ 
	           "    COALESCE(sum(fab3.BalanceAmount*map3.AccountSign),0) as ActualDiscAmt "+
	           "    from FactAccountBalance fab3, DimDate dd3, DimOrg do3, DimAccount da3,  "+
	           "    MapAccountProductGroup map3 "+
	           "    where fab3.DateKey = dd3.DateKey and "+
	           "    fab3.OrgKey = do3.OrgKey and "+
	           "    fab3.AccountKey = da3.AccountKey and "+
	           "    	 da3.CompanyCode = map3.CompanyCode and "+
	           "    da3.AccountCode = map3.AccountCode and "+
	           "    da3.SubsidiaryCode = map3.SubsidiaryCode and "+
	           "    da3.CompanyCode = '00100' and "+
	           "    map3.TemplateID = 1 and "+
	           "    map3.CompanyCode = '00100' and "+
	           "    map3.AccountGroup = 'DS' and "+
	           "    map3.ProductGroupCode is not null and "+
	           "    do3.CompanyCode = '00100' and "+
				 q3+		
		           sumtype3_2+  
	           "    group by pGroup) ds on ss.pGroup = ds.pGroup "+
	           "    )) ns "+
	           "    join "+
	           "    ( select RunningID as RID, MappingID as MID "+ 
	           "    from RunningIdMapping "+
	           "    where TemplateID = 1 "+
	           "    ) rim on ns.RID = rim.MID "+
	           "    group by rim.RID) ns on cs.RID = ns.RID "+  
	           "    group by Cate order by Cate "; */
			 	
				 System.out.println("query is inner ==> " + sql);
					SQLQuery query3 = session
							.createSQLQuery(sql);  
					List result2 = query3.list();
					System.out.println("xxxxxxxxxxxxxxxx result2="+result2.size());
					int size = result2.size(); 
					List popup3_2 =new ArrayList<FinancialPopup3DTO>();
					for (int j = 0; j < size; j++) {
						Object[] obj2=(Object[])result2.get(j);
						FinancialPopup3DTO group=new FinancialPopup3DTO(); 
						group
						.setSubCategory(obj2[0] != null ? obj2[0] + "" : "");
						group
						.setPercentLastPeriodActual(obj2[1] != null ? obj2[1] + "" : "");
						System.out.println("=====================setPercentLastPeriodActual"+group.getPercentLastPeriodActual());
						popup3_2.add(group);  
					}
					groupList.add(popup3);
					groupList.add(popup3_2);
		return groupList;
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
		return null;
	}

	@Override
	public List test() {
		// TODO Auto-generated method stub
		Session session=this.sessionAnnotationFactoryOP
				.getCurrentSession();
		/*SQLQuery query3 = session
				.createSQLQuery("{CALL proc_SelectPerspective(2011,1,1)}"); */ 
		SQLQuery query3 = session
				.createSQLQuery("CALL proc_SelectPerspective(2011,1,1)");
		query3.list();
		List result2 = query3.list();
		System.out.println("xxxxxxxxxxxxxxxx result2="+result2.size());
		int size = result2.size(); 
	 
		for (int j = 0; j < size; j++) {
			Object[] obj2=(Object[])result2.get(j);
			FinancialPopup3DTO group=new FinancialPopup3DTO(); 
			group
			.setSubCategory(obj2[0] != null ? obj2[0] + "" : "");
			group
			.setPercentLastPeriodActual(obj2[1] != null ? obj2[1] + "" : "");
			System.out.println("=====================setPercentLastPeriodActual"+group.getPercentLastPeriodActual());
			  
		}
		return null;
	}

}
