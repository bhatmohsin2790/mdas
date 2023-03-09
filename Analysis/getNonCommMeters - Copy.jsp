<%@page import="sun.print.PSPrinterJob"%>
<%@page import="java.util.*"%>
<%@page import="ActionBeans.AnalysisAction"%>
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

    ResultSet rs = null;
    Connection con = null;
    String sql = "", lastCommDatenTime = "";
    int slno = 1;
    String reportDate = request.getParameter("reportDate");
    if (reportDate.length() > 0) {
        reportDate = reportDate.replaceAll("/", "-");
    }
    String townId = request.getParameter("townId").trim();
    String metersType = request.getParameter("metersType");
    String category = request.getParameter("category");

%>
<table width="100%" id="analysReports">
    <thead>
        <!--    <tr>
                <td colspan="7" align="center">Non-communicating Sites Report</td>
            </tr>-->
        <tr >
            <th class="thstyle" >Sl No</th>
            <th class="thstyle" >Town</th>
            <th class="thstyle" >Substation</th>
            <th class="thstyle" >Location Name</th>       
            <th class="thstyle" >Meter Sl No</th>
            <th class="thstyle" >Last Comm Date&Time</th>
            <th class="thstyle" >No of Days</th>
        </tr>        
    </thead>
    <tbody>
        <%
            try {
                HttpSession sess = request.getSession(false);
                String office_type = sess.getAttribute("office_type").toString();
                String office_type_id = sess.getAttribute("office_type_id").toString();

                con = new DBUtil().getConnection();
                Map meters = new AnalysisAction().getMeters(townId, metersType, category, office_type, office_type_id);
                Map lastCommMap = new HashMap();
                System.out.println("total Meters--->" + meters.size());
                if (!meters.isEmpty()) {
                    String totalMeters = "";
                    for (Object meter : meters.keySet().toArray()) {
                        totalMeters = totalMeters + "'" + meter.toString() + "',";

                    }
                    totalMeters = totalMeters.substring(0, totalMeters.length() - 1);
                    //System.out.println("totalMeters====>"+totalMeters);
                    sql = "SELECT meter_serial_no,g3,extract(day FROM(cast(sysdate as TIMESTAMP) -cast(to_date(g3, 'dd-mm-YYYY hh24:mi:ss') AS TIMESTAMP))) days,extract(day FROM(cast(sysdate as TIMESTAMP) -cast(to_date(g2, 'dd-mm-YYYY hh24:mi:ss') AS TIMESTAMP))) days1 from d2 d11 where meter_serial_no in (" + totalMeters + " ) and log_time_stamp=(select max(log_time_stamp) from d2 d12 where d11.meter_serial_no=d12.meter_serial_no)";
                    if (reportDate.length() > 0) // sql=sql+" and g2 like '"+reportDate+"%' and g3 like '"+reportDate+"%'";
                    {
                        sql = sql + " and to_date(substr(g3,1,10),'DD/MM/YYYY')<=to_date('" + reportDate + "','DD/MM/YYYY') and to_date(substr(g3,1,10),'DD/MM/YYYY')<=to_date('" + reportDate + "','DD/MM/YYYY')";
                    }

                    System.out.println(sql);
                    PreparedStatement ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        if (rs.getInt(3) >= 2 && rs.getInt(4) >= 2) {
                            lastCommMap.put(rs.getString(1), rs.getString(2) + "," + rs.getInt(3));
                        }
                    }
                    // System.out.println("total meters"+lastCommMap);

                    Iterator it = meters.entrySet().iterator();
                    int sno = 1;
                    while (it.hasNext()) {
                        Map.Entry meter = (Map.Entry) it.next();
                        if (lastCommMap.containsKey(meter.getKey())) {
                            lastCommDatenTime = lastCommMap.get(meter.getKey()).toString();

        %>
        <tr class="trbg">
            <td class="tdbg"><%=sno%></td>
            <td class="tdbg"><%=meter.getValue().toString().split(",")[1]%></td>
            <td class="tdbg"><%=meter.getValue().toString().split(",")[2]%></td>
            <td class="tdbg"><%=meter.getValue().toString().split(",")[0]%></td>
            <td class="tdbg"><%=meter.getKey()%></td>
            <td class="tdbg"><%=lastCommDatenTime.split(",")[0]%></td>
            <td class="tdbg"><%=lastCommDatenTime.split(",")[1]%></td>
        </tr>
        <%
                            sno++;
                        }

                    } //if
                }//if meters map is not empty
                else {
                    out.println("<tr class='trbg'><td class='tdbg' colspan='6' align='center'>No meters available ...</td></tr>");
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

