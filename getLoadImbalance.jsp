<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="getConnection.jsp"%>
<%@include file="report_header.jsp" %>
<%@page import="java.text.*"%>
<%@page import="java.text.DecimalFormat"%> 
 <%!  
        PreparedStatement pstmt, pstmt1, pstmt2 = null;
        ResultSet rs, rs1, rs2 = null;
        double ctr = 1.0, ptr = 1.0, Actr = 1.0, Aptr = 1.0;
        double vmf = 1.0, cmf = 1.0, pmf = 1.0;
        double mf = 1.0;
        DecimalFormat df1 = new DecimalFormat("#0.000");
         String locationName="";

    %>
<%
           int lineCurrentsLimit=0;
           String meter_id = "";
            if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                meter_id = (String) session.getAttribute("meter_id");
            } else {
                meter_id = request.getParameter("meter_id");

            }
          
           
    %>

  
<table bordercolor="white" width="100%" border="0">   
    <tr >
        <td colspan="6" align="center" class="head1">
            LOAD IMBALANCE DATA
        </td>          
    </tr>
</table>
<table bordercolor="white" border="0" width="100%" style="font-size:11px;background-color:white;" id="dtable">
    <thead>
        <tr  style="color: white; font-weight: bold;" valign="bottom">
            <td align="center" rowspan="2" width="130px" style="min-width:125px;" >Reading Date Time</td>
            <td align="center" colspan="3" rowspan="1">Phase Voltages&nbsp;&nbsp;(V)</td>
            <td align="center" colspan="3">Line Current</td>
            <td align="center" colspan="4" rowspan="1">Power Factors</td>
            <td align="center" colspan="3">Powers</td>
            <td align="center" rowspan="1" style="color: white; font-weight: bold;min-width: 40px;">Freq</td>
        </tr>
        
        <tr  align="center">
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>          
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <td width="7.3%">Avg</td>
            <td width="8%">&nbsp;Act(kW)&nbsp;</td>
            <td width="10%">&nbsp;App(kVA)&nbsp;</td>
            <td width="10%">&nbsp;React(kVAr)&nbsp;</td>
            <td width="13%"></td>
        </tr>
    </thead>
   
    <%        
        try {
           
            if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                meter_id = (String) session.getAttribute("meter_id");
            } else {
                meter_id = request.getParameter("meter_id");

            }
            session.setAttribute("meter_id", meter_id);
            String stringToReturn = "";

    %>
    
    <%
        int data_type = 1; //2 - completed data   1 - Latest data
        double aemf = 1.0;
        if (request.getParameter("ApplyEMF") != null) {
            aemf = Double.parseDouble(request.getParameter("ApplyEMF"));

        } else {
            System.out.println("Apply EMF is not available ");
        }//end else
        System.out.println("EMF----------------->" + aemf);
      
        String meter_sl_no = "";
         pstmt = con.prepareStatement("select meter_serial_no,ml.locationname from meter,meterlocation ml where meterid="+meter_id+" and meterlocation=ml.locationid");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            meter_sl_no = rs.getString("meter_serial_no");
            locationName=rs.getString(2);
        }
        session.setAttribute("meter_sl_no", meter_sl_no);      
        System.out.println("meter serial no " + meter_sl_no);
       
    %>        

    <tbody >
        <%
           SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
            
            String sdate = request.getParameter("sdate");
            String edate = request.getParameter("edate");
            
            sdate=sdf1.format(sdf.parse(sdate));
            edate=sdf1.format(sdf.parse(edate));
            
            int start = Integer.parseInt(request.getParameter("start"));

           
            String sql = null;           
            
            System.out.println("Date Range Selected---------------------------------------------------->");
          
            pstmt2 = con.prepareStatement("select * from meter where meterid=" + meter_id);
            rs2 = pstmt2.executeQuery();
            if (rs2.next()) {
                    ctr = Double.parseDouble(rs2.getString("METER_CTR"));
                    ptr = Double.parseDouble(rs2.getString("METER_PTR"));
                        
                    String ACTR = rs2.getString("ADOPTED_CTR");
                    if (ACTR.contains("/")) {
                        String numerator = ACTR.substring(0, ACTR.indexOf("/"));
                        String denominator = ACTR.substring(ACTR.indexOf("/") + 1);
                        Actr = Double.valueOf(numerator) / Double.valueOf(denominator);
                    } else {
                        Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));
                    }
                        
                    Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR"));
                    // cmf = (Actr / Aptr) * (ctr / ptr);
                    vmf = Double.parseDouble(df1.format(Aptr / ptr));
                    cmf = Double.parseDouble(df1.format(Actr / ctr));
                    pmf = Double.parseDouble(rs2.getString("mf"));
                    
                }
           
            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "SELECT g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current, "
                        + "yph_line_current,bph_line_current,rph_power_factor,yph_power_factor, "
                        + " bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER, "
                        + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT, "
                        + " BPH_REACT_CURRENT,YPH_REACT_CURRENT,meter_time_stamp,log_time_stamp,meterid,rownum r  "
                        + " from d2 where  regexp_like(trim(rph_voltage), '^[0-9]') and meter_serial_no=? and (to_TIMESTAMP(g2,'dd-mm-yyyy hh24:mi:SS') >= to_date('" + sdate + " 00:00:00','YYYY-mm-DD hh24:mi:ss') and "
                        + "to_TIMESTAMP(g2,'dd-mm-yyyy hh24:mi:SS') <= to_date('" + edate + " 23:59:00','YYYY-mm-DD hh24:mi:ss') )"
                        + " order by to_date(g3,'DD-MM-YYYY HH24:MI:SS') desc";
               // System.out.println("sql  " + sql);
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_sl_no);
               
            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,"
                        + "bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,"
                        + "avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,"
                        + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,"
                        + "BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,"
                        + "YPH_REACT_CURRENT from d2 where meter_serial_no=? and "
                        + "str_to_date(g2,'%d-%m-%Y') >= str_to_date('" + sdate + "','%d/%m/%Y') and "
                        + "str_to_date(g2,'%d-%m-%Y') <= str_to_date('" + edate + "','%d/%m/%Y') "
                        + "order by meter_time_stamp desc limit ?,?";

                start = start - 1;
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, meter_id);
               

            }//end else if
          
            rs = pstmt.executeQuery();
            String dataString = "";
            int flag=0;
            while (rs.next()) {
                flag=1;
 //logic to get only overloaded currents-----------------------------------------------
                ArrayList al=new ArrayList();
              Double rlc=rs.getDouble("rph_line_current");
              Double ylc=rs.getDouble("yph_line_current");
              Double blc=rs.getDouble("bph_line_current");
              Double ryp=((rlc-ylc)/rlc)*100;
              Double rbp=((rlc-blc)/rlc)*100;
              Double ybp=((ylc-blc)/ylc)*100;
              Double yrp=((ylc-rlc)/ylc)*100;
              Double brp=((blc-rlc)/blc)*100;
              Double byp=((blc-ylc)/blc)*100;
             // System.out.println(ryp+"\t"+rbp+"\t"+ybp+"\t"+yrp+"\t"+brp+"\t"+byp);
              al.add(Math.abs(ryp));al.add(Math.abs(rbp));al.add(Math.abs(ybp));
              al.add(Math.abs(yrp));al.add(Math.abs(brp));al.add(Math.abs(byp));
              Double overLimit=(Double)Collections.max(al);
              if(overLimit>40){
                if (aemf == 0)//without MF
                {
                 
            %>

        <tr  align="center">
           
            <td ><%=rs.getString("g3") == null ? "" : rs.getString("g3")%></td>
            <td ><%=rs.getString("rph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("rph_voltage"))))%></td>
            <td ><%=rs.getString("yph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("yph_voltage"))))%></td>
            <td ><%=rs.getString("bph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("bph_voltage"))))%></td>
            <td ><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_LINE_CURRENT"))))%></td>
            <td ><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_LINE_CURRENT"))))%></td>
            <td ><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_LINE_CURRENT"))))%></td>

            <td ><%=rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("AVG_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FUND_ACT_POWER"))))%></td>
            <td ><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("APPARENT_POWER"))))%></td>
            <td ><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("REACT_POWER"))))%></td>
            <td ><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FREQUENCY"))))%></td>
        </tr>
        <%
        } else {
            %>

        <tr  align="center">
          
            <td ><%=rs.getString("g3") == null ? "" : rs.getString("g3")%></td>
            <td ><%=rs.getString("rph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("rph_voltage"))) * vmf)%></td>
            <td ><%=rs.getString("yph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("yph_voltage"))) * vmf)%></td>
            <td ><%=rs.getString("bph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("bph_voltage"))) * vmf)%></td>
            <td ><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_LINE_CURRENT"))) * cmf)%></td>
            <td ><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_LINE_CURRENT"))) * cmf)%></td>
            <td ><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_LINE_CURRENT"))) * cmf)%></td>

            <td ><%=rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("AVG_POWER_FACTOR"))))%></td>
            <td ><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FUND_ACT_POWER"))) * pmf)%></td>
            <td ><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("APPARENT_POWER"))) * pmf)%></td>
            <td ><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("REACT_POWER"))) * pmf)%></td>
            <td ><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FREQUENCY"))))%></td>
        </tr>

        <%
                    }
                     
                                   }//if limit >40
                }//while
            if(flag==0){
          %>
          <tr ><td  colspan="15" style="text-align: center">No Load Imbalance Data</td></tr>
           <%}   
        %>
    </tbody> </table>

    <% 
        } catch (Exception e) {
        out.println("Plz Try Again....");
        e.printStackTrace();
    }
       
%>


