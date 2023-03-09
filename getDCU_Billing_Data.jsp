<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%
    try {
        DecimalFormat df1 = new DecimalFormat("#0.000");
        NumberFormat twoDecFormat = new DecimalFormat("#0.00");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        String dcu_id = request.getParameter("dcu_id");
        System.out.println("SUBSTATION ID :" + dcu_id);
        // pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid "
        //       + "and m.feederid in  (select feederid from feeder where substationid=?)");
        String sql11 = "select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid and m.meterid in (" + dcu_id + ")";
        System.out.println("Qry==>" + sql11);
        PreparedStatement pstmt = con.prepareStatement(sql11);
        //pstmt.setString(1, dcu_id);
        ResultSet rs = pstmt.executeQuery();

        String f_ids = "";
        String f_names = "";
        String meter_ids = "";
        String meter_serial_nos = "";
        System.out.println("hi1");
        while (rs.next()) {
            System.out.println("hi");
            f_ids = f_ids + rs.getString("feederid") + ",";
            f_names = f_names + rs.getString("feedername") + ",";
            meter_ids = meter_ids + rs.getString("meterid") + ",";
            meter_serial_nos = meter_serial_nos + rs.getString("meter_serial_no") + ",";
        }

        String[] f_ids_arr = f_ids.split(",");
        String[] f_names_arr = f_names.split(",");
        String[] meter_ids_arr = meter_ids.split(",");
        String[] meter_serial_nos_arr = meter_serial_nos.split(",");

        for (int i = 0; i < f_ids_arr.length; i++) {
            System.out.println(f_ids_arr[i] + "-->" + f_names_arr[i] + "--->" + meter_ids_arr[i] + "--->" + meter_serial_nos_arr[i]);
            String[] param_names = null;
            if (meter_serial_nos_arr[i].equals("12040485") || meter_serial_nos_arr[i].equals("12040547") || meter_serial_nos_arr[i].equals("12040639") || meter_serial_nos_arr[i].equals("12040560") || meter_serial_nos_arr[i].equals("12040599") || meter_serial_nos_arr[i].equals("12040537") || meter_serial_nos_arr[i].equals("12040655") || meter_serial_nos_arr[i].equals("12040585") || meter_serial_nos_arr[i].equals("12040455") || meter_serial_nos_arr[i].equals("12040513")) {
                String header = "kWh,kVArh Lag,kVArh Lead,kVAh";
                param_names = header.split(",");

            } else {
                pstmt = con.prepareStatement("select * from d3_columns_header where meter_serial_no in(select meter_serial_no from meter where meterid=?) and billing_type='b3'");
                pstmt.setString(1, meter_ids_arr[i]);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    System.out.println("---------------------------Billing Header Got Dynamically-----------------------------------");
                    param_names = rs.getString("billing_columns_header").split(",");
                } else {
                    System.out.println("---------------------------Load survay Header Got Manually-----------------------------------");
                    pstmt = con.prepareStatement("select d3_params from metermake where metermakeid=(select metermake from meter where meterid=?)");
                    pstmt.setString(1, meter_ids_arr[i]);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        param_names = rs.getString("d3_params").split(",");
                    }//end if
                }//end else
            }
%>
<table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-right: 10px;<% if (i >= 2) {
            out.println("margin-top:10px;");
        }%>" >
    <thead>
        <tr>
            <td colspan="12"><strong>Feeder Name : </strong><%= f_names_arr[i]%> (<%=meter_serial_nos_arr[i]%>)</td>
        </tr>        
        <tr>
            <td width="60px" align="center"><strong>METER DATE</strong></td>
            <td width="60px" align="center"><strong>METER TIME</strong></td>
            <%
                for (int j = 0; j < param_names.length; j++) {
            %>
            <td width="60px" align="center"><%=param_names[j]%></td>
            <%
                }
            %>
        </tr>
    </thead>
    <tbody>
        <%
            if (DBUtil.getTargetDB().equals("mysql")) {
                pstmt = con.prepareStatement("select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 b3 where meter_serial_no=? order by d3_time_stamp desc limit 10");
            }
            if (DBUtil.getTargetDB().equals("oracle")) {
                pstmt = con.prepareStatement("select billing_date,data_string from(select to_date(to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS')billing_date,data_string,rownum from d3_b3 b3 where meter_serial_no=? order by d3_time_stamp desc) where rownum<=10");
            }
            pstmt.setString(1, meter_serial_nos_arr[i]);
            rs = pstmt.executeQuery();
            int data_available_flag = 0;
            while (rs.next()) {
                String[] data_string_arr = rs.getString("data_string").split(",");
                out.println("<tr>");
                out.println("<td align='left'>" + rs.getString("billing_date").substring(0, 10) + "</td>");
                out.println("<td align='left'>" + rs.getString("billing_date").substring(10) + "</td>");
                if (meter_serial_nos_arr[i].equals("12040485") || meter_serial_nos_arr[i].equals("12040547") || meter_serial_nos_arr[i].equals("12040639") || meter_serial_nos_arr[i].equals("12040560") || meter_serial_nos_arr[i].equals("12040599") || meter_serial_nos_arr[i].equals("12040537") || meter_serial_nos_arr[i].equals("12040655") || meter_serial_nos_arr[i].equals("12040585") || meter_serial_nos_arr[i].equals("12040455") || meter_serial_nos_arr[i].equals("12040513")) {
                    for (int j = 0; j < data_string_arr.length; j++) {

                        out.println("<td align='right'>" + df1.format(Double.parseDouble(data_string_arr[j])) + "</td>");

                    }
                    out.println("<tr>");
                    data_available_flag = 1;

                }//if
                else {
                    for (int j = 0; j < data_string_arr.length; j++) {
                        out.println("<td align='right'>" + df1.format(Double.parseDouble(data_string_arr[j])) + "</td>");
                    }
                    out.println("<tr>");
                    data_available_flag = 1;
                }
            }//else
            if (data_available_flag == 0) {
                out.println("<tr><td  colspan='12' align='center'>Data Not Available.</td></tr>");
            }
        %>
    </tbody>
</table>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }
%>


