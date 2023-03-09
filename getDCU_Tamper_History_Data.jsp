<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%
try{
    Map tamper_map = new HashMap();

            //Voltage Related Tampers
            tamper_map.put("1", "R-Phase - PT link Missing (Missing Potential)@Occurrence");
            tamper_map.put("2", "R-Phase - PT link Missing (Missing Potential)@Restoration");
            tamper_map.put("3", "Y-Phase - PT link Missing (Missing Potential)@Occurrence");
            tamper_map.put("4", "Y-Phase - PT link Missing (Missing Potential)@Restoration");
            tamper_map.put("5", "B-Phase - PT link Missing (Missing Potential)@Occurrence");
            tamper_map.put("6", "B-Phase - PT link Missing (Missing Potential)@Restoration");

            tamper_map.put("7", "Over Voltage in any Phase@Occurrence");
            tamper_map.put("8", "Over Voltage in any Phase@Restoration");

            tamper_map.put("9", "Low Voltage in any Phase@Occurrence");
            tamper_map.put("10", "Low Voltage in any Phase@Restoration");

            tamper_map.put("11", "Voltage Unbalance@Occurrence");
            tamper_map.put("12", "Voltage Unbalance@Restoration");

            //Current Related Tampers
            tamper_map.put("51", "Phase - R CT reverse@Occurrence");
            tamper_map.put("52", "Phase - R CT reverse@Restoration");
            tamper_map.put("53", "Phase - Y CT reverse@Occurrence");
            tamper_map.put("54", "Phase - Y CT reverse@Restoration");
            tamper_map.put("55", "Phase - B CT reverse@Occurrence");
            tamper_map.put("56", "Phase - B CT reverse@Restoration");

            tamper_map.put("57", "Phase - R CT Open@Occurrence");
            tamper_map.put("58", "Phase - R CT Open@Restoration");
            tamper_map.put("59", "Phase - Y CT Open@Occurrence");
            tamper_map.put("60", "Phase - Y CT Open@Restoration");
            tamper_map.put("61", "Phase - B CT Open@Occurrence");
            tamper_map.put("62", "Phase - B CT Open@Restoration");

            tamper_map.put("63", "Current Unbalance@Occurrence");
            tamper_map.put("64", "Current Unbalance@Restoration");

            tamper_map.put("65", "CT Bypass@Occurrence");
            tamper_map.put("66", "CT Bypass@Restoration");

            tamper_map.put("67", "Over Current in any Phase@Occurrence");
            tamper_map.put("68", "Over Current in any Phase@Restoration");

            //Power Failure Related Tampers
            tamper_map.put("101", "Power failure (3 phase)@Occurrence");
            tamper_map.put("102", "Power failure (3 phase)@Restoration");

            //Others
            tamper_map.put("201", "Influence of Permanent Magnet or AC/ DC Electromagnet@Occurrence");
            tamper_map.put("202", "Influence of Permanent Magnet or AC/ DC Electromagnet@Restoration");
            tamper_map.put("203", "Neutral Disturbance  - HF & DC@Occurrence");
            tamper_map.put("204", "Neutral Disturbance  - HF & DC@Restoration");
            tamper_map.put("205", "Very Low PF@Occurrence");
            tamper_map.put("206", "Very Low PF@Restoration");

            //Transaction Related Tampers
            tamper_map.put("151", "Real Time Clock - Date and Time@Occurrence");
            tamper_map.put("152", "Demand Integration Period@Occurrence");
            tamper_map.put("153", "Profile Capture Period@Occurrence");
            tamper_map.put("154", "Single-action Schedule for Billing Dates@Occurrence");
            tamper_map.put("155", "Activity Calendar for Time Zones etc@Occurrence");

            //Non Roll Over Tampers
            tamper_map.put("251", "Meter Cover Opening@Occurrence");

            //Control Tampers
            tamper_map.put("301", "Meter disconnected@Occurrence");
            tamper_map.put("302", "Meter connected@Occurrence");

    NumberFormat twoDecFormat = new DecimalFormat("#0.00");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MMM-yy");
    SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
String dcu_id = request.getParameter("dcu_id");
String feeder_id = request.getParameter("feeder_id");
    String from_date = request.getParameter("from_date");
    String to_date = request.getParameter("to_date");
PreparedStatement pstmt = con.prepareStatement("select * from digital_input_details where rtu_id=? order by srlno");
pstmt.setString(1, dcu_id);
ResultSet rs = pstmt.executeQuery();
String feeder_names = "";
String di_names = "";
while(rs.next())
{
    feeder_names = feeder_names + rs.getString("DESCRIPTION") + ",";
    di_names = di_names + rs.getString("Name1") + ",";
}

String[] feeders = feeder_names.split(",");
String[] dis = di_names.split(",");
//out.println(di_names);
    pstmt = con.prepareStatement("SELECT distinct AI_NAME,Name,Description FROM rtu_ai_data ai inner join analog_input_details analog on ai.AI_NAME=analog.Name and ai.rtu_id=? and analog.rtu_id=? and Feeder_ID=1");
    pstmt.setString(1, dcu_id);
    pstmt.setString(2, dcu_id);
    rs = pstmt.executeQuery();
    Map param_names = new HashMap();
    int no_of_rows = 4;
    while(rs.next())
    {
        no_of_rows++;
        param_names.put(rs.getString("AI_NAME"), rs.getString("DESCRIPTION"));
    }
        pstmt = con.prepareStatement("select * from tamper_param_names where rtu_id=? and feeder_id=?");
        pstmt.setString(1, dcu_id);
        pstmt.setString(2, feeder_id);
        rs = pstmt.executeQuery();
        %>
        <table border="0" width="auto" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;">
        <%
        int params_size = 0;
        if(rs.next())
        {
          String[] ls_param_names = rs.getString("PARAM_NAMES").split(",");
          params_size = ls_param_names.length;
          %>
              <thead>
              <tr>
                  <td><strong>DATE</strong></td>
                  <td><strong>TIME</strong></td>
                  <td width="200px"><strong>Tamper Type</strong></td>
                  <td><strong>Tamper Status</strong></td>
                  <%
          for(int j=0;j<ls_param_names.length;j++)
          {
              %>
              <td><%=ls_param_names[j] %></td>
              <%
          }
          %>
          </tr>
              </thead>
          <%
        }
System.out.println("ddd-->"+dateFormat2.format(dateFormat.parse(from_date)));
        pstmt = con.prepareStatement("select * from tamper_data where rtu_id=? and feeder_sl_no=? and tamper_date>=? and tamper_date<=? order by tamper_date desc,tamper_time desc");
        pstmt.setString(1, dcu_id);
        pstmt.setString(2, feeder_id);
        pstmt.setString(3, dateFormat2.format(dateFormat.parse(from_date)));
        pstmt.setString(4, dateFormat2.format(dateFormat.parse(to_date)));
        rs = pstmt.executeQuery();
        int ls_data_available_flg = 0;
        while(rs.next())
        {
            ls_data_available_flg = 1;
            String tamper_data = (String)tamper_map.get(rs.getString("Tamper_Type"));
            String[] tamper_data_arr = tamper_data.split("@");
            %>
            <tr>
                <td><%= dateFormat.format(dateFormat2.parse(rs.getString("TAMPER_DATE"))) %></td>
                <td><%= rs.getString("TAMPER_TIME") %></td>
                <td width="150px"><%= tamper_data_arr[0] %></td>
                <td><%= tamper_data_arr[1] %></td>
                <%
                String[] param_values = rs.getString("DATA_STRING").split(",");
                for(int j=0;j<param_values.length;j++)
                    {
                %>
                <td align="right"><%= param_values[j] %></td>
                <% } %>
            </tr>
            <%
        }
        if(ls_data_available_flg == 0)
        {
            %>
            <tr>
                <td width="500px" colspan="<%= params_size+2 %>" align="center">Data Not Available For This Feeder.</td>
            </tr>
            <%
        }
        %>

        </table>
        <%
}
catch(Exception e)
           {
    e.printStackTrace();
}
finally{
    con.close();
}
%>