<%@ page session="false" %>
<%@page import="java.text.DecimalFormat"%> 
<table width="100%" border="0">   
    <tr bgcolor="#56a5ec">
        <td colspan="6" align="center" class="head1">
            INSTANTANEOUS DATA
        </td>          
    </tr>
</table>
<%!    //import java.text.DecimalFormat;
    PreparedStatement pstmt, pstmt1, pstmt2 = null;
    ResultSet rs, rs1, rs2 = null;
    double ctr = 1.0, ptr = 1.0, Actr = 1.0, Aptr = 1.0;
    double vmf = 1.0, cmf = 1.0, pmf = 1.0;
    double mf = 1.0;
    DecimalFormat df1 = new DecimalFormat("#0.000");

%>
<%
            try {
                String meter_id = "";
                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                    meter_id = (String) session.getAttribute("meter_id");
                } else {
                    meter_id = request.getParameter("meter_id");
                }
                session.setAttribute("meter_id", meter_id);
                String stringToReturn = "";

%>
<%@ include file="getConnection.jsp"%>
<%
                int data_type = 1; //2 - completed data   1 - Latest data
                double aemf = 1.0;
                if (request.getParameter("ApplyEMF") != null) {
                    aemf = Double.parseDouble(request.getParameter("ApplyEMF"));
                } else {
                    System.out.println("Apply EMF is not available ");
                }//end else
                System.out.println("EMF----------------->" + aemf);
                if (request.getParameter("data_type") == null || request.getParameter("data_type") == "") {
                } else {
                    data_type = Integer.parseInt(request.getParameter("data_type"));
                }
                String meter_sl_no = "";
                pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    meter_sl_no = rs.getString("meter_serial_no");
                }
                session.setAttribute("meter_sl_no", meter_sl_no);
                System.out.println("Data type=" + data_type);
                System.out.println("meter serial no " + meter_sl_no);
                if (data_type == 2)// Starting and Ending Dates are selected
                {
%>        
<div style="overflow:scroll;width:1000px;">
    <table border="0"   id="ins_data">
        <tr>
            <td class="td1">Meter_ID</td>
            <td class="td1">Instantaneous Date</td>
            <td class="td1">Time</td>

            <td class="td1">R-Phase_Voltage_(V)</td>
            <td class="td1">Y-Phase_Voltage_(V)</td>
            <td class="td1">B-Phase_Voltage_(V)</td>

            <td class="td1">R-Phase_LineCurrent_(A)</td>
            <td class="td1">Y-Phase_LineCurrent_(A)</td>
            <td class="td1">B-Phase_LineCurrent_(A)</td>

            <td class="td1">R-Phase_ActiveCurrent_(A)</td>
            <td class="td1">Y-Phase_ActiveCurrent_(A)</td>
            <td class="td1">B-Phase_ActiveCurrent_(A)</td>

            <td class="td1">R-Phase_ReActiveCurrent_(A)</td>
            <td class="td1">Y-Phase_ReActiveCurrent_(A)</td>
            <td class="td1">B-Phase_ReActiveCurrent_(A)</td>

            <td class="td1">R-Phase_PowerFactor</td>
            <td class="td1">Y-Phase_PowerFactor</td>
            <td class="td1">B-Phase_PowerFactor</td>
            <td class="td1">Average_PowerFactor</td>

            <td class="td1">Active_Power_(KW)</td>
            <td class="td1">Apparent_Power_(KVA)</td>
            <td class="td1">Reactive_Power_(KVAR)</td>

            <td class="td1">Frequency_(Hz)</td>
        </tr>
       

        <tr bgcolor="#56a5ec" align="center">
            <td width="7.3%"></td>
            <td width="10.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="7.3%"></td>
            <td width="8%"></td>
            <td width="10%"></td>
            <td width="10%"></td>
            <td width="13%"></td>
            
            
            

        </tr>
        <%
                            String sql1="select * from meter where meterid="+meter_id;
                            System.out.println("sql for query----------->"+sql1);
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
                               /* out.println("ctr:" + ctr);
                                out.println("ptr:" + ptr);
                                out.println("Actr:" + Actr);
                                out.println("Aptr:" + Aptr);
                                out.println("vmf:" + vmf);
                                out.println("cmf:" + cmf); */
                            }
                            String sdate = request.getParameter("sdate");
                            String edate = request.getParameter("edate");
                            System.out.println("Starting date:" + sdate);
                            System.out.println("Ending date:" + edate);
                            int start = Integer.parseInt(request.getParameter("start"));
                            int limit = 10;
                            int count = 0;
                            String sql = null;
                            System.out.println("meterid---->" + meter_id);
                            if (sdate.equals("") && edate.equals(""))//Complete data without date selection
                            {
                                sql = "select count(*) from d2 where meterid=" + meter_id + "";
                                pstmt = con.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                if (rs.next()) {
                                    count = rs.getInt(1);
                                }//end if
                                System.out.println("Total No of records :" + count + "   Apply EMF :" + aemf);
                                if (DBUtil.getTargetDB().equals("oracle")) {
                                    sql = "select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT from "
                                            + "(select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,meterid,rownum r from"
                                            + "( select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,meterid from d2 order by to_timestamp(g2,'dd-mm-yyyy hh24:mi:ss') desc) where rownum <? and meterid=?) where  r>=?";
                                    pstmt = con.prepareStatement(sql);
                                    pstmt.setInt(1, start + limit);
                                    pstmt.setString(2, meter_id);
                                    pstmt.setInt(3, start);
                                } else if (DBUtil.getTargetDB().equals("mysql")) {
                                    sql = "select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,"
                                            + "rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,"
                                            + "REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,"
                                            + "BPH_REACT_CURRENT,YPH_REACT_CURRENT from d2  "
                                            + "where meterid=? order by meter_time_stamp desc limit ?,?";
                                    if (start == 1) {
                                        start = 0;
                                    }
                                    pstmt = con.prepareStatement(sql);
                                    pstmt.setString(1, meter_id);
                                    pstmt.setInt(2, start);
                                    pstmt.setInt(3, start + limit);
                                }//end else

                                rs = pstmt.executeQuery();
                                String dataString = "";
                                while (rs.next())//Complete data
                                {
                                    if (aemf == 0) {
        %>
        <tr>
            <td class="td2"><%=meter_sl_no%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(0, 10)%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(10)%></td>
            <td class="td2"><%=rs.getString("rph_voltage") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("rph_voltage")))%></td>
            <td class="td2"><%=rs.getString("yph_voltage") == null ? "NA" :df1.format(Double.parseDouble( rs.getString("yph_voltage")))%></td>
            <td class="td2"><%=rs.getString("bph_voltage") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("bph_voltage")))%></td>
            <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "NA" :df1.format(Double.parseDouble( rs.getString("RPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_LINE_CURRENT") == null ? "NA" :df1.format(Double.parseDouble( rs.getString("YPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_LINE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_LINE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("RPH_POWER_FACTOR") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("YPH_POWER_FACTOR") == null ? "NA" :df1.format(Double.parseDouble(rs.getString("YPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("BPH_POWER_FACTOR") == null ? "NA" :df1.format(Double.parseDouble(rs.getString("BPH_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("AVG_POWER_FACTOR") == null ? "NA" :df1.format(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))%></td>

            <td class="td2"><%=rs.getString("RPH_ACTIVE_CURRENT") == null ? "NA" :df1.format(Double.parseDouble(rs.getString("RPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_ACTIVE_CURRENT") == null ? "NA" :df1.format(Double.parseDouble( rs.getString("YPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_ACTIVE_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("BPH_ACTIVE_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("RPH_REACT_CURRENT") == null ? "NA" : df1.format(Double.parseDouble(rs.getString("RPH_REACT_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("YPH_REACT_CURRENT") == null ? "NA" :df1.format(Double.parseDouble(rs.getString("YPH_REACT_CURRENT")))%></td>
            <td class="td2"><%=rs.getString("BPH_REACT_CURRENT") == null ? "NA" :df1.format(Double.parseDouble( rs.getString("BPH_REACT_CURRENT")))%></td>

            <td class="td2"><%=rs.getString("FUND_ACT_POWER") == null ? "" :df1.format(Double.parseDouble( rs.getString("FUND_ACT_POWER")))%></td>
            <td class="td2"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")))%></td>
            <td class="td2"><%=rs.getString("REACT_POWER") == null ? "" :df1.format(Double.parseDouble(rs.getString("REACT_POWER")))%></td>
            <td class="td2"><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>


        </tr>
        <%

                                            } else {
                                                System.out.println("<----------------------------MF Selected--------------------->");
        %>
        <!-- With MF-->
        <tr>
            <td class="td2"><%=meter_sl_no%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(0, 10)%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(10)%></td>
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
            <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))%></td>
            <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("FUND_ACT_POWER")) / cmf)%></td>
            <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")) / cmf)%></td>
            <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")) / cmf)%></td>
            <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("FREQUENCY") == null ? "" :df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>

        </tr>
        <%
                                            }
                                        }//while
                                    } else {
                                        System.out.println("Date Range Selected---------------------------------------------------->");
                                        System.out.println("meterid---->" + meter_id);
                                        pstmt2 = con.prepareStatement("select * from meter where meterid=" + meter_id);
                                        rs2 = pstmt2.executeQuery();
                                        if (rs2.next()) {
                                            ctr = Double.parseDouble(rs2.getString("METER_CTR"));
                                            ptr = Double.parseDouble(rs2.getString("METER_PTR"));
                                            Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR"));
                                            Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR"));
                                            cmf = (Actr / Aptr) * (ctr / ptr);
                                            vmf = Double.parseDouble(df1.format(Aptr / ptr));
                                            pmf = Double.parseDouble(df1.format(cmf / vmf));
                                            System.out.println("ctr:" + ctr);
                                            System.out.println("ptr:" + ptr);
                                            System.out.println("Actr:" + Actr);
                                            System.out.println("Aptr:" + Aptr);
                                            System.out.println("vmf:" + vmf);
                                            System.out.println("cmf:" + cmf);
                                        }
                                        if (DBUtil.getTargetDB().equals("oracle")) {
                                            sql = "select count(*) from d2 where meterid=" + meter_id + " and to_date(g2,'DD-MM-YYYY HH24:MI:SS') >= to_date('" + sdate + "','DD/MM/YYYY') and to_date(G2,'DD-MM-YYYY HH24:MI:SS')<=to_date('" + edate + "','DD/MM/YYYY')";
                                        } else if (DBUtil.getTargetDB().equals("mysql")) {
                                            sql = "select count(*) from d2 where meterid=" + meter_id + " and "
                                                    + "str_to_date(g2,'%d-%m-%Y %H:%i:%s') >= str_to_date('" + sdate + "','%d/%m/%Y') "
                                                    + "and str_to_date(g2,'%d-%m-%Y %H:%i:%s')<= str_to_date('" + edate + "','%d/%m/%Y')";
                                        }//end else if
                                        pstmt = con.prepareStatement(sql);
                                        rs = pstmt.executeQuery();
                                        if (rs.next()) {
                                            count = rs.getInt(1);
                                        }//end if
                                        if (DBUtil.getTargetDB().equals("oracle")) {
                                            sql = "select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT from "
                                                    + "(select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,meterid,rownum r from"
                                                    + "(select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,YPH_REACT_CURRENT,meterid from d2 "
                                                    + " where  meterid=? and to_date(g2,'DD-MM-YYYY HH24:MI:SS') >= to_date('" + sdate + "','DD/MM/YYYY')and to_date(G2,'DD-MM-YYYY HH24:MI:SS') <= to_date('" + edate + "','DD/MM/YYYY') order by g2 desc) where rownum <=? )  where  r>=?";
                                            pstmt = con.prepareStatement(sql);
                                            pstmt.setString(1, meter_id);
                                            pstmt.setInt(2, start + limit);
                                            pstmt.setInt(3, start);
                                        } else if (DBUtil.getTargetDB().equals("mysql")) {
                                            sql = "select g3,rph_voltage,yph_voltage,bph_voltage,rph_line_current,yph_line_current,"
                                                    + "bph_line_current,rph_power_factor,yph_power_factor,bph_power_factor,"
                                                    + "avg_power_factor,FUND_ACT_POWER,APPARENT_POWER,REACT_POWER,"
                                                    + "FREQUENCY,RPH_ACTIVE_CURRENT,YPH_ACTIVE_CURRENT,"
                                                    + "BPH_ACTIVE_CURRENT,RPH_REACT_CURRENT,BPH_REACT_CURRENT,"
                                                    + "YPH_REACT_CURRENT from d2 where meterid=? and "
                                                    + "str_to_date(g2,'%d-%m-%Y') >= str_to_date('" + sdate + "','%d/%m/%Y') and "
                                                    + "str_to_date(g2,'%d-%m-%Y') <= str_to_date('" + edate + "','%d/%m/%Y') "
                                                    + "order by meter_time_stamp desc limit ?,?";
                                            //System.out.println(sql);
                                            if (start == 1) {
                                                start = 0;
                                            }//end if
                                            pstmt = con.prepareStatement(sql);
                                            pstmt.setString(1, meter_id);
                                            pstmt.setInt(2, start);
                                            pstmt.setInt(3, start + limit);
                                            //System.out.println("Start Val :" + start);
                                            //System.out.println("End Val :" + (start + limit));
                                        }//end else if

                                        rs = pstmt.executeQuery();
                                        String dataString = "";
                                        while (rs.next()) {
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
                                            if (aemf == 0)//without MF
                                            {
        %>
        <!-- Without MF-->
        <tr>
            <td class="td2"><%=meter_sl_no%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(0, 10)%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(10)%></td>
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
            <td class="td2"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))%></td>
            <td class="td2"><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("FUND_ACT_POWER")))%></td>
            <td class="td2"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")))%></td>
            <td class="td2"><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")))%></td>
            <td class="td2"><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>
        </tr>
        <%
                                                    } else {
        %>
        <!-- With MF-->
        <tr>
            <td class="td2"><%=meter_sl_no%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(0, 10)%></td>
            <td class="td2"><%=rs.getString("g3") == null ? "" : rs.getString("g3").substring(10)%></td>
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
            <td class="td2"><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("FUND_ACT_POWER")) / cmf)%></td>
            <td class="td2"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")) / cmf)%></td>
            <td class="td2"><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")) / cmf)%></td>
            <td class="td2"><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>
        </tr>
        <%
                                    }

                                }//while
                            }

                            out.println(stringToReturn);
        %>
      <!--  <tr>
            <td colspan="3">From  :<blink><%= sdate%></blink></td>
        <td colspan="3">To  :<blink><%= edate%></blink></td>
        </tr> -->
    </table>
    <!-- code for pagination -->
    <table width="100%" border="0">
        <tr>
            <td width="100%" align="center">
                <table>&nbsp;&nbsp;
                    <tr>
                        <%
                                            // code for previous
                                            int start_tmp = start;

                                            // code for page numbers
                                            //  start = 1;

                                            if (((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1 > 10) {
                        %>
                        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:getInstantData(<%=((start_tmp / 100) * 100) - 9%>)" style="text-decoration:none;">Prev 10</a></td>&nbsp;
                        <%
                                            }
                                            int page_no_start = (start_tmp / 100) * 100 + 1;
                                            int page_no_end = ((start_tmp / 100) * 100) + 90;
                                            page_no_start = (page_no_start / 10) + 1;
                                            page_no_end = (page_no_end / 10) + 1;

                                            start = 1;
                                            if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                                                page_no_end = (int) Math.ceil((double) count / (double) limit);
                                            }

                                            for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++) {
                                                if (i >= page_no_start && i <= page_no_end) {
                                                    if (i == ((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1) {
                        %>

                        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:getInstantData(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>&nbsp;

                        <%
                                                                            } else {
                        %>

                        <td id="pageNo"><a href="#"  onclick="javascript:getInstantData(<%=start%>)"><%=i%></a></td>&nbsp;

                        <%
                                                    }
                                                }
                                                start = start + limit;
                                            }
                                            // code for next
                                            //if((((Integer.parseInt(request.getParameter("start"))-1)/10)+1)>=1)
                                            start = start_tmp;
                                            if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                                            } else {
                                                start = Integer.parseInt(request.getParameter("start")) + 100;
                        %>
                        <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:getInstantData(<%=start%>)" style="text-decoration:none;">Next 10</a></td>&nbsp;

                        <%
                                            }
                        %>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <%
                        pstmt1 = con.prepareStatement("select * from meter where meterid=" + meter_id);
                        rs1 = pstmt1.executeQuery();
                        while (rs1.next()) {
    %>
   <!-- <table border="0" width="100%">
        <tr bgcolor="#56a5ec"  width="20%" colspan="3" rowspan="2">
            <td>
                <font color="#fffff">Inst CT Ratio &nbsp;:</font>
                <font color="white"><%=rs1.getString("meter_ctr")%></font>
            </td>
            <td>
                <font color="#fffff">Inst PT Ratio &nbsp;:</font>
                <font color="white"><%=rs1.getString("meter_ptr")%></font>
            </td>
            <td>
                <font color="#fffff">Adopted CT Ratio &nbsp;:</font>
                <font color="white"><%=rs1.getString("adopted_ctr")%></font>
            </td>
            <td>
                <font color="#fffff">Adopted CT Ratio &nbsp;:</font>
                <font color="white"><%=rs1.getString("adopted_ptr")%></font>
            </td>
            <td>
                <font color="#fffff">EMF &nbsp;:</font>
                <font color="white"><%=rs1.getString("mf")%></font>
            </td>
        </tr>
    </table>  -->
    <%
                        }
    %>
</div>   
<%
                }// end of complete data
                
                else {
                    double ctr, ptr, Actr, Aptr;
                    double vmf = 1.0, cmf = 1.0;
                    System.out.println("meterid---->" + meter_id);
                    pstmt2 = con.prepareStatement("select * from meter where meterid=" + meter_id);
                    rs2 = pstmt2.executeQuery();
                    if (rs2.next()) {
                        ctr = Double.parseDouble(rs2.getString("METER_CTR") == null ? "1.0" : rs2.getString("METER_CTR"));
                        ptr = Double.parseDouble(rs2.getString("METER_PTR") == null ? "1.0" : rs2.getString("METER_PTR"));
                        Actr = Double.parseDouble(rs2.getString("ADOPTED_CTR") == null ? "1.0" : rs2.getString("ADOPTED_CTR"));
                        Aptr = Double.parseDouble(rs2.getString("ADOPTED_PTR") == null ? "1.0" : rs2.getString("ADOPTED_PTR"));
                        cmf = (Actr / Aptr) * (ctr / ptr);
                        vmf = Double.parseDouble(df1.format(Aptr / ptr));
                        pmf = Double.parseDouble(df1.format(cmf / vmf));
                        System.out.println("ctr:" + ctr);
                        System.out.println("ptr:" + ptr);
                        System.out.println("Actr:" + Actr);
                        System.out.println("Aptr:" + Aptr);
                        System.out.println("vmf:" + vmf);
                        System.out.println("cmf:" + cmf);
                        System.out.println("pmf:" + pmf);
                    }
                    //pstmt = con.prepareStatement("select * from d2 where cdfid = ( select max(cdfid) from meter_data_time_stamp where meter_data_timestamp = ( select max(meter_data_timestamp) from meter_data_time_stamp where meterid="+meter_id+" ) )");
                    if (DBUtil.getTargetDB().equals("oracle")) {
                        pstmt = con.prepareStatement("select * from d2 where meterid=" + meter_id + " order by to_timestamp(g2,'DD-MM-YYYY HH24:MI:SS') desc");
                    } else {
                        pstmt = con.prepareStatement("select * from d2 where meterid=" + meter_id + " order by meter_time_stamp desc");
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
                    <td width="20%" colspan="3" rowspan="2">
                        <font color="#fffff">
                            <b>Date Of Reading:&nbsp;</b></font><font color="white"><%=rs.getString("g3").substring(0, 10)%>
                        </font>
                    </td>
                    <td width="20%" colspan="3" rowspan="2">
                        <font color="#fffff">
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


                    <td align="center" colspan="1"style="color: white; font-weight: bold;">Active Power</td>
                    <td align="center" colspan="1"style="color: white; font-weight: bold;">Apparent Power</td>
                    <td align="center" colspan="1"style="color: white; font-weight: bold;">Reactive Power</td>
                    <td align="center" colspan="8"style="color: white; font-weight: bold;">Frequency</td>
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
                                        if (aemf == 0) {
                %>
                <tr bgcolor="#e0ecf8" align="center">
                    <td class="td2"><%=rs.getString("rph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("rph_voltage")))%></td>
                    <td class="td2"><%=rs.getString("yph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("yph_voltage")))%></td>
                    <td class="td2"><%=rs.getString("bph_voltage") == null ? "" : df1.format(Double.parseDouble(rs.getString("bph_voltage")))%></td>
                    <td class="td2"><%=rs.getString("RPH_LINE_CURRENT") == null ? "" :df1.format(Double.parseDouble( rs.getString("RPH_LINE_CURRENT")))%></td>
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
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" :df1.format(Double.parseDouble( rs.getString("AVG_POWER_FACTOR")))%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("FUND_ACT_POWER") == null ? "" :df1.format(Double.parseDouble( rs.getString("FUND_ACT_POWER")))%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")))%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")))%></td>
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>
                <%--    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("VOLTAGE_PHASE_SEQUENCE") == null ? "" : rs.getString("VOLTAGE_PHASE_SEQUENCE")%></td> --%>
                </tr>
                <%
                                                        } else {
                                                            System.out.println("It is Else Start");
                %>
                <tr bgcolor="#e0ecf8" align="center">
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
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("AVG_POWER_FACTOR") == null ? "" : df1.format(Double.parseDouble(rs.getString("AVG_POWER_FACTOR")))%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("FUND_ACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("FUND_ACT_POWER")) / cmf)%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("APPARENT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("APPARENT_POWER")) / cmf)%></td>
                    <td class="td2" bgcolor="#e0ecf8" style="color:#494949;"><%=rs.getString("REACT_POWER") == null ? "" : df1.format(Double.parseDouble(rs.getString("REACT_POWER")) / cmf)%></td>
                    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("FREQUENCY") == null ? "" : df1.format(Double.parseDouble(rs.getString("FREQUENCY")))%></td>
                 <%--    <td class="td2" bgcolor="#e0ecf8"><%=rs.getString("VOLTAGE_PHASE_SEQUENCE") == null ? "" : rs.getString("VOLTAGE_PHASE_SEQUENCE")%></td>--%>
                </tr>
                <%
                                            System.out.println("It is Else End");
                                        }//end else
%>
            </table> </td></tr></table>
            <%
                                    pstmt1 = con.prepareStatement("select * from meter where meterid=" + meter_id);
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
                    }//while
                    //  String instant_split[] = dataString.split(",");
                    // out.println(instant_split.lengtd);
//   stringToReturn = stringToReturn+"<tr>";

                    //  for(int i=0;i<instant_split.lengtd;i++)
                    //       stringToReturn = stringToReturn+"<td>"+instant_split[i]+"</td>";;

                    //  stringToReturn = stringToReturn + "</tr></table>";
                    stringToReturn = stringToReturn;
                    out.println(stringToReturn);

                }
            } catch (Exception e) {
                out.println("Plz Try Again....");
                e.printStackTrace();
            }
            finally{
                con.close();
            }
%>
