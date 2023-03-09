<%@page import="java.util.Map"%>
<%@page import="ActionBeans.AnalysisAction"%>
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
    String category = request.getParameter("category");

    ResultSet rs = null;
    Connection con = null;
    String sql = "";
    int slno = 1;

%>
<table width="100%" class="stdtable stdtablecb smallfont" id="dtable">
    <thead >
        <tr >
            <th class="thstyle" >Sl No</th>
            <th class="thstyle">Location Name</th>       
            <th class="thstyle">Meter Sl No</th>
            <th class="thstyle">Power On Minutes </br>(hh:mm)</th>           
        </tr>
    </thead>  
    <tbody>
        <%
            try {
                HttpSession sess = request.getSession(false);
                String office_type = sess.getAttribute("office_type").toString();
                String office_type_id = sess.getAttribute("office_type_id").toString();
                Map meters = new AnalysisAction().getAllmeters(townId, metersType, category, office_type, office_type_id);
                con = new DBUtil().getConnection();
                if (!meters.isEmpty()) {
                    String totalMeters = "";
                    for (Object meter : meters.keySet().toArray()) {
                        totalMeters = totalMeters + "'" + meter.toString() + "',";

                    }
                    totalMeters = totalMeters.substring(0, totalMeters.length() - 1);
                    //sql="select d.dtrname,p.meter_serial_no,p.diff_in_minutes from power_fail_minutes p,meter m,dtr d,feeder f,substation s where p.meter_serial_no=m.meter_serial_no and m.dtrid=d.dtrid and d.feederid=f.feederid and f.substationid=s.substationid and s.townid="+townId+" and p.power_fail_date like '"+reportDate+"%' order by d.dtrname ";
                    if (metersType.equals("DTR")) {
                        sql = "select d.dtrname,m.meter_serial_no,p.diff_in_minutes from meter m join dtr d on d.dtrid=m.dtrid and m.meter_serial_no in(" + totalMeters + ") left outer join power_fail_minutes p on p.meter_serial_no=m.meter_serial_no and p.power_fail_date like '" + reportDate + "%'  order by d.dtrname";
                    }
                    if (metersType.equals("HT")) {
                        sql = "select ht.consumername,m.meter_serial_no,p.diff_in_minutes from meter m join ht_consumer ht on ht.consumerid=m.htconsumerid  and m.meter_serial_no in(" + totalMeters + ") left outer join power_fail_minutes p on p.meter_serial_no=m.meter_serial_no and p.power_fail_date like '" + reportDate + "%'  order by ht.consumername";
                    }

                    rs = con.prepareStatement(sql).executeQuery();
                    long hrs = 0, mins = 0;

                    while (rs.next()) {
                        if (rs.getString(3) != null) {
                            Long timeInMins = 1440 - Long.parseLong(rs.getString(3));
                            hrs = TimeUnit.MINUTES.toHours(timeInMins);
                            mins = TimeUnit.MINUTES.toMinutes(timeInMins - hrs * 60);
                        }
        %>
        <tr class="trbg">
            <td class="trbg" align="center"><%=slno%></td>
            <td class="tdbg"><%=rs.getString(1)%></td>
            <td class="tdbg"><%=rs.getString(2)%></td>
            <td class="tdbg" align="center"><%=rs.getString(3) == null ? " " : ((hrs < 10 ? "0" + hrs : hrs) + ":" + (mins < 10 ? "0" + mins : mins))%></td>
        </tr>
        <% slno++;
                    }
                }//if meters map is not empty
                else {
                    out.println("<tr class='trbg'><td class='tdbg' colspan='4' align='center'>No meters available under this ...</td></tr>");
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

</table>