<%@ page import="java.sql.*"%>
<%@page import="java.text.DecimalFormat"%> 
<%@page import="in.amitech.db.DBUtil"%>
 <% 
        PreparedStatement pstmt, pstmt1, pstmt2 = null;
        ResultSet rs, rs1, rs2 = null;
        double ctr = 1.0, ptr = 1.0, Actr = 1.0, Aptr = 1.0;
        double vmf = 1.0, cmf = 1.0, pmf = 1.0;
        double mf = 1.0;
        DecimalFormat df1 = new DecimalFormat("#0.000");
         String locationName="";
         
         String newLine = System.getProperty("line.separator");
             String dataSep = "\t";
             
             String totalString = "";
             String totalData="";

    %>
<%
           String meter_id = request.getParameter("meter_id");
           
           int data_type = 1; //2 - completed data   1 - Latest data
        double aemf = 1.0;
        if (request.getParameter("ApplyEMF") != null) {
            aemf = Double.parseDouble(request.getParameter("ApplyEMF"));

        } else {
            System.out.println("Apply EMF is not available ");
        }//end else
        System.out.println("EMF----------------->" + aemf);
        if (request.getParameter("data_type") == null || request.getParameter("data_type") == "") {
        } else {
            data_type = Integer.parseInt(request.getParameter("data_type"));
        }
         Connection con = new in.amitech.db.DBUtil().getConnection();
