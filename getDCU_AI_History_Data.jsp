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
try
{
    NumberFormat twoDecFormat = new DecimalFormat("#0.00");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
    String dcu_id = request.getParameter("dcu_id");
    String feeder_id = request.getParameter("feeder_id");
    String from_date = request.getParameter("from_date");
    String from_time = request.getParameter("from_time");
    String to_date = request.getParameter("to_date");
    String to_time = request.getParameter("to_time");
    System.out.println(from_date);
    System.out.println(to_date);
    PreparedStatement pstmt = con.prepareStatement("select Name,RTU_ID,Description from analog_input_details where rtu_id=? order by srlno");
    pstmt.setString(1, dcu_id);
    ResultSet rs = pstmt.executeQuery();
    Map param_names = new HashMap();
    String[] ai_temp = new String[100];
    int i = 0;
    while(rs.next())
    {
        ai_temp[i]= rs.getString("Name");
        param_names.put(rs.getString("Name"), rs.getString("DESCRIPTION"));
        i++;
    }
    String[] ai = new String[i];
    %>
<table border="0" width="auto" id="table_disp" cellpadding="0" cellspacing="1px" align="left">

    <%
    String time_values_str = "";
    for(int j=0;j<8;j++)
    {
        ai[j] = ai_temp[j];

        pstmt = con.prepareStatement("select AI_NAME,AI_VALUE,RTU_ID,AI_DATE,TIME from rtu_ai_data where rtu_id=? and AI_NAME=? and timestamp(CONCAT(AI_DATE,' ',TIME))>=timestamp(?) and timestamp(CONCAT(AI_DATE,' ',TIME))<=timestamp(?) order by timestamp(CONCAT(AI_DATE,' ',TIME))");
        pstmt.setString(1, dcu_id);
        pstmt.setString(2, ai[j]);
        pstmt.setString(3, dateFormat1.format(dateFormat.parse(from_date))+" "+from_time);
        pstmt.setString(4, dateFormat1.format(dateFormat.parse(to_date))+" "+to_time);
        rs = pstmt.executeQuery();
        %>
            <thead>
                <tr>
                    <td>Description</td>
        <%
        while(rs.next())
        {
            out.println("<td align=right>"+rs.getString("ai_date")+"<br />"+rs.getString("time")+"</td>");
        }
        %>
        </tr>
        </thead>
        <%
        break;
    }
int data_flag = 0;
    for(int j=0;j<8;j++)
    {
        ai[j] = ai_temp[j];

        pstmt = con.prepareStatement("select AI_NAME,AI_VALUE,RTU_ID,AI_DATE,TIME from rtu_ai_data where rtu_id=? and AI_NAME=? and timestamp(CONCAT(AI_DATE,' ',TIME))>=timestamp(?) and timestamp(CONCAT(AI_DATE,' ',TIME))<=timestamp(?) order by timestamp(CONCAT(AI_DATE,' ',TIME))");
        pstmt.setString(1, dcu_id);
        pstmt.setString(2, ai[j]);
        pstmt.setString(3, dateFormat1.format(dateFormat.parse(from_date))+" "+from_time);
        pstmt.setString(4, dateFormat1.format(dateFormat.parse(to_date))+" "+to_time);
        rs = pstmt.executeQuery();
        %>
        <tr>
            <td width="150px"><%= param_names.get(ai[j]) %></td>
        <%
        int no_of_val = 0;
        while(rs.next())
        {
            data_flag = 1;
            int ai_value = Integer.parseInt(rs.getString("ai_value"));
            out.println("<td>");
                out.println(ai_value);
            out.println("</td>");
            no_of_val++;
        }
        %>
        </tr>
        <%
    }
System.out.println("data_flag:"+data_flag);
    if(data_flag == 0)
        {
        %>
        <tr>
            <td width="600px">Data Not Available.</td>
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
