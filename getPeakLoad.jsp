<%@page import="java.util.Map.Entry"%>
<%@page import="FormBeans.InstantElectricBean"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@ include file="getConnection.jsp"%>
<%@include file="report_header.jsp" %>
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
           String meter_id = "";
            if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                meter_id = (String) session.getAttribute("meter_id");
            } else {
                meter_id = request.getParameter("meter_id");

            }
           String locationName=request.getParameter("name");
           
               
    %>

  
<table bordercolor="white" width="100%" border="0">   
    <tr >
        <td colspan="6" align="center" class="head1">
            PEAK LOAD DATA
        </td>          
    </tr>
</table>
<table bordercolor="white" border="0" width="100%" style="font-size:11px;background-color:white;" id="dtable">
    <thead>
        <tr  style="color: white; font-weight: bold;" valign="bottom">
            <td align="center" rowspan="2" width="130px" style="min-width:125px;" >Reading Date Time</td>
            <td align="center" colspan="3" rowspan="1">Phase Voltages&nbsp;&nbsp;(V)</td>
            <td align="center" colspan="3">Line Currents</td>
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
            
            session.setAttribute("meter_id", meter_id);
            String stringToReturn = "";

    
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
            String sql = null;           
            
          
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
            if(aemf==1.0){
                vmf=vmf; cmf=cmf; pmf=pmf;
            }else{
                vmf=1.0; cmf=1.0; pmf=1.0;
            }
            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "SELECT g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current, "
                        + "yph_line_current,bph_line_current,rph_power_factor,yph_power_factor, "
                        + " bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER, "
                        + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT, "
                        + " BPH_REACT_CURRENT,YPH_REACT_CURRENT,meter_time_stamp,log_time_stamp,meterid,rownum r  "
                        + " from d2 where  regexp_like(trim(rph_voltage), '^[0-9]') and meter_serial_no=? and (to_TIMESTAMP(g3,'dd-mm-yyyy hh24:mi:SS') >= to_date('" + sdate + " 00:00:00','YYYY-mm-DD hh24:mi:ss') and "
                        + "to_TIMESTAMP(g3,'dd-mm-yyyy hh24:mi:SS') <= to_date('" + edate + " 23:59:00','YYYY-mm-DD hh24:mi:ss') )"
                        + " order by to_date(g3,'DD-MM-YYYY HH24:MI:SS') desc";
                //System.out.println("sql  " + sql);
                pstmt = con.prepareStatement(sql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
                pstmt.setString(1, meter_sl_no);
            } else if (DBUtil.getTargetDB().equals("mysql")) {

            }//end else if
          
            rs = pstmt.executeQuery();
            int flag=0;
            String date="";
            
//-----------------------------------------------------------------------
            Map<String ,InstantElectricBean> finalMap=new HashMap<String, InstantElectricBean>();
            Map<String ,InstantElectricBean> tempMap=new HashMap<String, InstantElectricBean>();
            Map<String,Double> rMap=new HashMap<String, Double>();
            Map<String,Double> yMap=new HashMap<String, Double>();
            Map<String,Double> bMap=new HashMap<String, Double>();
