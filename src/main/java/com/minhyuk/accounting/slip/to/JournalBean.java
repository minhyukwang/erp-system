package com.minhyuk.accounting.slip.to;

import java.util.List;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.annotation.Remove;
import com.minhyuk.common.to.BaseBean;

@Dataset(name = "dsJournal")
public class JournalBean extends BaseBean {
	private String journalNo, slipNo, accountCode, journalType, customerCode, accountName, journalReceipt,
							customerName, journalAmt, summaryCode, summaryName;
	private List<JournalManagementBean> journalManagementBeanList;

	@Remove
	public List<JournalManagementBean> getJournalManagementBeanList() {
		return journalManagementBeanList;
	}

	@Remove
	public void setJournalManagementBeanList(List<JournalManagementBean> journalManagementBeanList) {
		this.journalManagementBeanList = journalManagementBeanList;
	}

	public String getJournalNo() {
		return journalNo;
	}

	public void setJournalNo(String journalNo) {
		this.journalNo = journalNo;
	}

	public String getSlipNo() {
		return slipNo;
	}

	public void setSlipNo(String slipNo) {
		this.slipNo = slipNo;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getJournalType() {
		return journalType;
	}

	public void setJournalType(String journalType) {
		this.journalType = journalType;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getJournalReceipt() {
		return journalReceipt;
	}

	public void setJournalReceipt(String journalReceipt) {
		this.journalReceipt = journalReceipt;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getJournalAmt() {
		return journalAmt;
	}

	public void setJournalAmt(String journalAmt) {
		this.journalAmt = journalAmt;
	}

	public String getSummaryCode() {
		return summaryCode;
	}

	public void setSummaryCode(String summaryCode) {
		this.summaryCode = summaryCode;
	}

	public String getSummaryName() {
		return summaryName;
	}

	public void setSummaryName(String summaryName) {
		this.summaryName = summaryName;
	}

}
