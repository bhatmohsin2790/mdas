<%@page import="java.text.SimpleDateFormat"%>
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
    int flag = 0;
    String sql = null;
    String sql1 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    String[] values;
    String substationName = "";
    String meterLocation = request.getParameter("location").trim();
    String substationId = request.getParameter("substationId").trim();
    String meterId = request.getParameter("meterId").trim();
    String fromDate = request.getParameter("date").trim();
    String endDate = request.getParameter("endDate").trim();
    String chkvalue = request.getParameter("values");
    System.out.println("chk value is" + chkvalue);
    int start = Integer.parseInt(request.getParameter("start"));
    System.out.println("start value is" + start);
    int limit = 10;
    int count = 0;
    if (!meterLocation.equals("feeder")) {
        System.out.println("meterid is" + meterId);
        if(con1 != null)
        {
            con1.close();
        }
        con1 = new DBUtil().getConnection();
        st = con1.createStatement();
        sql = "select meter_serial_no,modem_serial_no from meter where meter_serial_no='" + meterId + "'";
        System.out.println("sql is" + sql);
        rs1 = st.executeQuery(sql);

%>
<table border="1" class='mtable' id="modem_alerts" cellpadding="2" cellspacing="2" >
    <tbody>
        <%
            if (rs1.next()) {

        %>
        <tr><td colspan="3">&nbsp;&nbsp;&nbsp;Meter_sl_No:&nbsp;<%=meterId%>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Modem_sl_No:&nbsp;<%=rs1.getString("modem_serial_no")%></td>
        </tr>
        <% }%>
        <tr>
            <td ><h3>ALERT DESC</h3></td>
            <td><h3>ALERT GENERATED DATE</h3></td>
        </tr>

        <%
            try {
                if (DBUtil.getTargetDB().equals("oracle")) {
                    sql1 = "select alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') from modem_alerts  where meter_id='" + meterId + "' and alert_generated_date >= to_date('" + fromDate + "','dd/mm/yyyy') and alert_generated_date < = to_date('" + endDate + "','dd/mm/yyyy')";
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        //System.out.println("Latest date---->"+latestDate);

                        sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S') from modem_alerts where meter_id='" + meterId + "' and alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";

                    } else {

                        sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S') from modem_alerts where meter_id='" + meterId + "' and ";

                    }

                }
                sql1 = sql1 + "substr(alert_desc ,1,3) in (";

                if (chkvalue.contains("0")) //for Meter com failed.
                {
                    sql1 = sql1 + "'Met'";
                } else {
                    sql1 = sql1 + "''";
                }
                if (chkvalue.contains("1")) // for AMR power failed.
                {
                    sql1 = sql1 + ",'AMR'";
                } else {
                    sql1 = sql1 + ",''";
                }
                if (chkvalue.contains("2")) // for DTR power failed.
                {
                    sql1 = sql1 + ",'DTR'";
                } else {
                    sql1 = sql1 + ",''";
                }
                if (chkvalue.contains("3")) // for CRC failed.
                {
                    sql1 = sql1 + ",'CRC'";
                } else {
                    sql1 = sql1 + ",''";
                }

                sql1 = sql1 + ") order by alert_generated_date desc";

                System.out.println("query is" + sql1);
                rs = st.executeQuery(sql1);
                while (rs.next()) {
                    flag = 1;

        %>

        <tr>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td>

        </tr>

        <%
            }
            if (flag == 0) {%>
        <tr><td colspan="2" align="center">No Alerts</td></tr>
        <%  }

            } catch (Exception e) {
                e.printStackTrace();
            }//catch      
        %>
    </tbody></table>
    <%  }//if not feeder
    else {      //if feeder
        System.out.println("meterid is" + meterId);
        con1 = new DBUtil().getConnection();
        st = con1.createStatement();
        sql = "select substationname from substation where substationid=" + substationId;
        rs1 = st.executeQuery(sql);
        if (rs1.next()) {
            substationName = rs1.getString(1);
        }
        rs1.close();
        st.close();
        System.out.println("substationname is----->" + substationName);
        st = con1.createStatement();
        sql = "select meter_serial_no,modem_serial_no from meter where meter_serial_no='" + meterId + "'";
        System.out.println("sql is" + sql);
        rs1 = st.executeQuery(sql);

    %>
<table border="1" class='mtable' id="modem_alerts" cellpadding="2" cellspacing="2" >
    <tbody>
        <%
            if (rs1.next()) {

        %>
        <tr><td colspan="3" align="center">&nbsp;&nbsp;&nbsp;Meter Serial Number:&nbsp;<%=meterId%>


        </tr>
        <% }%>
        <tr>

            <% if (meterId.equals("All")) {%>
            <td><h3>SUBSTATION</h3></td>
            <td><h3>FEEDER </h3></td>
            <% }%>
            <td ><h3>ALERT DESC</h3></td>
            <td><h3>ALERT GENERATED DATE</h3></td>
        </tr>

        <%
            try {
                if (DBUtil.getTargetDB().equals("oracle")) {
                    sql1 = "select alert_desc,to_char(ALERT_GENERATED_DATE,'dd/mm/yyyy hh24:mi:ss') from modem_alerts  where meter_id='" + meterId + "' and alert_generated_date >= to_date('" + fromDate + "','dd/mm/yyyy') and alert_generated_date < = to_date('" + endDate + "','dd/mm/yyyy')";
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    if (!fromDate.equals("") && !endDate.equals("")) {
                        //getting the next date of end date
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        java.util.Date oldDate = sdf.parse(endDate);
                        java.util.Date newDate = new java.util.Date(oldDate.getTime() + 24 * 3600000);
                        String latestDate = sdf.format(newDate);
                        //System.out.println("Latest date---->"+latestDate);
                        if (meterId.equals("All")) {
                            sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S'),meter_id from modem_alerts where alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";
                        } else {
                            sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S') from modem_alerts where meter_id='" + meterId + "' and alert_generated_date >= str_to_date('" + fromDate + "','%d/%m/%Y') and alert_generated_date <= str_to_date('" + latestDate + "','%d/%m/%Y') and ";
                        }
                    } else {
                        if (meterId.equals("All")) {
                            sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S'),meter_id from modem_alerts where ";
                        } else {
                            sql1 = "select alert_desc,DATE_FORMAT(alert_generated_date,'%d/%m/%Y %H:%i:%S') from modem_alerts where meter_id='" + meterId + "' and ";
                        }
                    }

                }


                if (chkvalue.contains("0")) //for Meter com failed.
                {
                    sql1 = sql1 + "alert_desc like 'CRC Failed.%'";
                }
                if (chkvalue.contains("1")) // for AMR power failed.
                {
                    if (Integer.parseInt(substationId) != 0) {
                        sql1 = sql1 + " meter_id like '" + substationName + "%' and ";
                    }
                    sql1 = sql1 + " substr(alert_desc ,1,3) in (";
                    sql1 = sql1 + "'DCU' )";
                }

                sql1 = sql1 + " order by alert_generated_date desc";

                System.out.println("query is" + sql1);
                rs = st.executeQuery(sql1);
                while (rs.next()) {
                    flag = 1;

        %>

        <tr>

            <% if (meterId.equals("All") && chkvalue.contains("1")) {%>
            <td align="center"><%=rs.getString(3)%></td>
            <td align="center">---</td>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td>
            <% }%>
            <% if (meterId.equals("All") && chkvalue.contains("0")) {
                    String sql_feeder = "";
                    if (Integer.parseInt(substationId) != 0) {
                        sql_feeder = "select f.feedername,m.meter_serial_no from meter m,feeder f where f.feederid=m.feederid and m.meter_serial_no='" + rs.getString(3) + "' and f.substationid=" + substationId;
                    } else {
                        sql_feeder = "select f.feedername,m.meter_serial_no from meter m,feeder f where f.feederid=m.feederid and m.meter_serial_no='" + rs.getString(3) + "'";
                    }
                    PreparedStatement ps = con1.prepareStatement(sql_feeder);
                    ResultSet rs_feeder = ps.executeQuery();
                    if (rs_feeder.next()) {
                        if (Integer.parseInt(substationId) != 0) {
            %>           
            <td align="center"><%= substationName%></td>
            <% } else {%>
            <td align="center">---</td>
            <% }%>
            <td align="center"><%=rs_feeder.getString(1)%></td>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td>
            <%}
                    rs_feeder.close();
                    ps.close();
                }%>
            <% if (!meterId.equals("All")) {%>
            <td align="center"><%=rs.getString("alert_desc")%></td>
            <td align="center"><%=rs.getString(2)%></td> 
            <%}%>

        </tr>


        <%
            }
            if (flag == 0) {%>
        <tr><td colspan="2" align="center">No Alerts</td></tr>
        <%  }

            } catch (Exception e) {
                e.printStackTrace();
            }//catch      
        %>
    </tbody></table>
    <%  }//if not feeder %>



