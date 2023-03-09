
<%@page import="in.amitech.db.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%

String fileNameNew="";

		
      try
      {
	   PreparedStatement pstmt = null;
           ResultSet rs = null;	


           String meter_id = "", sql = null,data="";
           double mf=0;
                String[] data_string2=new String[0];
                String[] data_string=new String[0];
                 String lsdate=request.getParameter("lsdate").trim();
                 String ledate=request.getParameter("ledate").trim();
                 
                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") 
                {
                    meter_id = (String) session.getAttribute("meter_id");
                } 
                 else 
                {
                    meter_id = request.getParameter("meter_id");
                }
				System.out.println("******************************MeterID"+meter_id);
                session.setAttribute("meter_id", meter_id);
                Connection con = new DBUtil().getConnection();
                pstmt = con.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
                rs = pstmt.executeQuery();

                        while (rs.next()) 
                        {
                             data_string2 = rs.getString("d4_params").split(",");
                        }
                         String meter_sl_no = "";
                    pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
                    rs = pstmt.executeQuery();
                    if (rs.next()) 
                    {
                        meter_sl_no = rs.getString("meter_serial_no");
                    }
					
					if(meter_sl_no==null){
						fileNameNew="LS_Export.csv";
					}else{
						fileNameNew="LS_Export_"+meter_sl_no+".csv";
					}

                    session.setAttribute("meter_sl_no", meter_sl_no);
                     pstmt = con.prepareStatement("select mf from meter where meterid=" + meter_id);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        mf =rs.getDouble("mf");
                    }
System.out.println("multiplication factor-------"+mf);



    if(!lsdate.equals("") && !ledate.equals(""))
    {
        //------------------------------
            int MILLIS_IN_DAY = 1000 * 60 * 60 * 24;
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            java.util.Date  edate ;

            edate = (java.util.Date)dateFormat.parse(ledate);

            Calendar cal=Calendar.getInstance();
            cal.setTime(edate);
            cal.add(cal.DATE,1);
            String afterDate=cal.get(cal.DATE)+"/"+(cal.get(cal.MONTH)+1)+"/"+cal.get(cal.YEAR);
            System.out.println(" after one day is ----"+afterDate);
                           // String nextDate =dateFormat.format(cal.getTime(edate)+ MILLIS_IN_DAY);
                 //------------------------------
    sql = "select distinct d4_date, substr(data_string,1,instr(data_string, ',', 1, 1)-1) PARAM1," +
            " substr(data_string,instr(data_string, ',', 1, 1)+1,instr(data_string, ',', 1, 2)-instr(data_string, ',', 1, 1)-1) PARAM2," +
            " substr(data_string,instr(data_string, ',', 1, 2)+1,instr(data_string, ',', 1, 3)-instr(data_string, ',', 1, 2)-1) PARAM3," +
            " substr(data_string,instr(data_string, ',', 1, 3)+1,instr(data_string, ',', 1, 4)-instr(data_string, ',', 1, 3)-1) PARAM4," +
            " substr(data_string,instr(data_string, ',', 1, 4)+1,instr(data_string, ',', 1, 5)-instr(data_string, ',', 1, 4)-1) PARAM5," +
            " substr(data_string,instr(data_string, ',', 1, 5)+1,instr(data_string, ',', 1, 6)-instr(data_string, ',', 1, 5)-1) PARAM6," +
            " TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')>to_date('"+lsdate+" 00:00:00','dd/mm/yyyy hh24:mi:ss') and to_date(d4_date,'dd/mm/yyyy hh24:mi:ss')<=to_date('"+afterDate+" 00:00:00','dd/mm/yyyy hh24:mi:ss') and data_string is NOT NULL order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss'),TIME_DELAY  ";
    }
    else
    {
    sql="select distinct d4_date, substr(data_string,1,instr(data_string, ',', 1, 1)-1)" +
            " PARAM1, substr(data_string,instr(data_string, ',', 1, 1)+1,instr(data_string, ',', 1, 2)-instr" +
            "(data_string, ',', 1, 1)-1) PARAM2, substr(data_string,instr(data_string, ',', 1, 2)+1,instr(data_string, ',', 1, 3)-instr(data_string, ',', 1, 2)-1)" +
            " PARAM3, substr(data_string,instr(data_string, ',', 1, 3)+1,instr(data_string, ',', 1, 4)-instr(data_string, ',', 1, 3)-1) PARAM4," +
            " substr(data_string,instr(data_string, ',', 1, 4)+1,instr(data_string, ',', 1, 5)-instr(data_string, ',', 1, 4)-1) PARAM5, " +
            "substr(data_string,instr(data_string, ',', 1, 5)+1,instr(data_string, ',', 1, 6)-instr(data_string, ',', 1, 5)-1) PARAM6," +
            " TIME_DELAY from d4_data d4 where d4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?)and  data_string is NOT NULL " +
            "order by to_timestamp(d4_date,'dd/mm/yyyy hh24:mi:ss'),TIME_DELAY";
    }
    System.out.println(sql);
    pstmt = con.prepareStatement(sql);
