
<%@page import="in.amitech.db.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;

%>
<%
            try {
				
				System.out.println("***********************Loading Multiple Graph Data Start*****************************************");
                String meter_id = "", sql = null, data = "";
                double mf = 1.0;
                String string_data="";
                String[] data_string2 = new String[0];
                String[] data_string = new String[0];
                String lsdate = request.getParameter("sdate");
                String ledate = request.getParameter("edate");

                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                    meter_id = (String) session.getAttribute("meter_id");
                } else {
                    meter_id = request.getParameter("meterid");
                }
                session.setAttribute("meter_id", meter_id);
                Connection con = new DBUtil().getConnection();
		System.out.println("*****************Getting d4 Params **************************");
                if(meter_id.equals("00"))
               {
                String header="Fwd.kVAh,Fwd.kWh,Fwd.kVArh Lag,Fwd.kVArh Lead,RV,YV,BV,RI,YI,VI";
                data_string2=header.split(",");
               }
               else{
                pstmt = con.prepareStatement("select * from d4_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=" + meter_id + ")");
			rs = pstmt.executeQuery();
			 if (rs.next()) {
				 System.out.println("---------------------------Load survay Header Got Dynamically-----------------------------------");
                 data_string2 = rs.getString("load_columns_header").split(",");
			 }else{
				 System.out.println("---------------------------Load survay Header Got Manually-----------------------------------");
                        pstmt = con.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
                        rs = pstmt.executeQuery();

                        if (rs.next()) 
                        {
                             data_string2 = rs.getString("d4_params").split(",");
						}//end if
			 }//end else
                        
                     }
				System.out.println("*****************default multiplication factor-------" + mf);
                pstmt = con.prepareStatement("select imf from meter where meterid=" + meter_id);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    mf = rs.getDouble("imf");
                }
                System.out.println("multiplication factor-------" + mf);
				

%>
<%
         if (!lsdate.equals("") && !ledate.equals("")) {
             //------------------------------
             int MILLIS_IN_DAY = 1000 * 60 * 60 * 24;
             SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
             java.util.Date edate;

             edate = (java.util.Date) dateFormat.parse(ledate);

             Calendar cal = Calendar.getInstance();
             cal.setTime(edate);
             cal.add(cal.DATE, 1);
             String afterDate = cal.get(cal.DATE) + "/" + (cal.get(cal.MONTH) + 1) + "/" + cal.get(cal.YEAR);
             System.out.println(" after one day is ----" + afterDate);
             // String nextDate =dateFormat.format(cal.getTime(edate)+ MILLIS_IN_DAY);
             //------------------------------
             if (DBUtil.getTargetDB().equals("oracle")) {
             sql = "select distinct d4_date, data_string,TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')>to_date('" + lsdate + " 00:00:00','dd/mm/yyyy hh24:mi:ss') and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')<=to_date('" + afterDate + " 00:00:00','dd/mm/yyyy hh24:mi:ss') and data_string is NOT NULL order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss'),TIME_DELAY  ";
             } else if (DBUtil.getTargetDB().equals("mysql")) {
                 sql="select distinct d4_date, data_string,TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and str_to_date(d4_date,'%d-%m-%Y')>str_to_date('" + lsdate + " 00:00:00','%d/%m/%Y %H:%i:%S') and str_to_date(d4_date,'%d-%m-%Y')<=str_to_date('" + afterDate + " 00:00:00','%d/%m/%Y %H:%i:%S') and data_string is NOT NULL order by d4_time_stamp,TIME_DELAY  ";
             }
         } else {
            
         }
         System.out.println(sql);
         pstmt = con.prepareStatement(sql);
         pstmt.setString(1, meter_id);
         rs = pstmt.executeQuery();


         String p[] = {"p1","p2","p3","p4","p5","p6","p7","p8","p9","p10"};
         String p2 = "p2";
         String p3 = "p3";
         String p4 = "p4";
         String p5 = "p5";
         String p6 = "p6";
         List totalData = new ArrayList();
         String prevDate = null;
         String d4Date = null;
         String params[] ={"","","","","","","","","",""};
         
         String paramVals[] = {"","","","","","","","","",""};
         

         int timeDelay = 0;
         boolean found = false;
         String dataSep = ",";
         int count=0;

         while (rs.next()) {
             string_data =rs.getString("data_string");
             timeDelay = rs.getInt("TIME_DELAY");
             if (prevDate == null) {
                 prevDate = rs.getString("d4_date").split(" ")[0];
                 for(int i=0;i<string_data.split(",").length;i++)
                     {
                 paramVals[i] = "0";
                 
                 }
                  count=0;
             }
             found = false;
             d4Date = rs.getString("d4_date").split(" ")[0];
             for(int i=0;i<string_data.split(",").length;i++)
                     {
             params[i] = "" + (Double.parseDouble(string_data.split(",")[i]) * mf);

             }if (prevDate.equals(d4Date)) {
                 //System.out.println(d4Date + ":" + timeDelay);
                for(int i=0;i<string_data.split(",").length;i++)
                     {
                 paramVals[i] = "" + (Double.parseDouble(paramVals[i]) + Double.parseDouble(params[i]));
                 
                 }
                 count++;

             } else {
                 //System.out.println("************New Date Found**************");
                 for(int i=0;i<string_data.split(",").length;i++)
                     {
                 paramVals[i] = "" + (Double.parseDouble(paramVals[i]) + Double.parseDouble(params[i]));

                 }
                 count++;
                 found = true;
                 for(int i=0;i<string_data.split(",").length;i++)
                     {
                 totalData.add(p[i] + dataSep + prevDate + dataSep + paramVals[i]+dataSep+count);
                 
                 }
                 //System.out.println(prevDate + ":" + timeDelay);
                 prevDate = rs.getString("d4_date").split(" ")[0];
                 for(int i=0;i<string_data.split(",").length;i++)
                     {
                 paramVals[i] = "0";

                 }
                 count=0;
             }//end else

         }//end while

         if (found == false) {
             for(int i=0;i<string_data.split(",").length;i++)
                     {
             totalData.add(p[i] + dataSep + prevDate + dataSep + paramVals[i]+dataSep+count);

             }
         }//end if


