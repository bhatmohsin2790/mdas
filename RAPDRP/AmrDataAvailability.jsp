<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="ActionBeans.DataAvailableAction" %>
<%@page import="FormBeans.DataAvailableBean" %>

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
        <%              
            String reportMonth=request.getParameter("reportMonth"); 
             %> 
<!--<table width="100%"><tr><td align="right">
<input type="button" id="btnExport" value=" Export to Excel " onclick="exportExcel('scrollableTable');" />
</td></tr></table> -->
<table width="100%" id="scrollableTable" border="0" style="text-align:center; font-size:1" cellpadding="0" cellspacing="0" >
    <thead>
                <tr>    
                    <th class="thstyle" colspan="7">AMR Data Availability Report
                             On  <%=reportMonth%></th>
                </tr>   
        <tr>        
        <tr>
            <th class="thstyle" rowspan="2">Town</th>
            <th class="thstyle" colspan="3">DT Meters</th>
            <th class="thstyle" colspan="3">HT Meters</th>
            
                     
        </tr>
        <tr>
            <th class="thstyle" >Total Meters</th>
            <th class="thstyle">Available Meters</th>
            <th class="thstyle" >% of Available Meters</th>          
            <th class="thstyle" >Total Meters</th>
            <th class="thstyle">Available Meters</th>
            <th class="thstyle" >% of Available Meters</th>          
        </tr>
    </thead>
    <tbody>
         <%
        try{
             List daList= new DataAvailableAction().getDataAvailabilityMonthly(reportMonth);
             NumberFormat tdec= new DecimalFormat("#0.00");
               for(int i=0;i<daList.size();i++){
                   DataAvailableBean dab=(DataAvailableBean)daList.get(i);
                    float dtPercent=0f,htPercent=0f;
                    if(dab.getAvailDTMeters()!=0)
                        dtPercent=((float)dab.getAvailDTMeters()/dab.getTotalDTMeters())*100;
                    if(dab.getAvailHTMeters()!=0)
                        htPercent=((float)dab.getAvailHTMeters()/dab.getTotalHTMeters())*100;
                        
                   %>
                   <tr class="trbg">
                       <td class="tdbg"><%=dab.getTownName()%></td>
                       <td class="tdbg"><%=dab.getTotalDTMeters()==0?" ":dab.getTotalDTMeters()%></td>
                       <td class="tdbg"><%=dab.getAvailDTMeters()==0?" ":dab.getAvailDTMeters()%></td>
                       <td class="tdbg"><%=dtPercent==0.0?" ":tdec.format(dtPercent)+"%"%></td>
                       <td class="tdbg"><%=dab.getTotalHTMeters()==0?" ":dab.getTotalHTMeters()%></td>
                       <td class="tdbg"><%=dab.getAvailHTMeters()==0?" ":dab.getAvailHTMeters()%></td>
                       <td class="tdbg"><%=htPercent==0.0?" ":tdec.format(htPercent)+"%"%></td>
                   </tr>
               <%}
            
           }catch(Exception e){
               e.printStackTrace();
           }
           
        %>
    </tbody>
</table>
    </body>
</html>

