<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DO_Client" %>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%
try{
    String sql=null;String substationId=null;String dynamicIp=null;
    PreparedStatement ps=null;
    ResultSet rs=null;
    substationId=request.getParameter("dcu_id");
    System.out.println("dcu id  ====>"+substationId);
    if(Integer.parseInt(substationId)!=0){
       
    sql="select dynamic_ip from substation_ip where substationid="+substationId+" order by LOG_TIME_STAMP desc";
       }
       else{
        System.out.println("in else part");
        String meterNo=request.getParameter("meterNo").trim();
        System.out.println("meter no "+meterNo);
        sql="select dynamic_ip from substation_ip where substationid in(select substationid from feeder where feederid in(select feederid from meter where meter_serial_no='"+meterNo+"')) order by LOG_TIME_STAMP desc";
       }
    ps=con.prepareStatement(sql);
    rs=ps.executeQuery();
    if(rs.next())
      {
        dynamicIp=rs.getString(1);
      }
       else{
        out.println("<h3>IP is not available for this substation </h3>");
       }
    
        
        DO_Client do_client = new DO_Client();
        
        String cmd ="ONDEMAND,"+dynamicIp+",ONDEMANDIP";
        System.out.println(" commnad to substation--->"+cmd);
         String resp=null;
        
        resp = do_client.send_cmd(cmd,"172.18.2.26");
        //request.setAttribute("resp",resp);
        //if(resp.contains("COMMAND SENT SUCCESSFULLY"))
          //  do_client.cmd_Status_Update(cmd_id);
        out.println(resp);
   
}
catch(Exception e)
           {
    e.printStackTrace();
}
finally{
    con.close();
}
%>


 