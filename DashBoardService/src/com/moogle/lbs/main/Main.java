/**
 * Copyright 2005-2008 Noelios Technologies.
 * 
 * The contents of this file are subject to the terms of the following open
 * source licenses: LGPL 3.0 or LGPL 2.1 or CDDL 1.0 (the "Licenses"). You can
 * select the license that you prefer but you may not use this file except in
 * compliance with one of these Licenses.
 * 
 * You can obtain a copy of the LGPL 3.0 license at
 * http://www.gnu.org/licenses/lgpl-3.0.html
 * 
 * You can obtain a copy of the LGPL 2.1 license at
 * http://www.gnu.org/licenses/lgpl-2.1.html
 * 
 * You can obtain a copy of the CDDL 1.0 license at
 * http://www.sun.com/cddl/cddl.html
 * 
 * See the Licenses for the specific language governing permissions and
 * limitations under the Licenses.
 * 
 * Alternatively, you can obtain a royaltee free commercial license with less
 * limitations, transferable or non-transferable, directly at
 * http://www.noelios.com/products/restlet-engine
 * 
 * Restlet is a registered trademark of Noelios Technologies.
 */

package com.moogle.lbs.main;
  
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.moogle.lbs.balancescorecard.service.BalanceScorecardService;
import com.moogle.lbs.financedashboard.domain.FinancialPieDTO;
import com.moogle.lbs.financedashboard.service.FinanceDashboardService;
import com.moogle.lbs.operationdashboard.service.OperationDashboardService;

 
/**
 * Simple demo application that can be run either as a standalone application
 * (http://localhost:3000/v1/) or inside a servlet container
 * (http://localhost:8080/v1/).
 * 
 * @author Chatchai Pimtun (Admin)
 */
