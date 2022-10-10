package com.minhyuk.accounting.slip.to;

import java.util.List;

import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.annotation.Remove;
import com.minhyuk.common.to.BaseBean;

@Dataset(name="dsSlip")
public class SlipBean extends BaseBean{
	private String slipNo, empNo, slipBallotNo, slipSeq, slipDate, slipContent, slipStatus, approver,
							approvalDate, differenceAmt, slipWorker, slipType, slipDept;
	private List<JournalBean> journalBeanList;

	@Remove
	public List<JournalBean> getJournalBeanList() {
		return journalBeanList;
	}

	@Remove
	public void setJournalBeanList(List<JournalBean> journalBeanList) {
		this.journalBeanList = journalBeanList;
	}

	public String getSlipNo() {
		return slipNo;
	}

	public void setSlipNo(String slipNo) {
		this.slipNo = slipNo;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getSlipBallotNo() {
		return slipBallotNo;
	}

	public void setSlipBallotNo(String slipBallotNo) {
		this.slipBallotNo = slipBallotNo;
	}

	//@Remove
	public String getSlipSeq() {
		return slipSeq;
	}

	//@Remove
	public void setSlipSeq(String slipSeq) {
		this.slipSeq = slipSeq;
	}

	public String getSlipDate() {
		return slipDate;
	}

	public void setSlipDate(String slipDate) {
		this.slipDate = slipDate;
	}

	public String getSlipContent() {
		return slipContent;
	}

	public void setSlipContent(String slipContent) {
		this.slipContent = slipContent;
	}

	public String getSlipStatus() {
		return slipStatus;
	}

	public void setSlipStatus(String slipStatus) {
		this.slipStatus = slipStatus;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

	public String getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}

	public String getDifferenceAmt() {
		return differenceAmt;
	}

	public void setDifferenceAmt(String differenceAmt) {
		this.differenceAmt = differenceAmt;
	}

	public String getSlipWorker() {
		return slipWorker;
	}

	public void setSlipWorker(String slipWorker) {
		this.slipWorker = slipWorker;
	}

	public String getSlipType() {
		return slipType;
	}

	public void setSlipType(String slipType) {
		this.slipType = slipType;
	}

	public String getSlipDept() {
		return slipDept;
	}

	public void setSlipDept(String slipDept) {
		this.slipDept = slipDept;
	}

}
