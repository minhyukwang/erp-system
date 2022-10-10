package com.minhyuk.accounting.slip.dao;

import java.util.HashMap;
import java.util.List;

import com.minhyuk.accounting.slip.to.JournalBean;
import com.minhyuk.accounting.slip.to.JournalListBean;

public interface JournalDAO {

	//public List<JournalListBean> getJournalList(HashMap<String, Object> journalmap);

	public void insertJournal(JournalBean journalBean);
	public void updateJournal(JournalBean journalBean);
	public void deleteJournal(JournalBean journalBean);

	public List<JournalListBean> selectJournalList(HashMap<String, Object> journalListMap);

}
