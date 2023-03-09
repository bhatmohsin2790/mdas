<%--<%@ page session="false" %>--%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="in.amitech.db.DBUtil"%>


<%

            String fileNameNew = "";
            try {
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                ResultSet rs1 = null;
                Statement stmt = null;
          
                String meter_id = "", sql = null, data = "";
                double mf = 1.0, imf = 1.0;
                String[] data_string2 = new String[0];
                String[] data_string = new String[0];
                String lsdate = request.getParameter("lsdate").trim();
                String ledate = request.getParameter("ledate").trim();
                String emf = request.getParameter("EMF");
                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                    meter_id = (String) session.getAttribute("meter_id");
                } 
                else 
                {
                    meter_id = request.getParameter("meter_id");
                }
                System.out.println("******************************MeterID" + meter_id);
                session.setAttribute("meter_id", meter_id);
                Connection con = new DBUtil().getConnection();
                pstmt = con.prepareStatement("select * from d4_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=" + meter_id + ")");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    System.out.println("---------------------------Load survay Header Got Dynamically-----------------------------------");
                    data_string2 = rs.getString("load_columns_header").split(",");
                } else {
                    System.out.println("---------------------------Load survay Header Got Manually-----------------------------------");
                    pstmt = con.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        data_string2 = rs.getString("d4_params").split(",");
                    }//end if
                }//end else
                String meter_sl_no = "";
                pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
                rs = pstmt.executeQuery();
                if (rs.next()) 
                {
                    meter_sl_no = rs.getString("meter_serial_no");
                }
                if (meter_sl_no == null) 
                {
                    fileNameNew = "LS_Export.csv";
                } else 
                {
                    fileNameNew = "LS_Export_" + meter_sl_no + ".csv";
                }
                session.setAttribute("meter_sl_no", meter_sl_no);
                //mf new logic start
                String sql1 = "select mf,imf from meter where meterid=" + meter_id;
                stmt = con.createStatement();
                rs1 = stmt.executeQuery(sql1);
                if (rs1.next())
                {
                    mf = rs1.getDouble("mf") == 0 ? 1 : rs1.getDouble("mf");
                    imf = rs1.getDouble("imf") == 0 ? 1 : rs1.getDouble("imf");
                }
                if (emf.equals("0"))
                {
                    mf = 1.0;
                } 
                else 
                {
                    mf = mf;// * imf;
                }
                System.out.println("multiplication factor-------" + mf);
                String string_data = "";
                List totalData = new ArrayList();
                String prevDate = null;
                String d4Date = null;
                String d4Time = null;
                int timeDelay = 0;
                boolean found = false;
                String dataSep = "\t";
                if (!lsdate.equals("") && !ledate.equals("")) 
                {
                    // to get next date of selected end date
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date edate;
                    edate = (java.util.Date) dateFormat.parse(ledate);
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(edate);
                    cal.add(cal.DATE, 1);
                    String afterDate = cal.get(cal.DATE) + "/" + (cal.get(cal.MONTH) + 1) + "/" + cal.get(cal.YEAR);
                    System.out.println(" after one day is ----" + afterDate);
            if (DBUtil.getTargetDB().equals("oracle")) {
                    sql = "select distinct d4_date,data_string,time_delay,d4_time_stamp from d4_data where cdfid in(select cdfid from meter_data_time_stamp where meterid=" + meter_id + ")and to_date(substr(d4_date,1,10),'dd/mm/yyyy')>=to_date('" + lsdate + "','dd/mm/yyyy') and to_date(substr(d4_date,1,10),'dd/mm/yyyy')<=to_date('" + afterDate + "','dd/mm/yyyy')  and data_string is not null order by d4_time_stamp,TIME_DELAY";
                    } else if (DBUtil.getTargetDB().equals("mysql")) {
                        sql="select distinct d4_date,data_string,time_delay from d4_data where cdfid in(select cdfid from meter_data_time_stamp where meterid="+ meter_id + ")and str_to_date(d4_date,'%d-%m-%Y %H:%i:%S')>=str_to_date('" + lsdate + "','%d/%m/%Y %H:%i:%S') and str_to_date(d4_date,'%d-%m-%Y %H:%i:%S')<=str_to_date('" + afterDate + "','%d/%m/%Y %H:%i:%S')  and data_string is not null order by d4_time_stamp,TIME_DELAY";
                    }
                } 
                else 
                {
                    sql = "select distinct d4_date,data_string,time_delay,d4_time_stamp  from d4_data where cdfid in(select cdfid from meter_data_time_stamp where meterid=" + meter_id + ") and data_string is not null order by d4_time_stamp,TIME_DELAY";
                }
                System.out.println("sql query is---->"+sql);
                pstmt = con.prepareStatement(sql);
                rs = pstmt.executeQuery();
                String params[] = {"", "", "", "", "", "", "", "", "", ""};
                String paramVals[] = {"", "", "", "", "", "", "", "", "", ""};

                int headerLen = data_string2.length;
                int dataStringLen = 0;
                NumberFormat decFormat = new DecimalFormat("#0.000000");//actual 6

                int intervalPeriod = 0;
                int totalIntervals = 0;

                try 
                {
                    intervalPeriod = getLoadSurvayTimeDelay(con, meter_sl_no);
                    totalIntervals = 24 * (60 / intervalPeriod);
                    System.out.println(meter_sl_no + "Interval Period :" + intervalPeriod + ", Total Intervals :" + totalIntervals);
                } 
                catch (Exception e) 
                {
                }//end catch
                while (rs.next()) 
                {
                    found = false;
                    string_data = rs.getString("data_string");
                    //logic for proper d4 string data length
                    dataStringLen = string_data.split(",").length;
                    if (headerLen == dataStringLen) 
                    {
                        //nothing to do
                    } 
                    else if (headerLen > dataStringLen) 
                    {
                        System.out.println("Data String Len is Less than to Columns Header :" + string_data);
                        for (int i = dataStringLen; i < headerLen; i++) 
                        {
                            string_data = string_data + "0" + ",";
                        }//end for
                        System.out.println("Final Data String :" + string_data);
                    } 
                    else
                    {
                        System.out.println("Data String Len is Greater than to Columns Header :" + string_data);
                        String[] sdArr = string_data.split(",");
                        string_data = "";
                        for (int i = 0; i < headerLen; i++) 
                        {
                            string_data = string_data + sdArr[i] + ",";
                        }//end for
                        System.out.println("Final Data String :" + string_data);
                    }//end else
                    if (prevDate == null) 
                    {
                        prevDate = rs.getString("d4_date").split(" ")[0];
                        timeDelay = rs.getInt("TIME_DELAY");
                        System.out.println("Start Time Delay :" + timeDelay);
                        for (int i = 0; i < string_data.split(",").length; i++) 
                        {
                            params[i] = "";
                        }//end for
                        //check timeDelay start val
                        if (timeDelay != 1) 
                        {
                            //add -1 to the export data
                            timeDelay = 1;

                            if ((timeDelay + 1) < rs.getInt("TIME_DELAY")) 
                            {
                                //System.out.println("IF :"+(timeDelay+1)+":"+rs.getInt("TIME_DELAY"));
                                for (int i = 0; i < headerLen; i++) 
                                {
                                    for (int j = timeDelay; j < rs.getInt("TIME_DELAY"); j++) 
                                    {
                                        paramVals[i] = paramVals[i] + dataSep + "-1";
                                    }//end j for
                                }//end i for
                            }//end if

                            timeDelay = rs.getInt("TIME_DELAY");
                        } 
                        else
                        {
                            //nothing to do
                        }//end else
                    }//end if
                    d4Date = rs.getString("d4_date").split(" ")[0];
                    d4Time = rs.getString("d4_date").split(" ")[1];
                    if ((timeDelay + 1) < rs.getInt("TIME_DELAY")) 
                    {
                        //System.out.println("IF :"+(timeDelay+1)+":"+rs.getInt("TIME_DELAY"));
                        for (int i = 0; i < headerLen; i++) 
                        {
                            for (int j = timeDelay + 1; j < rs.getInt("TIME_DELAY"); j++)
                            {
                                paramVals[i] = paramVals[i] + dataSep + "-1";
                            }//end j for
                        }//end i for

                        for (int i = 0; i < string_data.split(",").length; i++) 
                        {
                            if (data_string2[i].toLowerCase().equals("avg_voltage")) 
                            {
                                params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * 0.3));
                            } 
                            else if (data_string2[i].toLowerCase().equals("avg_current")) 
                            {
                                params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * 400));
                            } 
                            else if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb") || data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")) 
                            {
                                //don't apply mf for these values
                                params[i] = string_data.split(",")[i];
                                //params[i] = decFormat.format(Double.parseDouble(string_data.split(",")[i]));
                            } else {
                                //params[i] = "" +decFormat.format(Double.parseDouble(string_data.split(",")[i])) * mf;
                                //System.out.println(string_data.split(",")[i]+"<-------------------------------------"+imf);
                                //params[i] = String.valueOf(Double.parseDouble(decFormat.format(Double.parseDouble(string_data.split(",")[i]))+0.001) * mf);
                                //System.out.println("****************************");
                                //params[i] = String.valueOf(Double.parseDouble(decFormat.format(Double.parseDouble(string_data.split(",")[i])*imf)+0.001) * mf);
                                //mf new logic end
                                //System.out.println("multiplication factor-------" + mf);
                                double val = Double.parseDouble(string_data.split(",")[i]) * imf;
                                params[i] = "" + Double.parseDouble(decFormat.format(val)) * mf;
                                //params[i] = "" +    decFormat.format((Double.parseDouble(decFormat.format(Double.parseDouble(string_data.split(",")[i]))) * mf));
                                //params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * mf));
                                //params[i] = "" + decFormat.format(Math.nextUp((Double.parseDouble(string_data.split(",")[i])) * mf));
                                //params[i] = "" + decFormat.format( (Double.parseDouble(string_data.split(",")[i]) * mf) );
                                //params[i] =  String.valueOf(decFormat.format(Double.parseDouble(string_data.split(",")[i]) * mf)));
                                //params[i] = String.valueOf(decFormat.format(Double.parseDouble(string_data.split(",")[i]))*mf;
                                //params[i] =  String.valueOf(decFormat.format(Double.parseDouble(string_data.split(",")[i]))*mf);
                            }//end else
                        }//end for
                    } else {
                        //System.out.println("Else :"+(timeDelay+1)+":"+rs.getInt("TIME_DELAY"));
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            ///System.out.println("test2 :");
                            if (data_string2[i].toLowerCase().equals("avg_voltage")) {
                                params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * 0.3));
                            } else if (data_string2[i].toLowerCase().equals("avg_current")) {
                                params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * 400));
                            } else if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb")
                                    || data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")) {
                                //don't apply mf for these values
                                params[i] = string_data.split(",")[i];
                            } else {
                                //params[i] = "" + (Double.parseDouble(string_data.split(",")[i]) * mf);
                                //System.out.println(string_data.split(",")[i]+"<-------------------1------------------"+imf);
                                //params[i] = String.valueOf(Double.parseDouble(decFormat.format(Double.parseDouble(string_data.split(",")[i])*imf)+0.001) * mf);
                                //params[i] = "" + decFormat.format((Double.parseDouble(decFormat.format(Double.parseDouble(string_data.split(",")[i]))) * mf));

                                double val = Double.parseDouble(string_data.split(",")[i]) * imf;
                                params[i] = "" + Double.parseDouble(decFormat.format(val)) * mf;
                                //params[i] = "" + decFormat.format((Double.parseDouble(string_data.split(",")[i]) * mf));
                                //params[i] = "" + decFormat.format(Math.nextUp((Double.parseDouble(string_data.split(",")[i])) * mf));
                                //params[i] =  String.valueOf(decFormat.format(Double.parseDouble(string_data.split(",")[i]* mf)));

                            }//end else

                        }//end for
                    }//end else

                    //previous style 
                    //timeDelay = rs.getInt("TIME_DELAY");
                    if (prevDate.equals(d4Date)) {
                        timeDelay = rs.getInt("TIME_DELAY");
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            paramVals[i] = paramVals[i] + dataSep + params[i];
                        }//end for
                    } else {

                        //System.out.println(timeDelay+"Date changed :"+rs.getInt("TIME_DELAY"));

                        //check timeDelay end val
                        if (timeDelay != totalIntervals) {
                            //add -1 to the export data

                            if ((timeDelay + 1) < totalIntervals) {
                                //System.out.println("IF :"+(timeDelay+1)+":"+rs.getInt("TIME_DELAY"));
                                for (int i = 0; i < headerLen; i++) {
                                    for (int j = timeDelay; j < totalIntervals; j++) {
                                        paramVals[i] = paramVals[i] + dataSep + "-1";
                                    }//end j for
                                }//end i for
                            }//end if
                        } else {
                            //nothing to do
                        }//end else

                        found = true;
                        for (int i = 0; i < string_data.split(",").length; i++) {
                            totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[i] + paramVals[i]);
                        }//end for

                        prevDate = rs.getString("d4_date").split(" ")[0];

                        for (int i = 0; i < string_data.split(",").length; i++) {
                            paramVals[i] = "";
                        }//end for

                        timeDelay = rs.getInt("TIME_DELAY");
                        //check timeDelay start val
                        if (timeDelay != 1) {
                            //add -1 to the export data
                            timeDelay = 1;

                            if ((timeDelay + 1) < rs.getInt("TIME_DELAY")) {
                                //System.out.println("IF :"+(timeDelay+1)+":"+rs.getInt("TIME_DELAY"));
                                for (int i = 0; i < headerLen; i++) {
                                    for (int j = timeDelay; j < rs.getInt("TIME_DELAY"); j++) {
                                        paramVals[i] = paramVals[i] + dataSep + "-1";
                                    }//end j for
                                }//end i for
                            }//end if
                            timeDelay = rs.getInt("TIME_DELAY");
                        } else {
                            //nothing to do
                        }//end else

                        for (int i = 0; i < string_data.split(",").length; i++) {
                            paramVals[i] = paramVals[i] + dataSep + params[i];

                        }//end for




                    }//end else
                }//while
                if (found == false) {

                    //check timeDelay end val
                    if (timeDelay != totalIntervals) {
                        //add -1 to the export data

                        if ((timeDelay + 1) < totalIntervals) {
                            //System.out.println("IF :"+(timeDelay+1)+":"+rs.getInt("TIME_DELAY"));
                            for (int i = 0; i < headerLen; i++) {
                                for (int j = timeDelay; j < totalIntervals; j++) {
                                    paramVals[i] = paramVals[i] + dataSep + "-1";
                                }//end j for
                            }//end i for
                        }//end if
                    } else {
                        //nothing to do
                    }//end else

                    for (int i = 0; i < string_data.split(",").length; i++) {
                        totalData.add(meter_sl_no + dataSep + prevDate + dataSep + data_string2[i] + paramVals[i]);
                    }//end for

                }//end if


