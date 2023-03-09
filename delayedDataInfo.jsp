<%@page import="java.util.concurrent.TimeUnit"%>
<%@include file="report_header.jsp" %>
<%@ include file="getConnection.jsp"%>
<table border="0" width="60%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-right: 10px;" >
    <thead>
    <td align="center">Scheduled Time</td>
    <td align="center">Meter RTC</td>
    <td align="center">Server Time</td>
    <td align="center">CDF Processed Time</td>
    <!-- <td align="center">Time Delay(hh:mm:ss)</td>         -->
</thead>
<tbody>
    <%
        int flag = 0;
        String meterId = request.getParameter("meterId").trim();
        System.out.println("meter id --->" + meterId);
        // String sql="select scheduled_date,g2,g3,time_delay,rtc_diff from cdf_comm_report where meter_serial_no='"+meterId+"' and time_delay>15 ";
        String sql = "SELECT scheduled_date,g2,g3,date_format(log_timestamp,'%d-%m-%Y %H:%i:%s'),TIMESTAMPDIFF(SECOND,str_to_date(g3,'%d-%m-%Y %H:%i:%s'),log_timestamp) FROM mdas_test.cdf_comm_report where meter_serial_no='" + meterId + "' AND (TIMESTAMPDIFF(SECOND,str_to_date(g3,'%d-%m-%Y %H:%i:%s'),log_timestamp)/60) >60 order by scheduled_date desc";
        PreparedStatement ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            flag = 1;
            if (rs.getString(1).equals(null)) {%>
    <tr><td colspan="4">Scheduled time is not configured</td></tr>
    <%     } else {
    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(2)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(4)%></td>  
        <%
            Long inSeconds = Long.parseLong(rs.getString(5));
            Long hours = TimeUnit.SECONDS.toHours(inSeconds);
            Long minutes = TimeUnit.SECONDS.toMinutes(inSeconds - (hours * 60 * 60));
            Long seconds = TimeUnit.SECONDS.toSeconds(inSeconds - ((hours * 60 * 60) + (minutes * 60)));
        %>                                                     
    </tr>
    <% }
                }
        con.close();
                if (flag == 0)%>
    <tr><td colspan="4" align="center">No Delayed Data</td></tr>
</tbody>
</table>