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
        NumberFormat threeDecFormat = new DecimalFormat("#0.000");
        NumberFormat twoDecFormat = new DecimalFormat("#0.00");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");

        String dcu_id = request.getParameter("dcu_id");
        String from_date = request.getParameter("fdate");
        String to_date = request.getParameter("tdate");
        System.out.println("dcu id---->" + dcu_id);
        from_date = dateFormat1.format(dateFormat.parse(from_date));
        to_date = dateFormat1.format(dateFormat.parse(to_date));
        String meter_sl_nos = "'";
        for (int id = 0; id < dcu_id.split(",").length; id++) {
            meter_sl_nos = meter_sl_nos + dcu_id.split(",")[id] + "','";
        }
        meter_sl_nos = meter_sl_nos + "'";
        String sql11 = "select distinct f.dcuid from meter m,feeder f where m.feederid=f.feederid and m.meter_serial_no in (" + meter_sl_nos + ")";
        PreparedStatement pstmt = con.prepareStatement(sql11);
        ResultSet rs = pstmt.executeQuery();
        String substations_ids_str = "";
        while (rs.next()) {
            substations_ids_str = substations_ids_str + rs.getString("dcuid") + ",";
        }
        String[] substations_arr = substations_ids_str.split(",");

        for (int main_loop = 0; main_loop < substations_arr.length; main_loop++) {
            pstmt = con.prepareStatement("select * from substation where substationid=(select substationid from dcuinfo where dcuid=?)");
            pstmt.setString(1, substations_arr[main_loop]);
            rs = pstmt.executeQuery();
            String substation_nm = "";
            if (rs.next()) {
                substation_nm = rs.getString("substationname");
            }
            String incoming_feeder_ids = "";
            String incoming_feeder_names = "";
            String incoming_meter_ids = "";
            String incoming_meter_slnos = "";

            String outgoing_feeder_ids = "";
            String outgoing_feeder_names = "";
            String outgoing_meter_ids = "";
            String outgoing_meter_slnos = "";
            String sql = "select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage,f.feeder_type from meter m,feeder f where m.feederid=f.feederid "
                    + "and m.feederid in  (select feederid from feeder where dcuid=?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, substations_arr[main_loop]);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                int feeder_type = Integer.parseInt(rs.getString("feeder_type"));
                if (feeder_type == 0) {
                    outgoing_feeder_ids = outgoing_feeder_ids + rs.getString("feederid") + ",";
                    outgoing_feeder_names = outgoing_feeder_names + rs.getString("feedername") + ",";
                    outgoing_meter_ids = outgoing_meter_ids + rs.getString("meterid") + ",";
                    outgoing_meter_slnos = outgoing_meter_slnos + rs.getString("meter_serial_no") + ",";
                } else {
                    incoming_feeder_ids = incoming_feeder_ids + rs.getString("feederid") + ",";
                    incoming_feeder_names = incoming_feeder_names + rs.getString("feedername") + ",";
                    incoming_meter_ids = incoming_meter_ids + rs.getString("meterid") + ",";
                    incoming_meter_slnos = incoming_meter_slnos + rs.getString("meter_serial_no") + ",";
                }
            }
            String[] incoming_feeder_ids_arr = incoming_feeder_ids.split(",");
            String[] incoming_feeder_names_arr = incoming_feeder_names.split(",");
            String[] incoming_meter_ids_arr = incoming_meter_ids.split(",");
            String[] incoming_meter_slnos_arr = incoming_meter_slnos.split(",");

            String[] outgoing_feeder_ids_arr = outgoing_feeder_ids.split(",");
            String[] outgoing_feeder_names_arr = outgoing_feeder_names.split(",");
            String[] outgoing_meter_ids_arr = outgoing_meter_ids.split(",");
            String[] outgoing_meter_slnos_arr = outgoing_meter_slnos.split(",");

