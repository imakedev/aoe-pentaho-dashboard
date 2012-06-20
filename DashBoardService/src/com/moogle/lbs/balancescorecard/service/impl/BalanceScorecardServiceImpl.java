package com.moogle.lbs.balancescorecard.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.moogle.lbs.balancescorecard.domain.KPIChart;
import com.moogle.lbs.balancescorecard.domain.KpiDetailDTO;
import com.moogle.lbs.balancescorecard.domain.Kpiresult;
import com.moogle.lbs.balancescorecard.domain.KpiresultPK;
import com.moogle.lbs.balancescorecard.domain.KpiresultthresholdDTO;
import com.moogle.lbs.balancescorecard.domain.KpiresultthresholdGroupDTO;
import com.moogle.lbs.balancescorecard.domain.KpiresultthresholdTreeDTO;
import com.moogle.lbs.balancescorecard.domain.OverAllDTO;
import com.moogle.lbs.balancescorecard.domain.OwnerresultDTO;
import com.moogle.lbs.balancescorecard.domain.PerspectiveresultDTO;
import com.moogle.lbs.balancescorecard.domain.TrendChart;
import com.moogle.lbs.balancescorecard.service.BalanceScorecardService;

/**
 * @author Chatchai Pimtun
 */
@Repository
@Transactional
public class BalanceScorecardServiceImpl implements BalanceScorecardService {

	private SessionFactory sessionAnnotationFactory;

	/*
	 * @Autowired public BalanceScorecardServiceImpl(SessionFactory
	 * sessionAnnotationFactory) { this.sessionAnnotationFactory =
	 * sessionAnnotationFactory; }
	 */
	public SessionFactory getSessionAnnotationFactory() {
		return sessionAnnotationFactory;
	}

