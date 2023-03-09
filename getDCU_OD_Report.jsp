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

        String dcu_id = request.getParameter("dcu_id");

        String sql11 = "select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid and m.meterid in (" + dcu_id + ")";
        //System.out.println("Qry==>" + sql11);
        pstmt = con.prepareStatement(sql11);

        rs = pstmt.executeQuery();

        String f_ids = "";
        String f_names = "";
        String meter_ids = "";
        String meter_serial_nos = "";
      
        while (rs.next()) {
           
            f_ids = f_ids + rs.getString("feederid") + ",";
            f_names = f_names + rs.getString("feedername") + ",";
            meter_ids = meter_ids + rs.getString("meterid") + ",";
            meter_serial_nos = meter_serial_nos + rs.getString("meter_serial_no") + ",";
        }

        String[] f_ids_arr = f_ids.split(",");
        String[] f_names_arr = f_names.split(",");
        String[] meter_ids_arr = meter_ids.split(",");
        String[] meter_serial_nos_arr = meter_serial_nos.split(",");
%>
<table bordercolor="white" border="0" width="100%" style="font-size:11px;background-color:white;" >	
    <thead>
        <tr bgcolor="#A8B2C5" style="color: white; font-weight: bold;" valign="bottom">
            <td align="center" rowspan="3" width="60px" style="min-width: 125px" >Reading<br /> Date Time</td>
            <td align="center" colspan="3" rowspan="2">Phase Voltages&nbsp;&nbsp;(V)</td>
            <td align="center" colspan="9"></td>
            <td align="center" colspan="4" rowspan="2">Power Factors</td>
            <td align="center" colspan="3"></td>
            <td align="center" rowspan="2" style="color: white; font-weight: bold;min-width: 40px;">Freq</td>
        </tr>
        <tr bgcolor="#A8B2C5" style="color: white; font-weight: bold;">
            <td align="center" colspan="3">Line Current</td>
            <td align="center" colspan="3">Active Current</td>
            <td align="center" colspan="3">Re-Active Current</td>
            <td align="center" style="color: white; font-weight: bold;" colspan="3">Powers</td>
        </tr>
        <tr bgcolor="#A8B2C5" align="center">
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
            <td width="7.3%">R</td>
            <td width="7.3%">Y</td>
            <td width="7.3%">B</td>
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

            <td width="8%">&nbsp;Act<br />(kW)&nbsp;</td>
            <td width="10%">&nbsp;App<br />(kVA)&nbsp;</td>
            <td width="10%">&nbsp;React<br />(kVAr)&nbsp;</td>
            <td width="13%"></td>
        </tr>
    </thead><tbody id="ssinstant">


        <%
            for (int i = 0; i < f_ids_arr.length; i++) {

                String sql1 = "select * from meter where meterid=" + meter_ids_arr[i];
                System.out.println("sql for query----------->" + sql1);
                pstmt2 = con.prepareStatement(sql1);
                rs2 = pstmt2.executeQuery();
                if (rs2.next()) {
                    ctr = Double.parseDouble(rs2.getString("METER_CTR"));
                    ptr = Double.parseDouble(rs2.getString("METER_PTR"));
                    Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));//comm ctr
                    Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR"));//comm ptr
                    //cmf =ctr/Actr;
                    vmf = Double.parseDouble(df1.format(Aptr / ptr));
                    pmf = Double.parseDouble(df1.format(cmf / vmf));
                    cmf = (Actr / Aptr) * (ctr / ptr);
                }
                //pstmt = con.prepareStatement("select * from d2 where cdfid = ( select max(cdfid) from meter_data_time_stamp where meter_data_timestamp = ( select max(meter_data_timestamp) from meter_data_time_stamp where meterid="+meter_id+" ) )");
                if (DBUtil.getTargetDB().equals("oracle")) {
                   /* pstmt = con.prepareStatement("select * from (select cdfid,data,g1,g2,g3,rph_voltage,yph_voltage,"
                            + "bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_active_current,yph_active_current,"
                            + "bph_active_current,rph_react_current,yph_react_current,bph_react_current,fund_act_power,react_power,"
                            + "apparent_power,rph_total_act_power,rph_react_power,yph_total_act_power,yph_react_power,bph_total_act_power,"
                            + "bph_react_power,d2_system_total_act_power,d2_system_total_react_power,d2_system_apparent_power,rph_power_factor,"
                            + "yph_power_factor,bph_power_factor,avg_power_factor,r_y_voltage_angle,y_b_voltage_angle,b_r_voltage_angle,"
                            + "voltage_phase_sequence,frequency,meterid,current_phase_sequence,meter_serial_no,meter_time_stamp,log_time_stamp,"
                            + "rownum r from d2 where meterid=" + meter_ids_arr[i] + " order by to_timestamp(g3,'DD-MM-YYYY HH24:MI:SS') desc) where rownum<=1");
   */            
                    pstmt = con.prepareStatement("select * from ( "
+" select d.cdfid,d.g1,d.g2,d.g3,d.rph_voltage,d.yph_voltage, "
+" d.bph_voltage,d.rph_line_current,d.yph_line_current,d.bph_line_current,d.rph_active_current,d.yph_active_current,"
+" d.bph_active_current,d.rph_react_current,d.yph_react_current,d.bph_react_current,d.fund_act_power,d.react_power, "
+" d.apparent_power,d.rph_total_act_power,d.rph_react_power,d.yph_total_act_power,d.yph_react_power,d.bph_total_act_power,"
+" d.bph_react_power,d.d2_system_total_act_power,d.d2_system_total_react_power,d.d2_system_apparent_power,d.rph_power_factor,"
+" d.yph_power_factor,d.bph_power_factor,d.avg_power_factor,d.r_y_voltage_angle,d.y_b_voltage_angle,d.b_r_voltage_angle,"
+" d.voltage_phase_sequence,d.frequency,d.meterid,d.current_phase_sequence,d.meter_serial_no,d.meter_time_stamp,d.log_time_stamp,"
+" rownum r from d2 d,meter_data_info m where d.meter_time_stamp=m.meter_data_time_stamp and d.meter_serial_no=m.meter_serial_no and "
+" d.meterid="+ meter_ids_arr[i] +" order by to_timestamp(g3,'DD-MM-YYYY HH24:MI:SS') desc) where rownum<=1");
                    
                    
                    
 
                     } else {
                    pstmt = con.prepareStatement("select * from d2 d,meter_data_info m where d.meter_time_stamp=m.meter_data_time_stamp and d.meter_serial_no=m.meter_serial_no and d.meterid=" + meter_ids_arr[i] + " order by meter_time_stamp desc limit 1");
                }//end else
                System.out.println("meter_ids_arr[i] " + meter_ids_arr[i]);
                rs = pstmt.executeQuery();
                String dataString = "";
                int len = 0;%>
        <tr bgcolor="#A8B2C5" align="center" >
            <td colspan="22" align="left"><strong>Feeder Name : </strong><%= f_names_arr[i]%> (<%=meter_serial_nos_arr[i]%>)</td> 
        </tr>

        <% while (rs.next()) {
                len++;


        %>


        <%
            if (i == 0) {
        %>



        <%                    }
            double aemf = 1.0;
            if (request.getParameter("ApplyEMF") != null) {
                aemf = Double.parseDouble(request.getParameter("ApplyEMF"));
            } else {
                System.out.println("Apply EMF is not available ");
            }//end else
            System.out.println("EMF----------------->" + aemf);
            if (aemf == 0) {
        %>
        <tr bgcolor="#A8B2C5" align="center" >

            <td class="td2" ><%=rs.getString("g3")%></td>

            <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("rph_voltage")))%></td>
            <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("yph_voltage")))%></td>
            <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("bph_voltage")))%></td>
            <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("RPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("YPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("BPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_REACT_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_REACT_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_REACT_CURRENT")))%></td>
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

        <tr bgcolor="#A8B2C5" align="center" >

            <td class="td2" ><%=rs.getString("g3")%></td>

            <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("rph_voltage")) / vmf)%></td>
            <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("yph_voltage")) / vmf)%></td>
            <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("bph_voltage")) / vmf)%></td>
            <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("RPH_LINE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("YPH_LINE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : df1.format(Double.parseDouble(rs.getString("BPH_LINE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_ACTIVE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_ACTIVE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_ACTIVE_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_REACT_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("YPH_REACT_CURRENT")) * cmf)%></td>
            <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_REACT_CURRENT")) * cmf)%></td>
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
            }
        %>
    </tbody></table>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>


