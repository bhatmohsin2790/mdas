<%@page import="java.text.*"%>
<%@ include file="getConnection.jsp"%>
<%     PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
            try {
               // pstmt = con.prepareStatement("SELECT substationname,dynamic_ip,date_time FROM substation_ip tab1 LEFT JOIN substation tab2 ON tab1.substationid=tab2.SUBSTATIONID WHERE tab1.substationid!=0 AND tab2.SUBSTATIONNAME!='' order by substationname,date_time desc ");
			   pstmt = con.prepareStatement("SELECT SS.SUBSTATIONNAME, SI.DYNAMIC_IP,to_char(SI.LOG_TIME_STAMP,'DD-MM-YYYY HH24:MI:SS') LOG_TIME_STAMP FROM SUBSTATION_IP SI, SUBSTATION SS WHERE SI.SUBSTATIONID (+) = SS.SUBSTATIONID AND SI.DYNAMIC_IP IS NOT NULL ORDER BY LOG_TIME_STAMP DESC");
		rs = pstmt.executeQuery();
%>
<table border=0>
<tr>
<td valign="top">
<table border=0 width=500px>
<thead>
<tr>
<td>SUBSTATION</td>
<td>DYNAMIC IP</td>
<td>DATE TIME</td>
</tr>
</thead>
<tbody>
<%
String sub_nm = "none";
int loop=0;
	while(rs.next())
{
if(loop!=0 && !sub_nm.equals(rs.getString("substationname")))
{
	%>
</tbody>
</table>
</td>
<td valign="top">
<td valign="top">
<table border=0 width=500px>
<thead>
<tr>
<td>SUBSTATION</td>
<td>DYNAMIC IP</td>
<td>DATE TIME</td>
</tr>
</thead>
<tbody>
	<%
}
loop++;
sub_nm = rs.getString("substationname");
%>
<tr>
<td><%= rs.getString("substationname") %></td>
<td><%= rs.getString("dynamic_ip") %></td>
<td><%= rs.getString("LOG_TIME_STAMP") %></td>
</tr>
<%	
}
%>
</tbody>
</table>
</td>
</tr>
</table>
<%
                }
catch(Exception e)
{}
finally
{
	if(con!=null)
	con.close();
}
%>
