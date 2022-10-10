package com.minhyuk.accounting.slip.to;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.to.BaseBean;

@Dataset(name = "dsJournalList")
public class JournalListBean extends BaseBean {
	private String slipDate, journalType, accountCode, accountName, journalAmt,
							summaryName, customerCode, customerName, debtor, creditor, slipType, slipStatus;

	public String getDebtor() {
		return debtor;
	}

	public void setDebtor(String debtor) {
		this.debtor = debtor;
	}

	public String getCreditor() {
		return creditor;
	}

	public void setCreditor(String creditor) {
		this.creditor = creditor;
	}

	public String getSlipDate() {
		return slipDate;
	}

	public void setSlipDate(String slipDate) {
		this.slipDate = slipDate;
	}

	public String getSlipType() {
		return slipType;
	}

	public void setSlipType(String slipType) {
		this.slipType = slipType;
	}

	public String getSlipStatus() {
		return slipStatus;
	}

	public void setSlipStatus(String slipStatus) {
		this.slipStatus = slipStatus;
	}

	public String getJournalType() {
		return journalType;
	}

	public void setJournalType(String journalType) {
		this.journalType = journalType;
	}

	public String getAccountCode() {
		return accountCode;
	}

	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getJournalAmt() {
		return journalAmt;
	}

	public void setJournalAmt(String journalAmt) {
		this.journalAmt = journalAmt;
	}

	public String getSummaryName() {
		return summaryName;
	}

	public void setSummaryName(String summaryName) {
		this.summaryName = summaryName;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}



}
