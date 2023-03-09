<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil" %>
<%
    Connection con = null;
    try {
        String meter_no = "";
        String meter_id = request.getParameter("meter_id");
        String fromDate = request.getParameter("sdate");
        String toDate = request.getParameter("edate");
        String values[] = request.getParameter("chkvalues").split(",");
        String newLine = System.getProperty("line.separator");
        String dataSep = "\t";
        String fileNameNew = "Tampers.xls";
        String sql = "";
        String totalString = "";
        NumberFormat twoDecFormat = new DecimalFormat("#0.000");
        PreparedStatement ps = null;
        ResultSet rs = null;
        con = new in.amitech.db.DBUtil().getConnection();
        totalString = "MeterSlNo" + dataSep + "Event Dates" + dataSep + "Event Type" + dataSep + "Event Status";

        sql = "select meter_serial_no from meter where meterid=" + meter_id + "";
        rs = con.prepareStatement(sql).executeQuery();
        while (rs.next()) {
            meter_no = rs.getString(1);
        }
        System.out.println("------------>" + meter_no + "-------" + values[0]);
        //to get headers
        sql = "select * from d5_columns_header where meter_serial_no='" + meter_no + "'";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            for (int i = 0; i < rs.getString("tamper_columns_header").split(",").length; i++) {
                totalString = totalString + dataSep + rs.getString("tamper_columns_header").split(",")[i];
            }
        }
        ps.close();
        rs.close();
        if (fromDate.equals("") && toDate.equals("")) {
            sql = "select event_date,e.event_type,event_status,data_string from "
                    + " d5_data d,events e where d.meter_serial_no='" + meter_no + "'"
                    + " and d.event_type=e.event_code and d.event_type in (";
            for (int i = 0; i < values.length; i++) {
                sql = sql + "'" + values[i] + "'" + ",";
            }
            sql = sql + "'0')order by d5_time_stamp desc ";
        } else {
            sql = "select   event_date,e.event_type,event_status,data_string,d.event_type from  d5_data d,events e where d.meter_serial_no='" + meter_no + "' and d.event_type=e.event_code and "
                    + " trunc(d.d5_time_stamp) >=to_date('" + fromDate + "','DD/MM/YYYY') "
                    + "and trunc(d.d5_time_stamp)<=to_date('" + toDate + "','DD/MM/YYYY') and "
                    + " d.event_type in (";
            for (int i = 0; i < values.length; i++) {
                sql = sql + Integer.parseInt(values[i]) + ",";
            }
            sql = sql + "0) order by d5_time_stamp asc";
        }
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        String totalData = "";
        System.out.println("----------------->" + sql);
        while (rs.next()) {

            totalData = totalData + meter_no + dataSep + rs.getString(1) + dataSep + rs.getString(2) + dataSep + ((rs.getString(3).trim().contains("restored")) ? "Restored" : "Occured");
            if (rs.getString(4) != null) {
                String data_string[] = rs.getString(4).split(",");
                for (int i = 0; i <= data_string.length - 1; i++) {
                    totalData = totalData + dataSep + twoDecFormat.format(Double.parseDouble(data_string[i]));
                }
            }
            totalData = totalData + newLine;
        }
        totalString = totalString + newLine + totalData;



        //response.setContentType("application/octet-stream"); //for csv format(.csv)
        response.setContentType("application/vnd.ms-excel");   //for xls format(.xls)

        response.setHeader("Content-Disposition", "attachment;filename=" + fileNameNew);
        ServletOutputStream op = response.getOutputStream();
        op.write(totalString.getBytes(), 0, totalString.length());
        op.flush();
        op.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }

%>

