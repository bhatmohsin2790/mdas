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
        <%              
            String townId=request.getParameter("townId"); 
            String reportDate=request.getParameter("reportDate"); 
            String meterType=request.getParameter("metersType"); 
             %> 
<!--<table width="100%"><tr><td align="right">
<input type="button" id="btnExport" value=" Export to Excel " onclick="exportExcel('scrollableTable');" />
</td></tr></table> -->
<table width="100%" id="scrollableTable" border="0" style="text-align:center; font-size:1" cellpadding="0" cellspacing="0" >
    <thead>
                <tr>    
                    <th class="thstyle" colspan="16">System Overload Report
                             On  <%=reportDate%></th>
                </tr>   
        <tr>        
        <tr>
            <th class="thstyle">SlNo</th>
            <th class="thstyle">Town Name</th>
            <th class="thstyle">Feeder with peak load >120% of rated load</th>
            <th class="thstyle">DT with peak load >100% of rated load</th>
            <th class="thstyle">Power Xr. with peak load >100% of rated load</th>
            
        </tr>
        
    </thead>
    <tbody>
        <tr class="trbg"><td class="tdbg" colspan="5">Yet to be develop</td>
        </tr>
         <%
        try{
             NumberFormat twoDec= new DecimalFormat("#0.00");
             
           }catch(Exception e){
               response.sendRedirect("../errorPage.jsp?message="+e.getMessage());
               e.printStackTrace();
           }
           
        %>
    </tbody>
</table>
    </body>
</html>