	public void setSessionAnnotationFactory(
			SessionFactory sessionAnnotationFactory) {
		this.sessionAnnotationFactory = sessionAnnotationFactory;
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	public List<Integer> listYear() {
		// TODO Auto-generated method stub
		List<Integer> list =null;
		try{
		
		 list = this.sessionAnnotationFactory
				.getCurrentSession()
				.createQuery(
						"select distinct dimdate.year from Dimdate dimdate   order by dimdate.year desc ")
				.list();
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		System.out.println("listYear ="+list);
		return list;
		
	}

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<String> listDivisions() { // TODO Auto-generated
	 * method stub String sql="Select 'ALL' as division from dimbranch" +
	 * " Union" +
	 * " Select distinct(division) as division from dimbranch order by Division "
	 * ; SQLQuery query=
	 * this.sessionAnnotationFactory.getCurrentSession().createSQLQuery(sql);
	 * List list = query.list(); System.out.println("list balace="+list); int
	 * size=list.size(); List result=new ArrayList(size); for (int i = 0; i <
	 * size; i++) { //Object[] objs = (Object[])list.get(i); String value=
	 * (String)list.get(i); result.add(value.trim()); }
	 * System.out.println("result size="+result.size()); //query.addEntity(arg0,
	 * arg1) return result; }
	 */
	/*
	 * (non-Javadoc) Select distinct ors.KPIOwnerKey, ors.KPIOwnerName from
	 * ownerresult ors, dimdate dd Where ors.DateKey = dd.DateKey and dd.Year =
	 * ?Year Parameter and dd.MonthName = ?Month Parameter
	 */

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	// public List<OwnerresultDTO> listOwnerResult(Integer year, String
	// monthName) {
	public List<OwnerresultDTO> listOwnerResult(Integer year, int month) {
		// TODO Auto-generated method stub
		/*
		 * String sql=
		 * "Select distinct ors.KPIOwnerKey as kpiOwnerKey, ors.KPIOwnerName  as KPIOwnerName from"
		 * + " OwnerResult ors, DimDate dd	Where ors.DateKey = dd.DateKey " +
		 * "  and dd.Year ="+year+"   and month(dd.Date) ="+month+" ";
		 */
		String sql = "Select distinct OwnerCode, OwnerName from OwnerResult "
				+ " Where ResultYear =" + year + " " + " and ResultMonth ="
				+ month + "";
		SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(sql);
		System.out.println("debug sql=" + sql);
		List result = query.list();
		int size = result.size();
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
			OwnerresultDTO ownerresultDTO = new OwnerresultDTO();
			ownerresultDTO.setKpiOwnerKey(obj[0] != null ? new BigDecimal(
					obj[0] + "") : null);
			ownerresultDTO.setKpiOwnerName(obj[1] != null ? obj[1] + "" : "");
			result.set(j, ownerresultDTO);
		}
		return result;
	}

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	// public List<OwnerresultthresholdDTO> getKPIOverall(Integer year, String
	// monthName,
	public List<OverAllDTO> getKPIOverall(Integer year, int month,
			BigDecimal kpiOwenerKey) {
		// TODO Auto-generated method stub
		/*
		 * *** Query สำหรับ Score 2.25 of 3.00 และข้อมูลที่จะแสดงบน Gauge Meter
		 * Select PercentActualVsTarget, SystemScore from OwnerResult Where
		 * ResultYear = ?Year Parameter and ResultMonth = ?Month Parameter and
		 * OwnerCode = ?Owner Parameter
		 * 
		 * 2.25 = SystemScore 3.00 = Select max(SystemScore) from
		 * OwnerSysScoreThreshold Where SystemYear = ?Year Parameter and
		 * OwnerCode = ?Owner Parameter
		 */

		/*
		 * *** Query สำหรับสเกลของ Gauge Meter หน่วยเป็น % Select SystemScore,
		 * BeginThreshold, EndThreshold, SystemColorCode from
		 * OwnerSysScoreThreshold Where SystemYear = ?Year Parameter and
		 * OwnerCode = ?Owner Parameter
		 */

		/*
		 * String sql=
		 * "Select  ors.KPIOwnerName as kpiOwnerName, ors.KPIOwnerKey as kpiOwnerKey, ors.DateKey as dateKey ,oth.ColorKey as colorKey,ors.ActualValue as actualValue, ors.TargetValue as targetValue,"
		 * +
		 * "  ors.PercentActualVsTarget as percentActualVsTarget,oth.BeginThreshold as beginThreshold,"
		 * + " oth.EndThreshold as endThreshold, oth.ColorCode as colorCode " +
		 * " From   OwnerResult ors, DimDate dd, ownerresultthreshold oth Where ors.DateKey = dd.DateKey and ors.KPIOwnerKey = oth.KPIOwnerKey "
		 * + " and ors.DateKey = oth.DateKey and " +
		 * " dd.Year ="+year+" and month(dd.Date) ="
		 * +month+"   and ors.KPIOwnerKey ="+kpiOwenerKey;
		 */
		String sql = "Select PercentActualVsTarget, SystemScore"
				+ "	from OwnerResult Where ResultYear = " + year + ""
				+ "	and ResultMonth = " + month + "" + "	and OwnerCode = "
				+ kpiOwenerKey.intValue() + "";

		System.out.println("debug sql=" + sql);
		SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(sql);
		String systemScore = "";
		String maxSystemScore = "";
		List result = query.list();
		int size = result.size();
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
			systemScore = (obj[1] != null ? obj[1] + "" : "");
		}
		sql = "Select max(SystemScore) from OwnerSysScoreThreshold "
				+ "	Where SystemYear =  " + year + " and OwnerCode =  "
				+ kpiOwenerKey.intValue() + "";
		query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(sql);
		result = query.list();
		size = result.size();
		for (int j = 0; j < size; j++) {
			java.lang.Integer obj = (java.lang.Integer) result.get(j);
			maxSystemScore = (obj + "");
		}
		List<OverAllDTO> overAllDTOList = new ArrayList(1);
		OverAllDTO dto = new OverAllDTO();
		dto.setSystemScore(systemScore);
		dto.setMaxSystemScore(maxSystemScore);
		overAllDTOList.add(dto);
		System.out.println("systemScore=" + systemScore + ",maxSystemScore="
				+ maxSystemScore);
		return overAllDTOList;
	}

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<OverAllDTO> getPieKPIOverall(Integer year, int
	 * month, BigDecimal kpiOwenerKey) { // TODO Auto-generated method stub
	 * String
	 * sql="Select SystemScore, BeginThreshold, EndThreshold, SystemColorCode "
	 * + " from OwnerSysScoreThreshold " +
	 * " Where SystemYear = "+year+" and OwnerCode = "
	 * +kpiOwenerKey.intValue()+" ";
	 * 
	 * System.out.println("debug sql="+sql); SQLQuery query=
	 * this.sessionAnnotationFactory.getCurrentSession(). createSQLQuery(sql);
	 * List<OverAllDTO> overAllDTOList=new ArrayList(1); List result =
	 * query.list(); int size = result.size(); for (int j = 0; j < size; j++) {
	 * Object[] obj = (Object[]) result.get(j); OverAllDTO dto=new OverAllDTO();
	 * dto.setSystemScore(obj[0] != null ? obj[0] + "" : "");
	 * dto.setBeginThreshold(obj[1] != null ? obj[1] + "" : "");
	 * dto.setEndThreshold(obj[2] != null ? obj[2] + "" : "");
	 * dto.setSystemColorCode(obj[3] != null ? obj[3] + "" : "");
	 * overAllDTOList.add(dto); } return overAllDTOList; }
	 */

	@SuppressWarnings("unchecked")
	@Transactional(readOnly = true)
	@Override
	/*
	 * public List<PerspectiveresultDTO> getPerspective(BigDecimal KPIOwnerKey,
	 * Integer year, String monthName) {
	 */
	public List<PerspectiveresultDTO> getPerspective(BigDecimal KPIOwnerKey,
			Integer year, int month) {
		// TODO Auto-generated method stub
		/*
		 * String sql=
		 * "Select  distinct prs.PerspectiveKey as perspectiveKey , prs.PerspectiveName as perspectiveName,prs.PerspectiveKey  as id from PerspectiveResult prs, DimDate dd "
		 * + " Where prs.DateKey = dd.DateKey and dd.Year ="+year+"" +
		 * " and month(dd.Date) ="
		 * +month+" and  prs.KPIOwnerKey ="+KPIOwnerKey+"";
		 */
		String sql = "Select PerspectiveCode , PerspectiveName from PerspectiveResult Where"
				+ "	ResultYear = "
				+ year
				+ " and	ResultMonth = "
				+ month
				+ " and	OwnerCode = " + month + "";
		SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(sql);
		System.out.println("debug sql=" + sql);
		List result = query.list();
		int size = result.size();
		List<PerspectiveresultDTO> perspectiveresultDTOList = new ArrayList(
				size);
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
			PerspectiveresultDTO dto = new PerspectiveresultDTO();
			dto.setPerspectiveKey(obj[0] != null ? new BigDecimal(obj[0] + "")
					: null);
			dto.setPerspectiveName(obj[1] != null ? obj[1] + "" : "");
			perspectiveresultDTOList.add(dto);
		}
		return perspectiveresultDTOList;
	}

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<KpiresultthresholdGroupDTO>
	 * getKPIListLevel0(Integer year, int month, BigDecimal KPIOwnerKey ,Integer
	 * perspectiveKey) { // TODO Auto-generated method stub
	 * 
	 * String strGroup=
	 * "Select krs.KpiKey, krs.DateKey, krs.PerspectiveKey, krs. PerspectiveName, krs.KpiName "
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth Where" +
	 * " krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and krs. DateKey = kth. DateKey and"
	 * + "  dd.Year ="+year+" and" + " month(dd.Date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and" +
	 * " krs.PerspectiveKey ="+perspectiveKey+"  and" +
	 * " krs.DisplayFlag ='Y' and krs.ParentKpiName ='NA' and " +
	 * " krs.PerspectiveKey="
	 * +perspectiveKey+"  group by krs.KpiKey,krs.DateKey,krs.PerspectiveKey ";
	 * SQLQuery query= this.sessionAnnotationFactory.getCurrentSession().
	 * createSQLQuery(strGroup); List KpiresultthresholdGroupDTOs =new
	 * ArrayList(); System.out.println("debug sqlGroup="+strGroup); List
	 * kpiresultthresholdGroups = query.list();
	 * if(kpiresultthresholdGroups!=null && kpiresultthresholdGroups.size()>0){
	 * for (int i = 0; i < kpiresultthresholdGroups.size(); i++) { Object[]
	 * kpiresultthresholdGroupArray = (Object[])kpiresultthresholdGroups.get(i);
	 * KpiresultthresholdGroupDTO group =new KpiresultthresholdGroupDTO();
	 * group.setKpiKey((Integer)kpiresultthresholdGroupArray[0]);
	 * group.setDateKey((Integer)kpiresultthresholdGroupArray[1]);
	 * group.setPerspectiveKey((Integer)kpiresultthresholdGroupArray[2]);
	 * group.setKpiName((String)kpiresultthresholdGroupArray[4]); String sql=
	 * "Select  krs.KpiKey as kpiKey, krs.DateKey as dateKey, krs.PerspectiveKey as perspectiveKey, krs.PerspectiveName as perspectiveName, "
	 * +
	 * " krs.KpiName as kpiName, krs.KPIOwnerWeighting as kpiOwnerWeighting, krs.PerspectiveWeighting as perspectiveWeighting, krs.Frequency as frequency,"
	 * +
	 * " krs.TargetValue as targetValue, krs.ActualValue as actualValue, krs.PercentActualVsTarget as percentActualVsTarget, kth.BeginThreshold as beginThreshold,"
	 * +
	 * " kth.EndThreshold as endThreshold, kth.ColorCode as colorCode, kth.UpdatedDT as updatedDT, krs.AccumulatedFlag as accumulatedFlag"
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth" +
	 * " Where krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and" +
	 * " krs.DateKey = kth. DateKey and dd.Year ="+year+" and" +
	 * " month(dd.Date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and" +
	 * " krs.PerspectiveKey ="+group.getPerspectiveKey()+"  and" +
	 * " krs.KpiKey ="+group.getKpiKey()+" and" +
	 * " krs.DisplayFlag ='Y' and krs.ParentKpiName ='NA'" ; query=
	 * this.sessionAnnotationFactory.getCurrentSession(). createSQLQuery(sql);
	 * query.addEntity("kpiresultthresholdDTO",KpiresultthresholdDTO.class);
	 * System.out.println("debug sql="+sql); List<KpiresultthresholdDTO> list
	 * =query.list(); group.setKpiresultthresholdDTOs(list);
	 * System.err.println("xxxxxxxxxxxxxxxxxxxxxxxx=>"+list);
	 * KpiresultthresholdGroupDTOs.add(group); } }
	 * 
	 * return KpiresultthresholdGroupDTOs; }
	 */

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<TrendChart> getTrendChartLevel0(Integer year, int
	 * month, BigDecimal KPIOwnerKey ,Integer kpiKey) { // TODO Auto-generated
	 * method stub String sql="SELECT KpiKey" +
	 * " , sum(If(month(dd.Date)=1 , krs.ActualValue,0)) as 'jan' "+
	 * " , sum(If(month(dd.Date)=2 , krs.ActualValue,0)) as 'feb' "+
	 * " , sum(If(month(dd.Date)=3 , krs.ActualValue,0)) as 'mar' "+
	 * " , sum(If(month(dd.Date)=4 , krs.ActualValue,0)) as 'apr' "+
	 * " , sum(If(month(dd.Date)=5 , krs.ActualValue,0)) as 'may' "+
	 * " , sum(If(month(dd.Date)=6 , krs.ActualValue,0)) as 'jun' "+
	 * " , sum(If(month(dd.Date)=7 , krs.ActualValue,0)) as 'jul' "+
	 * " , sum(If(month(dd.Date)=8 , krs.ActualValue,0)) as 'aug' "+
	 * " , sum(If(month(dd.Date)=9 , krs.ActualValue,0)) as 'sep' "+
	 * " , sum(If(month(dd.Date)=10 , krs.ActualValue,0)) as 'oct' "+
	 * " , sum(If(month(dd.Date)=11 , krs.ActualValue,0)) as 'nov' "+
	 * " , sum(If(month(dd.Date)=12 , krs.ActualValue,0)) as 'dec' "+
	 * " , KpiKey as id  "+ " FROM kpiresult krs,dimdate dd " +
	 * " where krs.DateKey=dd.DateKey "+ " and dd.Year="+year+" "+
	 * " and month(dd.Date) between 1 and "+month+" "+
	 * " and krs.KPIOwnerKey="+KPIOwnerKey
	 * +" and krs.DisplayFlag='Y' and krs.parentKpiName='NA'" +
	 * " and krs.parentKpiKey="+kpiKey+" "+ " group by Kpikey "; SQLQuery query=
	 * this.sessionAnnotationFactory.getCurrentSession().createSQLQuery(sql);
	 * query.addEntity("trendChart", TrendChart.class);
	 * System.out.println("debug sql="+sql); return (
	 * List<TrendChart>)query.list(); }
	 */

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<KpiresultthresholdGroupDTO> getKPIList(Integer
	 * year, int month, BigDecimal KPIOwnerKey ,Integer kpiKey) { String
	 * strGroup=
	 * "Select krs.KpiKey, krs.DateKey, krs.PerspectiveKey, krs. PerspectiveName, krs.KpiName "
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth Where" +
	 * " krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and krs. DateKey = kth. DateKey and"
	 * + "  dd.Year ="+year+" and" + " month(dd.Date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and " + " krs.DisplayFlag ='Y' and " +
	 * " krs.ParentKpiKey ="
	 * +kpiKey+"  group by krs.KpiKey,krs.DateKey,krs.PerspectiveKey  ";
	 * SQLQuery query= this.sessionAnnotationFactory.getCurrentSession().
	 * createSQLQuery(strGroup); List KpiresultthresholdGroupDTOs =new
	 * ArrayList(); System.out.println("debug sqlGroup="+strGroup); List
	 * kpiresultthresholdGroups = query.list();
	 * if(kpiresultthresholdGroups!=null && kpiresultthresholdGroups.size()>0){
	 * for (int i = 0; i < kpiresultthresholdGroups.size(); i++) { Object[]
	 * kpiresultthresholdGroupArray = (Object[])kpiresultthresholdGroups.get(i);
	 * KpiresultthresholdGroupDTO group =new KpiresultthresholdGroupDTO();
	 * group.setKpiKey((Integer)kpiresultthresholdGroupArray[0]);
	 * group.setDateKey((Integer)kpiresultthresholdGroupArray[1]);
	 * group.setPerspectiveKey((Integer)kpiresultthresholdGroupArray[2]);
	 * group.setKpiName((String)kpiresultthresholdGroupArray[4]); String sql=
	 * "Select krs.KpiKey as kpiKey, krs.DateKey as dateKey, krs.PerspectiveKey as perspectiveKey, krs.PerspectiveName as perspectiveName, "
	 * +
	 * " krs.KpiName as kpiName, krs.KPIOwnerWeighting as kpiOwnerWeighting, krs.PerspectiveWeighting as perspectiveWeighting, krs.Frequency as frequency,"
	 * +
	 * " krs.TargetValue as targetValue, krs.ActualValue as actualValue, krs.PercentActualVsTarget as percentActualVsTarget, kth.BeginThreshold as beginThreshold,"
	 * +
	 * " kth.EndThreshold as endThreshold, kth.ColorCode as colorCode, kth.UpdatedDT as updatedDT, krs.AccumulatedFlag as accumulatedFlag  "
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth" +
	 * " Where krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and" +
	 * " krs.DateKey = kth. DateKey and dd.Year ="+year+" and" +
	 * " month(dd.date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and " + " krs.DisplayFlag ='Y' and " +
	 * " krs.KpiKey ="+group.getKpiKey()+" and "+
	 * " krs.ParentKpiKey ="+kpiKey+" "; query=
	 * this.sessionAnnotationFactory.getCurrentSession(). createSQLQuery(sql);
	 * query.addEntity("kpiresultthresholdDTO",KpiresultthresholdDTO.class);
	 * System.out.println("debug sql="+sql);
	 * group.setKpiresultthresholdDTOs((List
	 * <KpiresultthresholdDTO>)query.list());
	 * KpiresultthresholdGroupDTOs.add(group); } }
	 * 
	 * return KpiresultthresholdGroupDTOs; }
	 */
	/*
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List getKPIListAndChart(Integer year, int month, int
	 * KPIOwnerKey, int parentKpiKey) {
	 * 
	 * String strGroup=
	 * "Select krs.KpiKey, krs.DateKey, krs.PerspectiveKey, krs. PerspectiveName, krs.KpiName "
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth Where" +
	 * " krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and krs. DateKey = kth. DateKey and"
	 * + "  dd.Year ="+year+" and" + " month(dd.date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and" + " krs.DisplayFlag ='Y' and  " +
	 * " krs.ParentKpiKey ="
	 * +parentKpiKey+"  group by krs.KpiKey,krs.DateKey,krs.PerspectiveKey  ";
	 * 
	 * SQLQuery query= this.sessionAnnotationFactory.getCurrentSession().
	 * createSQLQuery(strGroup); List KpiresultthresholdGroupDTOs =new
	 * ArrayList();
	 * System.out.println("debug sqlGroup getKPIListAndChart="+strGroup); List
	 * kpiresultthresholdGroups = query.list();
	 * if(kpiresultthresholdGroups!=null && kpiresultthresholdGroups.size()>0){
	 * for (int i = 0; i < kpiresultthresholdGroups.size(); i++) { Object[]
	 * kpiresultthresholdGroupArray = (Object[])kpiresultthresholdGroups.get(i);
	 * KpiresultthresholdGroupDTO group =new KpiresultthresholdGroupDTO();
	 * group.setKpiKey((Integer)kpiresultthresholdGroupArray[0]);
	 * group.setDateKey((Integer)kpiresultthresholdGroupArray[1]);
	 * group.setPerspectiveKey((Integer)kpiresultthresholdGroupArray[2]);
	 * group.setKpiName((String)kpiresultthresholdGroupArray[4]); String sql1=
	 * "Select  krs.KpiKey as kpiKey, krs.DateKey as dateKey, krs.PerspectiveKey as perspectiveKey, krs.PerspectiveName as perspectiveName, "
	 * +
	 * " krs.KpiName as kpiName, krs.KPIOwnerWeighting as kpiOwnerWeighting, krs.PerspectiveWeighting as perspectiveWeighting, krs.Frequency as frequency,"
	 * +
	 * " krs.TargetValue as targetValue, krs.ActualValue as actualValue, krs.PercentActualVsTarget as percentActualVsTarget, kth.BeginThreshold as beginThreshold,"
	 * +
	 * " kth.EndThreshold as endThreshold, kth.ColorCode as colorCode, kth.UpdatedDT as updatedDT, krs.AccumulatedFlag as accumulatedFlag"
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth" +
	 * " Where krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and" +
	 * " krs.DateKey = kth. DateKey and dd.Year ="+year+" and" +
	 * " month(dd.Date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and" +
	 * " krs.KpiKey ="+group.getKpiKey()+" and" +
	 * " krs.ParentKpiKey ="+parentKpiKey+" and" + " krs.DisplayFlag ='Y' ";
	 * query= this.sessionAnnotationFactory.getCurrentSession().
	 * createSQLQuery(sql1 );
	 * query.addEntity("kpiresultthresholdDTO",KpiresultthresholdDTO.class);
	 * System.out.println("debug sql1 getKPIListAndChart="+sql1);
	 * List<KpiresultthresholdDTO> list =query.list();
	 * group.setKpiresultthresholdDTOs(list); // get trend chart String
	 * sql="SELECT KpiKey" +
	 * " , sum(If(month(dd.Date)=1 , krs.ActualValue,0)) as 'jan' "+
	 * " , sum(If(month(dd.Date)=2 , krs.ActualValue,0)) as 'feb' "+
	 * " , sum(If(month(dd.Date)=3 , krs.ActualValue,0)) as 'mar' "+
	 * " , sum(If(month(dd.Date)=4 , krs.ActualValue,0)) as 'apr' "+
	 * " , sum(If(month(dd.Date)=5 , krs.ActualValue,0)) as 'may' "+
	 * " , sum(If(month(dd.Date)=6 , krs.ActualValue,0)) as 'jun' "+
	 * " , sum(If(month(dd.Date)=7 , krs.ActualValue,0)) as 'jul' "+
	 * " , sum(If(month(dd.Date)=8 , krs.ActualValue,0)) as 'aug' "+
	 * " , sum(If(month(dd.Date)=9 , krs.ActualValue,0)) as 'sep' "+
	 * " , sum(If(month(dd.Date)=10 , krs.ActualValue,0)) as 'oct' "+
	 * " , sum(If(month(dd.Date)=11 , krs.ActualValue,0)) as 'nov' "+
	 * " , sum(If(month(dd.Date)=12 , krs.ActualValue,0)) as 'dec' "+
	 * " , KpiKey as id  "+ " FROM kpiresult krs,dimdate dd " +
	 * " where krs.DateKey=dd.DateKey "+ " and dd.Year="+year+" "+
	 * " and month(dd.Date) between 1 and "+month+" "+
	 * " and krs.KPIOwnerKey="+KPIOwnerKey+" and krs.DisplayFlag='Y' " +
	 * " and krs.parentKpiKey="+parentKpiKey+" "+
	 * " and krs.Kpikey="+group.getKpiKey()+" "+ " group by Kpikey ";
	 * System.out.println("debug sql getKPIListAndChart="+sql); query=
	 * this.sessionAnnotationFactory.getCurrentSession().createSQLQuery(sql);
	 * query.addEntity("trendChart", TrendChart.class); TrendChart trendChart =
	 * null; Object obj=query.uniqueResult(); if(obj!=null) trendChart =
	 * (TrendChart)obj; group.setTrendChart(trendChart);
	 * KpiresultthresholdGroupDTOs.add(group); } }
	 * 
	 * return KpiresultthresholdGroupDTOs; }
	 */
	/*
	 * @SuppressWarnings( "unchecked" )
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<TrendChart> getTrendChart(Integer year, int month,
	 * BigDecimal KPIOwnerKey,Integer kpiKey) { String sql="SELECT KpiKey" +
	 * " , sum(If(month(dd.Date)=1 , krs.ActualValue,0)) as 'jan' "+
	 * " , sum(If(month(dd.Date)=2 , krs.ActualValue,0)) as 'feb' "+
	 * " , sum(If(month(dd.Date)=3 , krs.ActualValue,0)) as 'mar' "+
	 * " , sum(If(month(dd.Date)=4 , krs.ActualValue,0)) as 'apr' "+
	 * " , sum(If(month(dd.Date)=5 , krs.ActualValue,0)) as 'may' "+
	 * " , sum(If(month(dd.Date)=6 , krs.ActualValue,0)) as 'jun' "+
	 * " , sum(If(month(dd.Date)=7 , krs.ActualValue,0)) as 'jul' "+
	 * " , sum(If(month(dd.Date)=8 , krs.ActualValue,0)) as 'aug' "+
	 * " , sum(If(month(dd.Date)=9 , krs.ActualValue,0)) as 'sep' "+
	 * " , sum(If(month(dd.Date)=10 , krs.ActualValue,0)) as 'oct' "+
	 * " , sum(If(month(dd.Date)=11 , krs.ActualValue,0)) as 'nov' "+
	 * " , sum(If(month(dd.Date)=12 , krs.ActualValue,0)) as 'dec' "+
	 * " , KpiKey as id "+ " FROM kpiresult krs,dimdate dd " +
	 * " where krs.DateKey=dd.DateKey "+ " and dd.Year="+year+" "+
	 * " and month(dd.date) between 1 and "+month+" "+
	 * " and krs.KPIOwnerKey="+KPIOwnerKey
	 * +" and krs.DisplayFlag='Y' and krs.parentKpiKey="
	 * +kpiKey+" group by Kpikey ";
	 * System.out.println("debug sql getTrendChart="+sql); SQLQuery query=
	 * this.sessionAnnotationFactory.getCurrentSession().createSQLQuery(sql);
	 * query.addEntity("trendChart", TrendChart.class); return
	 * (List<TrendChart>)query.list(); }
	 */
	@Transactional(readOnly = true)
	@Override
	public Kpiresult getKPIDetail(KpiresultPK id) {
		// TODO Auto-generated method stub
		String sql = "from Kpiresult kpiResult  "
				+ " where kpiResult.id.kpiKey=" + id.getKpiKey() + " "
				+ " and  kpiResult.id.dateKey=:dateKey ";
		Query query = this.sessionAnnotationFactory.getCurrentSession()
				.createQuery(sql);
		query.setParameter("dateKey", id.getDateKey());
		System.out.println("debug sql getKPIDetail=" + sql);
		List list = query.list();
		Object obj = query.uniqueResult();
		if (obj != null)
			return (Kpiresult) obj;
		return null;
	}

	/*
	 * @SuppressWarnings("unchecked")
	 * 
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List<PerspectiveresultthresholdDTO>
	 * getPerspectiveResult(Integer year, int month,BigDecimal kpiOwenerKey) {
	 * // TODO Auto-generated method stub String sql=
	 * " Select prs.PerspectiveKey as perspectiveKey ,prs.KPIOwnerKey as kpiOwnerKey, "
	 * +
	 * "  prs.PerspectiveName as perspectiveName, prs.DateKey as dateKey ,  pth.ColorKey as colorKey ,"
	 * +
	 * "  prs.ActualValue as actualValue, prs.TargetValue as targetValue, prs.PercentActualVsTarget as percentActualVsTarget,"
	 * +
	 * " pth.BeginThreshold as beginThreshold, pth.EndThreshold as endThreshold, pth.ColorCode as colorCode "
	 * +
	 * " From	perspectiveresult prs, dimdate dd, perspectiveresultthreshold pth"
	 * + " Where	prs.DateKey = dd.DateKey and " +
	 * " prs. PerspectiveKey = pth. PerspectiveKey and" +
	 * " prs. DateKey = pth. DateKey and dd.Year ="+year+" and" +
	 * " month(dd.Date) ="+month+" and prs.KPIOwnerKey ="+kpiOwenerKey+"";
	 * SQLQuery query= this.sessionAnnotationFactory.getCurrentSession().
	 * createSQLQuery( sql);
	 * System.out.println("debug sql getPerspectiveResult="+sql);
	 * query.addEntity
	 * ("perspectiveresultthresholdDTO",PerspectiveresultthresholdDTO.class);
	 * return (List<PerspectiveresultthresholdDTO>)query.list();
	 * 
	 * }
	 */

	@SuppressWarnings({ "unchecked" })
	@Transactional(readOnly = true)
	@Override
	public List<KPIChart> getKPIChart(Integer year, int month, Integer kpiKey,
			String accumulatedFlag) {
		// TODO Auto-generated methodstub
		String sql = "";
		if (accumulatedFlag.equals("Y")) {
			sql = "select krs1.kpiName as  kpiName, krs1.KpiKey as kpiKey,krs1.DateKey as dateKey, dd1.MonthNo, dd1.MonthName, krs1.ActualValue, krs1.TargetValue, "
					+ " krs1.ActualValue+COALESCE((SELECT SUM(krs2.ActualValue) "
					+ " from kpiresult krs2, dimdate dd2  where krs1.KpiKey = krs2.KpiKey   and krs1.DateKey = krs2.DateKey"
					+ " and krs2.DateKey = dd2.DateKey   and dd1.MonthNo < dd2.MonthNo),0) as AccumActualValue,"
					+ " (select krs3.ActualValue   from kpiresult krs3, dimdate dd3"
					+ "   where krs3.DateKey = dd3.DateKey   and krs1.KpiKey = krs3.KpiKey"
					+ "   and dd3.Year =("
					+ year
					+ " - 1)"
					+ "   and month(dd3.Date) between 1 and "
					+ month
					+ ") as LastYearActual "
					+ "	from kpiresult krs1, dimdate dd1 where krs1.DateKey = dd1.DateKey and"
					+ "	dd1.Year ="
					+ year
					+ " and	month(dd1.Date) between 1 and "
					+ month
					+ " and"
					+ "	krs1.KpiKey =" + kpiKey + " order by dd1.MonthNo";
		} else if (accumulatedFlag.equals("N")) {
			sql = "select krs.kpiName as  kpiName ,krs.KpiKey as kpiKey,krs.DateKey as dateKey, dd.MonthNo, dd.MonthName, krs.ActualValue, krs.TargetValue,"
					+ " (select krs.ActualValue   from kpiresult krs2, dimdate dd2"
					+ "  where krs2.DateKey = dd2.DateKey   and krs.KpiKey = krs2.KpiKey"
					+ " and dd.Year =("
					+ year
					+ " - 1)  and month(dd.Date) between 1 and "
					+ month
					+ " ) as LastYearActual  "
					+ " , null as accumActualValue "
					+ " from kpiresult krs, dimdate dd where krs.DateKey = dd.DateKey and	dd.Year ="
					+ year
					+ " and"
					+ " month(dd.Date) between 1 and "
					+ month
					+ " and krs.KpiKey =" + kpiKey + "  order by dd.MonthNo";
		}
		System.out.println(" debug sql=" + sql);
		SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(sql);
		query.addEntity("kpiChart", KPIChart.class);
		return (List<KPIChart>) query.list();
	}

	/*
	 * 
	 */
	@Transactional(readOnly = true)
	@Override
	public List getKPIListAndChartLevel0(Integer year, int month,
			int KPIOwnerKey, int perspectiveKey) {
		// TODO Auto-generated method stub
		String strGroup = "Select KpiCode, KpiName, OwnerWeighting, PerspectiveWeighting, Frequency, TargetValue, ActualValue, PercentActualVsTarget, SystemScore, SystemColorCode, UpdatedDT, AccumulatedFlag "
				+ " From KpiResult Where ResultYear = "
				+ year.intValue()
				+ " and ResultMonth ="
				+ month
				+ " and OwnerCode = "
				+ KPIOwnerKey
				+ " "
				+ " and PerspectiveCode = "
				+ perspectiveKey + " and " + " ParentKpiCode = 'NA' ";
		System.out.println("debug sqlGroup=" + strGroup);
		SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(strGroup);
		List KpiresultthresholdGroupDTOs = new ArrayList();
		List kpiresultthresholdGroups = query.list();
		if (kpiresultthresholdGroups != null
				&& kpiresultthresholdGroups.size() > 0) {
			for (int i = 0; i < kpiresultthresholdGroups.size(); i++) {
				Object[] kpiresultthresholdGroupArray = (Object[]) kpiresultthresholdGroups
						.get(i);
				KpiresultthresholdGroupDTO group = new KpiresultthresholdGroupDTO();
				group.setKpiKey((Integer) kpiresultthresholdGroupArray[0]);
				group.setDateKey((Integer) kpiresultthresholdGroupArray[1]);
				group.setPerspectiveKey((Integer) kpiresultthresholdGroupArray[2]);
				group.setKpiName((String) kpiresultthresholdGroupArray[4]);
				String sql2 = "Select  krs.KpiKey as kpiKey, krs.DateKey as dateKey, krs.PerspectiveKey as perspectiveKey, krs.PerspectiveName as perspectiveName, "
						+ " krs.KpiName as kpiName, krs.KPIOwnerWeighting as kpiOwnerWeighting, krs.PerspectiveWeighting as perspectiveWeighting, krs.Frequency as frequency,"
						+ " krs.TargetValue as targetValue, krs.ActualValue as actualValue, krs.PercentActualVsTarget as percentActualVsTarget, kth.BeginThreshold as beginThreshold,"
						+ " kth.EndThreshold as endThreshold, kth.ColorCode as colorCode, kth.UpdatedDT as updatedDT, krs.AccumulatedFlag as accumulatedFlag"
						+ " From kpiresult krs, dimdate dd, kpiresultthreshold kth"
						+ " Where krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and"
						+ " krs.DateKey = kth. DateKey and dd.Year ="
						+ year
						+ " and"
						+ " month(dd.Date) ="
						+ month
						+ " and"
						+ " krs.KPIOwnerKey ="
						+ KPIOwnerKey
						+ " and"
						+ " krs.KpiKey ="
						+ group.getKpiKey()
						+ " and"
						+ " krs.PerspectiveKey ="
						+ group.getPerspectiveKey()
						+ "  and"
						+ " krs.DisplayFlag ='Y' and krs.ParentKpiName ='NA'";
				System.out.println("debug sql=" + sql2);
				query = this.sessionAnnotationFactory.getCurrentSession()
						.createSQLQuery(sql2);
				query.addEntity("kpiresultthresholdDTO",
						KpiresultthresholdDTO.class);
				List<KpiresultthresholdDTO> list = query.list();
				group.setKpiresultthresholdDTOs(list);
				String sql = "SELECT KpiKey"
						+ " , sum(If(month(dd.Date)=1 , krs.ActualValue,0)) as 'jan' "
						+ " , sum(If(month(dd.Date)=2 , krs.ActualValue,0)) as 'feb' "
						+ " , sum(If(month(dd.Date)=3 , krs.ActualValue,0)) as 'mar' "
						+ " , sum(If(month(dd.Date)=4 , krs.ActualValue,0)) as 'apr' "
						+ " , sum(If(month(dd.Date)=5 , krs.ActualValue,0)) as 'may' "
						+ " , sum(If(month(dd.Date)=6 , krs.ActualValue,0)) as 'jun' "
						+ " , sum(If(month(dd.Date)=7 , krs.ActualValue,0)) as 'jul' "
						+ " , sum(If(month(dd.Date)=8 , krs.ActualValue,0)) as 'aug' "
						+ " , sum(If(month(dd.Date)=9 , krs.ActualValue,0)) as 'sep' "
						+ " , sum(If(month(dd.Date)=10 , krs.ActualValue,0)) as 'oct' "
						+ " , sum(If(month(dd.Date)=11 , krs.ActualValue,0)) as 'nov' "
						+ " , sum(If(month(dd.Date)=12 , krs.ActualValue,0)) as 'dec' "
						+ " , KpiKey as id  "
						+ " FROM kpiresult krs,dimdate dd "
						+ " where krs.DateKey=dd.DateKey " + " and dd.Year="
						+ year + " " + " and month(dd.Date) between 1 and "
						+ month + " " + " and krs.KPIOwnerKey=" + KPIOwnerKey
						+ " and krs.DisplayFlag='Y' and krs.parentKpiName='NA'"
						+ " and krs.Kpikey=" + group.getKpiKey() + " "
						+ " group by Kpikey ";
				System.out.println("debug sql" + sql);
				query = this.sessionAnnotationFactory.getCurrentSession()
						.createSQLQuery(sql);
				query.addEntity("trendChart", TrendChart.class);
				TrendChart trendChart = null;
				Object obj = query.uniqueResult();
				if (obj != null)
					trendChart = (TrendChart) obj;
				group.setTrendChart(trendChart);
				KpiresultthresholdGroupDTOs.add(group);
			}
		}
		return KpiresultthresholdGroupDTOs;
	}

	/*
	 * @Transactional(readOnly = true)
	 * 
	 * @Override public List getKPIListAndChartLevel0(Integer year, int month,
	 * int KPIOwnerKey, int perspectiveKey) { // TODO Auto-generated method stub
	 * String strGroup=
	 * "Select krs.KpiKey, krs.DateKey, krs.PerspectiveKey, krs. PerspectiveName, krs.KpiName "
	 * + " From KpiResult krs, DimDate dd, kpiresultthreshold kth Where" +
	 * " krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and krs. DateKey = kth. DateKey and"
	 * + "  dd.Year ="+year+" and" + " month(dd.date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and" + " krs.DisplayFlag ='Y' and  " +
	 * "  krs.ParentKpiName ='NA'  and krs.PerspectiveKey ="+perspectiveKey+" "
	 * + "   group by krs.KpiKey,krs.DateKey,krs.PerspectiveKey ";
	 * System.out.println("debug sqlGroup="+strGroup); SQLQuery query=
	 * this.sessionAnnotationFactory.getCurrentSession().
	 * createSQLQuery(strGroup); List KpiresultthresholdGroupDTOs =new
	 * ArrayList(); List kpiresultthresholdGroups = query.list();
	 * if(kpiresultthresholdGroups!=null && kpiresultthresholdGroups.size()>0){
	 * for (int i = 0; i < kpiresultthresholdGroups.size(); i++) { Object[]
	 * kpiresultthresholdGroupArray = (Object[])kpiresultthresholdGroups.get(i);
	 * KpiresultthresholdGroupDTO group =new KpiresultthresholdGroupDTO();
	 * group.setKpiKey((Integer)kpiresultthresholdGroupArray[0]);
	 * group.setDateKey((Integer)kpiresultthresholdGroupArray[1]);
	 * group.setPerspectiveKey((Integer)kpiresultthresholdGroupArray[2]);
	 * group.setKpiName((String)kpiresultthresholdGroupArray[4]); String sql2=
	 * "Select  krs.KpiKey as kpiKey, krs.DateKey as dateKey, krs.PerspectiveKey as perspectiveKey, krs.PerspectiveName as perspectiveName, "
	 * +
	 * " krs.KpiName as kpiName, krs.KPIOwnerWeighting as kpiOwnerWeighting, krs.PerspectiveWeighting as perspectiveWeighting, krs.Frequency as frequency,"
	 * +
	 * " krs.TargetValue as targetValue, krs.ActualValue as actualValue, krs.PercentActualVsTarget as percentActualVsTarget, kth.BeginThreshold as beginThreshold,"
	 * +
	 * " kth.EndThreshold as endThreshold, kth.ColorCode as colorCode, kth.UpdatedDT as updatedDT, krs.AccumulatedFlag as accumulatedFlag"
	 * + " From kpiresult krs, dimdate dd, kpiresultthreshold kth" +
	 * " Where krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and" +
	 * " krs.DateKey = kth. DateKey and dd.Year ="+year+" and" +
	 * " month(dd.Date) ="+month+" and" +
	 * " krs.KPIOwnerKey ="+KPIOwnerKey+" and" +
	 * " krs.KpiKey ="+group.getKpiKey()+" and" +
	 * " krs.PerspectiveKey ="+group.getPerspectiveKey()+"  and" +
	 * " krs.DisplayFlag ='Y' and krs.ParentKpiName ='NA'";
	 * System.out.println("debug sql="+sql2); query=
	 * this.sessionAnnotationFactory.getCurrentSession(). createSQLQuery(sql2 );
	 * query.addEntity("kpiresultthresholdDTO",KpiresultthresholdDTO.class);
	 * List<KpiresultthresholdDTO> list =query.list();
	 * group.setKpiresultthresholdDTOs(list); String sql="SELECT KpiKey" +
	 * " , sum(If(month(dd.Date)=1 , krs.ActualValue,0)) as 'jan' "+
	 * " , sum(If(month(dd.Date)=2 , krs.ActualValue,0)) as 'feb' "+
	 * " , sum(If(month(dd.Date)=3 , krs.ActualValue,0)) as 'mar' "+
	 * " , sum(If(month(dd.Date)=4 , krs.ActualValue,0)) as 'apr' "+
	 * " , sum(If(month(dd.Date)=5 , krs.ActualValue,0)) as 'may' "+
	 * " , sum(If(month(dd.Date)=6 , krs.ActualValue,0)) as 'jun' "+
	 * " , sum(If(month(dd.Date)=7 , krs.ActualValue,0)) as 'jul' "+
	 * " , sum(If(month(dd.Date)=8 , krs.ActualValue,0)) as 'aug' "+
	 * " , sum(If(month(dd.Date)=9 , krs.ActualValue,0)) as 'sep' "+
	 * " , sum(If(month(dd.Date)=10 , krs.ActualValue,0)) as 'oct' "+
	 * " , sum(If(month(dd.Date)=11 , krs.ActualValue,0)) as 'nov' "+
	 * " , sum(If(month(dd.Date)=12 , krs.ActualValue,0)) as 'dec' "+
	 * " , KpiKey as id  "+ " FROM kpiresult krs,dimdate dd " +
	 * " where krs.DateKey=dd.DateKey "+ " and dd.Year="+year+" "+
	 * " and month(dd.Date) between 1 and "+month+" "+
	 * " and krs.KPIOwnerKey="+KPIOwnerKey
	 * +" and krs.DisplayFlag='Y' and krs.parentKpiName='NA'" +
	 * " and krs.Kpikey="+group.getKpiKey()+" "+ " group by Kpikey ";
	 * System.out.println("debug sql"+sql); query=
	 * this.sessionAnnotationFactory.getCurrentSession().createSQLQuery(sql);
	 * query.addEntity("trendChart", TrendChart.class); TrendChart trendChart =
	 * null; Object obj=query.uniqueResult(); if(obj!=null) trendChart =
	 * (TrendChart)obj; group.setTrendChart(trendChart);
	 * KpiresultthresholdGroupDTOs.add(group); } } return
	 * KpiresultthresholdGroupDTOs; }
	 */
	@Transactional(readOnly = true)
	@Override
	/*
	 * public List getKPIListAndChartRecursive(List results ,Integer year,
	 * String monthName, int KPIOwnerKey, int parentKpiKey) {
	 */
	public List getKPIListAndChartRecursive(List results, Integer year,
			int month, int KPIOwnerKey, int parentKpiKey) {

		// TODO Auto-generated method stub
		String strGroup = "Select krs.KpiKey, krs.DateKey, krs.PerspectiveKey, krs. PerspectiveName, krs.KpiName "
				+ " From kpiresult krs, dimdate dd, kpiresultthreshold kth Where"
				+ " krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and krs. DateKey = kth. DateKey and"
				+ "  dd.Year ="
				+ year
				+ " and"
				+ " month(dd.Date) ="
				+ month
				+ " and"
				+ " krs.KPIOwnerKey ="
				+ KPIOwnerKey
				+ " and"
				+ " krs.DisplayFlag ='Y' and  "
				+ " krs.ParentKpiKey ="
				+ parentKpiKey
				+ "  group by krs.KpiKey,krs.DateKey,krs.PerspectiveKey  ";
		System.out.println("debug sqlgroup=" + strGroup);
		SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
				.createSQLQuery(strGroup);
		/*
		 * query.setParameter("year", year); query.setParameter("month", month);
		 * query.setParameter("KPIOwnerKey", KPIOwnerKey);
		 * query.setParameter("ParentKpiKey", parentKpiKey);
		 */
		// List resutl=new ArrayList(2);
		List KpiresultthresholdGroupDTOs = new ArrayList();
		List kpiresultthresholdGroups = query.list();
		if (kpiresultthresholdGroups != null
				&& kpiresultthresholdGroups.size() > 0) {
			for (int i = 0; i < kpiresultthresholdGroups.size(); i++) {
				Object[] kpiresultthresholdGroupArray = (Object[]) kpiresultthresholdGroups
						.get(i);
				KpiresultthresholdGroupDTO group = new KpiresultthresholdGroupDTO();
				group.setKpiKey((Integer) kpiresultthresholdGroupArray[0]);
				group.setDateKey((Integer) kpiresultthresholdGroupArray[1]);
				group.setPerspectiveKey((Integer) kpiresultthresholdGroupArray[2]);
				group.setKpiName((String) kpiresultthresholdGroupArray[4]);
				group.setChildOf(parentKpiKey + "");
				String sql2 = "Select  krs.KpiKey as kpiKey, krs.DateKey as dateKey, krs.PerspectiveKey as perspectiveKey, krs.PerspectiveName as perspectiveName, "
						+ " krs.KpiName as kpiName, krs.KPIOwnerWeighting as kpiOwnerWeighting, krs.PerspectiveWeighting as perspectiveWeighting, krs.Frequency as frequency,"
						+ " krs.TargetValue as targetValue, krs.ActualValue as actualValue, krs.PercentActualVsTarget as percentActualVsTarget, kth.BeginThreshold as beginThreshold,"
						+ " kth.EndThreshold as endThreshold, kth.ColorCode as colorCode, kth.UpdatedDT as updatedDT, krs.AccumulatedFlag as accumulatedFlag"
						+ " From kpiresult krs, dimdate dd, kpiresultthreshold kth"
						+ " Where krs.DateKey = dd.DateKey and krs.KpiKey = kth.KpiKey and"
						+ " krs.DateKey = kth. DateKey and dd.Year ="
						+ year
						+ " and"
						+ " month(dd.Date) ="
						+ month
						+ " and"
						+ " krs.KPIOwnerKey ="
						+ KPIOwnerKey
						+ " and"
						+ " krs.KpiKey ="
						+ group.getKpiKey()
						+ " and"
						+ " krs.ParentKpiKey ="
						+ parentKpiKey
						+ " and"
						+ " krs.DisplayFlag ='Y' ";
				System.out.println("debug sql2 ==> " + sql2);
				query = this.sessionAnnotationFactory.getCurrentSession()
						.createSQLQuery(sql2);

				/*
				 * query.setParameter("year", year); query.setParameter("month",
				 * month); query.setParameter("KpiKey", group.getKpiKey());
				 * query.setParameter("KPIOwnerKey", KPIOwnerKey);
				 * query.setParameter("ParentKpiKey", parentKpiKey);
				 */
				query.addEntity("kpiresultthresholdDTO",
						KpiresultthresholdDTO.class);
				List<KpiresultthresholdDTO> list = query.list();
				group.setKpiresultthresholdDTOs(list);

				// get trend chart
				String sql = "SELECT KpiKey"
						+
						/*
						 * " , sum(If(dd.MonthName='Jan' , krs.ActualValue,0)) as 'jan' "
						 * +
						 * " , sum(If(dd.MonthName='Feb' , krs.ActualValue,0)) as 'feb' "
						 * +
						 * " , sum(If(dd.MonthName='Mar' , krs.ActualValue,0)) as 'mar' "
						 * +
						 * " , sum(If(dd.MonthName='Apr' , krs.ActualValue,0)) as 'apr' "
						 * +
						 * " , sum(If(dd.MonthName='May' , krs.ActualValue,0)) as 'may' "
						 * +
						 * " , sum(If(dd.MonthName='Jun' , krs.ActualValue,0)) as 'jun' "
						 * +
						 * " , sum(If(dd.MonthName='Jul' , krs.ActualValue,0)) as 'jul' "
						 * +
						 * " , sum(If(dd.MonthName='Aug' , krs.ActualValue,0)) as 'aug' "
						 * +
						 * " , sum(If(dd.MonthName='Sep' , krs.ActualValue,0)) as 'sep' "
						 * +
						 * " , sum(If(dd.MonthName='Oct' , krs.ActualValue,0)) as 'oct' "
						 * +
						 * " , sum(If(dd.MonthName='Nov' , krs.ActualValue,0)) as 'nov' "
						 * +
						 * " , sum(If(dd.MonthName='Dec' , krs.ActualValue,0)) as 'dec' "
						 * +
						 */
						" , sum(If(month(dd.Date)=1 , krs.ActualValue,0)) as 'jan' "
						+ " , sum(If(month(dd.Date)=2 , krs.ActualValue,0)) as 'feb' "
						+ " , sum(If(month(dd.Date)=3 , krs.ActualValue,0)) as 'mar' "
						+ " , sum(If(month(dd.Date)=4 , krs.ActualValue,0)) as 'apr' "
						+ " , sum(If(month(dd.Date)=5 , krs.ActualValue,0)) as 'may' "
						+ " , sum(If(month(dd.Date)=6 , krs.ActualValue,0)) as 'jun' "
						+ " , sum(If(month(dd.Date)=7 , krs.ActualValue,0)) as 'jul' "
						+ " , sum(If(month(dd.Date)=8 , krs.ActualValue,0)) as 'aug' "
						+ " , sum(If(month(dd.Date)=9 , krs.ActualValue,0)) as 'sep' "
						+ " , sum(If(month(dd.Date)=10 , krs.ActualValue,0)) as 'oct' "
						+ " , sum(If(month(dd.Date)=11 , krs.ActualValue,0)) as 'nov' "
						+ " , sum(If(month(dd.Date)=12 , krs.ActualValue,0)) as 'dec' "
						+ " , KpiKey as id  "
						+ " FROM kpiresult krs,dimdate dd "
						+ " where krs.DateKey=dd.DateKey " + " and dd.Year="
						+ year + " " + " and month(dd.Date) between 1 and "
						+ month + " " + " and krs.KPIOwnerKey=" + KPIOwnerKey
						+ " and krs.DisplayFlag='Y' "
						+ " and krs.parentKpiKey=" + parentKpiKey + " "
						+ " and krs.Kpikey=" + group.getKpiKey() + " "
						+ " group by Kpikey ";

				System.out.println("debug sql=" + sql);
				// " and krs.KPIOwnerKey=:KPIOwnerKey and krs.DisplayFlag='Y' and krs.parentKpiKey=:kpiKey group by Kpikey ";
				query = this.sessionAnnotationFactory.getCurrentSession()
						.createSQLQuery(sql);
				/*
				 * query.setParameter("year", year); query.setParameter("month",
				 * month); query.setParameter("KPIOwnerKey", KPIOwnerKey);
				 * query.setParameter("kpiKey", group.getKpiKey());
				 * query.setParameter("ParentKpiKey", parentKpiKey);
				 */
				query.addEntity("trendChart", TrendChart.class);
				TrendChart trendChart = null;
				Object obj = query.uniqueResult();
				if (obj != null)
					trendChart = (TrendChart) obj;
				group.setTrendChart(trendChart);
				/*
				 * resutl.add(KpiresultthresholdGroupDTOs);
				 * resutl.add(query.list());
				 */
				// KpiresultthresholdGroupDTOs.add(group);
				results.add(group);
				// return null;
				results = getKPIListAndChartRecursive(results, year, month,
						KPIOwnerKey, group.getKpiKey());
			}
		}

		return results;
	}

	@Override
	public List<OwnerresultDTO> listOwnerResultProc(Integer year, int month) {
		// TODO Auto-generated method stub
		/*Session session = this.sessionAnnotationFactory.getCurrentSession();
		SQLQuery query3 = session
				.createSQLQuery("CALL proc_SelectPerspective(2011,1,1)");
		query3.list();
		List result2 = query3.list();
		System.out.println("xxxxxxxxxxxxxxxx result2=" + result2.size());
		int size = result2.size();

		for (int j = 0; j < size; j++) {
			Object[] obj2 = (Object[]) result2.get(j);
			FinancialPopup3DTO group = new FinancialPopup3DTO();
			group.setSubCategory(obj2[0] != null ? obj2[0] + "" : "");
			group.setPercentLastPeriodActual(obj2[1] != null ? obj2[1] + ""
					: "");
		}*/
		return null;
	}

	@Override
	public List<OverAllDTO> getKPIOverallPopupScoreProc(Integer year, int month,
			BigDecimal kpiOwenerKey) {
		// TODO Auto-generated method stub
		List result=new ArrayList<OverAllDTO>(1);
		String systemScore="";
		String maxScore="";
		String percentActualVsTarget="";
    try{
		Session session = this.sessionAnnotationFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("{CALL Proc_OverPopupScore("+ year.intValue() + "," + month + "," + kpiOwenerKey.intValue()+ ")}");
		System.out.println("into getKPIOverallProc");
		//query.uniqueResult(); 
		List resultSet= query.list();
		 int size = resultSet.size();
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) resultSet.get(j);
			/*	OverAllDTO overAll = new OverAllDTO();*/
			percentActualVsTarget=(obj[0] != null ? obj[0] + "" : "");
			systemScore=(obj[1] != null ? obj[1] + "" : "");
			//result.set(j, overAll);
		} 
		 query = session.createSQLQuery("{CALL Proc_OverPopupMaxScore("+ year.intValue() + "," + kpiOwenerKey.intValue()+ ")}");
		 resultSet= query.list();
		 for (int j = 0; j < size; j++) {
			 java.lang.Integer obj = (java.lang.Integer) resultSet.get(j); 
			maxScore=(obj.intValue() + ""); 
			} 
		OverAllDTO overAll = new OverAllDTO();
		overAll.setSystemScore(systemScore);
		overAll.setMaxSystemScore(maxScore);
		overAll.setPercentActualVsTarget(percentActualVsTarget);
		result.add(overAll);
    }catch (Exception e) {
		// TODO: handle exception
    	e.printStackTrace();
	}
		return result;
	}
	@Override
	public List<OverAllDTO> getKPIOverallPopupProc(Integer year, 
			BigDecimal kpiOwenerKey) {
		// TODO Auto-generated method stub
		List result=null;
    try{
		Session session = this.sessionAnnotationFactory.getCurrentSession(); 
		SQLQuery query = session.createSQLQuery("{CALL Proc_OverPopupScale("+ year.intValue() + "," + kpiOwenerKey.intValue()+ ")}");
		System.out.println("into getKPIOverallPopupProc");
		//query.uniqueResult(); 
		result= query.list();
		 int size = result.size();
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
				OverAllDTO overAll = new OverAllDTO();
			overAll.setSystemScore(obj[0] != null ? obj[0] + "" : "");
			overAll.setBeginThreshold(obj[1] != null ? obj[1] + "" : "");
			overAll.setEndThreshold(obj[2] != null ? obj[2] + "" : "");
			overAll.setSystemColorCode(obj[3] != null ? obj[3] + "" : "");
			result.set(j, overAll);
		} 
    }catch (Exception e) {
		// TODO: handle exception
    	e.printStackTrace();
	}
		return result;
	}

	@Override
	public List<PerspectiveresultDTO> getPerspectiveProc( // OK
			BigDecimal KPIOwnerKey, Integer year, int month) {
		// TODO Auto-generated method stub
		Session session = this.sessionAnnotationFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("CALL Proc_Perspective("
				+ year.intValue() + "," + month + "," + KPIOwnerKey.intValue()
				+ ")");
		List result = query.list();
		int size = result.size();
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
			PerspectiveresultDTO perspectiveresultDTO = new PerspectiveresultDTO();
			perspectiveresultDTO
					.setPerspectiveKey(obj[0] != null ? new BigDecimal(obj[0]
							+ "") : null);
			perspectiveresultDTO.setPerspectiveName(obj[1] != null ? obj[1]
					+ "" : "");
			result.set(j, perspectiveresultDTO);
		}
		return result;
	}

	@Override
	public List getKPIListAndChartLevel0Proc(Integer year, int month,
			int KPIOwnerKey, int perspectiveKey) {
		// TODO Auto-generated method stub
		Session session = this.sessionAnnotationFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("CALL Proc_KpiListParent("
				+ year.intValue() + "," + month + "," + KPIOwnerKey+ "," + perspectiveKey
				+ ")");
		List result = query.list();
		int size = result.size();
		/*call Proc_KpiListParent(2011,3,1,1)
		call Proc_TrendChartParent(2011,3,1,1,'f1')*/
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
			 
			KpiresultthresholdTreeDTO tree = new KpiresultthresholdTreeDTO();
			tree.setKpiCode(obj[0] != null ? obj[0]+"": null);
			tree.setKpiName(obj[1] != null ? obj[1]+"": null);
			tree.setOwnerWeighting(obj[2] != null ? obj[2]+"": null);
			tree.setPerspectiveWeighting(obj[3] != null ? obj[3]+"": null);
			tree.setFrequency(obj[4] != null ? obj[4]+"": null);
			tree.setTargetValue(obj[5] != null ? obj[5]+"": null);
			tree.setActualValue(obj[6] != null ? obj[6]+"": null);
			tree.setPercentActualVsTarget(obj[7] != null ? obj[7]+"": null);
			tree.setSystemScore(obj[8] != null ? obj[8]+"": null);
			tree.setSystemColorCode(obj[9] != null ? obj[9]+"": null);
			tree.setUpdatedDT(obj[10] != null ? obj[10]+"": null);
			tree.setAccumulatedFlag(obj[11] != null ? obj[11]+"": null) ;
			SQLQuery query2 = session.createSQLQuery("CALL Proc_TrendChartParent("
					+ year.intValue() + "," + month + "," + KPIOwnerKey+ "," + perspectiveKey+ ",'" + tree.getKpiCode()
					+ "')");
			List result2 = query2.list();
			int size_inner=result2.size();
			List<TrendChart> trends=new ArrayList<TrendChart>(size_inner);
			for (int i = 0; i <size_inner; i++) {
				Object[] obj2 = (Object[]) result2.get(i);
				TrendChart trend=new TrendChart();
				trend.setJan(obj2[1]+"");
				trend.setFeb(obj2[2]+"");
				trend.setMar(obj2[3]+"");
				trend.setApr(obj2[4]+"");
				trend.setMay(obj2[5]+"");
				trend.setJun(obj2[6]+"");
				trend.setJul(obj2[7]+"");
				trend.setAug(obj2[8]+"");
				trend.setSep(obj2[9]+"");
				trend.setOct(obj2[10]+"");
				trend.setNov(obj2[11]+"");
				trend.setDec(obj2[12]+"");
				trends.add(trend);
			}
			tree.setTrendChart(trends);
			/*List result3=null;
		    try{
				 
				SQLQuery query3 = session.createSQLQuery("{CALL Proc_PerspectiveScale("+ year.intValue() + "," + perspectiveKey+ ")}");
				System.out.println("into getKPIOverallPopupProc");
				//query.uniqueResult(); 
				result3= query3.list();
				 int size3 = result3.size();
				for (int z = 0; z < size3; z++) {
					Object[] obj3 = (Object[]) result3.get(z);
						OverAllDTO overAll = new OverAllDTO();
					overAll.setSystemScore(obj3[0] != null ? obj3[0] + "" : "");
					overAll.setBeginThreshold(obj3[1] != null ? obj3[1] + "" : "");
					overAll.setEndThreshold(obj3[2] != null ? obj3[2] + "" : "");
					overAll.setSystemColorCode(obj3[3] != null ? obj3[3] + "" : "");
					result3.set(z, overAll);
				} 
		    }catch (Exception e) {
				// TODO: handle exception
		    	e.printStackTrace();
			}
		    tree.setOverAllDTO(result3);*/
			result.set(j, tree);
		} 
		return result;
	}

	@Override
	public KpiDetailDTO getKPIDetailProc(int year,
			int month, String ownerCode, String kpiCode) {
		// TODO Auto-generated method stub
		
				String sql = "call Proc_KpiDetail("+year+","+month+",'"+ownerCode+"','"+kpiCode+"') ";
				SQLQuery query = this.sessionAnnotationFactory.getCurrentSession()
						.createSQLQuery(sql);
				List list = query.list();
				int size = list.size();
				String kpiName="";
				String objective="";
				String formulaDesc="";
				String kpiDesc="";
				String uom="";
				String dataSource="";
				String targetRangeDesc="";
				String lastRevisedDT="";
				for (int j = 0; j < size; j++) {
					Object[] obj = (Object[]) list.get(j);
					kpiName=(obj[0] != null ? obj[0]+"": null);
					objective=(obj[1] != null ? obj[1]+"": null);
					formulaDesc=(obj[2] != null ? obj[2]+"": null);
					kpiDesc=(obj[3] != null ? obj[3]+"": null);
					uom=(obj[4] != null ? obj[4]+"": null);
					dataSource=(obj[5] != null ? obj[5]+"": null);
					targetRangeDesc=(obj[6] != null ? obj[6]+"": null);
					lastRevisedDT=(obj[7] != null ? obj[7]+"": null);
				}
				return new KpiDetailDTO(kpiName, objective, formulaDesc, kpiDesc, uom, dataSource, targetRangeDesc, lastRevisedDT);  
	}

	@Override
	public List getKPIListAndChartRecursiveProc(List results, Integer year,
			int month, int KPIOwnerKey, String parentKpiKey) {
		// TODO Auto-generated method stub
		Session session = this.sessionAnnotationFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("CALL Proc_KpiListChild("
				+ year.intValue() + "," + month + "," + KPIOwnerKey+ ",'" + parentKpiKey
				+ "')");
		List result = query.list();
		int size = result.size();
		/*call Proc_KpiListChild(2011,3,1,'c3')
        call Proc_TrendChartChild(2011,3,1,'c3')*/
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) result.get(j);
			 
			KpiresultthresholdTreeDTO tree = new KpiresultthresholdTreeDTO();
			tree.setChildOf(parentKpiKey + "");
			tree.setKpiCode(obj[0] != null ? obj[0]+"": null);
			tree.setKpiName(obj[1] != null ? obj[1]+"": null);
			tree.setOwnerWeighting(obj[2] != null ? obj[2]+"": null);
			tree.setPerspectiveWeighting(obj[3] != null ? obj[3]+"": null);
			tree.setFrequency(obj[4] != null ? obj[4]+"": null);
			tree.setTargetValue(obj[5] != null ? obj[5]+"": null);
			tree.setActualValue(obj[6] != null ? obj[6]+"": null);
			tree.setPercentActualVsTarget(obj[7] != null ? obj[7]+"": null);
			tree.setSystemScore(obj[8] != null ? obj[8]+"": null);
			tree.setSystemColorCode(obj[9] != null ? obj[9]+"": null);
			tree.setUpdatedDT(obj[10] != null ? obj[10]+"": null);
			tree.setAccumulatedFlag(obj[11] != null ? obj[11]+"": null) ;
			SQLQuery query2 = session.createSQLQuery("CALL Proc_TrendChartChild("
					+ year.intValue() + "," + month + "," + KPIOwnerKey+ ",'" + parentKpiKey
					+ "')");
			List result2 = query2.list();
			int size_inner=result2.size();
			List<TrendChart> trends=new ArrayList<TrendChart>(size_inner);
			for (int i = 0; i <size_inner; i++) {
				Object[] obj2 = (Object[]) result2.get(i);
				TrendChart trend=new TrendChart();
				trend.setJan(obj2[1]+"");
				trend.setFeb(obj2[2]+"");
				trend.setMar(obj2[3]+"");
				trend.setApr(obj2[4]+"");
				trend.setMay(obj2[5]+"");
				trend.setJun(obj2[6]+"");
				trend.setJul(obj2[7]+"");
				trend.setAug(obj2[8]+"");
				trend.setSep(obj2[9]+"");
				trend.setOct(obj2[10]+"");
				trend.setNov(obj2[11]+"");
				trend.setDec(obj2[12]+"");
				trends.add(trend);
			}
			tree.setTrendChart(trends);
			//result.set(j, tree);
			results.add(tree);
			// return null;
			results = getKPIListAndChartRecursiveProc(results, year, month,
					KPIOwnerKey,tree.getKpiCode());
		} 
		return results;
	}

	@Override
	public List<KPIChart> getKPIChartProc(Integer year, int month,String bscOwner,
			String kpicode, String accumulatedFlag) {
		// TODO Auto-generated method stub
		//call Proc_KpiChart(2011,3,1,'c1')
		List result=null;
	    try{
			Session session = this.sessionAnnotationFactory.getCurrentSession(); 
			SQLQuery query = session.createSQLQuery("{CALL Proc_KpiChart("+ year.intValue() + "," + month+"," + bscOwner+",'" + kpicode+"')}");
			System.out.println("into getKPIChartProc");
			//query.uniqueResult(); 
			result= query.list();
			 int size = result.size();
			for (int j = 0; j < size; j++) {
				Object[] obj = (Object[]) result.get(j);
				 
				KPIChart chart = new KPIChart();
				chart.setMonthNo(obj[0] != null ? new Integer(obj[0] + "") : null);
				chart.setMonthName(obj[1] != null ? obj[1] + "" : "");
				chart.setActualValue(obj[2] != null ? new BigDecimal(obj[2] + "") :null);
				chart.setTargetValue(obj[3] != null ? new BigDecimal(obj[3] + "") :null);
				chart.setAccumActualValue(obj[4] != null ? new BigDecimal(obj[4] + "") : null);
				chart.setLastYearActual(obj[5] != null ?new BigDecimal( obj[5] + "" ): null);
				result.set(j, chart);
			} 
	    }catch (Exception e) {
			// TODO: handle exception
	    	e.printStackTrace();
		}
			return result;
		}
	 

	@Override
	public List<OverAllDTO> getKPIPerspectiveScoreProc(Integer year, int month,
			int kpiOwenerKey, int perspectiveKey) {
		// TODO Auto-generated method stub
		List result=new ArrayList<OverAllDTO>(1);
		String systemScore="";  
		String percentActualVsTarget="";
		//call Proc_PerspectiveScore(2011,3,1,1)
    try{
		Session session = this.sessionAnnotationFactory.getCurrentSession();
		SQLQuery query = session.createSQLQuery("{CALL Proc_PerspectiveScore("+ year.intValue() + "," + month + "," + kpiOwenerKey+ "," + perspectiveKey+ ")}");
		System.out.println("into getKPIOverallProc");
		//query.uniqueResult(); 
		List resultSet= query.list();
		 int size = resultSet.size();
		for (int j = 0; j < size; j++) {
			Object[] obj = (Object[]) resultSet.get(j); 
			percentActualVsTarget=(obj[0] != null ? obj[0] + "" : "");
			systemScore=(obj[1] != null ? obj[1] + "" : "");
			//result.set(j, overAll);
		} 
		 
		OverAllDTO overAll = new OverAllDTO();
		overAll.setSystemScore(systemScore);
		overAll.setPercentActualVsTarget(percentActualVsTarget);
		result.add(overAll);
    }catch (Exception e) {
		// TODO: handle exception
    	e.printStackTrace();
	}
		return result;
	}

	@Override
	public List<OverAllDTO> getKPIPerspectiveProc(Integer year,
			int kpiOwenerKey, int perspectiveKey) {
		// TODO Auto-generated method stub
		//call Proc_PerspectiveScale(2011,1,1)
		List result=null;
	    try{
			Session session = this.sessionAnnotationFactory.getCurrentSession(); 
			SQLQuery query = session.createSQLQuery("{CALL Proc_PerspectiveScale("+ year.intValue() + "," + kpiOwenerKey+ "," + perspectiveKey+ ")}");
			System.out.println("into getKPIPerspectiveProc");
			//query.uniqueResult(); 
			result= query.list();
			 int size = result.size();
			for (int j = 0; j < size; j++) {
				Object[] obj = (Object[]) result.get(j);
					OverAllDTO overAll = new OverAllDTO();
				overAll.setSystemScore(obj[0] != null ? obj[0] + "" : "");
				overAll.setBeginThreshold(obj[1] != null ? obj[1] + "" : "");
				overAll.setEndThreshold(obj[2] != null ? obj[2] + "" : "");
				overAll.setSystemColorCode(obj[3] != null ? obj[3] + "" : "");
				result.set(j, overAll);
			} 
			//System.out.println("data return="+result);
	    }catch (Exception e) {
			// TODO: handle exception
	    	e.printStackTrace();
		}
			return result;
	}
}
