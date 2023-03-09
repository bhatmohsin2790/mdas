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
try{
    NumberFormat twoDecFormat = new DecimalFormat("#0.00");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat dateFormat1 = new SimpleDateFormat("dd-MMM-yy");
    SimpleDateFormat dateFormat2 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
String dcu_id = request.getParameter("dcu_id");
String feeder_id = request.getParameter("feeder_id");
    String from_date = request.getParameter("from_date");
    String to_date = request.getParameter("to_date");
System.out.println("From date :"+dateFormat1.format(dateFormat.parse(from_date)));
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
        pstmt = con.prepareStatement("select * from ls_param_names where rtu_id=? and feeder_id=?");
        pstmt.setString(1, dcu_id);
        pstmt.setString(2, feeder_id);
        rs = pstmt.executeQuery();
        %>
        <table border="0" width="98%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;">
        <%
        int params_size = 0;
        String ls_param_names_str;
        if(rs.next())
        {
          ls_param_names_str = rs.getString("PARAM_NAMES");
          
        }

        String[] ls_param_names = rs.getString("PARAM_NAMES").split(",");
        params_size = ls_param_names.length;
        
        pstmt = con.prepareStatement("select * from ls_data where rtu_id=? and feeder_sl_no=? and LS_DATE>=? and LS_DATE<=? order by ls_date,ls_time");
        pstmt.setString(1, dcu_id);
        pstmt.setString(2,feeder_id);
        pstmt.setString(3,dateFormat1.format(dateFormat.parse(from_date)));
        pstmt.setString(4,dateFormat1.format(dateFormat.parse(to_date)));
        rs = pstmt.executeQuery();
        %>
        <thead>
        <tr>
            <td>Description</td>
        <%
        String date_str = "";
        int ls_data_available_flg = 0;
        while(rs.next())
        {
            ls_data_available_flg = 1;
            date_str = date_str + dateFormat.format(dateFormat2.parse(rs.getString("LS_DATE"))) + " " + rs.getString("LS_TIME") +",";
            %>
                <td><%= dateFormat.format(dateFormat2.parse(rs.getString("LS_DATE"))) %><br />
                <%= rs.getString("LS_TIME") %></td>
            <%
        }
        %>
                <td>Average</td><td></td>
        </tr>
        </thead>
        <%
        for(int i=0;i<ls_param_names.length;i++)
        {
            pstmt = con.prepareStatement("select * from ls_data where rtu_id=? and feeder_sl_no=? and LS_DATE>=? and LS_DATE<=? order by ls_date,ls_time");
            pstmt.setString(1, dcu_id);
            pstmt.setString(2,feeder_id);
            pstmt.setString(3,dateFormat1.format(dateFormat.parse(from_date)));
            pstmt.setString(4,dateFormat1.format(dateFormat.parse(to_date)));
            rs = pstmt.executeQuery();

            %>
            <tr>
                <td><%= ls_param_names[i] %></td>
            <%
            double total_val = 0;
            double avg_val = 0;
            int no_of_val = 0;
            String data_str = "";
        while(rs.next())
        {
            ls_data_available_flg = 1;
            data_str = data_str + rs.getString("Param"+(i+1)) + ",";
            total_val = total_val + Double.parseDouble(rs.getString("Param"+(i+1)));
            %>
                <td align="right"><%= rs.getString("Param"+(i+1)) %></td>
            <%
            no_of_val++;
        }
            avg_val = total_val / (double)no_of_val;
            %>
            <td align="right"><font color="green"><%=avg_val%></font></td>

        <td align="right">
            <input type="hidden" id="avg_value<%=i%>" name="avg_value" value="<%=avg_val%>" />
            <input type="hidden" id="ai_name<%=i%>" name="ai_name" value="<%=ls_param_names[i]%>" />
            <input type="hidden" id="ai_values_string<%=i%>" name="ai_values_string" value="<%=data_str%>" />
            <input type="hidden" id="time_values_string<%=i%>" name="time_values_string" value="<%=date_str%>" />
            <input type="button" value="Graph" name="<%=i%>" onClick="create_graph(this.name)"/>
        </td>
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


