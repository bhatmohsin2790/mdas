<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
    #modem_alerts h3
    {background-color:#EEEEEE;
     border:1px solid #EEEEEE;
     color:#666666;
     width:auto;
     font-size:12px;
     padding:5px 15px;
     text-decoration:none;}

</style>

<%
    Connection con1 = null;
    Statement st = null;
    PreparedStatement pstmt = null;
    int flag = 0;
    String sql = null;
    String sql1, sql2 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    String meterId = request.getParameter("meterId").trim();
    String fromDate = request.getParameter("date").trim();
    String endDate = request.getParameter("endDate").trim();
    String chkvalue = request.getParameter("values");

    int start = Integer.parseInt(request.getParameter("start"));
    System.out.print("start value is" + start);

    int limit = 10;
    int count = 0;
    if (con1 != null) {
        con1.close();
    }
    con1 = new DBUtil().getConnection();
    sql2 = "select count(*) from modem_alerts where meter_id='" + meterId + "' and to_char(alert_generated_date,'dd/mm/yyyy') between '" + fromDate + "'and '" + endDate + "'";

    pstmt = con1.prepareStatement(sql2);
    rs = pstmt.executeQuery();
    if (rs.next()) {
        count = rs.getInt(1);
    }//end if
    System.out.println("Total No of records :" + count);
    //---------------
    System.out.println("meterid is" + meterId);

    st = con1.createStatement();
    sql = "select meter_serial_no,modem_serial_no from meter where meterid='" + meterId + "'";
    System.out.println("sql is" + sql);
    pstmt = con1.prepareStatement(sql);
    rs1 = pstmt.executeQuery();
%>
<table border="1"  id="modem_alerts" cellpadding="0"  cellspacing="0" style="border:silver;">
    <tbody>

        <%
            if (rs1.next()) {

        %>

        <tr><td colspan="3">&nbsp;&nbsp;Meter_sl_No:&nbsp;<%=rs1.getString("meter_serial_no")%>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Modem_sl_No:&nbsp;<%=rs1.getString("modem_serial_no")%></td>
        </tr>
        <% }%>
        <tr>

            <td><h3>ALERT_CODE</h3></td>
            <td ><h3>ALERT-DESC</h3></td>
            <td><h3>ALERT_GENERATED_DATE</h3></td>
        </tr>

        <%
            try {

                sql1 = "select alert_code,alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') from"
                        + "(select alert_code,alert_desc,ALERT_GENERATED_DATE,meter_id,rownum r from"
                        + "(select alert_code,alert_desc,ALERT_GENERATED_DATE,meter_id from modem_alerts where meter_id='" + meterId + "' and to_char(alert_generated_date,'dd/mm/yyyy') between '" + fromDate + "'and '" + endDate + "' order by alert_generated_date desc"
                        + ")where rownum<=?) where r>=?";
                System.out.println("query is" + sql1);

                pstmt = con1.prepareStatement(sql1);
                pstmt.setInt(1, start + limit);
                pstmt.setInt(2, start);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    flag = 1;

        %>

        <tr>
            <td align="center"><%=rs.getInt("ALERT_CODE")%></td>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(3)%></td>

        </tr>


        <%
                }
                if (flag == 0) {
                    out.println("No Alerts Between These Dates");
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </tbody></table>

<!--code for pagination ----------->
<table width="100%" border="0">
    <tr>
        <td width="100%" align="center">
            <table>&nbsp;&nbsp;
                <tr>
                    <%


                        // code for previous
                        int start_tmp = start;

                        // code for page numbers
                        //  start = 1;

                        if (((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1 > 10) {
                    %>
                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:Alerts(<%=((start_tmp / 100) * 100) - 9%>)" style="text-decoration:none;">Prev 10</a></td>&nbsp;
                    <%
                        }
                        int page_no_start = (start_tmp / 100) * 100 + 1;
                        int page_no_end = ((start_tmp / 100) * 100) + 90;
                        page_no_start = (page_no_start / 10) + 1;
                        page_no_end = (page_no_end / 10) + 1;

                        start = 1;
                        if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                            page_no_end = (int) Math.ceil((double) count / (double) limit);
                        }

                        for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++) {
                            if (i >= page_no_start && i <= page_no_end) {
                                if (i == ((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1) {
                    %>

                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:Alerts(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>&nbsp;

                    <%
                    } else {
                    %>

                    <td id="pageNo"><a href="#"  onclick="javascript:Alerts(<%=start%>)"><%=i%></a></td>&nbsp;

                    <%
                                }
                            }
                            start = start + limit;
                        }
                        // code for next
                        //if((((Integer.parseInt(request.getParameter("start"))-1)/10)+1)>=1)
                        start = start_tmp;
                        if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                        } else {


                            start = Integer.parseInt(request.getParameter("start")) + 100;

                    %>

                    <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:Alerts(<%=start%>)" style="text-decoration:none;">Next 10</a></td>&nbsp;

                    <%
                        }

                    %>
                </tr>
            </table>
        </td>
    </tr>
</table>



