package com.moogle.lbs.operationdashboard.service.impl;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

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
import com.moogle.lbs.operationdashboard.service.OperationDashboardService;


/**
 * @author Chatchai Pimtun
 */
@Repository
@Transactional
public class OperationDashboardServiceImpl implements OperationDashboardService{

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
		Session session =this.sessionAnnotationFactoryOP.getCurrentSession();
		List<Integer> list=null;
			  list =  session.
			createQuery("select distinct dimdate.year from Dimdate dimdate   order by dimdate.year desc ").list();
		return list;
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	public List<String> listDivisions() {
		List result=null;
		List list=null;
		try{ 
		// TODO Auto-generated method stub
		/*String sql="Select 'ALL' as division from DimBranch" +
				" Union" +
				" Select distinct(division) as Division from DimBranch order by Division ";*/
		String sql="{CALL proc_op_listDivisions(null)}";
		System.out.println("query is  ==> "+sql);
		
		 SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql); 
		  list = query.list();
		   
		/*System.out.println("list opr="+list);
		int size=list.size();
		 result=new ArrayList(size);
		for (int i = 0; i < size; i++) {
			String value= (String)list.get(i); 
			result.add(value.trim());
		}
		System.out.println("result aa size="+result.size());*/
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		//query.addEntity(arg0, arg1)
		//System.out.println("debug size="+list.size());
		return list;
	}
	@Transactional(readOnly = true)
	@Override
	public List<String> listSections() {
		// TODO Auto-generated method stub
		/*String sql="Select 'ALL' as section from DimBranch" +
				" Union" +
				" Select distinct(section) from DimBranch order by Section";
		System.out.println("query is ==> "+sql);*/
		String sql="{CALL proc_op_listSections(null)}";
		System.out.println("query is  ==> "+sql);
		 
		 //SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql); 
		 
		return (List<String>)this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql).list();
   }
	@Transactional(readOnly = true)
	@Override
	public List<String> listAreas() {
		// TODO Auto-generated method stub
		/*String sql="Select 'ALL' as Area from DimBranch" +
				" Union" +
				" Select distinct(Area) from DimBranch order by Area";
		System.out.println("query is ==> "+sql);*/
		String sql="{CALL proc_op_listAreas(null)}";
		System.out.println("query is  ==> "+sql);
		return (List<String>)this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql).list();
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	public List<BranchDTO> listBranch() {
		// TODO Auto-generated method stub
		/*String sql="select 'ALL' as branchName , 'ALL' as branchCode from DimBranch" +
				" Union" +
				" Select distinct(branchName) as  branchName,BranchCode as branchCode from DimBranch order by branchName";
		System.out.println("query is ==> "+sql);*/ 
		String sql="{CALL proc_op_listBranch(null)}";
		System.out.println("query is  ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			BranchDTO branchDTO =new BranchDTO();
			branchDTO.setBranchName(obj[0]!=null?obj[0]+"":"");
			branchDTO.setBranchCode(obj[1]!=null?obj[1]+"":"");
			result.set(i, branchDTO);
		}  
		return result;
		/*query.addEntity("branchDTO", BranchDTO.class); 
		return (List<BranchDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<SummaryMTDDTO> getSummaryMTD(int year, int month) {
		// TODO Auto-generated method stub
	String sql="SELECT " +
		" This.Division as division"+
		" ,This.SalesTargetAmt as salesTargetAmt"+
		" ,This.NetSalesAmt as netSalesAmt"+
		" ,Last.NetSalesAmt as lastNetSalesAmt "+
		" FROM "+
		" ( SELECT "+
		"   dimbranch.Division as Division "+
		"   ,SUM(factsalestarget.SalesTargetAmt) as SalesTargetAmt "+
		"   ,SUM(factsalestarget.NetSalesAmt) as NetSalesAmt "+
		"  FROM factsalestarget , dimdate , DimBranch "+
		"  WHERE factsalestarget.DateKey = dimdate.DateKey "+
		"  and factsalestarget.BranchKey =  dimbranch.BranchKey "+
		"  and Year(dimdate.Date) =:year "+
		"  and Month(dimdate.Date) =:month "+
		"  Group by dimbranch.Division ) as This "+
		""+
		" LEFT JOIN "+
		" ( SELECT "+
		"    dimbranch.Division as Division "+
		"   ,SUM(factsalestarget.NetSalesAmt) as NetSalesAmt "+
		"  FROM factsalestarget , dimdate , DimBranch "+
		"  WHERE factsalestarget.DateKey = dimdate.DateKey "+
		"  and factsalestarget.BranchKey = dimbranch.BranchKey "+
		"  and Year(dimdate.Date) =:year-1 "+
		"  and Month(dimdate.Date) =:month "+
		"  Group by dimbranch.Division ) as Last "+
		""+
		" ON This.Division = Last.Division";
	// System.out.println("query is ==> "+sql);
	SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
	
	query.setParameter("year", year);
	query.setParameter("month", month);
	List result = query.list();
	int size = result.size();
	for (int i = 0; i < size; i++) {
		Object[] obj= (Object[])result.get(i);
		SummaryMTDDTO summaryMTDDTO =new SummaryMTDDTO();
		summaryMTDDTO.setDivision(obj[0]!=null?obj[0]+"":"");
		summaryMTDDTO.setSalesTargetAmt(obj[1]!=null?obj[1]+"":"");
		summaryMTDDTO.setNetSalesAmt(obj[2]!=null?obj[2]+"":"");
		summaryMTDDTO.setLastNetSalesAmt(obj[3]!=null?obj[3]+"":"");
		result.set(i, summaryMTDDTO);
	}   
	return result;
   // query.addEntity("summaryMTDDTO", SummaryMTDDTO.class); 
  // return (List<SummaryMTDDTO>)query.list();
	}
	@Transactional(readOnly = true)
	@Override
	public List<SummaryMTDDivisionDTO> getSummaryMTDDivision(String division, int year, int month) {
		// TODO Auto-generated method stub
		 
		String sql="SELECT "+ 
		"  This.Section as section "+
		" ,This.SalesTargetAmt as salesTargetAmt "+
		" ,This.NetSalesAmt as netSalesAmt "+
		" ,Last.NetSalesAmt as lastNetSalesAmt"+
		" FROM "+
		" ( SELECT "+
		"    dimbranch.Section as Section "+
		"   ,SUM(factsalestarget.SalesTargetAmt) as SalesTargetAmt "+
		"   ,SUM(factsalestarget.NetSalesAmt) as NetSalesAmt "+
		"  FROM factsalestarget , dimdate , DimBranch "+
		"  WHERE factsalestarget.DateKey = dimdate.DateKey "+
		"  and factsalestarget.BranchKey = dimbranch.BranchKey "+
		"  and dimbranch.Division =:division "+
		"  and Year(dimdate.Date) =:year "+
		"  and Month(dimdate.Date) =:month "+
		"  Group by dimbranch.Section ) as This "+
		" "+
		" LEFT JOIN "+
		" ( SELECT "+
		"    dimbranch.Section as Section "+
		"   ,SUM(factsalestarget.NetSalesAmt) as NetSalesAmt "+
		"  FROM factsalestarget , dimdate , DimBranch "+
		"  WHERE factsalestarget.DateKey = dimdate.DateKey "+
		"  and factsalestarget.BranchKey = dimbranch.BranchKey "+
		"  and dimbranch.Division =:division "+
		"  and Year(dimdate.Date) =:year "+
		"  and Month(dimdate.Date) =:month "+
		"  Group by dimbranch.Section ) as Last "+
		""+
		" ON This.Section = Last.Section ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month);
		query.setParameter("division", division);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			SummaryMTDDivisionDTO summaryMTDDivisionDTO =new SummaryMTDDivisionDTO();
			summaryMTDDivisionDTO.setSection(obj[0]!=null?obj[0]+"":"");
			summaryMTDDivisionDTO.setSalesTargetAmt(obj[1]!=null?obj[1]+"":"");
			summaryMTDDivisionDTO.setNetSalesAmt(obj[3]!=null?obj[3]+"":"");
			summaryMTDDivisionDTO.setLastNetSalesAmt(obj[4]!=null?obj[4]+"":"");
			result.set(i, summaryMTDDivisionDTO);
		}  
		 
		return result;
	  /*  query.addEntity("summaryMTDDivisionDTO", SummaryMTDDivisionDTO.class);
	    return (List<SummaryMTDDivisionDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<SummaryMTDDivisionSectionDTO> getSummaryMTDDivisionSection(String section, String division,
			int year, int month) {
		// TODO Auto-generated method stub
		String sql=" SELECT "+ 
		  " This.Area as area "+
		  " ,This.SalesTargetAmt as salesTargetAmt "+
		  " ,This.NetSalesAmt  as netSalesAmt"+
		  " ,Last.NetSalesAmt  as lastNetSalesAmt"+
		  " FROM "+
		 " ( SELECT "+
		 "   dimbranch.Area as Area "+
		 "  ,SUM(factsalestarget.SalesTargetAmt) as SalesTargetAmt "+
		 "  ,SUM(factsalestarget.NetSalesAmt) as NetSalesAmt "+
		 " FROM factsalestarget , dimdate , DimBranch "+
		 " WHERE factsalestarget.DateKey = dimdate.DateKey "+
		 " and factsalestarget.BranchKey = dimbranch.BranchKey "+
		 " and dimbranch.Division =:division "+
		 " and dimbranch. Section =:section "+
		 " and Year(dimdate.Date) =:year "+
		 " and Month(dimdate.Date) =:month "+
		 " Group by dimbranch.Area ) as This "+
		 " "+
		" LEFT JOIN "+
		" ( SELECT "+
		"    dimbranch.Area as Area "+
		"   ,SUM(factsalestarget.NetSalesAmt) as NetSalesAmt "+
		"  FROM factsalestarget , dimdate , DimBranch "+
		"  WHERE factsalestarget.DateKey = dimdate.DateKey "+
		"  and factsalestarget.BranchKey = dimbranch.BranchKey "+
		"  and dimbranch.Division =:division "+
		"  and dimbranch. Section =:section "+
		"  and Year(dimdate.Date) =:year "+
		"  and Month(dimdate.Date) =:month "+
		"  Group by dimbranch.Area ) as Last "+
		""+
		" ON This.Area = Last.Area ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month);
		query.setParameter("division", division);
		query.setParameter("section", section);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			SummaryMTDDivisionSectionDTO summaryMTDDivisionSectionDTO =new SummaryMTDDivisionSectionDTO();
			summaryMTDDivisionSectionDTO.setArea(obj[0]!=null?obj[0]+"":"");
			summaryMTDDivisionSectionDTO.setSalesTargetAmt(obj[1]!=null?obj[1]+"":"");
			summaryMTDDivisionSectionDTO.setNetSalesAmt(obj[3]!=null?obj[3]+"":"");
			summaryMTDDivisionSectionDTO.setLastNetSalesAmt(obj[4]!=null?obj[4]+"":"");
			result.set(i, summaryMTDDivisionSectionDTO);
		}   
		return result;
	   /* query.addEntity("summaryMTDDivisionSectionDTO", SummaryMTDDivisionSectionDTO.class);
	    return (List<SummaryMTDDivisionSectionDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<LucreDTO> getLucre(int year, int month, int limit) {
		// TODO Auto-generated method stub
		String sql=" SELECT "+
		" branchName as branchName "+
		" ,(SUM(SalesAmt)-SUM(CostAmt)) as gpamt "+
		" ,(SUM(SalesAmt)-SUM(CostAmt))/SUM(SalesAmt) as percentGP "+
		" FROM factretailsales , DimBranch , dimdate "+
		" WHERE factretailsales.BranchKey = dimbranch.BranchKey "+
		" AND factretailsales.DateKey = dimdate.DateKey "+
		" AND YEAR(dimdate.Date) =:year "+
		" AND MONTH(dimdate.Date) =:month "+
		" "+
		" ORDER BY GPAmt  DESC "+
		" LIMIT "+limit;
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			LucreDTO lucreDTO =new LucreDTO();
			lucreDTO.setBranchName(obj[0]!=null?obj[0]+"":"");
			lucreDTO.setGpamt(obj[1]!=null?obj[1]+"":"");
			lucreDTO.setPercentGP(obj[2]!=null?obj[2]+"":""); 
			result.set(i, lucreDTO);
		}   
		return result;
	  /*  query.addEntity("lucreDTO", LucreDTO.class);
	    return (List<LucreDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<LossDTO> getLoss(int year, int month, int limit) {
		// TODO Auto-generated method stub
		String sql=" SELECT "+
		" branchName as branchName "+
		" ,(SUM(SalesAmt)-SUM(CostAmt)) as gpamt "+
		" ,(SUM(SalesAmt)-SUM(CostAmt))/SUM(SalesAmt) as percentGP "+
		" FROM factretailsales , DimBranch , dimdate "+
		" WHERE factretailsales.BranchKey = dimbranch.BranchKey "+
		" AND factretailsales.DateKey = dimdate.DateKey "+
		" AND YEAR(dimdate.Date) =:year "+
		" AND MONTH(dimdate.Date) =:month "+
		" "+
		" ORDER BY GPAmt  "+
		" LIMIT "+limit;
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			LossDTO lossDTO =new LossDTO();
			lossDTO.setBranchName(obj[0]!=null?obj[0]+"":"");
			lossDTO.setGpamt(obj[1]!=null?obj[1]+"":"");
			lossDTO.setPercentGP(obj[2]!=null?obj[2]+"":"");
			result.set(i, lossDTO);
		}  
		 
		return result;
	    /*query.addEntity("lossDTO", LossDTO.class);
	    return (List<LossDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<SalesGrowthDTO> getSalesGrowth(int year, int month, int limit, String order) {
		// TODO Auto-generated method stub
		String sql=" SELECT "+
		" BranchName as branchName"+
		" ,SUM(SalesAmt) AS sales "+
		" ,(SELECT SUM(SalesAmt) "+
		"  FROM factretailsales Fact , dimdate DDate "+
		"  WHERE Fact.DateKey = DDate.DateKey"+ 
		"  AND Fact.BranchKey = dimbranch.BranchKey "+ 
		"  AND YEAR(DDate.Date) =:year -1 "+
		"  AND MONTH(DDate.Date) =:month) AS lastSales "+
		" ,(SUM(SalesAmt)- "+
		"  (SELECT SUM(SalesAmt) "+
		"   FROM factretailsales Fact , dimdate DDate "+
		"  WHERE Fact.DateKey = DDate.DateKey "+
		"   AND Fact.BranchKey = dimbranch.BranchKey "+
		"   AND YEAR(DDate.Date) =:year -1 "+
		"   AND MONTH(DDate.Date) =:month)) AS diff "+
		" ,((SUM(SalesAmt)- "+
		"  (SELECT SUM(SalesAmt) "+
		"   FROM factretailsales Fact , dimdate DDate "+
		"   WHERE Fact.DateKey = DDate.DateKey "+
		"   AND Fact.BranchKey = dimbranch.BranchKey "+
		"   AND YEAR(DDate.Date) =:year -1 "+
		"   AND MONTH(DDate.Date) =:month))/ "+
		"  (SELECT SUM(SalesAmt) "+
		"   FROM factretailsales Fact , dimdate DDate "+
		"   WHERE Fact.DateKey = DDate.DateKey "+
		"   AND Fact.BranchKey = dimbranch.BranchKey "+
		"   AND YEAR(DDate.Date) =:year -1 "+
		"   AND MONTH(DDate.Date) =:month)) AS percentGrowth "+
		" "+
		" FROM factretailsales , DimBranch , dimdate "+
		" WHERE factretailsales.BranchKey = dimbranch.BranchKey "+
		" AND factretailsales.DateKey = dimdate.DateKey "+
		" AND YEAR(dimdate.Date) =:year "+
		" AND MONTH(dimdate.Date) =:month "+
		""+
		" ORDER BY PercentGrowth   "+order+// DESC -- ถ้ายอดขายต่ำสุด เอา DESC ออก
		"	LIMIT "+limit;
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			SalesGrowthDTO salesGrowthDTO =new SalesGrowthDTO();
			salesGrowthDTO.setBranchName(obj[0]!=null?obj[0]+"":"");
			salesGrowthDTO.setSales(obj[1]!=null?obj[1]+"":"");
			salesGrowthDTO.setLastSales(obj[2]!=null?obj[2]+"":"");
			salesGrowthDTO.setDiff(obj[3]!=null?obj[3]+"":"");
			salesGrowthDTO.setPercentGrowth(obj[4]!=null?obj[4]+"":"");
			result.set(i, salesGrowthDTO);
		}   
		return result;
	   /* query.addEntity("salesGrowthDTO", SalesGrowthDTO.class);
	    return (List<SalesGrowthDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<Sale_Day_PercentGrowthDTO> getSale_Day_PercentGrowth(int year, int month) {
		// TODO Auto-generated method stub
		String sql=" SELECT "+
		 " BranchName as branchName"+
		" ,SUM(SalesAmt) AS sales "+
		" ,(SELECT SUM(SalesAmt) "+
		"  FROM factretailsales Fact , dimdate DDate "+
		"  WHERE Fact.DateKey = DDate.DateKey "+
		"  AND Fact.BranchKey = dimbranch.BranchKey "+
		"  AND YEAR(DDate.Date) =:year "+
		"  AND MONTH(DDate.Date) =:month -1) AS lastSales "+
		" ,(SUM(SalesAmt)- "+
		" (SELECT SUM(SalesAmt) "+
		"  FROM factretailsales Fact , dimdate DDate "+
		"  WHERE Fact.DateKey = DDate.DateKey "+
		"  AND Fact.BranchKey = dimbranch.BranchKey "+
		"  AND YEAR(DDate.Date) =:year "+
		"  AND MONTH(DDate.Date) =:month -1)) AS diffSales "+
		" ,(SUM(SalesAmt)- "+
		" (SELECT SUM(SalesAmt) "+
		"  FROM factretailsales Fact , dimdate DDate "+
		"  WHERE Fact.DateKey = DDate.DateKey "+
		"  AND Fact.BranchKey = dimbranch.BranchKey "+
		"  AND YEAR(DDate.Date) =:year "+
		"  AND MONTH(DDate.Date) =:month -1))/ "+
		" (SELECT SUM(SalesAmt) "+
		"  FROM factretailsales Fact , dimdate DDate "+
		"  WHERE Fact.DateKey = DDate.DateKey "+
		"  AND Fact.BranchKey = dimbranch.BranchKey "+
		"  AND YEAR(DDate.Date) =:year "+
		"  AND MONTH(DDate.Date) =:month -1) AS percentGrowth "+
		"  "+
		" FROM factretailsales , DimBranch , dimdate "+
		" WHERE factretailsales.BranchKey = dimbranch.BranchKey "+
		" AND factretailsales.DateKey = dimdate.DateKey "+
		" AND YEAR(dimdate.Date) =:year "+
		" AND MONTH(dimdate.Date) =:month "+
		""+
		" ORDER BY PercentGrowth ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);

		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			Sale_Day_PercentGrowthDTO sale_Day_PercentGrowthDTO =new Sale_Day_PercentGrowthDTO();
			sale_Day_PercentGrowthDTO.setBranchName(obj[0]!=null?obj[0]+"":"");
			sale_Day_PercentGrowthDTO.setSales(obj[1]!=null?obj[1]+"":"");
			sale_Day_PercentGrowthDTO.setLastSales(obj[2]!=null?obj[2]+"":"");
			sale_Day_PercentGrowthDTO.setDiffSales(obj[3]!=null?obj[3]+"":"");
			sale_Day_PercentGrowthDTO.setPercentGrowth(obj[4]!=null?obj[4]+"":"");
			result.set(i, sale_Day_PercentGrowthDTO);
		}   
		return result;
	 /*   query.addEntity("sale_Day_PercentGrowthDTO", Sale_Day_PercentGrowthDTO.class);
	    return (List<Sale_Day_PercentGrowthDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<NetSalesByBranchStatusDTO> getNetSalesByBranchStatus(int year, int month) {
		// TODO Auto-generated method stub
		String sql=" SELECT "+
		 " (SELECT SUM(NetSalesAmt)  " +
		 " FROM factretailsales Fact , dimdate DDate "+ 
		 " WHERE Fact.DateKey = DDate.DateKey "+
		 " AND Fact.BranchKey = dimbranch.BranchKey "+
		 " AND YEAR(DDate.Date) =:year -1 "+
		 " AND MONTH(DDate.Date) =:month) AS lastNetSales "+
		 " ,SUM(NetSalesAmt) AS netSales "+
		" ,(SUM(NetSalesAmt)- "+
		 " (SELECT SUM(NetSalesAmt) "+
		 " FROM factretailsales Fact , dimdate DDate "+
		 " WHERE Fact.DateKey = DDate.DateKey "+
		 " AND Fact.BranchKey = dimbranch.BranchKey "+
		 " AND YEAR(DDate.Date) =:year -1 "+ 
		 " AND MONTH(DDate.Date) =:month))/ "+ 
		 " (SELECT SUM(NetSalesAmt) "+
		 " FROM factretailsales Fact , dimdate DDate "+
		 " WHERE Fact.DateKey = DDate.DateKey "+
		 " AND Fact.BranchKey = dimbranch.BranchKey "+
		 " AND YEAR(DDate.Date) =:year -1 "+
		 " AND MONTH(DDate.Date) =:month) AS percentGrowth "+
		 " "+
		" FROM factretailsales , dimbranch , dimdate "+
		" WHERE factretailsales.BranchKey = dimbranch.BranchKey "+
		" AND factretailsales.DateKey = dimdate.DateKey "+
		//"-- AND dimdate.Date BETWEEN dimbranch.DataStartDate AND dimbranch.DataEndDate
		" AND YEAR(dimdate.Date) =:year "+
		" AND MONTH(dimdate.Date) =:month "+
		""+
		" GROUP BY dimbranch.BranchStatus ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			NetSalesByBranchStatusDTO netSalesByBranchStatusDTO =new NetSalesByBranchStatusDTO();
			netSalesByBranchStatusDTO.setLastNetSales(obj[0]!=null?obj[0]+"":"");
			netSalesByBranchStatusDTO.setNetSales(obj[1]!=null?obj[1]+"":"");
			netSalesByBranchStatusDTO.setPercentGrowth(obj[1]!=null?obj[1]+"":"");
			result.set(i, netSalesByBranchStatusDTO);
		}  
		return result;
	 /*   query.addEntity("netSalesByBranchStatusDTO", NetSalesByBranchStatusDTO.class);
	    return (List<NetSalesByBranchStatusDTO>)query.list();*/

	}
	@Transactional(readOnly = true)
	@Override
	public List<NetSalesByProductGroupDTO> getNetSalesByProductGroup(int year, int month) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+ 
			" dimproductgroup.ProductGroup as  productGroup"+
			" ,SUM(NetSalesAmt) AS netSales "+
			" ,(SUM(NetSalesAmt)- "+
			" (SELECT SUM(NetSalesAmt) "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.ProductGroupKey = dimproductgroup.ProductGroupKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ))/ "+
			" (SELECT SUM(NetSalesAmt) "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.ProductGroupKey = dimproductgroup.ProductGroupKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month) AS vsly "+
			" ,(SUM(NetSalesAmt)-SUM(SalesTargetAmt))/SUM(SalesTargetAmt) AS vsplan "+
			"  "+
			"  "+
			" FROM factsalestarget , dimdate ,dimproductgroup "+
			" WHERE factsalestarget.DateKey = dimdate.DateKey "+
			" AND factsalestarget.ProductGroupKey = dimproductgroup.ProductGroupKey "+
			//" -- AND dimdate.Date BETWEEN dimbranch.DataStartDate AND dimbranch.DataEndDate "+
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" "+
			" GROUP BY dimproductgroup.ProductGroup ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		

		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			NetSalesByProductGroupDTO netSalesByProductGroupDTO =new NetSalesByProductGroupDTO();
			netSalesByProductGroupDTO.setProductGroup(obj[0]!=null?obj[0]+"":"");
			netSalesByProductGroupDTO.setNetSales(obj[1]!=null?obj[1]+"":"");
			netSalesByProductGroupDTO.setVsly(obj[2]!=null?obj[2]+"":"");
			netSalesByProductGroupDTO.setVsplan(obj[3]!=null?obj[3]+"":"");			
			result.set(i, netSalesByProductGroupDTO);
		}   
		return result;
	   /* query.addEntity("netSalesByProductGroupDTO", NetSalesByProductGroupDTO.class);
	    return (List<NetSalesByProductGroupDTO>)query.list(); */
	}
	@Transactional(readOnly = true)
	@Override
	public List<NetSalesDTO> getNetSales(int year, int month, String branch, String area,
			String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" dimproductgroup.ProductGroup  as productGroup"+
			" ,SUM(NetSalesAmt) AS netSales "+
			" ,(SUM(NetSalesAmt)- "+
			" (SELECT SUM(NetSalesAmt) "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.ProductGroupKey = dimproductgroup.ProductGroupKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month))/ "+
			" (SELECT SUM(NetSalesAmt) "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.ProductGroupKey = dimproductgroup.ProductGroupKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month) AS vsly "+
			" ,(SUM(NetSalesAmt)-SUM(SalesTargetAmt))/SUM(SalesTargetAmt) AS vsplan "+
			" "+
			" "+
			" FROM factsalestarget , dimdate ,dimproductgroup ,DimBranch "+
			" WHERE factsalestarget.DateKey = dimdate.DateKey "+
			" AND factsalestarget.ProductGroupKey = dimproductgroup.ProductGroupKey "+
			" AND factsalestarget.BranchKey = dimbranch.BranchKey "+
			""+  
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch "+
			" "+
			" GROUP BY dimproductgroup.ProductGroup ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		 
		query.setParameter("year", year);
		query.setParameter("month", month); 
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			NetSalesDTO netSalesDTO =new NetSalesDTO();
			netSalesDTO.setProductGroup(obj[0]!=null?obj[0]+"":"");
			netSalesDTO.setNetSales(obj[1]!=null?obj[1]+"":"");
			netSalesDTO.setVsly(obj[2]!=null?obj[2]+"":"");
			netSalesDTO.setVsplan(obj[3]!=null?obj[3]+"":"");
			result.set(i, netSalesDTO);
		}  
		return result;
	    /*query.addEntity("netSalesDTO", NetSalesDTO.class);
	    return (List<NetSalesDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<CostDTO> getCost(int year, int month, String branch, String area,
			String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT  "+
			"  "+
			" dimproduct.ProductGroup As productGroup "+
			" ,SUM(factretailsales.CostAmt) AS costAmt "+
			" ,(SUM(factretailsales.CostAmt)- "+
			" (SELECT "+
			" SUM(SubFact.CostAmt) AS costAmtLastYear "+
			" FROM factretailsales SubFact, dimdate DDate "+
			" WHERE SubFact.DateKey = DDate.DateKey "+
			" AND SubFact.BranchKey = factretailsales.BranchKey "+
			" AND SubFact.ProductKey = factretailsales.ProductKey "+
			"  "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ))/ "+
			" (SELECT "+ 
			" SUM(SubFact.CostAmt) AS costAmtLastYear "+
			" FROM factretailsales SubFact, dimdate DDate "+
			" WHERE SubFact.DateKey = DDate.DateKey "+ 
			" AND SubFact.BranchKey = factretailsales.BranchKey "+
			" AND SubFact.ProductKey = factretailsales.ProductKey "+
			" "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ) AS costAmtLastYear, "+
			" '0' AS plan "+
			" "+ 
			" FROM factretailsales , dimdate  , DimBranch , dimproduct "+
			" WHERE factretailsales.DateKey = dimdate.DateKey "+
			" AND factretailsales.BranchKey = dimbranch.BranchKey "+
			" AND factretailsales.ProductKey = dimproduct.ProductKey "+ 
			" "+ 
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch "+
			" "+
			" GROUP BY DayOfWeek, ProductGroup ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month); 
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			CostDTO costDTO =new CostDTO();
			costDTO.setProductGroup(obj[0]!=null?obj[0]+"":"");
			costDTO.setCostAmt(obj[1]!=null?obj[1]+"":"");
			costDTO.setCostAmtLastYear(obj[2]!=null?obj[2]+"":"");
			result.set(i, costDTO);
		}   
		return result;
	  /*  query.addEntity("CostDTO", CostDTO.class);
	    return (List<CostDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<String> getProductCategories() {
		// TODO Auto-generated method stub 
		String sql =" SELECT "+
			" DISTINCT(ProductCategory) AS productCategory "+
			" FROM dimproduct ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql); 
	    return (List<String>)query.list();
	}
	@Transactional(readOnly = true)
	@Override
	public List<String> getProductGroups(String productCategory) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" DISTINCT(ProductGroup) AS productGroup "+
			" FROM dimproduct "+
			" where ProductCategory in ('"+productCategory+"') ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		 
	    return (List<String>)query.list();
	}
	@Transactional(readOnly = true)
	@Override
	public List<SalesTrendDTO> getSalesTrend(int year, int month, String branch, String area,
			String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			//" dimdate.Date AS salesDate, "+
		   " dimdate.Date , "+
			" (SELECT "+
			"  SUM(Fact.NetSalesAmt) AS netSalesLast "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Date(DDate.Date) = Date(dimdate.Date) "+
			//" AND DDate.Date = dimdate.Date "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ) AS netSalesLast, "+
			" SUM(NetSalesAmt) AS netSalesAmtThis, "+ 
			" SUM(SalesTargetAmt) AS target, "+
			" ((SUM(NetSalesAmt)-SUM(SalesTargetAmt))/SUM(SalesTargetAmt)*100) AS actualVSTarget, "+
			" (SUM(NetSalesAmt)- "+
			" (SELECT "+
			" 		      SUM(Fact.NetSalesAmt) AS netSalesLast "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Date(DDate.Date) = Date(dimdate.Date) "+
			//" AND DDate.Date = dimdate.Date "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month )/ "+
			" (SELECT "+
			" 		      SUM(Fact.NetSalesAmt) AS netSalesLast "+
			" FROM factsalestarget Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Date(DDate.Date) = Date(dimdate.Date) "+
		//	" AND DDate.Date = dimdate.Date "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month )*100) AS growth "+
			""+ 
			" FROM factsalestarget , dimdate  , dimbranch "+
			" WHERE factsalestarget.DateKey = dimdate.DateKey "+
			" AND factsalestarget.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		
		query.setParameter("year", year);
		query.setParameter("month", month); 
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			SalesTrendDTO salesTrendDTO =new SalesTrendDTO();
			salesTrendDTO.setSalesDate(obj[0]!=null?obj[0]+"":"");
			salesTrendDTO.setNetSalesLast(obj[1]!=null?obj[1]+"":"");
			salesTrendDTO.setNetSalesAmtThis(obj[2]!=null?obj[2]+"":"");
			salesTrendDTO.setTarget(obj[3]!=null?obj[3]+"":"");
			salesTrendDTO.setActualVSTarget(obj[4]!=null?obj[4]+"":"");
			salesTrendDTO.setGrowth(obj[5]!=null?obj[5]+"":"");
			result.set(i, salesTrendDTO);			 
		}   
		return result;
	  /*  query.addEntity("salesTrendDTO", SalesTrendDTO.class);
	    return (List<SalesTrendDTO>)query.list();*/

	}
	@Transactional(readOnly = true)
	@Override
	public List<SalesBySalesTypeDTO> getSalesBySalesType(int year, int month, String branch,
			String area, String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" dimdate.DayOfWeek AS dayOfWeek "+
			" ,dimsalestype.SalesType As salesType "+
			" ,SUM(factretailsales.SalesAmt) AS salesAmt "+
			" "+
			" FROM factretailsales , dimdate  , DimBranch , dimsalestype "+ 
			" WHERE factretailsales.DateKey = dimdate.DateKey "+
			" AND factretailsales.BranchKey = dimbranch.BranchKey "+
			" AND factretailsales.SalesTypeKey = dimsalestype.SalesTypeKey "+
			"  "+
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch "+
			" "+
			" GROUP BY DayOfWeek, SalesType ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
			query.setParameter("year", year);
			query.setParameter("month", month); 
			query.setParameter("division", division); 
			query.setParameter("section", section); 
			query.setParameter("area", area); 
			query.setParameter("branch", branch);
			List result = query.list();
			int size = result.size();
			for (int i = 0; i < size; i++) {
				Object[] obj= (Object[])result.get(i);
				SalesBySalesTypeDTO salesBySalesTypeDTO =new SalesBySalesTypeDTO();
				salesBySalesTypeDTO.setDayOfWeek(obj[0]!=null?obj[0]+"":"");
				salesBySalesTypeDTO.setSalesType(obj[1]!=null?obj[1]+"":"");
				salesBySalesTypeDTO.setSalesAmt(obj[2]!=null?obj[2]+"":"");
				result.set(i, salesBySalesTypeDTO);
			}  
			return result;
		  /*  query.addEntity("salesBySalesTypeDTO", SalesBySalesTypeDTO.class);
		    return (List<SalesBySalesTypeDTO>)query.list();*/
		}
	@Transactional(readOnly = true)
	@Override
	public List<DiscountDTO> getDiscount(int year, int month, String branch, String area,
			String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			"  "+
			" SUM(factretailsales.DiscountAmt) AS discountThisYear, "+
			"  "+
			" (SELECT SUM(SubFact.DiscountAmt) AS discountLastYear "+ 
			" FROM factretailsales  SubFact , dimdate DDate "+
			" WHERE SubFact.DateKey = DDate.DateKey "+
			" AND SubFact.BranchKey = factretailsales.BranchKey "+
			"  "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ) DiscountLastYear , "+
			" '0' AS plan "+
			" "+
			" FROM factretailsales , dimdate , DimBranch "+
			" WHERE factretailsales.DateKey = dimdate.DateKey "+
			" AND factretailsales.BranchKey = dimbranch.BranchKey "+
			" "+
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch "+
			" ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month); 
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			DiscountDTO discountDTO =new DiscountDTO();
			discountDTO.setDiscountThisYear(obj[0]!=null?obj[0]+"":"");
			discountDTO.setDiscountLastYear(obj[1]!=null?obj[1]+"":"");
			discountDTO.setPlan(obj[2]!=null?obj[2]+"":"");
			result.set(i, discountDTO);
		}   
		return result;
	   /* query.addEntity("discountDTO", DiscountDTO.class);
	    return (List<DiscountDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<AverageCheckDTO> getAverageCheck(int year, int month, String branch,
			String area, String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" (SELECT (SUM(NetSalesAmt)/SUM(NoOfCustomer)) AS avgCheckLast "+
			" FROM factbranchsnapshot Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND factbranchsnapshot.BranchKey = Fact.BranchKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ) AS avgCheckLast, "+
			" "+
			" (SUM(NetSalesAmt)/SUM(NoOfCustomer)) AS avgCheckThis, "+
			" "+
			" ((SUM(NetSalesAmt)/SUM(NoOfCustomer))- "+
			" (SELECT (SUM(NetSalesAmt)/SUM(NoOfCustomer)) AS avgCheckLast "+
			" FROM factbranchsnapshot Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND factbranchsnapshot.BranchKey = Fact.BranchKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month )/ "+
			" (SELECT (SUM(NetSalesAmt)/SUM(NoOfCustomer)) AS avgCheckLast "+
			" FROM factbranchsnapshot Fact , dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND factbranchsnapshot.BranchKey = Fact.BranchKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month )*100 ) AS growth "+
			" "+
			" FROM factbranchsnapshot , dimdate , DimBranch "+
			" WHERE factbranchsnapshot.DateKey = dimdate.DateKey "+
			" AND factbranchsnapshot.BranchKey = dimbranch.BranchKey "+
			""+ 
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month); 
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List list = query.list();
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[])list.get(i);
			AverageCheckDTO dto = new AverageCheckDTO();
			dto.setAvgCheckLast(obj[0]!=null?obj[0]+"":"");
			dto.setAvgCheckThis(obj[1]!=null?obj[1]+"":"");
			dto.setGrowth(obj[2]!=null?obj[2]+"":"");
			list.set(i, dto);
			/*private String	avgCheckLast;
			private String avgCheckThis;
			private String growth;*/
		}
	  //  query.addEntity("AverageCheckDTO", AverageCheckDTO.class);
	    return (List<AverageCheckDTO>)list;
	}
	@Transactional(readOnly = true)
	@Override
	public List<CustomerPerDayDTO> getCustomerPerDay(int year, int month, String branch,
			String area, String section, String division) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" 		  (SELECT "+
			" 		      SUM(Fact.NoOfCustomer)/COUNT(DISTINCT(Fact.DateKey)) AS customerPerDayLast "+
			" FROM factbranchsnapshot Fact, dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+ 
			" AND YEAR(DDate.Date) =:year "+
			" AND MONTH(DDate.Date) =:month ) AS customerPerDayLast, "+
			"  "+
			" SUM(factbranchsnapshot.NoOfCustomer)/COUNT(DISTINCT(factbranchsnapshot.DateKey)) AS customerPerDayThis, "+
			"  "+ 
			" (SUM(factbranchsnapshot.NoOfCustomer)/COUNT(DISTINCT(factbranchsnapshot.DateKey)) - "+
			" (SELECT "+
			" 		      SUM(Fact.NoOfCustomer)/COUNT(DISTINCT(Fact.DateKey)) AS customerPerDayLast "+
			" FROM factbranchsnapshot Fact, dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year "+
			" AND MONTH(DDate.Date) =:month ) / "+
			" (SELECT "+
			" 		      SUM(Fact.NoOfCustomer)/COUNT(DISTINCT(Fact.DateKey)) AS customerPerDayLast "+
			" FROM factbranchsnapshot Fact, dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year "+
			" AND MONTH(DDate.Date) =:month )*100 ) AS growth "+
			" "+ 
			" FROM factbranchsnapshot , dimdate , DimBranch "+
			" WHERE factbranchsnapshot.DateKey = dimdate.DateKey "+
			" AND factbranchsnapshot.BranchKey = dimbranch.BranchKey "+
			""+ 
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month); 
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			CustomerPerDayDTO customerPerDayDTO =new CustomerPerDayDTO();
			customerPerDayDTO.setCustomerPerDayLast(obj[0]!=null?obj[0]+"":"");
			customerPerDayDTO.setCustomerPerDayThis(obj[1]!=null?obj[1]+"":"");
			customerPerDayDTO.setGrowth(obj[2]!=null?obj[2]+"":"");
			result.set(i, customerPerDayDTO);
		}   
		return result;
	    /*query.addEntity("customerPerDayDTO", CustomerPerDayDTO.class);
	    return (List<CustomerPerDayDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<AverageSalesPerBillDTO> getAverageSalesPerBill(int year, int month, String branch,
			String area, String section, String division) {
		// TODO Auto-generated method stub

		String sql =" SELECT "+
			" 	  (SELECT "+
			" 		      SUM(Fact.NetSalesAmt)/SUM(Fact.NoOfBill) AS salesPerBillLast "+
			" FROM factbranchsnapshot Fact, dimdate DDate  "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year "+
			" AND MONTH(DDate.Date) =:month ) AS salesPerBillLast, "+
			"  "+
			" 		  SUM(factbranchsnapshot.NetSalesAmt)/SUM(factbranchsnapshot.NoOfBill) AS salesPerBillThis, "+
			"  "+
			" (SUM(factbranchsnapshot.NetSalesAmt)/SUM(factbranchsnapshot.NoOfBill) - "+
			" (SELECT "+
			" 		      SUM(Fact.NetSalesAmt)/SUM(Fact.NoOfBill) AS salesPerBillLast "+
			" FROM factbranchsnapshot Fact, dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year "+
			" AND MONTH(DDate.Date) =:month ) /  "+
			" (SELECT "+
			" 		      SUM(Fact.NetSalesAmt)/SUM(Fact.NoOfBill) AS salesPerBillLast "+
			" FROM factbranchsnapshot Fact, dimdate DDate "+
			" WHERE Fact.DateKey = DDate.DateKey "+
			" AND Fact.BranchKey = dimbranch.BranchKey "+
			" AND YEAR(DDate.Date) =:year "+
			" AND MONTH(DDate.Date) =:month )*100 ) AS growth "+
			""+ 
			" FROM factbranchsnapshot , dimdate , DimBranch "+
			" WHERE factbranchsnapshot.DateKey = dimdate.DateKey "+
			" AND factbranchsnapshot.BranchKey = dimbranch.BranchKey "+
			""+ 
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month "+
			" AND dimbranch.Division =:division "+
			" AND dimbranch.Section =:section "+
			" AND dimbranch.Area =:area "+
			" AND dimbranch.BranchName =:branch ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month);
		query.setParameter("division", division); 
		query.setParameter("section", section); 
		query.setParameter("area", area); 
		query.setParameter("branch", branch);
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			AverageSalesPerBillDTO averageSalesPerBillDTO =new AverageSalesPerBillDTO();
			averageSalesPerBillDTO.setSalesPerBillLast(obj[0]!=null?obj[0]+"":"");
			averageSalesPerBillDTO.setSalesPerBillThis(obj[1]!=null?obj[1]+"":"");
			averageSalesPerBillDTO.setGrowth(obj[2]!=null?obj[2]+"":"");
			result.set(i, averageSalesPerBillDTO);
		}  
		return result;
	   /* query.addEntity("averageSalesPerBillDTO", AverageSalesPerBillDTO.class);
	    return (List<AverageSalesPerBillDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override 
	public List<RegionGrowthDTO> getRegionGrowth(int year, int month) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" 	 dimbranch.Region AS region "+
			" ,(SELECT SUM(SalesAmt) "+
			" FROM factretailsales Fact , dimdate DDate "+
			" WHERE Fact.BranchKey = dimbranch.BranchKey "+
			" AND Fact.DateKey = dimdate.DateKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month ) AS lastSalesAmt "+
			" ,SUM(SalesAmt) AS thisSalesAmt "+
			" ,(SUM(SalesAmt) - "+
			" (SELECT SUM(SalesAmt) "+
			" FROM factretailsales Fact , dimdate DDate "+
			" WHERE Fact.BranchKey = dimbranch.BranchKey "+
			" AND Fact.DateKey = dimdate.DateKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month )/ "+
			" (SELECT SUM(SalesAmt) "+
			" FROM factretailsales Fact , dimdate DDate "+
			" WHERE Fact.BranchKey = dimbranch.BranchKey "+
			" AND Fact.DateKey = dimdate.DateKey "+
			" AND YEAR(DDate.Date) =:year -1 "+
			" AND MONTH(DDate.Date) =:month )*100) AS growth "+
			" "+
			" FROM factretailsales , DimBranch , dimdate "+
			" WHERE factretailsales.BranchKey = dimbranch.BranchKey "+
			" AND factretailsales.DateKey = dimdate.DateKey "+
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			RegionGrowthDTO regionGrowthDTO =new RegionGrowthDTO();
			regionGrowthDTO.setRegion(obj[0]!=null?obj[0]+"":"");
			regionGrowthDTO.setLastSalesAmt(obj[1]!=null?obj[1]+"":"");
			regionGrowthDTO.setThisSalesAmt(obj[2]!=null?obj[2]+"":"");
			regionGrowthDTO.setGrowth(obj[3]!=null?obj[3]+"":"");
			result.set(i, regionGrowthDTO);
		}  
	 
		return result;
	    /*query.addEntity("regionGrowthDTO", RegionGrowthDTO.class);
	    return (List<RegionGrowthDTO>)query.list();*/
	}
	@Transactional(readOnly = true)
	@Override
	public List<GoogleMapDTO> getGoogleMap(int year, int month) {
		// TODO Auto-generated method stub
		String sql =" SELECT "+
			" dimbranch.BranchCode as  branchCode, "+
			" dimbranch.BranchName as branchName, "+
			" dimbranch.SubDistrict as subDistrict, "+
			" dimbranch.District as district, "+
			" dimbranch.Province as province, "+
			" dimbranch.Region as region, "+
		  " SUM(factsalestarget.NetSalesAmt) AS netSalesAmt, "+
			" SUM(factsalestarget.SalesTargetAmt) AS targetAmt "+
			" "+
			" FROM factsalestarget , DimBranch , dimdate "+
			" WHERE factsalestarget.BranchKey = dimbranch.BranchKey "+
			" AND factsalestarget.DateKey = dimdate.DateKey "+
			""+ 
			" AND YEAR(dimdate.Date) =:year "+
			" AND MONTH(dimdate.Date) =:month ";
		System.out.println("query is ==> "+sql);
		SQLQuery query=	this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(sql);
		query.setParameter("year", year);
		query.setParameter("month", month); 
		List result = query.list();
		int size = result.size();
		for (int i = 0; i < size; i++) {
			Object[] obj= (Object[])result.get(i);
			GoogleMapDTO googleMapDTO =new GoogleMapDTO();
			googleMapDTO.setBranchCode(obj[0]!=null?obj[0]+"":"");
			googleMapDTO.setBranchCode(obj[1]!=null?obj[1]+"":"");
			googleMapDTO.setSubDistrict(obj[2]!=null?obj[2]+"":"");
			googleMapDTO.setDistrict(obj[3]!=null?obj[3]+"":"");
			googleMapDTO.setProvince(obj[4]!=null?obj[4]+"":"");
			googleMapDTO.setRegion(obj[5]!=null?obj[5]+"":"");
			googleMapDTO.setNetSalesAmt(obj[6]!=null?obj[6]+"":"");
			googleMapDTO.setTargetAmt(obj[7]!=null?obj[7]+"":"");
			result.set(i, googleMapDTO);
		}   
		return result;
	   /* query.addEntity("googleMapDTO", GoogleMapDTO.class);
	    return (List<GoogleMapDTO>)query.list();*/
	} 
}