%>
<table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-right: 10px;display:none;" >
    <thead>
        <tr>
            <td>
                <strong><%=substation_nm%></strong>
            </td>
        </tr>
        <tr>
            <td><strong>Feeder Name</strong></td>
            <td><strong>Previous Reading</strong></td>
            <td><strong>Present Reading</strong></td>
            <!--            <td><strong>Active Import (KWH)</strong></td>-->
            <!--            <td><strong>MF</strong></td>-->
            <td><strong>Consumption</strong></td>
            <td><strong>Loss</strong></td>
            <td><strong>Loss(%)</strong></td>
        </tr> 
    </thead>
    <%
        double total_incoming = 0;
        double total_outgoing = 0;
        double consumption = 0;
        //Outgoing feeders   
        double[] previous_reading_arr1 = new double[incoming_feeder_ids_arr.length];
        double[] present_reading_arr1 = new double[incoming_feeder_ids_arr.length];
        double[] previous_reading_arr2 = new double[outgoing_feeder_ids_arr.length];
        double[] present_reading_arr2 = new double[outgoing_feeder_ids_arr.length];

        for (int i = 0; i < incoming_feeder_ids_arr.length; i++) {
            double previous_reading = 0;

            double present_reading = 0;
            double active_import = 0;
            double mf = 1;
    %>
    <tbody>
        <tr>
            <td><%= incoming_feeder_names_arr[i] + " (" + incoming_meter_slnos_arr[i] + ")"%></td>
            <%
                String[] param_names = null;
                pstmt = con.prepareStatement("select * from d3_columns_header where meter_serial_no in(select meter_serial_no from meter where meterid=?) and billing_type='b3'");
                pstmt.setString(1, incoming_meter_ids_arr[i]);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    System.out.println("---------------------------Billing Header Got Dynamically-----------------------------------");
                    param_names = rs.getString("billing_columns_header").split(",");
                } else {
                    System.out.println("---------------------------Billing Header Got Manually-----------------------------------");
                    pstmt = con.prepareStatement("select d3_params from metermake where metermakeid=(select metermake from meter where meterid=?)");
                    pstmt.setString(1, incoming_meter_ids_arr[i]);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        param_names = rs.getString("d3_params").split(",");
                    }//end if
                }//end else
                int kwh_loc = 0;
                for (int j = 0; j < param_names.length; j++) {
                    if (param_names[j].contains("KWh(I)_tot")) {
                        kwh_loc = j;
                    }
                }
                if (DBUtil.getTargetDB().equals("oracle")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,to_char(d3_time_stamp,'dd-MM-yy hh24:mm:ss') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and to_char(d3_time_stamp,'yyyy-MM-dd') like '" + from_date + "%' order by d3_time_stamp desc");
                }
                if (DBUtil.getTargetDB().equals("mysql")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and d3_time_stamp like '" + from_date + "%' order by d3_time_stamp limit 1");
                }
                pstmt.setString(1, incoming_meter_slnos_arr[i]);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String[] data_string_arr = rs.getString("data_string").split(",");
                    System.out.println("in pr--->" + data_string_arr[kwh_loc]);
                    previous_reading = previous_reading + Double.parseDouble(data_string_arr[kwh_loc]);
                    previous_reading_arr1[i] = previous_reading;
                }
                if (DBUtil.getTargetDB().equals("oracle")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,to_char(d3_time_stamp,'dd-MM-yy hh24:mm:ss') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and to_char(d3_time_stamp,'yyyy-MM-dd') like '" + to_date + "%' order by d3_time_stamp desc");
                }
                if (DBUtil.getTargetDB().equals("mysql")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and d3_time_stamp like '" + to_date + "%' order by d3_time_stamp desc limit 1");
                }
                pstmt.setString(1, incoming_meter_slnos_arr[i]);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String[] data_string_arr = rs.getString("data_string").split(",");
                    present_reading = Double.parseDouble(data_string_arr[kwh_loc]);
                    present_reading_arr1[i] = present_reading;
                }
                active_import = present_reading - previous_reading;
            %>
            <td align="right"><%= threeDecFormat.format(previous_reading)%></td>
            <td align="right"><%= threeDecFormat.format(present_reading)%></td>
            <td align="right"><%= threeDecFormat.format(active_import)%></td>
            <!--<td align="right"><%= threeDecFormat.format(mf)%></td>-->
    <!--        <td align="right"><%= threeDecFormat.format(active_import * mf)%></td>-->
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <%
                total_incoming = total_incoming + (active_import * mf);
            %>
        </tr>
    </tbody>
    <%
        }


        //Outgoing feeders    
        for (int i = 0; i < outgoing_feeder_ids_arr.length; i++) {
            System.out.println("4444");
            double previous_reading = 0;
            double present_reading = 0;
            double active_import = 0;
            double mf = 1;
    %>
    <tbody>
        <tr>
            <td>&nbsp;&nbsp;&nbsp;(-)<%= outgoing_feeder_names_arr[i] + " (" + outgoing_meter_slnos_arr[i] + ")"%></td>
            <%

                String[] param_names = null;
                pstmt = con.prepareStatement("select * from d3_columns_header where meter_serial_no in(select meter_serial_no from meter where meterid=?) and billing_type='b3'");
                pstmt.setString(1, outgoing_meter_ids_arr[i]);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    System.out.println("---------------------------Billing Header Got Dynamically-----------------------------------");
                    param_names = rs.getString("billing_columns_header").split(",");
                } else {
                    System.out.println("---------------------------Billing Header Got Manually-----------------------------------");
                    pstmt = con.prepareStatement("select d3_params from metermake where metermakeid=(select metermake from meter where meterid=?)");
                    pstmt.setString(1, outgoing_meter_ids_arr[i]);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        param_names = rs.getString("d3_params").split(",");
                    }//end if
                }//end else

                int kwh_loc = 0;
                for (int j = 0; j < param_names.length; j++) {
                    if (param_names[j].contains("KWh(I)_tot")) {
                        kwh_loc = j;
                    }
                }
                if (DBUtil.getTargetDB().equals("oracle")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,to_char(d3_time_stamp,'dd-MM-yy hh24:mm:ss') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and to_char(d3_time_stamp,'yyyy-MM-dd') like '" + from_date + "%' order by d3_time_stamp desc");
                }
                if (DBUtil.getTargetDB().equals("mysql")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and d3_time_stamp like '" + from_date + "%' order by d3_time_stamp limit 1");
                }
                pstmt.setString(1, outgoing_meter_slnos_arr[i]);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String[] data_string_arr = rs.getString("data_string").split(",");
                    System.out.println("pr read--->" + data_string_arr[kwh_loc]);
                    previous_reading = previous_reading + Double.parseDouble(data_string_arr[kwh_loc]);
                    previous_reading_arr2[i] = previous_reading;
                }
                if (DBUtil.getTargetDB().equals("oracle")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,to_char(d3_time_stamp,'dd-MM-yy hh24:mm:ss') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and to_char(d3_time_stamp,'yyyy-MM-dd') like '" + to_date + "%' order by d3_time_stamp desc");
                }
                if (DBUtil.getTargetDB().equals("mysql")) {
                    pstmt = con.prepareStatement("select d3_time_stamp,date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 b3 where meter_serial_no=? and d3_time_stamp like '" + to_date + "%' order by d3_time_stamp desc limit 1");
                }
                pstmt.setString(1, outgoing_meter_slnos_arr[i]);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String[] data_string_arr = rs.getString("data_string").split(",");
                    System.out.println("ps read--->" + data_string_arr[kwh_loc]);
                    present_reading = Double.parseDouble(data_string_arr[kwh_loc]);
                    present_reading_arr2[i] = present_reading;
                }
                System.out.println("pres--->" + present_reading + "----" + previous_reading);
                active_import = present_reading - previous_reading;
            %>
            <td align="right"><%= threeDecFormat.format(previous_reading)%></td>
            <td align="right"><%= threeDecFormat.format(present_reading)%></td>
            <td align="right"><%= threeDecFormat.format(active_import)%></td>
            <!--<td align="right"><%= threeDecFormat.format(mf)%></td>-->
    <!--        <td align="right"><%= threeDecFormat.format(active_import * mf)%></td>-->
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <%
                total_outgoing = total_outgoing + (active_import * mf);
            %>
        </tr>
    </tbody>
    <%
        }
    %>
    <tbody>
        <tr>
            <td colspan="4" align="right"><strong>Total Loss</strong></td>
            <td align="right"><%= threeDecFormat.format(total_incoming - total_outgoing)%></td>
            <td align="right"><%= twoDecFormat.format(((total_incoming - total_outgoing) / total_incoming) * 100) + " %"%></td>
        </tr>
    </tbody>
