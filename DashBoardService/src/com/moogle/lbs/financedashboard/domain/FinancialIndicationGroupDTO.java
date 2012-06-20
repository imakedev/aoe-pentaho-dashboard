package com.moogle.lbs.financedashboard.domain;

import java.io.Serializable;
import java.util.List;

public class FinancialIndicationGroupDTO  implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String ratioGroupName;
	private List<FinancialIndicationDTO> financialIndicationDTO;
	public String getRatioGroupName() {
		return ratioGroupName;
	}
	public void setRatioGroupName(String ratioGroupName) {
		this.ratioGroupName = ratioGroupName;
	}
	public List<FinancialIndicationDTO> getFinancialIndicationDTO() {
		return financialIndicationDTO;
	}
	public void setFinancialIndicationDTO(
			List<FinancialIndicationDTO> financialIndicationDTO) {
		this.financialIndicationDTO = financialIndicationDTO;
	}
	

}