//adding header-----------------------
       totalString= "Reading Date Time"+dataSep+"Rph-voltage"+dataSep+"Yph-voltage"+dataSep+"Bph-voltage"+
                     dataSep+"Rph-current"+dataSep+"Yph-current"+dataSep+"Bph-current"+dataSep+"Rph-pf"+dataSep+"Yph-pf"+dataSep+"Bph-pf"+
                     dataSep+"Avg-pf"+dataSep+"Act(kW)"+dataSep+"App(kVA)"+dataSep+"React(kVAr)"+dataSep+"Frequency"+dataSep+"Kwh"+dataSep+"Kvah";                                                 
    try {      
             
        
        String meter_sl_no = "",columns = "";
         pstmt = con.prepareStatement("select meter_serial_no,ml.locationname from meter,meterlocation ml where meterid="+meter_id+" and meterlocation=ml.locationid");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            meter_sl_no = rs.getString("meter_serial_no");
            locationName=rs.getString(2);
        }
        String fileNameNew = meter_sl_no+"-InstantData.xls";
        session.setAttribute("meter_sl_no", meter_sl_no);      
        System.out.println("meter serial no " + meter_sl_no);
        pstmt = con.prepareStatement("select BILLING_COLUMNS_HEADER from d3_columns_header d3 ,meter m where m.meter_serial_no = d3.meter_serial_no and m.meterid="+meter_id+"");
            rs = pstmt.executeQuery();
            while(rs.next()) {
                columns = rs.getString("BILLING_COLUMNS_HEADER");                
            }     
            System.out.println("BILLING_COLUMNS_HEADER\t"+columns);
            int kwh = 0,kvah = 0;
            for(int i=0;i<columns.split(",").length;i++)
            {
                if(columns.split(",")[i].contains("KWh"))
                {
                    kwh = i;
                    break;
                }
            } 
            for(int k=0;k<columns.split(",").length;k++)
            {
                if(columns.split(",")[k].contains("KVAh"))
                {
                    kvah = k;
                    break;
                }
            }      
            System.out.println(kwh+"\t-------------------------\t"+kvah);
        if (data_type == 2)// complete data
        {
             totalData = "";
    
            String sdate = request.getParameter("sdate");
            String edate = request.getParameter("edate");
            System.out.println("Starting date:" + sdate);
            //System.out.println("Ending date:" + edate);
            int limit = 50;
            int count = 0;
            String sql = null;           
            if (sdate.equals("") && edate.equals(""))//Complete data without date selection
            { } else {
            System.out.println("Date Range Selected---------------------------------------------------->");
          
            pstmt2 = con.prepareStatement("select * from meter where meterid=" + meter_id);
            rs2 = pstmt2.executeQuery();
            if (rs2.next()) {
                ctr = Double.parseDouble(rs2.getString("METER_CTR"));
                ptr = Double.parseDouble(rs2.getString("METER_PTR"));
		       
			   String ACTR=rs2.getString("ADOPTED_CTR");
			   if(ACTR.contains("/")){	
				String numerator = ACTR.substring(0,ACTR.indexOf("/"));
				String denominator = ACTR.substring(ACTR.indexOf("/")+1);
				Actr = Double.valueOf(numerator)/Double.valueOf(denominator);
			   }else{
			     Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));
			   }
                
                Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR"));
               // cmf = (Actr / Aptr) * (ctr / ptr);
                vmf = Double.parseDouble(df1.format(Aptr / ptr));
                cmf = Double.parseDouble(df1.format(Actr / ctr));
                pmf = Double.parseDouble(rs2.getString("mf"));
                System.out.println("ctr:" + ctr);
                System.out.println("ptr:" + ptr);
                System.out.println("Actr:" + Actr);
                System.out.println("Aptr:" + Aptr);
                System.out.println("vmf:" + vmf);
                System.out.println("cmf:" + cmf);
            }
             if (aemf == 0)//without MF
                                 {
                 vmf=1.0; cmf=1.0; pmf=1.0;
             }
            
            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "SELECT (extract(DAY FROM log_time_stamp - meter_time_stamp)*24*60*60)+ "
                        + " (extract(HOUR FROM log_time_stamp - meter_time_stamp)*60*60)+ "
                        + "  (extract(MINUTE FROM log_time_stamp - meter_time_stamp)*60)+ "
                        + "  extract(SECOND FROM log_time_stamp - meter_time_stamp)  "
                        + "timediff,cdfid,g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current, "
                        + "yph_line_current,bph_line_current,rph_power_factor,yph_power_factor, "
                        + " bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER, "
                        + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT, "
                        + " BPH_REACT_CURRENT,YPH_REACT_CURRENT,meter_time_stamp,log_time_stamp,meterid  "
                        + " from d2 where  regexp_like(trim(rph_voltage), '^[0-9]') and meterid=? and (to_TIMESTAMP(g2,'dd-mm-yyyy hh24:mi:SS') >= to_date('" + sdate + ":00','YYYY-mm-DD hh24:mi:ss') and "
                        + "to_TIMESTAMP(g2,'dd-mm-yyyy hh24:mi:SS') <= to_date('" + edate + ":00','YYYY-mm-DD hh24:mi:ss') )  order by to_date(g3,'DD-MM-YYYY HH24:MI:SS') desc";
               // System.out.println("sql  " + sql);
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_id);
            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "select TIMESTAMPDIFF(SECOND,str_to_date(g3,'%d-%m-%Y %H:%i:%s'),log_time_stamp) timediff,g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,"
                        + "bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,"
                        + "avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,"
                        + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,"
                        + "BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,"
                        + "YPH_REACT_CURRENT from d2 where meterid=? and "
                        + "str_to_date(g2,'%d-%m-%Y') >= str_to_date('" + sdate + "','%d/%m/%Y') and "
                        + "str_to_date(g2,'%d-%m-%Y') <= str_to_date('" + edate + "','%d/%m/%Y') "
                        + "order by meter_time_stamp desc limit ?,?";

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_id);
                
            }//end else if
          
            rs = pstmt.executeQuery();
            while (rs.next()) 
            {                
                    String locdata = "";
                    String locsql = "select * from d3_b3 where cdfid=" + rs.getString("cdfid") + "";
                    Statement st = con.createStatement();
                    ResultSet locrs = st.executeQuery(locsql);
                    boolean status = false;
                    while (locrs.next()) 
                    {
                        locdata = locrs.getString("data_string");
                        System.out.println("LocData\t"+locdata);
                        status = true;
                    } 
                    if(status)
                    {
                        Long delayTimeInSeconds = Long.parseLong(rs.getString(1));
                        if (delayTimeInSeconds > 60) 
                        {
                            delayTimeInSeconds = delayTimeInSeconds / 60;
                        }
                        totalData=totalData+(rs.getString("g3") == null ? "" : rs.getString("g3"))+dataSep;
                        totalData=totalData+(rs.getString("rph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("rph_voltage"))) * vmf))+dataSep;
                        totalData=totalData+(rs.getString("yph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("yph_voltage"))) * vmf))+dataSep;
                        totalData=totalData+(rs.getString("bph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("bph_voltage"))) * vmf))+dataSep;
                        totalData=totalData+(rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_LINE_CURRENT"))) * cmf))+dataSep;
                        totalData=totalData+(rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_LINE_CURRENT"))) * cmf))+dataSep;
                        totalData=totalData+(rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_LINE_CURRENT"))) * cmf))+dataSep;
                        totalData=totalData+(rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FUND_ACT_POWER"))) * pmf))+dataSep;
                        totalData=totalData+(rs.getString("APPARENT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("APPARENT_POWER"))) * pmf))+dataSep;
                        totalData=totalData+(rs.getString("REACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("REACT_POWER"))) * pmf))+dataSep;
                        totalData=totalData+(rs.getString("FREQUENCY") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FREQUENCY")))))+dataSep;
                        totalData=totalData+(locdata.split(",")[kwh].equals("") ? "" : df1.format(Math.abs(Double.parseDouble(locdata.split(",")[kwh]))))+dataSep;
                        totalData=totalData+(locdata.split(",")[kvah].equals("") ? "" : df1.format(Math.abs(Double.parseDouble(locdata.split(",")[kvah]))))+dataSep;
                        totalData = totalData + newLine;
                    }//inner if
                }//while
            totalString = totalString + newLine + totalData;
            }

        %>
       

<%
}// end of complete data
else {          // latest data block
    totalData = "";
   
    pstmt2 = con.prepareStatement("select * from meter where meterid=" + meter_id);
    rs2 = pstmt2.executeQuery();
    if (rs2.next()) {
        ctr = Double.parseDouble(rs2.getString("METER_CTR") == null ? "1.0" : rs2.getString("METER_CTR"));
        ptr = Double.parseDouble(rs2.getString("METER_PTR") == null ? "1.0" : rs2.getString("METER_PTR"));
        //Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR") == null ? "1.0" : rs2.getString("ADOPTED_CTR"));
		if(rs2.getString("ADOPTED_CTR")==null)
			Actr = Double.valueOf("1.0");
		else{
		  String ACTR=rs2.getString("ADOPTED_CTR");
         if(ACTR.contains("/")){
          String numerator = ACTR.substring(0,ACTR.indexOf("/"));
          String denominator = ACTR.substring(ACTR.indexOf("/")+1);
          Actr = Double.valueOf(numerator)/Double.valueOf(denominator);
		 }else{
			Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));
		 }
		}

        Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR") == null ? "1.0" : rs2.getString("ADOPTED_PTR"));
       // cmf = (Actr / Aptr) * (ctr / ptr);
        vmf = Double.parseDouble(df1.format(Aptr / ptr));
        cmf = Double.parseDouble(df1.format(Actr / ctr));
        pmf = Double.parseDouble(rs2.getString("mf"));
		
        /*System.out.println("ctr:" + ctr);
        System.out.println("ptr:" + ptr);
        System.out.println("Actr:" + Actr);
        System.out.println("Aptr:" + Aptr);*/
        System.out.println("vmf:" + vmf);
        System.out.println("cmf:" + cmf);
        System.out.println("pmf:" + pmf);
    }
     if (aemf == 0){
         vmf=1; cmf=1; pmf=1;
     }
    String sql = "";
    if (DBUtil.getTargetDB().equals("oracle")) {

        //sql = "select * from d2 where meterid=" + meter_id + " order by to_timestamp(g2,'DD-MM-YYYY HH24:MI:SS') desc";
        sql = "SELECT (extract(DAY FROM log_time_stamp - meter_time_stamp)*24*60*60)+ "
                + "(extract(HOUR FROM log_time_stamp - meter_time_stamp)*60*60)+"
                + "(extract(MINUTE FROM log_time_stamp - meter_time_stamp)*60)+"
                + "extract(SECOND FROM log_time_stamp - meter_time_stamp) "
                + "timediff,cdfid,g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,"
                + "bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,"
                + "FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,"
                + "BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT from"
                + "(select cdfid,g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,"
                + "bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,"
                + "FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,"
                + "BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,meter_time_stamp,log_time_stamp from(select cdfid,g3,rph_voltage,yph_voltage,bph_voltage,"
                + "rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,"
                + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,"
                + "meter_time_stamp,log_time_stamp,meterid,rownum r from"
                + "( select cdfid,g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,"
                + "bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,"
                + "REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,"
                + "meterid,meter_time_stamp,log_time_stamp from d2 order by to_timestamp(g3,'dd-mm-yyyy hh24:mi:ss') desc) where regexp_like(trim(rph_voltage), '^[0-9]') and rownum<51  and meterid=" + meter_id + ") where r>=0)";
        pstmt = con.prepareStatement(sql);
    } else if (DBUtil.getTargetDB().equals("mysql")) {

        //pstmt = con.prepareStatement("select * from d2 where meterid=" + meter_id + " order by meter_time_stamp desc limit 10");
        sql = "select TIMESTAMPDIFF(SECOND,str_to_date(g3,'%d-%m-%Y %H:%i:%s'),log_time_stamp) timediff,g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_active_current,yph_active_current,bph_active_current,rph_react_current,yph_react_current,bph_react_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,fund_act_power,apparent_power,react_power,frequency from d2 where meterid=" + meter_id + " order by meter_time_stamp desc limit 10";
       
        pstmt = con.prepareStatement(sql);
    }//end else
    rs = pstmt.executeQuery();
    while (rs.next()) {
            String locdata = "";
                    String locsql = "select * from d3_b3 where cdfid=" + rs.getString("cdfid") + "";
                    Statement st = con.createStatement();
                    ResultSet locrs = st.executeQuery(locsql);
                    boolean status = false;
                    while (locrs.next()) 
                    {
                        locdata = locrs.getString("data_string");
                        System.out.println("LocData\t"+locdata);
                        status = true;
                    } 
                    if(status)
                    {               
                        totalData=totalData+(rs.getString("g3") == null ? "" : rs.getString("g3"))+dataSep;
                        totalData=totalData+(rs.getString("rph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("rph_voltage"))) * vmf))+dataSep;
                        totalData=totalData+(rs.getString("yph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("yph_voltage"))) * vmf))+dataSep;
                        totalData=totalData+(rs.getString("bph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("bph_voltage"))) * vmf))+dataSep;
                        totalData=totalData+(rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_LINE_CURRENT"))) * cmf))+dataSep;
                        totalData=totalData+(rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_LINE_CURRENT"))) * cmf))+dataSep;
                        totalData=totalData+(rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_LINE_CURRENT"))) * cmf))+dataSep;
                        totalData=totalData+(rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))))+dataSep;
                        totalData=totalData+(rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FUND_ACT_POWER"))) * pmf))+dataSep;
                        totalData=totalData+(rs.getString("APPARENT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("APPARENT_POWER"))) * pmf))+dataSep;
                        totalData=totalData+(rs.getString("REACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("REACT_POWER"))) * pmf))+dataSep;
                        totalData=totalData+(rs.getString("FREQUENCY") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FREQUENCY")))))+dataSep;
                        totalData=totalData+(locdata.split(",")[kwh].equals("") ? "" : df1.format(Math.abs(Double.parseDouble(locdata.split(",")[kwh]))))+dataSep;
                        totalData=totalData+(locdata.split(",")[kvah].equals("") ? "" : df1.format(Math.abs(Double.parseDouble(locdata.split(",")[kvah]))))+dataSep;                        
                        totalData = totalData + newLine;
                   }//If
            }//while
        totalString = totalString + newLine + totalData;
        }
        //----------------------------------------------------------        
        //response.setContentType("application/octet-stream"); //for csv format(.csv)
        response.setContentType("application/vnd.ms-excel");   //for xls format(.xls)       
        response.setHeader("Content-Disposition", "attachment;filename=" + fileNameNew);
        ServletOutputStream op = response.getOutputStream();
        op.write(totalString.getBytes(), 0, totalString.length());
        op.flush();
        op.close();
        //----------------------------------------------------------   
    } catch (Exception e) {
        out.println("Plz Try Again....");
        e.printStackTrace();
    }
       finally{
           con.close();
       }
%>
