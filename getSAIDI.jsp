<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%
    Connection con = null;
    Statement st = null;
    String sql = null;
    String alert_desc = null;
    String alert_next_desc = null;
    String alert_time = null;
    long timedifference = 0;
    int flag = 0;
    float SAIDI;
    String meterId = request.getParameter("meter_id").trim();
    String sdate = request.getParameter("sdate").trim();
    String edate = request.getParameter("edate").trim();
    System.out.println("before" + sdate);

    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    java.util.Date fdate = (java.util.Date) df.parse(sdate);
    java.util.Date tdate = (java.util.Date) df.parse(edate);
    DateFormat sdf = new SimpleDateFormat("dd-MMM-yy");
    String fromdate = sdf.format(fdate);
    String todate = sdf.format(tdate);
    System.out.println("after" + fromdate);
    int datediff = (int) ((tdate.getTime() - fdate.getTime()) / (1000 * 60 * 60 * 24));
    System.out.println("no of days between" + datediff);
    con = new DBUtil().getConnection();
    sql = "select alert_desc,LEAD(alert_desc,1,0) over (order by alert_generated_date) next,to_char(alert_generated_date,'hh:mi:ss') art from"
            + " modem_alerts where alert_desc like 'AMR%' and meter_id=" + meterId + " and "
            + "to_date(substr(alert_generated_date,1,9),'DD-Mon-YY') between to_date('" + fromdate + "','DD-MON-YY') and "
            + "to_date('" + todate + "','DD-MON-YY')";
    System.out.println("sql is" + sql);
    st = con.createStatement();
    ResultSet rs = st.executeQuery(sql);
    while (rs.next()) {
        alert_desc = alert_desc + "," + rs.getString(1);
        alert_next_desc = alert_next_desc + "," + rs.getString(2);
        alert_time = alert_time + "," + rs.getString(3);
        flag = 1;
    }
    if (flag == 0) {
        out.println("No Data is Available in these days");
    }
    String desc[] = alert_desc.split(",");
    String next_desc[] = alert_next_desc.split(",");
    String time[] = alert_time.split(",");

    //to know the time difference between AMR power failed and restored
    for (int i = 0; i < desc.length; i++) {
        if (desc[i].equalsIgnoreCase("AMR Power Failed") && next_desc[i].equalsIgnoreCase("AMR Power Restored")) {
            DateFormat dateformat = new SimpleDateFormat("hh:mm:ss");
            java.util.Date startingtime = dateformat.parse(time[i]);
            java.util.Date nexttime = dateformat.parse(time[i + 1]);

            timedifference = timedifference + ((nexttime.getHours() * 3600) + (nexttime.getMinutes() * 60) + nexttime.getSeconds()) - ((startingtime.getHours() * 3600) + (startingtime.getMinutes() * 60) + startingtime.getSeconds());


        }
    }
    System.out.println("time is" + timedifference);
    SAIDI = (timedifference / 3600) / (float) datediff;
    int hours = (int) SAIDI;
    int minutes = (int) ((SAIDI - Math.floor(SAIDI)) * 60);

    con.close();
%>
<h3 align="center" style="padding-top:140px">SAIDI value : <%=hours%>h <%=minutes%>min (per day)</h3>




