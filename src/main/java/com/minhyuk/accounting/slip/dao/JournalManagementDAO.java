package com.minhyuk.accounting.slip.dao;

import com.minhyuk.accounting.slip.to.JournalManagementBean;

public interface JournalManagementDAO {

	public void insertJournalManagement(JournalManagementBean journalManagementBean);
	public void updateJournalManagement(JournalManagementBean journalManagementBean);
	public void deleteJournalManagement(JournalManagementBean journalManagementBean);

}
