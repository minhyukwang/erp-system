package com.minhyuk.accounting.slip.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.minhyuk.accounting.slip.to.CreditorBalanceBean;
import com.minhyuk.accounting.slip.to.DebtorBalanceBean;
import com.minhyuk.accounting.slip.to.FormerIncomeBean;
import com.minhyuk.accounting.slip.to.FormerStatementPositionBean;
import com.minhyuk.accounting.slip.to.IncomeStatementBean;
import com.minhyuk.accounting.slip.to.JournalListBean;
import com.minhyuk.accounting.slip.to.SlipBean;
import com.minhyuk.accounting.slip.to.StatementPositionBean;

public interface SlipServiceFacade {

	public List<SlipBean> getSlipList(HashMap<String, Object> slipMap);
	public <T> void batchSlipList(Map<String, Object> batchSlipList);
	public List<CreditorBalanceBean> getCreditorList(HashMap<String, Object> creditorMap);
	public List<DebtorBalanceBean> getDebtorList(HashMap<String, Object> debtorMap);

	public List<IncomeStatementBean> getIncomeList(HashMap<String, Object> incomeMap);
	public List<FormerIncomeBean> getFormerIncomeList(String year);

	public List<StatementPositionBean> getStatementList(HashMap<String, Object> statementMap);
	public List<FormerStatementPositionBean> getFormerStatementList(String year);

	public <T> void batchIncomeList(Map<String, Object> batchIncomeMap);
	public <T> void batchStatementPositionList(Map<String, Object> batchStatementMap);

	public List<JournalListBean> getJournalList(HashMap<String, Object> journalListMap);

}
