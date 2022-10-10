package com.minhyuk.accounting.slip.as;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.minhyuk.accounting.slip.dao.JournalDAO;
import com.minhyuk.accounting.slip.dao.JournalManagementDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.minhyuk.accounting.slip.dao.SettlementDAO;
import com.minhyuk.accounting.slip.dao.SlipDAO;
import com.minhyuk.accounting.slip.to.CreditorBalanceBean;
import com.minhyuk.accounting.slip.to.DebtorBalanceBean;
import com.minhyuk.accounting.slip.to.FormerIncomeBean;
import com.minhyuk.accounting.slip.to.FormerStatementPositionBean;
import com.minhyuk.accounting.slip.to.IncomeStatementBean;
import com.minhyuk.accounting.slip.to.JournalBean;
import com.minhyuk.accounting.slip.to.JournalListBean;
import com.minhyuk.accounting.slip.to.JournalManagementBean;
import com.minhyuk.accounting.slip.to.SlipBean;
import com.minhyuk.accounting.slip.to.StatementPositionBean;
import com.minhyuk.accounting.slip.to.TotalIncomeBean;
import com.minhyuk.accounting.slip.to.TotalStatementBean;

@Component
public class SlipApplicationServiceImpl implements SlipApplicationService {
	@Autowired
	SlipDAO slipDAO;
	@Autowired
    JournalDAO journalDAO;
	@Autowired
    JournalManagementDAO journalManagementDAO;
	@Autowired
	SettlementDAO settlementDAO;


	@Override
	public List<SlipBean> getSlipList(HashMap<String, Object> slipmap) {
		return slipDAO.selectSlipList(slipmap);
	}

	@Override
	public List<CreditorBalanceBean> getCreditorList(HashMap<String, Object> creditorMap) {
		return settlementDAO.selectCreditorList(creditorMap);
	}

	@Override
	public List<DebtorBalanceBean> getDebtorList(HashMap<String, Object> debtorMap) {
		return settlementDAO.selectDebtorList(debtorMap);
	}

	@Override
	public List<IncomeStatementBean> getIncomeList(HashMap<String, Object> incomeMap) {
		return settlementDAO.selectIncomeList(incomeMap);
	}

	@Override
	public List<FormerIncomeBean> getFormerIncomeList(String year) {
		return settlementDAO.selectFormerIncomeList(year);
	}

	@Override
	public List<StatementPositionBean> getStatementList(HashMap<String, Object> statementMap) {
		return settlementDAO.selectStatementList(statementMap);
	}

	@Override
	public List<FormerStatementPositionBean> getFormerStatementList(String year) {
		return settlementDAO.selectFormerStatementList(year);
	}

	@SuppressWarnings("unchecked")
	@Override
	public <T> void batchSlipList(Map<String, Object> batchSlipList) {
		List<SlipBean> slipList = (List<SlipBean>) batchSlipList.get("slipList");
		List<JournalBean> journalList = (List<JournalBean>) batchSlipList.get("journalList");
		List<JournalManagementBean> journalmanagementList = (List<JournalManagementBean>) batchSlipList.get("journalmanagementList");

		for(SlipBean slipBean:slipList){
			if(slipBean.getStatus().equals("inserted")){
				slipDAO.insertSlip(slipBean);
			}else if(slipBean.getStatus().equals("updated")){
				slipDAO.updateSlip(slipBean);
			}else{
				slipDAO.deleteSlip(slipBean);
			}
		}
		for(JournalBean journalBean:journalList){
			if(journalBean.getStatus().equals("inserted")){
				journalDAO.insertJournal(journalBean);
			}else if(journalBean.getStatus().equals("updated")){
				journalDAO.updateJournal(journalBean);
			}else{
				journalDAO.deleteJournal(journalBean);
			}
		}
		for(JournalManagementBean journalManagementBean:journalmanagementList){
			if(journalManagementBean.getStatus().equals("inserted")){
				journalManagementDAO.insertJournalManagement(journalManagementBean);
			}else if(journalManagementBean.getStatus().equals("updated")){
				journalManagementDAO.updateJournalManagement(journalManagementBean);
			}else{
				journalManagementDAO.deleteJournalManagement(journalManagementBean);
			}
		}
	}

	@SuppressWarnings("unchecked")
	public <T> void batchIncomeList(Map<String, Object> batchIncomeMap) {
		List<IncomeStatementBean> incomeStateBeanList = (List<IncomeStatementBean>) batchIncomeMap.get("incomeStateBeanList");
		List<TotalIncomeBean> totalIncomeBeanList = (List<TotalIncomeBean>) batchIncomeMap.get("totalIncomeBeanList");

		for(TotalIncomeBean totalIncomeBean:totalIncomeBeanList){
			switch(totalIncomeBean.getStatus()){
			case "insert":settlementDAO.insertTotalIncome(totalIncomeBean);break;
			}
		}
		for(IncomeStatementBean incomeStateBean:incomeStateBeanList){
				switch(incomeStateBean.getStatus()){
				case "normal":settlementDAO.insertIncomeStatement(incomeStateBean);break;
			}
		}

	}

	@SuppressWarnings("unchecked")
	public <T> void batchStatementPositionList(Map<String, Object> batchStatementMap) {
		List<StatementPositionBean> statementPositionBeanList = (List<StatementPositionBean>) batchStatementMap.get("statementPositionBeanList");
		List<TotalStatementBean> totalStatementBeanList = (List<TotalStatementBean>) batchStatementMap.get("totalStatementBeanList");

		for(TotalStatementBean totalStatementBean:totalStatementBeanList){
			switch(totalStatementBean.getStatus()){
			case "insert":settlementDAO.insertTotalStatement(totalStatementBean);break;
			}
		}
		for(StatementPositionBean statementPositionBean:statementPositionBeanList){
				switch(statementPositionBean.getStatus()){
				case "normal":settlementDAO.insertStatementPosition(statementPositionBean);break;
			}
		}

	}

	@Override
	public List<JournalListBean> getJournalList(HashMap<String, Object> journalListMap) {
		return journalDAO.selectJournalList(journalListMap);
	}

}
