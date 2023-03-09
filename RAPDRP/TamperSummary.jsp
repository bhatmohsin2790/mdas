<%@page import="ActionBeans.TamperSummary"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="ActionBeans.InstantElectricAction" %>
<%@page import="FormBeans.InstantElectricBean" %>
<%@page import="in.amitech.db.DBUtil" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
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
        #district_33kv_load tr  td {
             background-color: #E8EBE2;
              border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
     </style> 
    </head>
    <body>
        <%!
            Connection con=null;
            PreparedStatement ps=null;
            ResultSet rs=null;
            String sql=""; 
            String location_code="";                                            

        %>
        <%              
            String townId=request.getParameter("townId"); 
            String reportMonth=request.getParameter("reportMonth"); 
            String meterType=request.getParameter("metersType"); 
            String meterNo=request.getParameter("meterNo"); 
            //getting meter details
             con=new DBUtil().getConnection();
             rs=con.prepareStatement("select location_code from meter where meter_serial_no='"+meterNo.split("-")[1]+"'").executeQuery();
             if(rs.next()){
                 location_code=rs.getString(1);
             }
            
            
            
             %> 
<!--<table width="100%"><tr><td align="right">
<input type="button" id="btnExport" value=" Export to Excel " onclick="exportExcel('scrollableTable');" />
</td></tr></table> -->

<table width="50%" id="scrollableTable" border="0" style="text-align:center; font-size:1" cellpadding="0" cellspacing="0" >
    <thead>
        <tr>
        <th class="thstyle" >Meter Sl No :<%=meterNo.split("-")[1]%></th>
            <th class="thstyle" >Location Name :<%=meterNo.split("-")[0]%></th>
            <th class="thstyle" >Location Code :<%=location_code==null?" ":location_code%></th>    
        </tr>     
        
        <tr>
            <th class="thstyle" >Tamper Type</th>
            <th class="thstyle" >Tamper Count</th>
            <th class="thstyle" >Tamper Duration(Hrs:Mins)</th>
            
                     
        </tr>
    </thead>
    <tbody>
       
         <%
        try{
             sql="select * from events where event_code in(select distinct(event_type) from d5_data where meter_serial_no='"+meterNo.split("-")[1]+"' and to_char(d5_time_stamp,'MM/YYYY')='"+reportMonth+"')";
             rs=con.prepareStatement(sql).executeQuery();
             while(rs.next()){
                 String tdetails[]=new TamperSummary().getTamperSummary(meterNo.split("-")[1], reportMonth, rs.getString("event_code"));
                 %>
                 <tr class="trbg">
                     <td class="tdbg"><%=rs.getString("event_type")%></td>
                     <td class="tdbg"><%=tdetails.length>1?tdetails[0]:" "%></td>
                     <td class="tdbg"><%=tdetails.length>1?tdetails[1]:" "%></td>
                 </tr>
             <%}
             
           }catch(Exception e){
               response.sendRedirect("errorPage.jsp?message="+e.getMessage());
               e.printStackTrace();
           }
           
        %>
    </tbody>
</table>
    </body>
</html>


