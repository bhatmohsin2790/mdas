<%@include file="report_header.jsp" %>
<%!
   PreparedStatement pstmt = null;
   ResultSet rs = null;
%>
<%
try{
      String meter_id = "";
    if(request.getParameter("meter_id")==null ||  request.getParameter("meter_id")=="")
       {
    meter_id = (String)session.getAttribute("meter_id");
    }else
       meter_id = request.getParameter("meter_id");
    session.setAttribute("meter_id",meter_id);
   String stringToReturn = "";
    %>

<%@ include file="getConnection.jsp"%>

<table width="100%" border="0">
    <tr bgcolor="#56a5ec">
        <td colspan="6" align="center" class="head1">
             TOD ENERGY CONSUMPTION
        </td>
    </tr>
</table>
<table class="mtable">
    <tr>
        <td class="td1">
            Billing Dates
        </td>
        <td class="td1">
            TOD Reg.
        </td>

<%
 pstmt = con.prepareStatement("select b4_tod_params from metermake where metermakeid=(select metermake from meter where meterid="+meter_id+")");
   rs = pstmt.executeQuery();

   while(rs.next())
   {
    String data_string2[] = rs.getString("b4_tod_params").split(",");
    for(int i=0;i<data_string2.length;i++){
    %>
    <td class="td1"><%=data_string2[i]%></td>
    <%}
    }
%>

    </tr>


   <%

String meter_sl_no="";
  pstmt = con.prepareStatement("select meter_serial_no from meter where meterid="+meter_id);
   rs = pstmt.executeQuery();
      if(rs.next())
   {
meter_sl_no = rs.getString("meter_serial_no");
}
   session.setAttribute("meter_sl_no",meter_sl_no);

   System.out.println("meterid---->"+meter_id);
   pstmt = con.prepareStatement("select  distinct(billing_date),b4.tod_value,b4.data_string from d3_b4 b4,d3_dates dates where b4.cdfid=dates.cdfid and b4.billing_day=dates.billing_day and b4.cdfid in (select cdfid from meter_data_time_stamp where meterid="+meter_id+") order by billing_date desc");
   rs = pstmt.executeQuery();
   String dataString = "";
   while(rs.next())
   {
    String data_string[] = rs.getString("data_string").split(",");
if(Integer.parseInt(rs.getString("tod_value"))==0)
    {
    %>
    <tr style="background:#EDF5FA;">
    <%
    }
    else
        {
        %>
        <tr>
        <%
        }
 %>
        <td class="td2"><%=rs.getString("billing_date")%></td>
         <td class="td2"><%=rs.getString("tod_value")%></td>
        <% for(int i=0;i<=data_string.length-1;i++){ %>
        <td class="td2"><%=data_string[i]%></td>
        <% } %>
    </tr>
    <%
    }
   %>
   </table>
   <%
   }
catch(Exception e)
        {out.println("Plz Try Again....");e.printStackTrace();}
%>
