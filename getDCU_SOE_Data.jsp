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

    pstmt = con.prepareStatement("select * from rtu_di_data where rtu_id=? order by sno desc");
    pstmt.setString(1, dcu_id);
    rs = pstmt.executeQuery();
    String latest_date = "";
    String latest_time = "";
    if(rs.next())
    {
        latest_date = rs.getString("DI_DATE");
        latest_time = rs.getString("TIME");
    }
    pstmt = con.prepareStatement("select * from (select DIV_ID,DIV_VALUE,SOE_DATE,TIME,RTU_ID from rtu_soe_data where rtu_id=? order by soe_date desc,time desc) tab1,(select Name1,RTU_ID,Description from digital_input_details where rtu_id=? order by srlno) tab2 where tab1.DIV_ID=tab2.Name1 order by soe_date desc,time desc");
    pstmt.setString(1, dcu_id);
    pstmt.setString(2, dcu_id);
    rs = pstmt.executeQuery();
    int no_of_rec = 0;
    %>
    <table border="0" width="350px" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;">
    <thead>
    <tr>
        <td><strong>Description</strong></td>
        <td><strong>SOE DATE</strong></td>
        <td><strong>SOE TIME</strong></td>
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
                <td><strong>SOE DATE</strong></td>
                <td><strong>SOE TIME</strong></td>
                <td><strong>Status</strong></td>
                </tr>
            </thead>
            <%
        }
        %>
        <tr <% if(no_of_rec==0){ out.println("style='background:#C0C0C0;'"); } %>>
            <td><%=rs.getString("Description")%></td>
            <td align="right"><%=dateFormat.format(dateFormat1.parse(rs.getString("SOE_DATE")))%></td>
            <td align="right"><%=rs.getString("TIME")%></td>
            <td align="left">
<%
            int di_value = Integer.parseInt(rs.getString("div_value"));
            switch(di_value)
            {
                case 0: out.println("Undefined");break;
                case 1: out.println("OPEN");break;
                case 2: out.println("CLOSE");break;
                case 3: out.println("Transiant");break;
            }
            %>
</td>
        </tr>
        <%
        no_of_rec++;
    }
    if(no_of_rec==0)
    {
        %>
        <tr>
            <td colspan="4" align="center">Data Not Available.</td>
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