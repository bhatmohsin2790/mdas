<%@ page import="java.text.*"%>
<%@ page import="java.sql.*"%>
<%@page import="in.amitech.db.DBUtil"%>
<%     PreparedStatement pstmt = null;
    ResultSet rs = null;
    int energyMF = 0;
    Double emf = 1.0;
    String data_string2[] = null;
    String sql = "";

    String newLine = System.getProperty("line.separator");
    String dataSep = "\t";
    String fileNameNew = "MainEnergy.xls";
    String totalString = "";
    Connection con = null;
%>
<%
    try {
        String meter_sl_no = "";
        String meter_id = "";
        con = new in.amitech.db.DBUtil().getConnection();
        String fromDate = request.getParameter("esdate").trim();
        String toDate = request.getParameter("eedate").trim();

        NumberFormat oneDec = new DecimalFormat("#0.0");
        if (request.getParameter("meter_sl_no") == null || request.getParameter("meter_sl_no") == "") {
            meter_sl_no = (String) session.getAttribute("meter_sl_no");
        } else {
            meter_sl_no = request.getParameter("meter_sl_no");
        }
        if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
            meter_id = (String) session.getAttribute("meter_id");
        } else {
            meter_id = request.getParameter("meter_id");
        }
        String stringToReturn = "";

        if (energyMF == 1) {
            pstmt = con.prepareStatement("select mf from meter where meter_serial_no='" + meter_sl_no + "'");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                emf = Double.parseDouble(rs.getString("mf"));
            }
        }
//        System.out.println("mf for energy---->" + emf);
%>

<%
    pstmt = con.prepareStatement("select * from d3_columns_header where meter_serial_no='" + meter_sl_no + "' and billing_type='b3'");
    rs = pstmt.executeQuery();
    while (rs.next()) {
        data_string2 = rs.getString("billing_columns_header").split(",");
    }
%>

<%
    //getting the first and last kwh values in selected dates
    double firstValue = 0, lastValue = 0, TotalEnergy = 0;
    if (!fromDate.equals("") && !toDate.equals("")) {
        sql = "select * from d3_b3 where meter_serial_no='" + meter_sl_no + "' and trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY') and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY') order by d3_time_stamp ";
    } else {
        sql = "select * from d3_b3 where meter_serial_no='" + meter_sl_no + "' order by d3_time_stamp ";
    }
    pstmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    rs = pstmt.executeQuery();
    if (rs.first()) {
        String firstRow[] = rs.getString("data_string").split(",");
        for (int i = 0; i < firstRow.length; i++) {
            if (data_string2[i].equals("KWh(I)_tot")) {
                firstValue = Double.parseDouble(firstRow[i]);
            }
        }
    }//first 
    if (rs.last()) {
        String lastRow[] = rs.getString("data_string").split(",");
        for (int i = 0; i < lastRow.length; i++) {
            if (data_string2[i].equals("KWh(I)_tot")) {
                lastValue = Double.parseDouble(lastRow[i]);
            }
        }
    }//last 
    if (meter_sl_no.equals("JKB01435") || meter_sl_no.equals("JKB01431") || meter_sl_no.equals("JKB01238")) {
        TotalEnergy = (lastValue - firstValue) * 1000;
    } else {
        TotalEnergy = lastValue - firstValue;
    }

    totalString = totalString + "Meter Sl No" + dataSep + "Billing Dates" + dataSep;
    for (int i = 0; i < data_string2.length; i++) {
        totalString = totalString + data_string2[i] + dataSep;
    }

%>
<%            if (DBUtil.getTargetDB().equals("oracle")) {
            if (!fromDate.equals("") && !toDate.equals("")) {
                sql = "select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS') billing_date,data_string from d3_b3 b3 where meter_serial_no='" + meter_sl_no + "' and "
                        + "trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY') and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY') order by d3_time_stamp desc";
            } else {
                sql = "select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS') billing_date,data_string from d3_b3 b3 where meter_serial_no='" + meter_sl_no + "'  order by d3_time_stamp desc";
            }
            pstmt = con.prepareStatement(sql);

        } else if (DBUtil.getTargetDB().equals("mysql")) {

            if (!fromDate.equals("") && !toDate.equals("")) {
                sql = "select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,"
                        + "data_string from d3_b3 b3 where meter_serial_no=? and  str_to_date(date_format(b3.d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y')>= str_to_date('" + fromDate + "','%d/%m/%Y') and str_to_date(date_format(b3.d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') <= str_to_date('" + toDate + "','%d/%m/%Y') "
                        + "order by d3_time_stamp desc limit ?,?";
            } else {
                sql = "select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,"
                        + "data_string from d3_b3 b3 where meter_serial_no=? order by d3_time_stamp desc limit ?,?";
            }

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, meter_sl_no);

        }//end else if

        rs = pstmt.executeQuery();

        String dataString = "";
        NumberFormat formatter = new DecimalFormat("#0.000");
        String totalData = "";
        while (rs.next()) {
            if (rs.getString("data_string") != null) {
                String data_string[] = rs.getString("data_string").split(",");
                String val = null;
                for (int i = 0; i < data_string.length; i++) {

                    val = data_string[i];
                    if (val.length() > 1) {
                        try {
                            double d = Double.parseDouble(val);
                            if (meter_sl_no.equals("JKB01435") || meter_sl_no.equals("JKB01431") || meter_sl_no.equals("JKB01238")) {
                                data_string[i] = String.valueOf(formatter.format(d * 1000));
                            } else {
                                data_string[i] = String.valueOf(formatter.format(d));
                            }
                        } catch (Exception e) {
                        }//end catch
                    }//end if
                }//end for

                totalData = totalData + meter_sl_no + dataSep + "'" + rs.getString("billing_date");
                if (energyMF == 1) {
                    for (int i = 0; i <= data_string.length - 1; i++) {
                        totalData = totalData + dataSep + formatter.format(Double.parseDouble(data_string[i]) * emf);
                    }
                } else {
                    for (int i = 0; i <= data_string.length - 1; i++) {
                        totalData = totalData + dataSep + Double.parseDouble(data_string[i]);
                    }
                }
                totalData = totalData + newLine;

            } //if data string is not null
        }//while
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
    }
    finally{
        con.close();
    }
%>