%>


<%
          //System.out.println("tatal Data is --->" + totalData);

          String str = null;
          String[] strArr = null;
          List dateLs = new ArrayList();
          String paramType=null;
          String paramsData[]={"","","","","","","","","",""};
          
          String paramVal="0";

          for (int i = 0; i < totalData.size(); i++) {
              str = (String) totalData.get(i);
              strArr = str.split(",");
              paramType="";
              paramVal="0";
              for (int j = 0; j < strArr.length; j++) {
                  //System.out.println(strArr[j]);
                  if (j== 0) {
                      paramType=strArr[j];
                  } else if (j == 1) {

                      if (!dateLs.contains(strArr[j])) {
                          dateLs.add(strArr[j]);
                      }
                  } else if (j == 2) {
                    paramVal=strArr[j];
                      
                  }//end else
                  else if(j==3){

                      count=Integer.parseInt( strArr[j] );

                      if(count == 0 ){
                          }else{
                          paramVal= ""+(Float.parseFloat(paramVal)/count);
                          }
                          //-------------------------
                      for(int k=0;k<string_data.split(",").length;k++)
                     {
                      if(paramType.equals(p[k])){
                          if(paramsData[k].equals("")){
                              paramsData[k]=paramVal;
                              }else{
                              paramsData[k]=paramsData[k]+dataSep+paramVal;
                              }
                          }
                          }


                      }//end else if
              }//end j for

          }//end for
          String multipleData="",dateString="";
          System.out.println("Date :"+dateLs);
          for(int i=0;i<dateLs.size();i++)
           {
              if(dateString.equals("")){
                  dateString=(String)dateLs.get(i);
                  }
              else{
                  dateString=dateString+","+(String)dateLs.get(i);
                  }
          }
          
          multipleData="dates"+","+dateString;
          for(int k=0;k<string_data.split(",").length;k++)
                     {
                        multipleData=multipleData+";"+data_string2[k]+","+paramsData[k];
              
                     }
          out.println(multipleData);
%>

<% } catch (Exception e) {

                e.printStackTrace();
            }
%>