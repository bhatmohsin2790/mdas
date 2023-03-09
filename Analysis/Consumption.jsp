<%@page import="java.text.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="ActionBeans.AnalysisAction"%>
<%@page import="FormBeans.AnalysisBean" %>
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
    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");
    String townId = request.getParameter("townId").trim();
    String metersType = request.getParameter("meterType");
    String category = request.getParameter("category");

    ResultSet rs = null;
    Connection con = null;
    String sql = "";


%>
<table width="100%" class="stdtable stdtablecb smallfont" id="dtable">
    <thead>
        <tr>
            <th class="thstyle">Location Name</th>       
            <th class="thstyle">Meter No</th>
            <th class="thstyle">From Date</th>
            <th class="thstyle">KWH </th> 
            <th class="thstyle">To Date</th>
            <th class="thstyle">KWH </th>           
            <th class="thstyle">Consumption </br>(without MF)</th>           
            <th class="thstyle">MF </th>
            <th class="thstyle">Consumption </br>(with MF)</th>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                NumberFormat twoDec = new DecimalFormat("#0.00");
                HttpSession sess = request.getSession(false);
                String office_type = sess.getAttribute("office_type").toString();
                String office_type_id = sess.getAttribute("office_type_id").toString();
                Map meters = new AnalysisAction().getAllmeters(townId, metersType, category, office_type, office_type_id);
                if (!meters.isEmpty()) {

                    Map amap = new AnalysisAction().getConsumptionAnalysis(townId, fromDate, toDate, metersType, meters);
                    Iterator it = amap.entrySet().iterator();
                    System.out.println("total map size   " + amap.size());
                    while (it.hasNext()) {
                        Map.Entry am = (Map.Entry) it.next();
                        AnalysisBean ab = (AnalysisBean) am.getValue();
             try{
        %>
        <tr class="trbg">
            <td class="tdbg"><%=ab.getLocation()%></td>
            <td class="tdbg"><%=ab.getMeterNo()%></td>
            <td class="tdbg"><%=ab.getFromDate() == null ? " " : ab.getFromDate()%></td>
            <td class="tdbg"><%=ab.getFromDate() == null ? " " : twoDec.format(Double.parseDouble(ab.getKwhFrom()))%></td>
            <td class="tdbg"><%=ab.getFromDate() == null ? " " : ab.getToDate()%></td>
            <td class="tdbg"><%=ab.getFromDate() == null ? " " : twoDec.format(Double.parseDouble(ab.getKwhTo()))%></td>
            <td class="tdbg"><%=ab.getFromDate() == null ? " " : twoDec.format(Double.parseDouble(ab.getKwhTo()) - Double.parseDouble(ab.getKwhFrom()))%></td>
            <td class="tdbg"><%=ab.getMf()%></td>
            <td class="tdbg"><%=ab.getFromDate() == null ? " " : twoDec.format((Double.parseDouble(ab.getKwhTo()) - Double.parseDouble(ab.getKwhFrom())) * Double.parseDouble(ab.getMf()))%></td>
        </tr>
        <%
			 }catch(Exception e){}
                    }//iterator
                }//if meters map is not empty
                else {
                    out.println("<tr class='trbg'><td class='tdbg' colspan='4' align='center'>No meters available under this ...</td></tr>");
                }
            }//try
            catch (Exception e) {
                out.println("<h4>Error:</h4>" + e.getMessage());
            } 
        %>

    </tbody>
</table>