</table>
<div style="border:1px solid #494949;margin-bottom: 10px;">
    <table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px">
        <thead>
            <tr>
                <td colspan="9">
                    <strong><%=substation_nm%></strong>
                </td>
            </tr>
            <tr>
                <td colspan="4"><strong>Incoming Feeders</strong></td>
                <td style="border:0px;background:#FFF;">&nbsp;</td>
                <td colspan="4"><strong>Outgoing Feeders</strong></td>
            </tr>
        </thead>
        <thead>
            <tr>
                <td><strong>Feeder Name</strong></td>
                <td><strong>Previous Reading</strong></td>
                <td><strong>Present Reading</strong></td>
                <td><strong>Consumption</strong></td>
                <td style="border:0px;background:#FFF;">&nbsp;</td>
                <td><strong>Feeder Name</strong></td>
                <td><strong>Previous Reading</strong></td>
                <td><strong>Present Reading</strong></td>
                <td><strong>Consumption</strong></td>
            </tr>
        </thead>
        <tbody>
            <%
                int max_size = (outgoing_feeder_ids_arr.length >= incoming_feeder_ids_arr.length) ? outgoing_feeder_ids_arr.length : incoming_feeder_ids_arr.length;
                for (int loop = 0; loop < max_size; loop++) {
                    System.out.println("555");
                    out.println("<tr style='font-size:11px;'>");
                    if (loop < incoming_feeder_ids_arr.length) {
                        out.println("<td>" + incoming_feeder_names_arr[loop] + "</td>");
                        out.println("<td align='right'>" + threeDecFormat.format(previous_reading_arr1[loop]) + "</td>");
                        out.println("<td align='right'>" + threeDecFormat.format(present_reading_arr1[loop]) + "</td>");
                        double consumption_val = present_reading_arr1[loop] - previous_reading_arr1[loop];
                        out.println("<td align='right'>" + threeDecFormat.format(consumption_val) + "</td>");
                    } else {
                        out.println("<td colspan=4 > </td>");
                    }
                    if (loop < outgoing_feeder_ids_arr.length) {
                        out.println("<td style='border:0px;'>&nbsp;</td>");
                        out.println("<td>" + outgoing_feeder_names_arr[loop] + "</td>");
                        out.println("<td align='right'>" + threeDecFormat.format(previous_reading_arr2[loop]) + "</td>");
                        out.println("<td align='right'>" + threeDecFormat.format(present_reading_arr2[loop]) + "</td>");
                        double consumption_val = present_reading_arr2[loop] - previous_reading_arr2[loop];
                        out.println("<td align='right'>" + threeDecFormat.format(consumption_val) + "</td>");
                    } else {
                        out.println("<td colspan=5> </td>");
                    }
                }
            %>
            <tr>
                <td>Total</td>
                <td colspan="3" align='right'><%=threeDecFormat.format(total_incoming)%></td>
                <td style="border:0px;">&nbsp;</td>
                <td colspan="4" align='right'><%=threeDecFormat.format(total_outgoing)%></td>
            </tr>
            <tr>
                <td>Loss</td>
                <td colspan="8" align="right"><%= threeDecFormat.format(total_incoming - total_outgoing)%></td>
            </tr>
            <tr>
                <td>Loss(%)</td>
                <td align="right" colspan="8"><%= twoDecFormat.format(((total_incoming - total_outgoing) / total_incoming) * 100) + " %"%></td>
            </tr>
        </tbody>
    </table>

</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }

%>