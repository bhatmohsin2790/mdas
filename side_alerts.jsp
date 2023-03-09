<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.ResultSet"%>
<form name="meterReportsForm" action="javascript:void(0)">
    <table border="0" width="150px" style="padding-top: 0em; padding-bottom: 0.0em">
        <tr>
            <td align="left" style="line-height: 18px;">
                <table border="0">
                    <tr>
                        <td><input type="radio" name="r1" value="ht"  onclick="getAlertsHirarchy(this.value);"/></td>
                        <td> HT</td>
                        <td><input type="radio" name="r1" value="feeder"  onclick="getAlertsHirarchy(this.value);"/></td>
                        <td> Feeder</td>
                        <td><input type="radio" name="r1" value="dtr" checked onclick="getAlertsHirarchy(this.value);"/></td>
                        <td> DTR</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

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
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select Circle</option>
                <%
                                    Connection con = new DBUtil().getConnection();
                                    PreparedStatement pstmt = null;
                                    ResultSet rs = null;
                                    try {
                                        pstmt = con.prepareStatement("select * from circle");
                                        rs = pstmt.executeQuery();
                                        while (rs.next()) {
                        %>
                        <option value="<%=rs.getString("circleid")%>"><%=rs.getString("circlename")%></option>
                        <%
                                        }

                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                        %>
            </select>
        </td>
    </tr>
            <tr>
                <td align="left">
                    <b>Division :</b>
                    <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showSubDivisions(this.value);">
                        <option value="0">Select Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <b>Sub Division :</b>
                    <select name="subdivision" id="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showTowns(this.value)">
                        <option value="0">Select Sub-Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <b>Town :</b>
                    <select name="town" id ="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showSubStations(this.value);">
                        <option value="0">Select Town</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <b>Substation :</b>
                    <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showFeeders(this.value);">
                        <option value="0">Select SubStation</option>
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
            <!-- search meters -->
            <tr>
                <td align="left">
                    <h4><input type="text" name="meterSearchId" id="meterSearchId" maxlength="8" style="width:150px" /></h4>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <h4><input type="button" value="Search Meter(s)" onclick="javascript:searchForMeters('dtr')"/></h4>
                </td>
            </tr>

            <tr>
                <td align="left">
                    <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="12" onChange="sendMeterId();">
                    </select>
                </td>
            </tr>
        </table>
    </div>
</form>