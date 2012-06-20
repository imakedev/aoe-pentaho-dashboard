package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;
import java.util.List;

public class FinancialPopup1GroupDTO implements Serializable {
	/**
	 *  
	 */
	private static final long serialVersionUID = 1L;
	private String groupName;
	private List<FinancialPopup1DTO> financialPopup1DTO;
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public List<FinancialPopup1DTO> getFinancialPopup1DTO() {
		return financialPopup1DTO;
	}
	public void setFinancialPopup1DTO(List<FinancialPopup1DTO> financialPopup1DTO) {
		this.financialPopup1DTO = financialPopup1DTO;
	}
	 
	

}
