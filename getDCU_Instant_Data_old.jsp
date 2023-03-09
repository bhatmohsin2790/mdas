<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
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

        pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid "
                + "and m.feederid in  (select feederid from feeder where substationid=?)");
        pstmt.setString(1, dcu_id);
        rs = pstmt.executeQuery();

        String f_ids = "";
        String f_names = "";
        String meter_ids = "";
        String meter_serial_nos = "";
        System.out.println("hi1");
        while (rs.next()) {
            System.out.println("hi");
            f_ids = f_ids + rs.getString("feederid") + ",";
            f_names = f_names + rs.getString("feedername") + ",";
            meter_ids = meter_ids + rs.getString("meterid") + ",";
            meter_serial_nos = meter_serial_nos + rs.getString("meter_serial_no") + ",";
        }

        String[] f_ids_arr = f_ids.split(",");
        String[] f_names_arr = f_names.split(",");
        String[] meter_ids_arr = meter_ids.split(",");
        String[] meter_serial_nos_arr = meter_serial_nos.split(",");

        for (int i = 0; i < f_ids_arr.length; i++) {
            //pstmt = con.prepareStatement("select * from d2 where cdfid = ( select max(cdfid) from meter_data_time_stamp where meter_data_timestamp = ( select max(meter_data_timestamp) from meter_data_time_stamp where meterid="+meter_id+" ) )");
            if (DBUtil.getTargetDB().equals("oracle")) {
                pstmt = con.prepareStatement("select * from d2 where meterid=" + meter_ids_arr[i] + " order by to_timestamp(g2,'DD-MM-YYYY HH24:MI:SS') desc");
            } else {
                pstmt = con.prepareStatement("select * from d2 where meterid=" + meter_ids_arr[i] + " order by meter_time_stamp desc");
            }//end else
            rs = pstmt.executeQuery();
            String dataString = "";
            if (rs.next()) {
                /* byte b1[] = rs.getBytes("data");
                dataString = new String(b1);
                String instant_split[] = dataString.split(",");
                stringToReturn = stringToReturn+"<tr>";
                
                for(int i=0;i<instant_split.lengtd;i++)
                {
                stringToReturn = stringToReturn+"<td class='td2'>"+instant_split[i]+"</td>";
                }
                
                stringToReturn = stringToReturn + "</tr>"   ;
                 */
%>
<table border="0" width="100%" bordercol="#ffffff">	                                             
    <tr bgcolor="#56a5ec">
        <td>
            <table>
                <tr>
                    <td width="20%" colspan="3" rowspan="2" style="font-size:12px;">
                        <font color="#000" >
                        <strong>Feeder Name : </strong></font><font color="white"><%= f_names_arr[i]%> (<%=meter_serial_nos_arr[i]%>)
                        </font>
                    </td>
                    <td width="20%" colspan="3" rowspan="2">
                        <font color="#000">
                        <b>Date Of Reading:&nbsp;</b></font><font color="white"><%=rs.getString("g3").substring(0, 10)%>
                        </font>
                    </td>
                    <td width="20%" colspan="3" rowspan="2">
                        <font color="#000">
                        <b>Time Of Reading:&nbsp;&nbsp;</b></font><font color="white"><%=rs.getString("g3").substring(10)%>
                        </font>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table bordercolor="white" border="0" width="100%">	<!-- Table for Volages and Current -->
                <tr bgcolor="#56a5ec" style="color: white; font-weight: bold;">
                    <td align="center" colspan="3" rowspan="2">Phase Voltages&nbsp;&nbsp;(V)</td>
                    <td align="center" colspan="9">Currents&nbsp;&nbsp;(A)</td>
                    <td align="center" colspan="15">Powers&nbsp;&nbsp;(KW)</td>
                </tr>
                <tr bgcolor="#56a5ec" style="color: white; font-weight: bold;">
                    <td align="center" colspan="3">Line Current</td>
                    <td align="center" colspan="3">Active Current</td>
                    <td align="center" colspan="3">Re-Active Current</td>
                    <td align="center" style="color: white; font-weight: bold;" colspan="4">Power Factors</td>


                    <td align="center" colspan="1" style="color: white; font-weight: bold;">Active Power</td>
                    <td align="center" colspan="1" style="color: white; font-weight: bold;">Apparent Power</td>
                    <td align="center" colspan="1" style="color: white; font-weight: bold;">Reactive Power</td>
                    <td align="center" colspan="8" style="color: white; font-weight: bold;">Frequency</td>
                    <!--     <td colspan="1"style="color: white; font-weight: bold;">Phase Sequence</td>-->

                </tr>
                <tr bgcolor="#56a5ec" align="center">
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
                    <td width="8%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="13%"></td>



                </tr>
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
                <tr bgcolor="#e0ecf8" align="center">
                    <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : rs.getString("rph_voltage")%></td>
                    <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : rs.getString("yph_voltage")%></td>
                    <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : rs.getString("bph_voltage")%></td>
                    <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : rs.getString("RPH_LINE_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : rs.getString("YPH_LINE_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : rs.getString("BPH_LINE_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" : rs.getString("RPH_ACTIVE_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" : rs.getString("YPH_ACTIVE_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : rs.getString("BPH_ACTIVE_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : rs.getString("RPH_REACT_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" : rs.getString("YPH_REACT_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" : rs.getString("BPH_REACT_CURRENT")%></td>
                    <td class="td2"><%=rs.getString("RPH_POWER_FACTOR") == null ? "" : rs.getString("RPH_POWER_FACTOR")%></td>
                    <td class="td2"><%=rs.getString("YPH_POWER_FACTOR") == null ? "" : rs.getString("YPH_POWER_FACTOR")%></td>
                    <td class="td2"><%=rs.getString("BPH_POWER_FACTOR") == null ? "" : rs.getString("BPH_POWER_FACTOR")%></td>
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : rs.getString("AVG_POWER_FACTOR")%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("FUND_ACT_POWER") == null ? "" : rs.getString("FUND_ACT_POWER")%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("APPARENT_POWER") == null ? "" : rs.getString("APPARENT_POWER")%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("REACT_POWER") == null ? "" : rs.getString("REACT_POWER")%></td>
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("FREQUENCY") == null ? "" : rs.getString("FREQUENCY")%></td>
                <!--    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("VOLTAGE_PHASE_SEQUENCE") == null ? "" : rs.getString("VOLTAGE_PHASE_SEQUENCE")%></td>-->
                </tr>
                <%
                } else {
                    System.out.println("It is Else Start");
                %>
                <tr bgcolor="#e0ecf8" align="center">
                    <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : Math.round(Double.parseDouble(rs.getString("rph_voltage")) / vmf)%></td>
                    <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : Math.round(Double.parseDouble(rs.getString("yph_voltage")) / vmf)%></td>
                    <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : Math.round(Double.parseDouble(rs.getString("bph_voltage")) / vmf)%></td>
                    <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" : Math.round(Double.parseDouble(rs.getString("RPH_LINE_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "" : Math.round(Double.parseDouble(rs.getString("YPH_LINE_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "" : Math.round(Double.parseDouble(rs.getString("BPH_LINE_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" : Math.round(Double.parseDouble(rs.getString("RPH_ACTIVE_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" : Math.round(Double.parseDouble(rs.getString("YPH_ACTIVE_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : Math.round(Double.parseDouble(rs.getString("BPH_ACTIVE_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : Math.round(Double.parseDouble(rs.getString("RPH_REACT_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" : Math.round(Double.parseDouble(rs.getString("YPH_REACT_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" : Math.round(Double.parseDouble(rs.getString("BPH_REACT_CURRENT")) * cmf)%></td>
                    <td class="td2"><%=rs.getString("RPH_POWER_FACTOR") == null ? "" : rs.getString("RPH_POWER_FACTOR")%></td>
                    <td class="td2"><%=rs.getString("YPH_POWER_FACTOR") == null ? "" : rs.getString("YPH_POWER_FACTOR")%></td>
                    <td class="td2"><%=rs.getString("BPH_POWER_FACTOR") == null ? "" : rs.getString("BPH_POWER_FACTOR")%></td>
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : rs.getString("AVG_POWER_FACTOR")%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("FUND_ACT_POWER") == null ? "" : Math.round(Double.parseDouble(rs.getString("FUND_ACT_POWER")) / cmf)%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("APPARENT_POWER") == null ? "" : Math.round(Double.parseDouble(rs.getString("APPARENT_POWER")) / cmf)%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("REACT_POWER") == null ? "" : Math.round(Double.parseDouble(rs.getString("REACT_POWER")) / cmf)%></td>
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("FREQUENCY") == null ? "" : rs.getString("FREQUENCY")%></td>
                 <!--    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("VOLTAGE_PHASE_SEQUENCE") == null ? "" : rs.getString("VOLTAGE_PHASE_SEQUENCE")%></td>-->
                </tr>
                <%
                        System.out.println("It is Else End");
                    }//end else
                %>
            </table> </td></tr></table>
            <%
                pstmt1 = con.prepareStatement("select * from meter where meterid=" + meter_ids_arr[i]);
                rs1 = pstmt1.executeQuery();
                while (rs1.next()) {
            %>
<table border="0" width="100%">
    <tr bgcolor="#56a5ec"  width="20%" colspan="3" rowspan="2">
        <td>
            <font color="#fffff">Inst CT Ratio &nbsp;:</font>
            <font color="white"><%=rs1.getString("meter_ctr") == null ? "1.0" : rs1.getString("meter_ctr")%></font>
        </td>
        <td>
            <font color="#fffff">Inst PT Ratio &nbsp;:</font>
            <font color="white"><%=rs1.getString("meter_ptr") == null ? "1.0" : rs1.getString("meter_ptr")%></font>
        </td>
        <td>
            <font color="#fffff">Adopted CT Ratio &nbsp;:</font>
            <font color="white"><%=rs1.getString("adopted_ctr") == null ? "1.0" : rs1.getString("adopted_ctr")%></font>
        </td>
        <td>
            <font color="#fffff">Adopted PT Ratio &nbsp;:</font>
            <font color="white"><%=rs1.getString("adopted_ptr") == null ? "1.0" : rs1.getString("adopted_ptr")%></font>
        </td>
        <td>
            <font color="#fffff">EMF &nbsp;:</font>
            <font color="white"><%=rs1.getString("mf")%></font>
        </td>
    </tr><tr><td></td><td></td><td></td><td></td><td>NA: Not Applicable</td></tr>
</table>
<%
    }
%>    
<%

            } else {
                out.println("Data Not Available For This Meter....");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }
%>


