package com.minhyuk.accounting.slip.dao;

import java.util.HashMap;
import java.util.List;

import com.minhyuk.accounting.slip.to.CreditorBalanceBean;
import com.minhyuk.accounting.slip.to.DebtorBalanceBean;
import com.minhyuk.accounting.slip.to.FormerIncomeBean;
import com.minhyuk.accounting.slip.to.FormerStatementPositionBean;
import com.minhyuk.accounting.slip.to.IncomeStatementBean;
import com.minhyuk.accounting.slip.to.StatementPositionBean;
import com.minhyuk.accounting.slip.to.TotalIncomeBean;
import com.minhyuk.accounting.slip.to.TotalStatementBean;

public interface SettlementDAO {

	public List<CreditorBalanceBean> selectCreditorList(HashMap<String, Object> creditorMap);
	public List<DebtorBalanceBean> selectDebtorList(HashMap<String, Object> debtorMap);

	public List<IncomeStatementBean> selectIncomeList(HashMap<String, Object> incomeMap);
	public List<FormerIncomeBean> selectFormerIncomeList(String year);

	public List<StatementPositionBean> selectStatementList(HashMap<String, Object> statementMap);
	public List<FormerStatementPositionBean> selectFormerStatementList(String year);

	public void insertIncomeStatement(IncomeStatementBean incomeStatementBean);
	public void insertTotalIncome(TotalIncomeBean totalIncomeBean);

	public void insertStatementPosition(StatementPositionBean statementPositionBean);
	public void insertTotalStatement(TotalStatementBean totalStatementBean);

}
