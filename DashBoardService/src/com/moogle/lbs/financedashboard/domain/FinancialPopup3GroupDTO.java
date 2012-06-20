package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;
import java.util.List;

public class FinancialPopup3GroupDTO implements Serializable {
	/**
	 *  
	 */
	private static final long serialVersionUID = 1L;
	private String groupName;
	private List<FinancialPopup3DTO> financialPopup3DTO;
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public List<FinancialPopup3DTO> getFinancialPopup3DTO() {
		return financialPopup3DTO;
	}
	public void setFinancialPopup3DTO(List<FinancialPopup3DTO> financialPopup3DTO) {
		this.financialPopup3DTO = financialPopup3DTO;
	}
	

}
