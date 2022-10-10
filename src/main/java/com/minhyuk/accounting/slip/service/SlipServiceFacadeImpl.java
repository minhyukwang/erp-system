package com.minhyuk.accounting.slip.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.minhyuk.accounting.slip.as.SlipApplicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.minhyuk.accounting.slip.to.CreditorBalanceBean;
import com.minhyuk.accounting.slip.to.DebtorBalanceBean;
import com.minhyuk.accounting.slip.to.FormerIncomeBean;
import com.minhyuk.accounting.slip.to.FormerStatementPositionBean;
import com.minhyuk.accounting.slip.to.IncomeStatementBean;
import com.minhyuk.accounting.slip.to.JournalListBean;
import com.minhyuk.accounting.slip.to.SlipBean;
import com.minhyuk.accounting.slip.to.StatementPositionBean;

@Service
public class SlipServiceFacadeImpl implements SlipServiceFacade {
	@Autowired
    SlipApplicationService slipApplicationService;

	@Override
	public List<SlipBean> getSlipList(HashMap<String, Object> slipMap) {
		return slipApplicationService.getSlipList(slipMap);
	}

	@Override
	public List<CreditorBalanceBean> getCreditorList(HashMap<String, Object> creditorMap) {
		return slipApplicationService.getCreditorList(creditorMap);
	}

	@Override
	public List<DebtorBalanceBean> getDebtorList(HashMap<String, Object> debtorMap) {
		return slipApplicationService.getDebtorList(debtorMap);
	}

	@Override
	public List<IncomeStatementBean> getIncomeList(HashMap<String, Object> incomeMap) {
		return slipApplicationService.getIncomeList(incomeMap);
	}

	@Override
	public List<FormerIncomeBean> getFormerIncomeList(String year) {
		return slipApplicationService.getFormerIncomeList(year);
	}

	@Override
	public List<StatementPositionBean> getStatementList(HashMap<String, Object> statementMap) {
		return slipApplicationService.getStatementList(statementMap);
	}

	@Override
	public List<FormerStatementPositionBean> getFormerStatementList(String year) {
		return slipApplicationService.getFormerStatementList(year);
	}

	@Override
	public <T> void batchSlipList(Map<String, Object> batchSlipList) {
		slipApplicationService.batchSlipList(batchSlipList);
	}

	@Override
	public <T> void batchIncomeList(Map<String, Object> batchIncomeMap) {
		slipApplicationService.batchIncomeList(batchIncomeMap);
	}

	@Override
	public <T> void batchStatementPositionList(Map<String, Object> batchStatementMap) {
		slipApplicationService.batchStatementPositionList(batchStatementMap);
	}

	@Override
	public List<JournalListBean> getJournalList(HashMap<String, Object> journalListMap) {
		return slipApplicationService.getJournalList(journalListMap);
	}

}
