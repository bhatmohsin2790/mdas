<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
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
String meter_id1 = dcu_id.split(",")[0];
PreparedStatement pstmt = con.prepareStatement("select substationid from feeder where feederid=(select feederid from meter where meterid=?)");
    pstmt.setString(1, meter_id1);
    ResultSet rs = pstmt.executeQuery();
	if(rs.next())
		dcu_id = rs.getString("substationid");
//out.println("dcu==>"+dcu_id);

    System.out.println("selected dcu id is --->"+dcu_id);
    pstmt = con.prepareStatement("select * from rtu_ai_data where rtu_id=? order by sno desc");
    pstmt.setString(1, dcu_id);
    rs = pstmt.executeQuery();
    String latest_date = "";
    String latest_time = "";
    if(rs.next())
    {
        latest_date = rs.getString("AI_DATE");
        latest_time = rs.getString("TIME");
    }
    System.out.println("latest date is---->"+latest_date);
    System.out.println("latest time is ---->"+latest_time);
    %>
    <table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px">
    <thead>
    <tr>
        <td><strong>ANALOG DATA</strong></td>
        <td align="right">Latest Date & Time : <%= dateFormat.format(dateFormat1.parse(latest_date)) + " " + latest_time %></td>
    </tr>
    </thead>
    </table>
    <%
    pstmt = con.prepareStatement("select * from (select AI_NAME,AI_VALUE,RTU_ID from rtu_ai_data where rtu_id=? and AI_DATE=? and TIME=? order by sno) tab1,(select Name,RTU_ID,Description from analog_input_details where rtu_id=? order by srlno) tab2 where tab1.AI_NAME=tab2.Name");
    pstmt.setString(1, dcu_id);
    pstmt.setString(2, latest_date);
    pstmt.setString(3, latest_time);
    pstmt.setString(4, dcu_id);
    rs = pstmt.executeQuery();
    int no_of_rec = 0;
    %>
    <table border="0" width="350px" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;">
    <thead>
    <tr>
        <td><strong>Description</strong></td>
        <td><strong>Value</strong></td>
    </tr>
    </thead>

    <%
    while(rs.next())
    {
        if(no_of_rec!=0 && no_of_rec%20==0)
        {
            %>
            </table>
            <table border="0" width="350px" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-left: 10px;">
            <thead>
            <tr>
                <td><strong>Description</strong></td>
                <td><strong>Value</strong></td>
                </tr>
            </thead>
            <%
        }
        %>
        <tr>
            <td><%=rs.getString("Description")%></td>
            <td align="right"><%=rs.getString("AI_VALUE")%></td>
        </tr>
        <%
        no_of_rec++;
        if(no_of_rec==8) break;
    }
    if(no_of_rec==0)
    {
        %>
        <tr>
            <td colspan="2" align="center">Data Not Available.</td>
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