<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/rowstyle.css" /> 
<%
    try {
        NumberFormat twoDecFormat = new DecimalFormat("#0.00");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
        PreparedStatement pstmt, pstmt1, pstmt2 = null;
        ResultSet rs, rs1, rs2 = null;
        double ctr = 1.0, ptr = 1.0, Actr = 1.0, Aptr = 1.0;
        double vmf = 1.0, cmf = 1.0, pmf = 1.0;
        double mf = 1.0;
        DecimalFormat df1 = new DecimalFormat("#0.000");
        String meter_id = "";
        meter_id = request.getParameter("meter_no");
        String meterType = request.getParameter("meterType");
        String sdate = request.getParameter("startDate");
        String edate = request.getParameter("endDate");
        int start = Integer.parseInt(request.getParameter("start"));

%>
<table bordercolor="white" border="0" width="100%" style="font-size:11px;background-color:white;" >	
    <thead>
        <tr bgcolor="#56a5ec" style="color: white; font-weight: bold;" valign="bottom">
            <td align="center" rowspan="3" width="60px" style="min-width: 125px" >Reading<br /> Date Time</td>
            <td align="center" colspan="3" rowspan="2">Phase Voltages&nbsp;&nbsp;(V)</td>
            <td align="center" colspan="3"></td>
            <td align="center" colspan="4" rowspan="2">Power Factors</td>
            <td align="center" colspan="3"></td>
            <td align="center" rowspan="2" style="color: white; font-weight: bold;min-width: 40px;">Freq</td>
        </tr>
        <tr bgcolor="#56a5ec" style="color: white; font-weight: bold;">
            <td align="center" colspan="3">Line Current</td>
            <!--<td align="center" colspan="3">Active Current</td>
            <td align="center" colspan="3">Re-Active Current</td>-->
            <td align="center" style="color: white; font-weight: bold;" colspan="3">Powers</td>
        </tr>
        <tr bgcolor="#56a5ec" align="center">
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <!--<td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>-->
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <td width="7.3%">Avg</td>

            <td width="8%">&nbsp;Act<br />(kW)&nbsp;</td>
            <td width="10%">&nbsp;App<br />(kVA)&nbsp;</td>
            <td width="10%">&nbsp;React<br />(kVAr)&nbsp;</td>
            <td width="13%"></td>
        </tr>
    </thead><tbody id="ssinstant">


        <%


            String sql1 = "select * from meter where meter_serial_no='" + meter_id+"'";
            System.out.println("sql for query----------->" + sql1);
            pstmt2 = con.prepareStatement(sql1);
            rs2 = pstmt2.executeQuery();
            if (rs2.next()) {
                ctr = Double.parseDouble(rs2.getString("METER_CTR"));
                ptr = Double.parseDouble(rs2.getString("METER_PTR"));
               // Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));//comm ctr
                Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR"));//comm ptr
                //cmf =ctr/Actr;
                vmf = Double.parseDouble(df1.format(Aptr / ptr));
                pmf = Double.parseDouble(df1.format(cmf / vmf));
		        String ACTR=rs2.getString("ADOPTED_CTR");
			    if(ACTR.contains("/")){	
					String numerator = ACTR.substring(0,ACTR.indexOf("/"));
					String denominator = ACTR.substring(ACTR.indexOf("/")+1);
					Actr = Double.valueOf(numerator)/Double.valueOf(denominator);
				}else{
					Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));//comm ctr
				}				
                cmf = Double.parseDouble(df1.format(Actr / ctr));
            }
            String sql="";
            if (DBUtil.getTargetDB().equals("oracle")) {
                if(!sdate.equals("") && !edate.equals(""))   
             sql="select * from ( "
                        + " select d.cdfid,d.g1,d.g2,d.g3,d.rph_voltage,d.yph_voltage, "
                        + " d.bph_voltage,d.rph_line_current,d.yph_line_current,d.bph_line_current,d.rph_active_current,d.yph_active_current,"
                        + " d.bph_active_current,d.rph_react_current,d.yph_react_current,d.bph_react_current,d.fund_act_power,d.react_power, "
                        + " d.apparent_power,d.rph_total_act_power,d.rph_react_power,d.yph_total_act_power,d.yph_react_power,d.bph_total_act_power,"
                        + " d.bph_react_power,d.d2_system_total_act_power,d.d2_system_total_react_power,d.d2_system_apparent_power,d.rph_power_factor,"
                        + " d.yph_power_factor,d.bph_power_factor,d.avg_power_factor,d.r_y_voltage_angle,d.y_b_voltage_angle,d.b_r_voltage_angle,"
                        + " d.voltage_phase_sequence,d.frequency,d.meterid,d.current_phase_sequence,d.meter_serial_no,d.meter_time_stamp,d.log_time_stamp,"
                        + " rownum r from d2 d,meter_data_info m where d.meter_time_stamp=m.meter_data_time_stamp and d.meter_serial_no=m.meter_serial_no and "
                        + " d.meter_serial_no='" + meter_id + "' and m.meter_data_type in('TD','LS','OD','IP') and trunc(m.meter_data_time_stamp) >= to_date('" + sdate + "','dd/mm/yyyy') and "
                        + " trunc(m.meter_data_time_stamp) <= to_date('" + edate + "','dd/mm/yyyy')  order by to_timestamp(g3,'DD-MM-YYYY HH24:MI:SS') desc) where rownum<=10";
                else
                    sql="select * from ( "
                        + " select d.cdfid,d.g1,d.g2,d.g3,d.rph_voltage,d.yph_voltage, "
                        + " d.bph_voltage,d.rph_line_current,d.yph_line_current,d.bph_line_current,d.rph_active_current,d.yph_active_current,"
                        + " d.bph_active_current,d.rph_react_current,d.yph_react_current,d.bph_react_current,d.fund_act_power,d.react_power, "
                        + " d.apparent_power,d.rph_total_act_power,d.rph_react_power,d.yph_total_act_power,d.yph_react_power,d.bph_total_act_power,"
                        + " d.bph_react_power,d.d2_system_total_act_power,d.d2_system_total_react_power,d.d2_system_apparent_power,d.rph_power_factor,"
                        + " d.yph_power_factor,d.bph_power_factor,d.avg_power_factor,d.r_y_voltage_angle,d.y_b_voltage_angle,d.b_r_voltage_angle,"
                        + " d.voltage_phase_sequence,d.frequency,d.meterid,d.current_phase_sequence,d.meter_serial_no,d.meter_time_stamp,d.log_time_stamp,"
                        + " rownum r from d2 d,meter_data_info m where d.meter_time_stamp=m.meter_data_time_stamp and d.meter_serial_no=m.meter_serial_no and "
                        + " d.meter_serial_no='" + meter_id + "' and m.meter_data_type in('TD','LS','OD','IP')  order by to_timestamp(g3,'DD-MM-YYYY HH24:MI:SS') desc) where rownum<=10";
                    
                pstmt = con.prepareStatement(sql);




            } else {
                pstmt = con.prepareStatement("select * from d2 d,meter_data_info m where d.meter_time_stamp=m.meter_data_time_stamp and d.meter_serial_no=m.meter_serial_no and d.meter_serial_no='" + meter_id + "' order by meter_time_stamp desc limit 1");
            }//end else
            System.out.println(sql);
            //System.out.println("meter_ids_arr[i] " + meter_id);
            rs = pstmt.executeQuery();
            String dataString = "";
            int len = 0;
            int data_flag=0;
    %>


        <% while (rs.next()) {
            data_flag=1;
                len++;


        %>


        <%

            double aemf = 1.0;
            if (request.getParameter("ApplyEMF") != null) {
                aemf = Double.parseDouble(request.getParameter("ApplyEMF"));
            } else {
                System.out.println("Apply EMF is not available ");
            }//end else
            System.out.println("EMF----------------->" + aemf);
            if (aemf == 0) {
        %>
        <tr bgcolor="#e0ecf8" align="center" >

            <td class="td2" ><%=rs.getString("g3")%></td>

            <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("rph_voltage")))%></td>
            <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("yph_voltage")))%></td>
            <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("bph_voltage")))%></td>
            <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("RPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("YPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("BPH_LINE_CURRENT")))%></td>
            <!--<td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_REACT_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_REACT_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_REACT_CURRENT")))%></td>-->
            <td class="td2"><%=rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("RPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("YPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("BPH_POWER_FACTOR")))%></td>
            <td class="td2" ><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))%></td>
            <td class="td2"  ><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("FUND_ACT_POWER")))%></td>
            <td class="td2" ><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")))%></td>
            <td class="td2"  ><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")))%></td>
            <td class="td2"><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>
        <!--    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("VOLTAGE_PHASE_SEQUENCE") == null ? "" : rs.getString("VOLTAGE_PHASE_SEQUENCE")%></td>-->
        </tr>
        <%
        } else {
            System.out.println("It is Else Start");
        %>

        <tr bgcolor="#e0ecf8" align="center" >

            <td class="td2" ><%=rs.getString("g3")%></td>

            <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("rph_voltage")) / vmf)%></td>
            <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("yph_voltage")) / vmf)%></td>
            <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("bph_voltage")) / vmf)%></td>
            <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("RPH_LINE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("YPH_LINE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("BPH_LINE_CURRENT")) * cmf)%></td>
            <!--<td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_ACTIVE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_ACTIVE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_ACTIVE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_REACT_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_REACT_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_REACT_CURRENT")) * cmf)%></td>-->
            <td class="td2"><%=rs.getString("RPH_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("RPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("YPH_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("YPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("BPH_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("BPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))%></td>
            <td class="td2" ><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("FUND_ACT_POWER")) / cmf)%></td>
            <td class="td2"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")) / cmf)%></td>
            <td class="td2"><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")) / cmf)%></td>
            <td class="td2" ><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>
         <!--    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("VOLTAGE_PHASE_SEQUENCE") == null ? "" : rs.getString("VOLTAGE_PHASE_SEQUENCE")%></td>-->
        </tr>
        <%
                    System.out.println("It is Else End");
                }//end else


            }
            if(data_flag==0){
                %>
                <tr><td class="td2" colspan="21"><center>Data Not Available.</center></td></tr> 
                
           <% } %>
     
    </tbody></table>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>