pstmt.setString(1,meter_id);
rs = pstmt.executeQuery();


   List totalData = new ArrayList();
        String prevDate = null;
        String d4Date = null;
        String param1 = "";
        String param2 = "";
        String param3 = "";
        String param4 = "";
        String param5 = "";
        String param6 = "";

        String param1Vals = "";
        String param2Vals = "";
        String param3Vals = "";
        String param4Vals = "";
        String param5Vals = "";
        String param6Vals = "";

        int timeDelay = 0;
        boolean found = false;
        //String dataSep = ",";
		String dataSep = "\t";

        while (rs.next()) {
            timeDelay = rs.getInt("TIME_DELAY");
            if (prevDate == null) {
                prevDate = rs.getString("d4_date").split(" ")[0];
                param1Vals = "";
                param2Vals = "";
                param3Vals = "";
                param4Vals = "";
                param5Vals = "";
                param6Vals = "";

            }
            found = false;
            d4Date = rs.getString("d4_date").split(" ")[0];
            param1 = ""+(rs.getDouble("PARAM1")*mf);
            param2 = ""+(rs.getDouble("PARAM2")*mf);
            param3 = ""+(rs.getDouble("PARAM3")*mf);
            param4 = ""+(rs.getDouble("PARAM4")*mf);
            param5 = ""+(rs.getDouble("PARAM5")*mf);
            param6 = ""+(rs.getDouble("PARAM6")*mf);

            if (prevDate.equals(d4Date)) {
                System.out.println(d4Date + ":" + timeDelay);
                param1Vals = param1Vals + dataSep + param1;
                param2Vals = param2Vals + dataSep + param2;
                param3Vals = param3Vals + dataSep + param3;
                param4Vals = param4Vals + dataSep + param4;
                param5Vals = param5Vals + dataSep + param5;
                param6Vals = param6Vals + dataSep + param6;
            } else {
                System.out.println("************New Date Found**************");
                
                found = true;
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[0] + param1Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[1] + param2Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[2] + param3Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[3] + param4Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[4] + param5Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[5] + param6Vals);

				param1Vals = "";
                param2Vals = "";
                param3Vals = "";
                param4Vals = "";
                param5Vals = "";
                param6Vals = "";

				param1Vals = param1Vals + dataSep + param1;
                param2Vals = param2Vals + dataSep + param2;
                param3Vals = param3Vals + dataSep + param3;
                param4Vals = param4Vals + dataSep + param4;
                param5Vals = param5Vals + dataSep + param5;
                param6Vals = param6Vals + dataSep + param6;

                System.out.println(prevDate + ":" + timeDelay);
                prevDate = rs.getString("d4_date").split(" ")[0];
                
            }//end else

        }//end while

        if (found == false) 
        {
            totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[0] + param1Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[1] + param2Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[2] + param3Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[3] + param4Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[4] + param5Vals);
                totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[5] + param6Vals);
        }//end if


       
//String data = request.getParameter("data");
String meterid=request.getParameter("meterid");
//System.out.println(meterid);
//System.out.println("data is ="+data);
//java.io.File f = new java.io.File("/transco_reports");
//f.mkdirs();
//f=new java.io.File("/transco_reports/Ls_"+meterid+".xls");



String newLine = System.getProperty("line.separator");
/*
java.io.BufferedWriter bw=new java.io.BufferedWriter(new java.io.FileWriter(f));
for (int i = 0; i < totalData.size(); i++) {
            String str = (String) totalData.get(i);
            bw.write(str);
            bw.write(newLine);
            bw.flush();
        }
bw.close();
*/

	
	String totalString="";
	for (int i = 0; i < totalData.size(); i++) {
            String str = (String) totalData.get(i);
			totalString=totalString+str;
			totalString=totalString+newLine;
            
        }
		System.out.println("****************");
		System.out.println(totalString);
		System.out.println("****************");
		
		String testStr="abcdefghijklmnopqrstuvwxyz";
		System.out.println("********Write Start********");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition","attachment;filename="+fileNameNew);
		ServletOutputStream op = response.getOutputStream();
		op.write(totalString.getBytes(),0,totalString.length());
		//op.write(testStr.getBytes(),0,testStr.length());
		op.flush();
		op.close();
		System.out.println("********Write End********");

//out.println("Load Survay Data Exported Successfully to :"+f.getAbsolutePath());
//System.out.println("Load Survay Data Exported Successfully to :"+f.getAbsolutePath());
 }
      catch(Exception e)
              {
          
          //e.printStackTrace();
          }
%>