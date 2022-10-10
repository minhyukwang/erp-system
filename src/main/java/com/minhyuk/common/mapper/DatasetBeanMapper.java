package com.minhyuk.common.mapper;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.minhyuk.common.annotation.Column;
import com.minhyuk.common.annotation.Dataset;
import com.minhyuk.common.annotation.Remove;
import org.springframework.stereotype.Component;

import com.nexacro.xapi.data.DataSet;
import com.nexacro.xapi.data.DataSetList;
import com.nexacro.xapi.data.PlatformData;

@SuppressWarnings("rawtypes")
@Component
public class DatasetBeanMapper<T> {

   private String getDataSetName(Class classType) {

      String dataSetName = null;
      Annotation[] annotations = classType.getAnnotations();

      for (Annotation annotation : annotations) {
         if (annotation instanceof Dataset)
            dataSetName = ((Dataset) annotation).name();
      }

      return dataSetName;
   }

   private String getColumnName(Method method) {
      String columnName = null;
      Annotation[] annotations = method.getAnnotations();
      for (Annotation annotation : annotations) {
         if (annotation instanceof Column) {
            String annoValue = ((Column) annotation).name();
            columnName = annoValue;
         }

      }

      if (annotations.length == 0)
         columnName = formattingToSnake(method.getName());// m.getName()으로
                                                // 칼럼명을 만든다.

      return columnName;
   }

   private void setColumnName(DataSet dataSet, Method method,
         Map<String, String> nameMapper) {

      if (method.getName().startsWith("get")) {
         Column column = method.getAnnotation(Column.class);
         Remove remove = method.getAnnotation(Remove.class);

         if (column != null) {
            dataSet.addColumn(column.name(), 0, 100);
            nameMapper.put(column.name(), method.getName());
         } else if (column == null && remove == null) {
            String columnName = formattingToSnake(method.getName());

            dataSet.addColumn(columnName, 0, 100);
            nameMapper.put(columnName, method.getName());
         }
      }
   }

   private void setColumn(DataSet dataSet, Map<String, String> nameMapper,
         Object bean) throws Exception {

      int rowIndex = dataSet.newRow();

      for (String columnName : nameMapper.keySet()) {
         String methodName = nameMapper.get(columnName);

         Method method = bean.getClass().getDeclaredMethod(methodName, null);
         // 메서드명
         String value = (String) method.invoke(bean, null);
         dataSet.set(rowIndex, columnName, value);
      }

   }

   private Object setBean(DataSet dataSet, Class classType, int rowIndex)
         throws Exception {
      Object bean = classType.newInstance();
      Method[] methods = classType.getDeclaredMethods();
      Method statusSetMethod = classType.getMethod("setStatus", String.class);
      System.out.println(dataSet.getRowTypeName(rowIndex));

      statusSetMethod.invoke(bean, dataSet.getRowTypeName(rowIndex));

      for (Method method : methods) {
         if (method.getName().startsWith("set")) {

            String columnName = getColumnName(method);

            if (columnName != null) {

               Object columnValue = dataSet.getObject(rowIndex, columnName);
               if (columnValue != null)
                  method.invoke(bean, columnValue.toString());
            }

         }

      }

      return bean;
   }

   private Object setDeleteBean(DataSet dataSet, Class classType, int rowIndex)
         throws Exception {
      Object bean = classType.newInstance();
      Method[] methods = classType.getDeclaredMethods();

      Method statusSetMethod = classType.getMethod("setStatus", String.class);
      statusSetMethod.invoke(bean, "deleted");

      for (Method method : methods) {
         if (method.getName().startsWith("set")) {

            String columnName = getColumnName(method);
            if (columnName != null) {
               Object columnValue = dataSet.getRemovedData(rowIndex,
                     columnName);
               if (columnValue != null)
                  method.invoke(bean, columnValue.toString());
            }

         }

      }
      return bean;
   }

   public List<T> datasetToBeans(PlatformData inData, Class classType)
         throws Exception {
      List<T> beanList = null;
      String dataSetName = getDataSetName(classType);
      System.out.println("getDataSetCount : " + inData.getDataSetCount());
      DataSet dataSet = inData.getDataSet(dataSetName);

      if (dataSet != null) {
         Object bean = null;
         System.out.println("dataSetName : " + dataSetName);
         beanList = new ArrayList<T>();
         System.out.println("bbb");
         int rowCount = dataSet.getRowCount();
         System.out.println(dataSet.getRowCount());
         System.out.println("rowCount : " + rowCount);
         // status가 insert update인 로우 -> bean으로 변환
         for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
            System.out.println("ddd");
            bean = setBean(dataSet, classType, rowIndex);
            System.out.println("eee");
            beanList.add((T) bean);
         }

         rowCount = dataSet.getRemovedRowCount();

         for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
            bean = setDeleteBean(dataSet, classType, rowIndex);
            beanList.add((T) bean);
         }

      }

      return beanList;

   }

   public Object dataSetToBean(PlatformData inData, Class classType)
         throws Exception {

      Object bean = null;

      String dataSetName = getDataSetName(classType);

      DataSet dataSet = inData.getDataSet(dataSetName);
      if (dataSet != null) {
         if (dataSet.getRemovedRowCount() == 0)
            bean = setBean(dataSet, classType, 0);
         else
            bean = setDeleteBean(dataSet, classType, 0);
      } else {
         return null;
      }
      return bean;
   }

   public void beansToDataset(PlatformData outData, List<?> beanList,
         Class classType) throws Exception {
      Map<String, String> nameMapper = new HashMap<String, String>();

      // 보낼 데이터셋 생성
      DataSetList dataSetList = outData.getDataSetList();

      String dataSetName = getDataSetName(classType);

      DataSet dataSet = new DataSet(dataSetName);

      dataSetList.add(dataSet);

      // 칼럼 생성 및 칼럼명과 메서드명 매칭
      Method[] methods = classType.getDeclaredMethods();
      for (Method method : methods)
         setColumnName(dataSet, method, nameMapper);

      // 빈에 있는 데이터를 칼럼으로 복사
      for (Object bean : beanList)
         setColumn(dataSet, nameMapper, bean);

   }

   public void beanToDataSet(PlatformData outData, Object bean, Class classType)
         throws Exception {
      Map<String, String> nameMapper = new HashMap<>();

      DataSetList dataSetList = outData.getDataSetList();

      String dataSetName = getDataSetName(classType);

      DataSet dataSet = new DataSet(dataSetName);

      dataSetList.add(dataSet);

      if (bean != null) {
         Method[] methods = classType.getDeclaredMethods();

         // 칼럼 생성 및 칼럼명과 메서드명 매칭
         for (Method method : methods)
            setColumnName(dataSet, method, nameMapper);
      }

      // 빈에 있는 데이터를 칼럼으로 복사
      setColumn(dataSet, nameMapper, bean);

   }

   private String formattingToSnake(String name) {
      String regex = "([a-z])([A-Z])";
      String replacement = "$1_$2";

      // set 또는 get 제거
      name = name.substring(3);
      // ..aA..bB.. -> ..a_A..b_B..
      name = name.replaceAll(regex, replacement);

      // ..A_A..B_B..
      return name.toLowerCase();
   }
}