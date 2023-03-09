<%@page import="ActionBeans.PowerOnOff10hr"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@ page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<style>
    .thstyle{
        background-color: #8FA1B5; 
        color:#FFFFFF;
        font-size:14px;
        border-left:1px solid #FFFFFF;
        text-decoration:none;
        font-family: monospace;
        border-bottom: 1px solid #FFFFFF;

    }
    .trbg{
        background-color: #E8EBE2;
        border-bottom: 1px solid #FFFFFF;
    }
    .tdbg{
        border-bottom: 1px solid #FFFFFF;
        border-left: 1px solid #FFFFFF;
    }
    #district_11kv_load tr  td {
        background-color: #E8EBE2;
        border-bottom: 1px solid #FFFFFF;
        border-left: 1px solid #FFFFFF;
    }
</style> 
<%
    String reportDate = request.getParameter("reportDate");
    reportDate = reportDate.replaceAll("/", "-");
    String townId = request.getParameter("townId").trim();
    String metersType = request.getParameter("metersType");

    ResultSet rs = null;
    Connection con = null;
    String sql = "";
    int slno = 1;

%>
<table width="100%">

    <tbody>
        <%
            try {
                //System.out.println("meter type--->"+metersType);
                con = new DBUtil().getConnection();
                //sql="select d.dtrname,p.meter_serial_no,p.diff_in_minutes from power_fail_minutes p,meter m,dtr d,feeder f,substation s where p.meter_serial_no=m.meter_serial_no and m.dtrid=d.dtrid and d.feederid=f.feederid and f.substationid=s.substationid and s.townid="+townId+" and p.power_fail_date like '"+reportDate+"%' order by d.dtrname ";
                if (metersType.equals("DTR")) {
                    sql = "select d.dtrname,m.meter_serial_no,p.diff_in_minutes from meter m join dtr d on d.dtrid=m.dtrid join feeder f on f.feederid=d.feederid join substation s "
                            + " on s.substationid=f.substationid join town t on t.townid=s.townid and s.townid=" + townId + " left outer join power_fail_minutes p on p.meter_serial_no=m.meter_serial_no and p.power_fail_date like '" + reportDate + "%'  order by d.dtrname";
                }
                if (metersType.equals("HT")) {
                    sql = "select ht.consumername,m.meter_serial_no,p.diff_in_minutes from meter m join ht_consumer ht on ht.consumerid=m.htconsumerid join feeder f on f.feederid=ht.feederid join substation s "
                            + " on s.substationid=f.substationid join town t on t.townid=s.townid and t.townid=" + townId + " left outer join power_fail_minutes p on p.meter_serial_no=m.meter_serial_no and p.power_fail_date like '" + reportDate + "%'  order by ht.consumername";
                }

                rs = con.prepareStatement(sql).executeQuery();
                long hrs = 0, mins = 0;

                while (rs.next()) {
                    if (rs.getString(3) != null) {
                        Long timeInMins = Long.parseLong(rs.getString(3));
                        hrs = TimeUnit.MINUTES.toHours(timeInMins);
                        mins = TimeUnit.MINUTES.toMinutes(timeInMins - hrs * 60);
                    }
                    if (hrs > 10) {
                        String lastPowerFailTimes=new PowerOnOff10hr().getLastTwoAlerts(rs.getString(2),reportDate);
        %>
        <tr class="trbg">
            <td class="trbg" align="center"><%=slno%></td>
            <td class="tdbg"><%=rs.getString(1)%></td>
            <td class="tdbg"><%=rs.getString(2)%></td>
            <td class="tdbg" align="center"><%=rs.getString(3) == null ? " " : ((hrs < 10 ? "0" + hrs : hrs) + ":" + (mins < 10 ? "0" + mins : mins))%></td>
            <td class="tdbg"><%=lastPowerFailTimes.split(",")[0].length()>0?lastPowerFailTimes.split(",")[0]:" "%></td>
            <td class="tdbg"><%=lastPowerFailTimes.split(",")[1].length()>0?lastPowerFailTimes.split(",")[1]:" "%></td>
        </tr>
        <% slno++;
                    }//if hrs>10
                    
                }

            }//try
            catch (Exception e) {
                // out.println("<h4>Error:</h4>" + e.getMessage());
                e.printStackTrace();
            }
            finally{
                con.close();
            }
        %>

    </tbody>
    <thead>
        <tr >
            <th class="thstyle" rowspan="2">Sl No</th>
            <th class="thstyle" rowspan="2">Location Name</th>       
            <th class="thstyle" rowspan="2">Meter Sl No</th>
            <th class="thstyle" rowspan="2">Power Off Minutes </br>(hh:mm)</th>
            <th class="thstyle" colspan="2">Last Power Fail</th>            
        </tr>
        <tr>
            <th class="thstyle">Occurred Time</th>
            <th class="thstyle">Restored Time</th>
        </tr>
    </thead>
</table>