//String data = request.getParameter("data");
                String meterid = request.getParameter("meterid");
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


                String totalString = "";
                for (int i = 0; i < totalData.size(); i++) {
                    String str = (String) totalData.get(i);
                    totalString = totalString + str;
                    totalString = totalString + newLine;

                }
                //System.out.println("****************");
                //System.out.println(totalString);
                //System.out.println("****************");

                String testStr = "abcdefghijklmnopqrstuvwxyz";
                //System.out.println("********Write Start********");
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment;filename=" + fileNameNew);
                ServletOutputStream op = response.getOutputStream();
                op.write(totalString.getBytes(), 0, totalString.length());
                //op.write(testStr.getBytes(),0,testStr.length());
                op.flush();
                op.close();
                //System.out.println("********Write End********");

//out.println("Load Survay Data Exported Successfully to :"+f.getAbsolutePath());
//System.out.println("Load Survay Data Exported Successfully to :"+f.getAbsolutePath());
            } catch (Exception e) {
                //e.printStackTrace();
            }
%>

<%!
    public String dateToString(String toPattern, Date fromDate) throws Exception {
        return new SimpleDateFormat(toPattern).format(fromDate);
    }//end method

    public Date stringToDate(String fromPattern, String fromDate) throws Exception {
        return new SimpleDateFormat(fromPattern).parse(fromDate);
    }//end method

    public Date getNextIPDate(Date ipDate, int ipInterval) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(ipDate);
        cal.add(Calendar.MINUTE, ipInterval);
        return cal.getTime();

    }//end method

    public int getLoadSurvayTimeDelay(Connection con, String meterSerialNo) throws Exception {

        String sql = null;
        Statement st = null;
        ResultSet rs = null;
        long minutes = 0;
        try {

            sql = "select * from d4_data where meter_serial_no='" + meterSerialNo + "' order by d4_time_stamp desc";
            st = con.createStatement();
            rs = st.executeQuery(sql);
            int timeDelay = -1;
            List<Date> ls = new ArrayList<Date>();
            Date dat = null;
            Date newDat = null;
            Calendar cal = null;

            while (rs.next()) {
                if (timeDelay == -1) {
                    timeDelay = rs.getInt("time_delay");
                    dat = new Date(rs.getTimestamp("d4_time_stamp").getTime());
                    //System.out.println("D4 Date :" + dat);
                } else {
                    if (timeDelay + 1 < rs.getInt("time_delay")) {
                        //time interval is missed
                        timeDelay = rs.getInt("time_delay");
                        //System.out.println("Time Delay is mist");
                        continue;
                    } else {
                        //proper time delay
                        //System.out.println("Time Delay matched");
                        cal = Calendar.getInstance();
                        cal.setTime(rs.getTimestamp("d4_time_stamp"));
                        //System.out.println(cal.getTime());
                        long diffMilliSeconds = (dat.getTime() - cal.getTimeInMillis());
                        //System.out.println("Acutal Diff :" + diffMilliSeconds);
                        minutes = (diffMilliSeconds / (1000 * 60));

                        //System.out.println("Minutes Diff :" + minutes);
                        if (60 % minutes == 0) {
                            //System.out.println("Minutes are ok");
                        } else {
                            minutes++;
                            //System.out.println("Minutes are incremented :" + minutes);
                        }//end else
                        break;
                    }//end else
                }//end else
            }//end while
        } finally {
        }//end finally
        return (int) minutes;
    }//end method
%>