package com.minhyuk.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.nexacro.xapi.data.Debugger;
import com.nexacro.xapi.data.PlatformData;
import com.nexacro.xapi.data.VariableList;
import com.nexacro.xapi.tx.HttpPlatformRequest;
import com.nexacro.xapi.tx.HttpPlatformResponse;
import com.nexacro.xapi.tx.PlatformType;



public class NexacroInterceptor extends HandlerInterceptorAdapter {
	private Debugger debugger;
	static final String[] EXCLUDE_URL_LIST = {
		  "/base/getEmpPdf.do" };



    //�������
	/*
     * postHandle �������� ���� , ���������� ����� 3�� (������ �߻��Ǵ��� ����ȴ�.)
     * ex <-- ������ �߻����� ���� ��� null ������ �߻��Ұ�� exception�� �޾ƿ´�.
     * */
    @Override
    public void afterCompletion(HttpServletRequest request,
          HttpServletResponse response, Object handler, Exception ex)
          throws Exception {
       // TODO Auto-generated method stub
      PlatformData outData = (PlatformData) request.getAttribute("outData");
      VariableList variableList = outData.getVariableList();

       if(ex!=null){
          ex.printStackTrace();
          variableList.add("ErrorCode", -1);
          variableList.add("ErrorMsg", ex.getMessage());
       }
       HttpPlatformResponse httpPlatformResponse = new HttpPlatformResponse(response, PlatformType.CONTENT_TYPE_XML, "UTF-8");
       System.out.println(outData.getDataSetList().size());


      httpPlatformResponse.setData(outData);
   //   if(outData.getDataSetList().size()!=0)
      httpPlatformResponse.sendData();


       //debug - out dataset
       System.out.println("================================================================="+outData.getDataSetList().size());
       for(int n=0; n<outData.getDataSetList().size(); n++) {
          System.out.println(debugger.detail(outData.getDataSet(n)));
       }
       //debug - out variable
       for(int n=0; n<outData.getVariableList().size(); n++) {
          System.out.println(debugger.detail(outData.getVariable(n)));
       }

       outData = null;
       super.afterCompletion(request, response, handler, ex);
    }
    //�� ��Ʈ�ѷ��� ����ǰ� ���ڿ� ����� 2�� (�����߻��� ����ȵ�)
    @Override
    public void postHandle(HttpServletRequest request,
          HttpServletResponse response, Object handler,
          ModelAndView modelAndView) throws Exception {
       // TODO Auto-generated method stub
       super.postHandle(request, response, handler, modelAndView);
    }

    //�� ��Ʈ�ѷ��� ����Ǳ� ������ ���� ���� ����� 1��
    @Override
    public boolean preHandle(HttpServletRequest request,
          HttpServletResponse response, Object handler) throws Exception {
       // TODO Auto-generated method stub
       debugger = new Debugger();
       HttpPlatformRequest httpPlatformRequest = new HttpPlatformRequest(request);
       httpPlatformRequest.receiveData();

       PlatformData inData = httpPlatformRequest.getData();
       PlatformData outData = new PlatformData();

       //debug - in dataset
       for(int n=0; n<inData.getDataSetList().size(); n++) {
          System.out.println(debugger.detail(inData.getDataSet(n)));
       }
       //debug - in variable
       for(int n=0; n<inData.getVariableList().size(); n++) {
          System.out.println(debugger.detail(inData.getVariable(n)));
       }

       request.setAttribute("inData", inData);
       request.setAttribute("outData",outData);

       return true;
    }
}