//-----------------------------------------------------------------------
            while (rs.next()) {
                flag=1; 
                InstantElectricBean ieb=new InstantElectricBean();
                ieb.setRph_voltage(rs.getString("rph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("rph_voltage"))) * vmf));
                ieb.setYph_voltage(rs.getString("yph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("yph_voltage"))) * vmf));
                ieb.setBph_voltage(rs.getString("bph_voltage") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("bph_voltage"))) * vmf));
                ieb.setRph_current(rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_LINE_CURRENT"))) * cmf));                                                                    
                ieb.setYph_current(rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_LINE_CURRENT"))) * cmf)); 
                ieb.setBph_current(rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_LINE_CURRENT"))) * cmf)); 
                ieb.setRph_pf(rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("RPH_POWER_FACTOR")))));
                ieb.setYph_pf(rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("YPH_POWER_FACTOR")))));
                ieb.setBph_pf(rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("BPH_POWER_FACTOR")))));
                ieb.setAvg_pf(rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))));
                ieb.setFrequency(rs.getString("FREQUENCY") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FREQUENCY")))));
                ieb.setKw(rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("FUND_ACT_POWER"))) * pmf));
                ieb.setKva(rs.getString("APPARENT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("APPARENT_POWER"))) * pmf));
                ieb.setKavar(rs.getString("REACT_POWER") == null ? "" : df1.format(Math.abs(Double.parseDouble(rs.getString("REACT_POWER"))) * pmf));
                   //date=rs.getString("g3").split(" ")[0];
                if(date.equals(rs.getString("g3").split(" ")[0])){
                    rMap.put(rs.getString("g3"), Math.abs(rs.getDouble("RPH_LINE_CURRENT")));
                    yMap.put(rs.getString("g3"), Math.abs(rs.getDouble("YPH_LINE_CURRENT")));
                    bMap.put(rs.getString("g3"), Math.abs(rs.getDouble("BPH_LINE_CURRENT")));
                    //System.out.println(date+"\t"+rMap.size()+"\t"+yMap+"\t"+bMap.size());
                    tempMap.put(rs.getString("g3"),ieb);
                    
                }else{
                    Double maxValue=0.0;
                    String peakDate="";
                    
                    if(!rMap.isEmpty() && !yMap.isEmpty() && !bMap.isEmpty()){
                    Double rmax=Collections.max(rMap.values());
                    Double ymax=Collections.max(yMap.values());
                    Double bmax=Collections.max(bMap.values());
                  System.out.println(rmax+"\t---"+ymax+"\t---"+bmax);
                    maxValue=(rmax>ymax?rmax:ymax)>bmax?(rmax>ymax?rmax:ymax):bmax;
                    
                            if (maxValue == rmax) {
                                    for (Entry<String, Double> entry : rMap.entrySet()) {
                                        if (entry.getValue().equals(rmax)) {
                                            peakDate = entry.getKey().toString();
                                        }
                                    }
                                }
                            if (maxValue == ymax) {
                                    for (Entry<String, Double> entry : yMap.entrySet()) {
                                        if (entry.getValue().equals(ymax)) {
                                            peakDate = entry.getKey().toString();
                                        }
                                    }
                                }
                            if (maxValue == bmax) {
                                    for (Entry<String, Double> entry : bMap.entrySet()) {
                                        if (entry.getValue().equals(bmax)) {
                                            peakDate = entry.getKey().toString();
                                        }
                                    }
                                }
                            
      System.out.println("Max date--->"+peakDate+"\t"+maxValue); 
                 finalMap.put(peakDate,tempMap.get(peakDate)); //adding peak load date to final map
                    }//if maps are not empty                      
                    date=rs.getString("g3").split(" ")[0];
                    rMap=new HashMap<String, Double>();
                    yMap=new HashMap<String, Double>();
                    bMap=new HashMap<String, Double>();
                    tempMap=new HashMap<String, InstantElectricBean>();
                    tempMap.put(rs.getString("g3"),ieb);
                }//else
                if(rs.isLast()){
                    Double maxValue=0.0;
                    String peakDate="";
                    
                    if(!rMap.isEmpty() && !yMap.isEmpty() && !bMap.isEmpty()){
                    Double rmax=Collections.max(rMap.values());
                    Double ymax=Collections.max(yMap.values());
                    Double bmax=Collections.max(bMap.values());
                    System.out.println(rmax+"\t---"+ymax+"\t---"+bmax);
                    maxValue=(rmax>ymax?rmax:ymax)>bmax?(rmax>ymax?rmax:ymax):bmax;
                    
                            if (maxValue == rmax) {
                                    for (Entry<String, Double> entry : rMap.entrySet()) {
                                        if (entry.getValue().equals(rmax)) {
                                            peakDate = entry.getKey().toString();
                                        }
                                    }
                                }
                            if (maxValue == ymax) {
                                    for (Entry<String, Double> entry : yMap.entrySet()) {
                                        if (entry.getValue().equals(ymax)) {
                                            peakDate = entry.getKey().toString();
                                        }
                                    }
                                }
                            if (maxValue == bmax) {
                                    for (Entry<String, Double> entry : bMap.entrySet()) {
                                        if (entry.getValue().equals(bmax)) {
                                            peakDate = entry.getKey().toString();
                                        }
                                    }
                                }
                            
      System.out.println("Max date--->"+peakDate+"\t"+maxValue); 
                 finalMap.put(peakDate,tempMap.get(peakDate)); //adding peak load date to final map
                    }//if maps are not empty                      
                    
                }//if rs.isLast()
                 }//while 
             for(Entry em:finalMap.entrySet()){
                 String key=em.getKey().toString();
                 InstantElectricBean ieb=(InstantElectricBean)em.getValue();
                 %>
                 <tr >
                     <td ><%=key%></td>
                     <td ><%=ieb.getRph_voltage()%></td>
                     <td ><%=ieb.getYph_voltage()%></td>
                     <td ><%=ieb.getBph_voltage()%></td>
                     <td ><%=ieb.getRph_current()%></td>
                     <td ><%=ieb.getYph_current()%></td>
                     <td ><%=ieb.getBph_current()%></td>
                     <td ><%=ieb.getRph_pf()%></td>
                     <td ><%=ieb.getYph_pf()%></td>
                     <td ><%=ieb.getBph_pf()%></td>
                     <td ><%=ieb.getAvg_pf()%></td>
                     <td ><%=ieb.getKw()%></td>
                     <td ><%=ieb.getKva()%></td>
                     <td ><%=ieb.getKavar()%></td>
                     <td ><%=ieb.getFrequency()%></td>
                 </tr>
             <%}
            if(flag==0){
          %>
          <tr ><td  colspan="15" style="text-align: center">No Peak Load Data</td></tr>
           <%}   
        %>
    </tbody> </table>


    <% 
        } catch (Exception e) {
        out.println("Plz Try Again....");
        e.printStackTrace();
    }
       
%>


