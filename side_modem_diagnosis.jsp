<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<form name="meterReportsForm" action="javascript:void(0)">
    <div id="getHirarchy">
        <table border="0" width="150px">
            
            <tr>
                <td align="left"><b>DISCOM :</b>
                    <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="">
                        <option value="16">JKPDD</option>
                        
                    </select>
                </td>
            </tr>
      <tr>
      <tr>
            <td align="left"><b>Zone :</b>
                <select name="zone" id ="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                        onChange="showCircles(this.value);">
                    <option value="0">Select Zone</option>
                  <%
                     try {
						 
                                    //-----------------------------
                                        HttpSession sess=request.getSession(false);
                                        String office_type=sess.getAttribute("office_type").toString();
										
                                        String office_type_id=sess.getAttribute("office_type_id").toString();
										
                                    //-----------------------------
                                    Connection con = new DBUtil().getConnection();
                                    PreparedStatement pstmt = null;
                                    ResultSet rs = null;
                                    String sql = "";
                                        if (office_type.trim().equals("SDO")) {
                                                sql = "select zoneid,zonename from zone where zoneid in(select zoneid from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid in(select divisionid from subdivision where subdivid=" + office_type_id + "))))";
                                            }
                                           else if (office_type.trim().equals("DO")) {
                                                sql = "select zoneid,zonename from zone where zoneid in(select zoneid from circle where circleid in(select circleid from town where townid in(select townid from division where divisionid=" + office_type_id + ")))";
                                            } else {
                                                sql = "select * from zone";
                                            }
                                        System.out.println(sql);
                                        pstmt = con.prepareStatement(sql);
                                        rs = pstmt.executeQuery();
                                        while (rs.next()) {
                        %>
                        <option value="<%=rs.getString("zoneid")%>"><%=rs.getString("zonename")%></option>
                        <%
                                        }

                                    } catch (Exception e) {
                                        out.println("Error....>"+e.getMessage());
                                        e.printStackTrace();
                                    }
                        %>
                </select>
            </td>
        </tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showTowns(this.value);">
                <option value="0">Select Circle</option>
                
            </select>
        </td>
    </tr>
            <tr>
                <td align="left">
                    <b>Town :</b>
                    <select name="town" id="townid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showDivisions(this.value);">
                        <option value="0">Select Town</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <b>Division :</b>
                    <select name="division" id="divisionid" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showSubDivisions(this.value)">
                        <option value="0">Select Division</option>
                    </select>
                </td>
            </tr>           
            <tr>
                <td align="left">
                    <b>Sub Division :</b>
                    <select name="subdivision" id ="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showSubStations(this.value);">
                        <option value="0">Select Sub-Division</option>
                    </select>
                </td>
            </tr>            
            <tr>
                <td align="left">
                    <b>Receiving Station :</b>
                    <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showFeeders(this.value);">
                        <option value="0">Select Receiving Station</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <b>Feeder :</b>
                    <!-- showDTRs(this.value,2) 2-ht 0-feeder 1-dtr -->
                    <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showDTRs(this.value,1);">
                        <option value="0">Select Feeder</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                        <input type="radio" name="r1" value="ht"/>HT
                        <input type="radio" name="r1" value="feeder"/>Feeder
                        <input type="radio" name="r1" value="dtr"/>DTR
                </td>
                    </tr>
            <tr>
                <td align="left">
                    <b>Search By :</b></td></tr>
            
            <tr><td>
                     <select name="searchBy" id="searchBy" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="">
                        <option value="meter">Meter slno</option>
                        <option value="name">Location Name</option>
                        <option value="code">Location Code</option>
                    </select>
                </td>
            </tr>
            <!-- search meters -->
            <tr>
                <td align="left">
                    <h4><input type="text" name="meterSearchId" id="meterSearchId" maxlength="8" style="width:150px" /></h4>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <h4><input type="button" value="Search Meter(s)" onclick="searchForMeters()"/></h4>
                </td>
            </tr>

            <tr>
                <td align="left">
                    <select name="dtr" id="dtr" style="width:190px;font-size:12px;font-family:verdana;" size="12" onChange="sendMeterId();">
                    </select>
                </td>
            </tr>
        </table>
    </div>
</form>