public class Main {

//    public static void main(String... args) throws Exception {
	public void testBSC(BalanceScorecardService balanceScorecardService){
		 //System.out.println(balanceScorecardService.listOwnerResult(2011,5)); // Jan , Feb , Mar 2011
		 //System.out.println(balanceScorecardService.listYear());
		 //System.out.println(balanceScorecardService.listDivisions()); not use
		
		/*List list1=balanceScorecardService.getKPIOverallPopupProc(2011,new java.math.BigDecimal(1));
		for (int i = 0; i < list1.size(); i++) {
			OverAllDTO dto=(OverAllDTO)list1.get(i);
		 
			System.out.println("dto.getEndThreshold()="+dto.getEndThreshold());
			System.out.println("getBeginThreshold="+dto.getBeginThreshold()); 
			System.out.println("getSystemColorCode="+dto.getSystemColorCode()); 
			System.out.println("===========================================");
		}
		 List list2=balanceScorecardService.getKPIOverallPopupScoreProc(2011,3,new java.math.BigDecimal(1));
		 for (int i = 0; i < list2.size(); i++) {
				OverAllDTO dto=(OverAllDTO)list2.get(i);
				System.out.println("getSystemScore="+dto.getSystemScore()+",percentActualVsTarget="+dto.getPercentActualVsTarget()); 
			}*/
		//   System.out.println(balanceScorecardService.getPerspectiveProc(new java.math.BigDecimal(1), 2011, 5));
		//System.out.println(balanceScorecardService.getKPIListAndChartLevel0Proc(2011, 3,1, 1));
		/*List level0= balanceScorecardService.getKPIListAndChartLevel0Proc(2011, 3,1, 1);
		List results=new ArrayList();
		if(level0!=null && level0.size()>0){
			int size= level0.size();
			for (int i = 0; i < size; i++) {
				KpiresultthresholdTreeDTO treeDTO = (KpiresultthresholdTreeDTO)level0.get(i); 
				results.add(treeDTO);
				 List tmp=new ArrayList();
		    	 List childs =   balanceScorecardService.getKPIListAndChartRecursiveProc(tmp,2011, 3,1,treeDTO.getKpiCode());
		    	   if(childs!=null && childs.size()>0){
		    		   int child_size=childs.size();
		    		   for (int j = 0; j < child_size; j++) { 
		    			   KpiresultthresholdTreeDTO groupChild = (KpiresultthresholdTreeDTO)childs.get(j); 
		    			   results.add(groupChild);
					}
		    	  }
			}
		}
		System.out.println(results);
		for (int i = 0; i < results.size(); i++) {
			KpiresultthresholdTreeDTO tree=(KpiresultthresholdTreeDTO)results.get(i);
			System.out.println(tree.getChildOf()+",name="+tree.getKpiName()+",code="+tree.getKpiCode());
		}
		
		*/
		//System.out.println(balanceScorecardService.getKPIPerspectiveProc(2011,1,1));
		System.out.println(balanceScorecardService.getKPIDetailProc(2011, 3, "1", "1"));
		// balanceScorecardService.getKPIPerspectiveScoreProc(2011,3,1,1);
		 //balanceScorecardService.getKPIListLevel0(2011, 1,new java.math.BigDecimal(1), 1);
		 /*balanceScorecardService.getTrendChartLevel0(2011, 1,new java.math.BigDecimal(1), 1);
		 balanceScorecardService.getKPIList(2011, 1,new java.math.BigDecimal(1), 1);
		 balanceScorecardService.getTrendChart(2011, 1,new java.math.BigDecimal(1), 1);
		 balanceScorecardService.getKPIListAndChartLevel0Proc(2011, 1,1, 1);
		 balanceScorecardService.getKPIListAndChart(2011, 1,1, 1);
		  KpiresultPK pk = new KpiresultPK();
	        pk.setDateKey(new BigDecimal(1097));
	         pk.setKpiKey(new BigDecimal(1));
		 balanceScorecardService.getKPIDetail(pk);
		 balanceScorecardService.getPerspectiveResult(2011, 1,new java.math.BigDecimal(1));
		 balanceScorecardService.getKPIChart(2011,1,17,"N");*/
	//	 balanceScorecardService.getKPIListAndChartLevel0(2011, 1,1, 1);
		// balanceScorecardService.getKPIListAndChartRecursive(List, Integer, int, int, int)
		/* List tmp=new ArrayList();
    	 List childs =   balanceScorecardService.getKPIListAndChartRecursive(tmp, 2011,"Jan",1,kpiresultthresholdGroupDTO.getKpiKey());
    	   if(childs!=null && childs.size()>0){
    		   for (int j = 0; j < childs.size(); j++) {
    			   
    			   KpiresultthresholdGroupDTO groupChild = (KpiresultthresholdGroupDTO)childs.get(j);
    			   System.err.println(" 			chatchai debug recursive ==>"+groupChild.getKpiKey());
    			   //results.add(groupChild);
			}
    	   }*/
	       /* System.out.println(balanceScorecardService.getKPIOverall(2011,"Jan",new java.math.BigDecimal(1)));
	        List list=balanceScorecardService.getPerspective(new java.math.BigDecimal(2),2011,"Jan");
	        System.out.println();
	        for(int i=0;i<list.size();i++){
	        	PerspectiveresultDTO perspectiveresultDTO  = (PerspectiveresultDTO)list.get(i);
	        	System.out.println("perspectiveresultDTO=="+perspectiveresultDTO.getPerspectiveName());
	        }
	       // System.out.println(balanceScorecardService.getTrendChartLevel0(2011,"Jan",new java.math.BigDecimal(1)).size());
	        System.out.println(balanceScorecardService.getKPIList(2011,"Jan",new BigDecimal(1),1).size());
	        List l = balanceScorecardService.getKPIListLevel0(2011,"Jan",new java.math.BigDecimal(1),1);
	        for(int i=0;i<l.size();i++){
	        	KpiresultthresholdGroupDTO kpiresultthresholdGroupDTO  = (KpiresultthresholdGroupDTO)l.get(i);
	        	System.out.println("kpiresultthresholdGroupDTO =="+kpiresultthresholdGroupDTO.getKpiName());
	        	System.out.println("kpiresultthresholdGroupDTO List =="+kpiresultthresholdGroupDTO.getKpiresultthresholdDTOs().size());
	        }
	        System.out.println(balanceScorecardService.getTrendChart(2011,"Jan",new BigDecimal(1),1).size());
	        KpiresultPK pk = new KpiresultPK();
	        pk.setDateKey(new BigDecimal(1097));
	         pk.setKpiKey(new BigDecimal(1));
	         List ll = balanceScorecardService.getKPIListAndChartLevel0(2011,"Jan",1,1);
	         System.out.println("ll "+ll.size());
	        // List x = (List)ll.get(0);
	      //   for (int i = 0; i < x.size(); i++) {
	        	 com.moogle.lbs.balancescorecard.domain.KpiresultthresholdGroupDTO xx =(com.moogle.lbs.balancescorecard.domain.KpiresultthresholdGroupDTO)ll.get(0);
				System.out.println(xx.getTrendChart());
			//}
	        //System.out.println(balanceScorecardService.getKPIDetail(pk));
	         //System.out.println(balanceScorecardService.getPerspectiveResult(2011, "Jan", new BigDecimal(1)));
	        System.out.println(balanceScorecardService.getKPIChart(2011,"Jan",17,"N"));
	       List lll=  balanceScorecardService.getKPIListAndChart(2011,"Jan",1,1);
	       System.err.println(lll);
	       for (int i = 0; i <lll.size(); i++) {
	    	   com.moogle.lbs.balancescorecard.domain.KpiresultthresholdGroupDTO yy = (com.moogle.lbs.balancescorecard.domain.KpiresultthresholdGroupDTO)lll.get(i);
	    	   System.out.println(yy.getKpiName());
		}
	       List level0=ll;
	       List results=new ArrayList();
	       for(int i =0;i<level0.size();i++){
	    	  // KpiresultthresholdGroupRecursiveDTO dataTable= new KpiresultthresholdGroupRecursiveDTO();
	    	   KpiresultthresholdGroupDTO kpiresultthresholdGroupDTO = (KpiresultthresholdGroupDTO)level0.get(i); 
	    	   dataTable.setKpiKey(kpiresultthresholdGroupDTO.getKpiKey());
	    	   dataTable.setKpiName(kpiresultthresholdGroupDTO.getKpiName());
	    	   results.add(dataTable);
	    	   results.add(kpiresultthresholdGroupDTO);
	    	   System.err.println(" chatchai debug kpi ==>"+kpiresultthresholdGroupDTO.getKpiKey());
	    	 List tmp=new ArrayList();
	    	 List childs =   balanceScorecardService.getKPIListAndChartRecursive(tmp, 2011,"Jan",1,kpiresultthresholdGroupDTO.getKpiKey());
	    	   if(childs!=null && childs.size()>0){
	    		   for (int j = 0; j < childs.size(); j++) {
	    			   
	    			   KpiresultthresholdGroupDTO groupChild = (KpiresultthresholdGroupDTO)childs.get(j);
	    			   System.err.println(" 			chatchai debug recursive ==>"+groupChild.getKpiKey());
	    			   results.add(groupChild);
				}
	    	   }
	    	 
	       }
	       System.err.println(results.size());*/
	 
	}
	public void testOP(OperationDashboardService operationDashboardService ){
		/*List list = operationDashboardService.listDivisions();
		
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		List<SummaryMTDDTO> list2 = operationDashboardService.getSummaryMTD(2011,3);
		for (SummaryMTDDTO summaryMTDDTO : list2) {
			System.out.println(summaryMTDDTO);
		}
		 List<SalesTrendDTO> xx= operationDashboardService.getSalesTrend(2011,3,"ALL","ALL","ALL","ALL");
		 System.err.println(xx);*/
	List list=	 operationDashboardService.getSalesTrend(2011,2,"ALL","ALL","ALL","ALL");
	for (int i = 0; i < list.size();i++){
		com.moogle.lbs.operationdashboard.domain.SalesTrendDTO sale = (com.moogle.lbs.operationdashboard.domain.SalesTrendDTO)
		list.get(i);
		System.out.println(""+sale.getActualVSTarget());
		System.out.println(""+sale.getGrowth());
		System.out.println(""+sale.getSalesDate());
		System.out.println(""+sale.getTarget());
		System.out.println(""+sale.getNetSalesLast());
	}
	System.out.println(list);
	operationDashboardService.getAverageCheck(2011, 1, "ALL","ALL","ALL","ALL");
	operationDashboardService.getAverageSalesPerBill(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getCost(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getCustomerPerDay(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getDiscount(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getGoogleMap(2011, 1);
	operationDashboardService.getLoss(2011, 1,  10);
	operationDashboardService.getLucre(2011, 1,  10);
	operationDashboardService.getNetSales(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getNetSalesByBranchStatus(2011, 1);
	operationDashboardService.getNetSalesByProductGroup(2011, 1);
	operationDashboardService.getProductCategories();
	operationDashboardService.getProductGroups("ALL");
	operationDashboardService.getRegionGrowth(2011, 1);
	operationDashboardService.getSale_Day_PercentGrowth(2011, 1);
	operationDashboardService.getSalesBySalesType(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getSalesGrowth(2011, 1,  10, "asc");
	operationDashboardService.getSalesTrend(2011, 1,  "ALL","ALL","ALL","ALL");
	operationDashboardService.getSummaryMTD(2011, 1);
	operationDashboardService.getSummaryMTDDivision("ALL", 2011, 1 );
	operationDashboardService.getSummaryMTDDivisionSection("ALL", "ALL", 2011, 1 );
	operationDashboardService.listAreas();
	operationDashboardService.listBranch();
	operationDashboardService.listDivisions();
	operationDashboardService.listSections();
	operationDashboardService.listYears();
		//operationDashboardService.getAverageCheck(year, month, branch, area, section, division);
		//operationDashboardService.getAverageCheck(2011, 02, "branch", "area", "section", "division");
	}
	public void testFI(FinanceDashboardService financeDashboardService){
		//System.out.println(financeDashboardService.listYears());
	/*	List<FinancialSummaryDTO> list=financeDashboardService.getFinancial_YTD_Monthly_Summary(2011, 4, null);
		System.out.println(list.size());
		for (FinancialSummaryDTO financialSummaryDTO : list) {
			System.out.println(financialSummaryDTO.getSumThisYearActualMonthly());
		}*/
	//	System.out.println(list.get(0).getPercentVarianceMONTHLY());
		List<FinancialPieDTO> list = financeDashboardService.getBarOfPile(2011, 12, null, "1");
		System.out.println(list);
		for (FinancialPieDTO financialPieDTO : list) {
			 System.out.println("TwoLastActual = "+financialPieDTO.getTwoLastActual()+",LastActual = "+financialPieDTO.getLastActual()
					 +"ThisActual = "+financialPieDTO.getThisActual()+",LastBudget = "+financialPieDTO.getLastBudget()
					 +"ThisBudget = "+financialPieDTO.getThisBudget()); 
		}
		// System.out.println(financeDashboardService.getPopup2(2011, 12, null, "1"));
		//System.out.println(financeDashboardService.getFinancialIndication(2011, 12, "00100"));
		/*List<FinancialPopup1GroupDTO> list =financeDashboardService.getPopup1(2011, 12, null, "1");
		System.out.println(list);
		if(list!=null)
		for (FinancialPopup1GroupDTO iterable_element : list) {
			
			List<FinancialPopup1DTO> l = iterable_element.getFinancialPopup1DTO();
			System.out.println("group="+iterable_element.getGroupName());
			for (FinancialPopup1DTO object : l) {
				System.out.println("     sup="+object.getSubCategory()+" , value="+object.getThisActual());
			}
		}*/
		/*List list =financeDashboardService.getPopup3(2011, 12, "Restaurant", "1");
		System.out.println(list.size());
		List<FinancialPopup3DTO> popup1=(List<FinancialPopup3DTO>)list.get(0);
		List<FinancialPopup3DTO> popup2=(List<FinancialPopup3DTO>)list.get(1);
		for (int i = 0; i < popup1.size(); i++) {
			FinancialPopup3DTO iterable_element =(FinancialPopup3DTO)popup1.get(i);
			FinancialPopup3DTO iterable_element2 =(FinancialPopup3DTO)popup2.get(i);
			System.out.println("     sup="+iterable_element.getSubCategory()+" , getPercentLastPeriodActual="+iterable_element2.getPercentLastPeriodActual()+", getPercentActual="+iterable_element.getPercentActual()+", getPercentBudget="+iterable_element.getPercentBudget());
		}*/
		//financeDashboardService.test();
		/*for (FinancialPopup3DTO iterable_element : popup1) { 
				System.out.println("     sup="+iterable_element.getSubCategory()+" , getPercentActual="+iterable_element.getPercentActual()+", getPercentBudget="+iterable_element.getPercentBudget()); 
		}
		for (FinancialPopup3DTO iterable_element : popup2) { 
			System.out.println("     sup="+iterable_element.getSubCategory()+" , value="+iterable_element.getPercentLastPeriodActual()); 
	}
		*/
		//String graphType, String sumType,String orgType)  // ยอดขาย, dropdown ,Restaurant
		/*List<FinancialMixDTO> list=financeDashboardService.getFD1_2_4(2011, 3, "3", "2",null);
		//["ยอดขาย","กำไรขั้นต้น","กำไรจากการดำเนินการ","กำไรสุทธิ"];
		//year,month,graphIndex,sumby,orgType
		System.out.println(list);
		if(list!=null)
		for (FinancialMixDTO financialMixDTO : list) {
			//-32692.160191 
			System.out.println("x="+financialMixDTO.getPercentGrowthMONTHLY()+"x");
			System.out.println("x="+financialMixDTO.getPercentVarianceMONTHLY()+"x"); //-32692.160191
			System.out.println("x="+financialMixDTO.getSumThisYearActualMonthly()+"x");
			System.out.println("x="+financialMixDTO.getSumThisYearBudgetMONTHLY()+"x"); //-32692.160191
			System.out.println("x="+financialMixDTO.getSumLastYearActualMONTHLY()+"x");
			
			//System.out.println("x="+financialMixDTO.getPercentVarianceMONTHLY());
		}*/
		//System.out.println(list.size());
		 
		/*List<FinancialMixDTO> list=financeDashboardService.getFD1_2_4_percent(2011, 12, "2",null);
		 for (FinancialMixDTO financialPieDTO : list) {
			 System.out.println("sumThisYearActualMonthly = "+financialPieDTO.getSumThisYearActualMonthly()+",sumThisYearBudgetMONTHLY = "+financialPieDTO.getSumThisYearBudgetMONTHLY()
					 +"sumLastYearActualMONTHLY = "+financialPieDTO.getSumLastYearActualMONTHLY()+",percentVarianceMONTHLY = "+financialPieDTO.getPercentVarianceMONTHLY()
					 +"percentGrowthMONTHLY = "+financialPieDTO.getPercentGrowthMONTHLY()); 
		}*/
		/*  List<FinancialPieDTO> list = financeDashboardService.getPile(2011, 12, "2");
		  System.out.println(list);
		 for (FinancialPieDTO financialPieDTO : list) {
			 System.out.println("TwoLastActual = "+financialPieDTO.getTwoLastActual()+",LastActual = "+financialPieDTO.getLastActual()
					 +"ThisActual = "+financialPieDTO.getThisActual()+",LastBudget = "+financialPieDTO.getLastBudget()
					 +"ThisBudget = "+financialPieDTO.getThisBudget()
					 +"getRevenueGroupDesc = "+financialPieDTO.getRevenueGroupDesc());
		}*/
//		  System.out.println(list.get(0).getThisActual());
		/*List list=financeDashboardService.getFinancial_YTD_Monthly_Tab(2011, 12, "Specialty", "6");
        
		System.out.println(list);*/
		//List list= financeDashboardService.getFinancialIndication(2011, 2, "S&P Syndicate");
		//System.err.println("xxxxxxxxxxxxxxxxxxxx ="+((com.moogle.lbs.financedashboard.domain.FinancialTabDTO)list.get(0)).getMno());
		/*List<FinancialIndicationGroupDTO> list=financeDashboardService.getFinancialIndication(2011, 7, "1");
		
		System.out.println(list.get(0).getFinancialIndicationDTO().size());*/
	}
	public static void main(String[] args) throws Exception {
        // Load the Spring application context
        final ApplicationContext springContext = new ClassPathXmlApplicationContext(
                new String[] {  
                		 "com/moogle/lbs/main/hibernate-config.xml"
                		//"com/moogle/lbs/main/hibernate-balancescorecard-config.xml",
                		//"com/moogle/lbs/main/hibernate-operationdashboard-config.xml",
                		//"com/moogle/lbs/main/hibernate-financedashboard-config.xml"
                		});
        BalanceScorecardService balanceScorecardService =(BalanceScorecardService) springContext.getBean("balanceScorecardService");
        OperationDashboardService operationDashboardService =(OperationDashboardService) springContext.getBean("operationDashboardService");
        FinanceDashboardService financeDashboardService =(FinanceDashboardService) springContext.getBean("financeDashboardService");
        Main obj=new Main();
     // obj.testBSC(balanceScorecardService);
        //obj.testOP(operationDashboardService);
        obj.testFI(financeDashboardService);
    }
	 
}
