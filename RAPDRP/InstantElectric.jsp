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
                    <th class="thstyle" colspan="16">Instantaneous Parameter Report
                             On  <%=reportDate%></th>
                </tr>   
        <tr>        
        <tr>
            <th class="thstyle" rowspan="2">SlNo</th>
            <th class="thstyle" rowspan="2">Location Name</th>
            <th class="thstyle" rowspan="2">Location Code</th>
            <th class="thstyle" rowspan="2">Meter Sl No</th>
            <th class="thstyle" colspan="3">Active Current</th>
            <th class="thstyle" colspan="3">Voltage</th>
            <th class="thstyle" colspan="3">P.F</th>
            <th class="thstyle" rowspan="2">KWh Import</th>
            <th class="thstyle" rowspan="2">KWh Export</th>
            <th class="thstyle" rowspan="2">Net KWh</th>
            
                     
        </tr>
        <tr>
            <th class="thstyle">R</th>
            <th class="thstyle">Y</th>
            <th class="thstyle">B</th>
            <th class="thstyle">R</th>
            <th class="thstyle">Y</th>
            <th class="thstyle">B</th>
            <th class="thstyle">R</th>
            <th class="thstyle">Y</th>
            <th class="thstyle">B</th>
                     
        </tr>
    </thead>
    <tbody>
       
         <%
        try{
             NumberFormat twoDec= new DecimalFormat("#0.00");
                Map  imap= new InstantElectricAction().getElectricInstant(townId, reportDate, meterType);
                Iterator it=imap.entrySet().iterator();
                System.out.println("total map size   "+imap.size());
                int slno=1;
                while(it.hasNext()){
                    Map.Entry am=(Map.Entry)it.next();
                    InstantElectricBean ieb=(InstantElectricBean)am.getValue();
                    %>
                    <tr class="trbg">
                        <td class="tdbg"><%=slno%></td>
                        <td class="tdbg" align="left"><%=ieb.getLocationName()%></td>
                        <td class="tdbg"><%=ieb.getLocationCode()==null?" ":ieb.getLocationCode()%></td>
                        <td class="tdbg"><%=ieb.getMeter_sl_no()%></td>
                        <td class="tdbg"><%=ieb.getRph_i_act()==null?" ":twoDec.format(Double.parseDouble(ieb.getRph_i_act()))%></td>
                        <td class="tdbg"><%=ieb.getYph_i_act()==null?" ":twoDec.format(Double.parseDouble(ieb.getYph_i_act()))%></td>
                        <td class="tdbg"><%=ieb.getBph_i_act()==null?" ":twoDec.format(Double.parseDouble(ieb.getBph_i_act()))%></td>
                        <td class="tdbg"><%=ieb.getRph_voltage()==null?" ":twoDec.format(Double.parseDouble(ieb.getRph_voltage()))%></td>
                        <td class="tdbg"><%=ieb.getYph_voltage()==null?" " :twoDec.format(Double.parseDouble(ieb.getYph_voltage()))%></td>
                        <td class="tdbg"><%=ieb.getBph_voltage()==null?" ":twoDec.format(Double.parseDouble(ieb.getBph_voltage()))%></td>
                        <td class="tdbg"><%=ieb.getRph_pf()==null?" ":twoDec.format(Double.parseDouble(ieb.getRph_pf()))%></td>
                        <td class="tdbg"><%=ieb.getYph_pf()==null?" ":twoDec.format(Double.parseDouble(ieb.getYph_pf()))%></td>
                        <td class="tdbg"><%=ieb.getBph_pf()==null?" ":twoDec.format(Double.parseDouble(ieb.getBph_pf()))%></td>
                        <td class="tdbg"><%=ieb.getKwh_import()==null?" ":twoDec.format(Double.parseDouble(ieb.getKwh_import()))%></td>
                        <td class="tdbg"><%=ieb.getKwh_export()==null?" ":twoDec.format(Double.parseDouble(ieb.getKwh_export()))%></td>
                        <td class="tdbg"><%=(ieb.getKwh_export()==null || ieb.getKwh_import()==null)?" ":twoDec.format(Double.parseDouble(ieb.getKwh_import())-Double.parseDouble(ieb.getKwh_export()))%></td>
                    </tr>
                   <%
                    slno++;
                   }//while
           }catch(Exception e){
               response.sendRedirect("../errorPage.jsp?message="+e.getMessage());
               e.printStackTrace();
           }
           
        %>
    </tbody>
</table>
    </body>
</html>


