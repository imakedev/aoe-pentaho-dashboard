package com.moogle.lbs.operationdashboard.service.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.moogle.lbs.operationdashboard.service.OperationDashboardProcService;

/**
 * @author Chatchai Pimtun
 */
@Repository
@Transactional
public class OperationDashboardProcServiceImpl implements OperationDashboardProcService{

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
		public List<String[]> callPROC(String query) { 
			//String sql="{CALL proc_op_listSections(null)}";
		//	System.out.println("query is  ==> "+query); 
			List <String[]> result=null;
			try{
				System.out.println(" query="+query);
				result=this.sessionAnnotationFactoryOP.getCurrentSession().createSQLQuery(query).list();
			}catch(Exception e){
				e.printStackTrace();
			}
			return result;
	   }
}
