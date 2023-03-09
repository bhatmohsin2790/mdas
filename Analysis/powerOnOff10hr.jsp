<%@page import="sun.print.PSPrinterJob"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
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
    //String reportDate = request.getParameter("reportDate");
    //reportDate = reportDate.replaceAll("/", "-");
    String townId = request.getParameter("townId").trim();
    String metersType = request.getParameter("metersType");
    String category=request.getParameter("category");

    ResultSet rs = null;
    Connection con = null;
    String sql = "",lastCommDatenTime="";
    int slno = 1;

%>
<table width="100%" class="stdtable stdtablecb smallfont" id="dtable">
 <thead>
        <tr >
            <th class="thstyle" >Sl No</th>
            <th class="thstyle" >Location Name</th>       
            <th class="thstyle" >Meter Sl No</th>
            <th class="thstyle" >Last Comm Date&Time</th>
        </tr>
        
    </thead>
    <tbody>
        <%
            try {
                  HttpSession sess=request.getSession(false);
                 String office_type=sess.getAttribute("office_type").toString();
                 String office_type_id=sess.getAttribute("office_type_id").toString();
                //System.out.println("meter type--->"+metersType);
                 con = new DBUtil().getConnection();
                 Map meters= new AnalysisAction().getMeters(townId, metersType,category,office_type,office_type_id);
                 Map lastCommMap=new HashMap();
                 Map commMap=new HashMap();
                 
                 if(!meters.isEmpty()){
                     String totalMeters="";
                     for(Object meter:meters.keySet().toArray()){
                         totalMeters=totalMeters+"'"+meter.toString()+"',";
                         
                     }
                     totalMeters=totalMeters.substring(0, totalMeters.length()-1);
                     System.out.println("totalMeters-------------------------->"+meters.size());
          /* sql="SELECT meter_serial_no,g3,extract(day FROM(cast(sysdate as TIMESTAMP) -cast(to_date(g3, 'dd-mm-YYYY hh24:mi:ss') AS TIMESTAMP))) days,"
                   + "extract(hour FROM(cast(sysdate as TIMESTAMP) -cast(to_date(g3, 'dd-mm-YYYY hh24:mi:ss') AS TIMESTAMP))) hrs from d2 d11 "
                   + "where meter_serial_no in ("+totalMeters+" ) and log_time_stamp=(select max(log_time_stamp) from d2 d12 where "
                   + "d11.meter_serial_no=d12.meter_serial_no)"; */
          sql="select regexp_replace(meter_no, '[^A-Z0-9 ]', ''),d2_timestamp,extract(day FROM(cast(sysdate as TIMESTAMP) -d2_timestamp)) days,extract(hour FROM(cast(sysdate as TIMESTAMP) -d2_timestamp)) hrs from meter_comm_track ";
             // sql=sql+" where meter_no in("+totalMeters+")";
              System.out.println(sql);
                 PreparedStatement ps=con.prepareStatement(sql);
                 rs=ps.executeQuery();
				 SimpleDateFormat sdf=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
                 while(rs.next()){
                     if(rs.getInt(3)>0 || rs.getInt(4)>10){
						 if(rs.getTimestamp(2)!=null)
                      lastCommMap.put(rs.getString(1), sdf.format(rs.getTimestamp(2)));
					 }
                     else  if(rs.getInt(3)==0 || rs.getInt(4)<10){
						 if(rs.getTimestamp(2)!=null)
                           commMap.put(rs.getString(1), sdf.format(rs.getTimestamp(2)));
					 }
                 }
               System.out.println("total meters"+lastCommMap.size());
               
                 Iterator it=meters.entrySet().iterator();
                 int sno=1;
                 while(it.hasNext()){
                     Map.Entry meter=(Map.Entry)it.next();
                     if(lastCommMap.containsKey(meter.getKey()))
                         lastCommDatenTime=lastCommMap.get(meter.getKey()).toString();
                     else if(commMap.containsKey(meter.getKey()))
                         lastCommDatenTime="Communicating...";
                     else
                         lastCommDatenTime="NA";
                    %>
                    <tr class="trbg">
                        <td class="tdbg"><%=sno%></td>
                        <td class="tdbg"><%=meter.getValue()%></td>
                        <td class="tdbg"><%=meter.getKey()%></td>
                        <td class="tdbg"><%=lastCommDatenTime%></td>
                    </tr>
                 <%
						sno++;
						}
                  
                                   }//if meters map is not empty
                                 else{
                      out.println("<tr class='trbg'><td class='tdbg' colspan='4' align='center'>No meters available under this town...</td></tr>");
                                 }
            }//try
            catch (Exception e) {
                // out.println("<h4>Error:</h4>" + e.getMessage());
                e.printStackTrace();
            }

        %>

    </tbody>
   
</table>