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
try
{
    NumberFormat twoDecFormat = new DecimalFormat("#0.00");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
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
    PreparedStatement pstmt = con.prepareStatement("SELECT distinct AI_NAME,Name,Description FROM rtu_ai_data ai inner join analog_input_details analog on ai.AI_NAME=analog.Name and ai.rtu_id=? and analog.rtu_id=? and Feeder_ID=? order by substr(AI_NAME,3)+0");
    pstmt.setString(1, dcu_id);
    pstmt.setString(2, dcu_id);
    pstmt.setString(3, feeder_id);
    ResultSet rs = pstmt.executeQuery();
    Map param_names = new HashMap();
    String[] ai_temp = new String[100];
    int i = 0;
    while(rs.next())
    {
        ai_temp[i]= rs.getString("AI_NAME");
        param_names.put(rs.getString("AI_NAME"), rs.getString("DESCRIPTION"));
        i++;
    }
    String[] ai = new String[i];
    %>
<table border="0" width="auto" id="table_disp" cellpadding="0" cellspacing="1px" align="left">

    <%
    String time_values_str = "";
    for(int j=0;j<i;j++)
    {
        ai[j] = ai_temp[j];

        pstmt = con.prepareStatement("SELECT * FROM rtu_ai_data where AI_NAME=? and RTU_ID=? and feeder_id=? and to_timestamp(AI_DATE||TIME,'YYYY-MM-DD HH24:MI:SS') >= to_timestamp(?,'YYYY-MM-DD HH24:MI:SS') and to_timestamp(AI_DATE||TIME,'YYYY-MM-DD HH24:MI:SS') <= to_timestamp(?,'YYYY-MM-DD HH24:MI:SS') order by SNO");
        pstmt.setString(1, ai[j]);
        pstmt.setString(2, dcu_id);
        pstmt.setString(3, feeder_id);
        pstmt.setString(4, dateFormat1.format(dateFormat.parse(from_date))+" "+from_time);
        pstmt.setString(5, dateFormat1.format(dateFormat.parse(to_date))+" "+to_time);
        rs = pstmt.executeQuery();
        %>
            <thead>
                <tr>
                    <td style="-moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-box-shadow: 0 6px 10px #A1A1A1;
    -webkit-box-shadow: 0 6px 10px #A1A1A1;">Description</td>
        <%
        while(rs.next())
        {
            time_values_str = time_values_str + rs.getString("ai_date") +" "+rs.getString("time") +",";
            out.println("<td align=right>"+rs.getString("ai_date")+"<br />"+rs.getString("time")+"</td>");
        }
        %>
        <td Align="right">Average</td>
        <td></td>
        </tr>
        </thead>
        <%
        break;
    }
int data_flag = 0;
    for(int j=0;j<i;j++)
    {
        ai[j] = ai_temp[j];

        pstmt = con.prepareStatement("SELECT * FROM rtu_ai_data where AI_NAME=? and RTU_ID=? and feeder_id=? and to_timestamp(AI_DATE||TIME,'YYYY-MM-DD HH24:MI:SS') >= to_timestamp(?,'YYYY-MM-DD HH24:MI:SS') and to_timestamp(AI_DATE||TIME,'YYYY-MM-DD HH24:MI:SS') <= to_timestamp(?,'YYYY-MM-DD HH24:MI:SS') order by SNO");
        pstmt.setString(1, ai[j]);
        pstmt.setString(2, dcu_id);
        pstmt.setString(3, feeder_id);
        pstmt.setString(4, dateFormat1.format(dateFormat.parse(from_date))+" "+from_time);
        pstmt.setString(5, dateFormat1.format(dateFormat.parse(to_date))+" "+to_time);
        rs = pstmt.executeQuery();
        %>
        <tr>
            <td width="150px"><%= param_names.get(ai[j]) %></td>
        <%
        double avg_val = 0;
        double total_val = 0;
        int no_of_val = 0;
        String ai_values_str = "";
        while(rs.next())
        {
            data_flag = 1;
            total_val = total_val + Double.parseDouble(rs.getString("ai_value"));
            out.println("<td align='right'>"+rs.getString("ai_value")+"</td>");
            ai_values_str = ai_values_str  + rs.getString("ai_value") + ",";
            no_of_val++;
        }
        avg_val = total_val/(double)no_of_val;
        NumberFormat formatter=new DecimalFormat(".000");
        avg_val =Double.parseDouble(formatter.format(avg_val));
        %>
        <td align="right"><font color="green"><%=avg_val%></font></td>
        
        <td align="right">
            <input type="hidden" id="avg_value<%=j%>" name="avg_value" value="<%=avg_val%>" />
            <input type="hidden" id="ai_name<%=j%>" name="ai_name" value="<%=param_names.get(ai[j])%>" />
            <input type="hidden" id="ai_values_string<%=j%>" name="ai_values_string" value="<%=ai_values_str%>" />
            <input type="hidden" id="time_values_string<%=j%>" name="time_values_string" value="<%=time_values_str%>" />
            <input type="button" value="Graph" name="<%=j%>" onClick="create_graph(this.name)"/>
        </td>
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
