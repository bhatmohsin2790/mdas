<%@page import="in.amitech.db.DBUtil"%>
<%@ page import="java.sql.*"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>

<%
    String newLine = System.getProperty("line.separator");
    String dataSep = "\t";
    String fileNameNew = "LoadSurvay.xls";
    String sql = "";
    String totalString = "";
    NumberFormat threeDecFormat = new DecimalFormat("#0.000");
    String lsdate = request.getParameter("lsdate");
    String ledate = request.getParameter("ledate");
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    Connection con = null;
    try {
        String meter_id = "";
        String emf = request.getParameter("EMF");
        // out.println("EMF:"+emf);
        String[] data_string2 = new String[0];
        String[] data_string = new String[0];
        if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
            meter_id = (String) session.getAttribute("meter_id");
        } else {
            meter_id = request.getParameter("meter_id");
        }

        String stringToReturn = "";
        con = new DBUtil().getConnection();
        pstmt = con.prepareStatement("select * from d4_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=" + meter_id + ")");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            System.out.println("---------------------------Load survay Header Got -----------------------------------");
            data_string2 = rs.getString("load_columns_header").split(",");
        } else {
            System.out.println("---------------------------Load survay Header Got Manually-----------------------------------");
            pstmt = con.prepareStatement("select no_of_params,d4_params from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
            rs = pstmt.executeQuery();

            if (rs.next()) {
                data_string2 = rs.getString("d4_params").split(",");
            }//end if
        }//end else

        totalString = "Meter Sl No" + dataSep + "Date Time";
        for (int i = 0; i < data_string2.length; i++) {
            totalString = totalString + dataSep + data_string2[i];
        }//end for

        String meter_sl_no = "";
        pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            meter_sl_no = rs.getString("meter_serial_no");
        }

        int flag = 0;

        double mf = 1.0, imf = 1.0, vmf = 1.0, cmf = 1.0;
        String sql1 = "select *  from meter where meterid=" + meter_id;
        stmt = con.createStatement();
        rs1 = stmt.executeQuery(sql1);
        while (rs1.next()) {
            mf = rs1.getDouble("mf");
            imf = rs1.getDouble("imf");
            vmf = rs1.getDouble("adopted_ptr") / rs1.getDouble("meter_ptr");
            String ACTR = rs1.getString("adopted_ctr");
            System.out.println("ACTR --> " + ACTR);
            if (ACTR.contains("/")) {
                String numerator = ACTR.substring(0, ACTR.indexOf("/"));
                String denominator = ACTR.substring(ACTR.indexOf("/") + 1);
                double cal_result = Double.valueOf(numerator) / Double.valueOf(denominator);
                cmf = (cal_result) / rs1.getDouble("meter_ctr");
            } else {
                cmf = rs1.getDouble("adopted_ctr") / rs1.getDouble("meter_ctr");
            }
            //cmf=rs1.getDouble("adopted_ctr")/rs1.getDouble("meter_ctr");
        }

        System.out.println("loadsurvay meterid---->" + meter_id);
        if (!lsdate.equals("") && !ledate.equals("")) {

            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "select  to_char(d4_time_stamp,'dd-mm-yyyy hh24:mi:ss') d4_date,"
                        + "data_string from d4_data d4 where meter_serial_no=?  and "
                        + "(trunc(d4_time_stamp)>=to_date('" + lsdate + "','dd/mm/yyyy') and "
                        + "trunc(d4_time_stamp)<=to_date('" + ledate + "','dd/mm/yyyy')) and "
                        + "data_string is NOT NULL  order by d4_time_stamp desc";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_sl_no);

            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "select  date_format(d4_time_stamp,'%d-%m-%Y %H:%i:%s') d4_date,"
                        + "data_string from d4_data d4 where meter_serial_no=?  "
                        + "and (date(d4_time_stamp)>=str_to_date('" + lsdate + "','%d/%m/%Y') and "
                        + "date(d4_time_stamp)<=str_to_date('" + ledate + "','%d/%m/%Y')) and "
                        + "data_string is NOT NULL order by d4_time_stamp desc limit ?,?";

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_sl_no);

            }//end else if
        } else {

            System.out.println("meterserialno  " + meter_sl_no);
            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "select  to_char(d4_time_stamp,'dd-mm-yyyy hh24:mi:ss') d4_date,"
                        + "data_string from d4_data d4 where meter_serial_no=? and "
                        + "data_string is NOT NULL  order by d4_time_stamp desc";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_sl_no);

            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "select  date_format(d4_time_stamp,'%d-%m-%Y %H:%i:%s') d4_date,data_string "
                        + "from d4_data d4 where meter_serial_no=? and data_string is NOT NULL "
                        + "order by d4_time_stamp desc limit ?,?";

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_sl_no);

            }//end else if

        }//end else

        rs = pstmt.executeQuery();
        String dataString = "";
        String d4Date = "";
        String[] d4DateArr = null;
        String totalData = "";
        while (rs.next()) {
            flag = 1;
            d4Date = rs.getString("d4_date");
            d4DateArr = d4Date.split(" ");
            if (d4DateArr[1].contains("23:59:00")) {
                d4Date = d4DateArr[0] + " " + "00:00:00";
            }//end if
            if (rs.getString("data_string") != null) {
                data_string = rs.getString("data_string").split(",");
                String val = null;
                for (int i = 0; i <= data_string.length - 1; i++) {
                    /*if (i == 3 || i == 4 || i == 5) {
                    continue;
                    } else {*/
                    val = data_string[i];
                    if (val.length() > 1) {
                        try {
                            double d;
                            if (emf.equals("0")) {
                                mf = 1.0;
                                vmf = 1.0;
                                cmf = 1.0;
                            } else {
                                mf = mf;
                                vmf = vmf;
                                cmf = cmf;
                            }
                            if (data_string2[i].toLowerCase().equals("avg_voltage")) {
                                d = Double.parseDouble(val) * vmf;
                            } else if (data_string2[i].toLowerCase().equals("avg_current")) {
                                d = Double.parseDouble(val) * cmf;
                            } else if (data_string2[i].toLowerCase().equals("vr") || data_string2[i].toLowerCase().equals("vy") || data_string2[i].toLowerCase().equals("vb")) {
                                d = Double.parseDouble(val) * vmf;
                            } else if (data_string2[i].toLowerCase().equals("lr") || data_string2[i].toLowerCase().equals("ly") || data_string2[i].toLowerCase().equals("lb")) {
                                d = Double.parseDouble(val) * cmf;
                            } else {

                                if (meter_sl_no.equals("JKB01435") || meter_sl_no.equals("JKB01431") || meter_sl_no.equals("JKB01238")) {
                                    d = (Double.parseDouble(threeDecFormat.format((Double.parseDouble(val) * imf) / 2))) * mf;
                                } else {
                                    d = (Double.parseDouble(threeDecFormat.format((Double.parseDouble(val) * imf)))) * mf;
                                }
                                //d = Double.parseDouble(val) * mf;                                                 
                            }//end else
                            data_string[i] = String.valueOf(threeDecFormat.format(d));
                        } catch (Exception e) {
                            e.printStackTrace();
                            //out.println("Plz Try Again....");
                        }//end catch
                    }//end if
                    //}//end else
                }//end for

                totalData = totalData + meter_sl_no + dataSep + "'" + d4Date;
                for (int i = 0; i <= data_string.length - 1; i++) {
                    totalData = totalData + dataSep + data_string[i];
                }
                totalData = totalData + newLine;

            }//if
        }//while
        if (flag == 0) {
            out.println("No Data in these Dates");
        }

        //----------------------------------------------------------
        totalString = totalString + newLine + totalData;

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
    } finally {
        con.close();
    }
%>
