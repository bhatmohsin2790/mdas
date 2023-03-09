<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<form name="onDemandTrack">
    <table border="0" width="150px" style="padding-top: 2em; padding-bottom: 1em">
        <tr>
            <td align="left" style="line-height: 18px;">
                <input type="radio" id="hirType" name="r1" value="dtr" onclick="getHirarchy(this.value);"> DTR
                <input type="radio" id="hirType" name="r1" value="feeder"  onclick="getHirarchy(this.value);"> Feeder
                <input type="radio" id="hirType" name="r1" value="ht" checked onclick="getHirarchy(this.value);"> HT
            </td>
        </tr>
    </table>

    <div id="getHirarchy">
        <table border="0" width="150px">

            <tr>
                <td align="left">
                    <h4><a href="javascript:void(0)">Administrative Hierarchy</a></h4>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Circle :
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
                    Division :
                    <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showSubDivisions(this.value);">
                        <option value="0">Select Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Sub Division :
                    <select name="subdivision" id="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showTowns(this.value);">
                        <option value="0">Select Sub-Division</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Town :
                    <select name="town" id ="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showSubStations(this.value);">
                        <option value="0">Select Town</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Substation :
                    <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showFeeders(this.value);">
                        <option value="0">Select SubStation</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Feeder :
                    <!-- showDTRs(this.value,2) 2-ht 0-feeder 1-dtr -->
                    <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                            onChange="showDTRs(this.value,2);">
                        <option value="0">Select Feeder</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td align="left">
                    <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="8">
                    </select>
                </td>
            </tr>
        </table>
    </div>
</form>