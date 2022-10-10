package com.minhyuk.common.to;

import com.minhyuk.common.annotation.Dataset;

@Dataset(name="dsQuery")
public class QueryBean extends BaseBean{
	String Query1, Query2, Query3, Query4, Query5, Query6;

	public String getQuery1() {
		return Query1;
	}

	public void setQuery1(String query1) {
		Query1 = query1;
	}

	public String getQuery2() {
		return Query2;
	}

	public void setQuery2(String query2) {
		Query2 = query2;
	}

	public String getQuery3() {
		return Query3;
	}

	public void setQuery3(String query3) {
		Query3 = query3;
	}

	public String getQuery4() {
		return Query4;
	}

	public void setQuery4(String query4) {
		Query4 = query4;
	}

	public String getQuery5() {
		return Query5;
	}

	public void setQuery5(String query5) {
		Query5 = query5;
	}

	public String getQuery6() {
		return Query6;
	}

	public void setQuery6(String query6) {
		Query6 = query6;
	}

}
