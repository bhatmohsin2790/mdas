<%@ page session="false" %>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
            String meterLoc = request.getParameter("meterLoc");
            if (meterLoc.equals("dtr")) {
%>

<table border="0" width="150px">

    <tr>
        <td align="left">
            <h4><input type="text" name="meterSearchId" id="meterSearchId" maxlength="8" /></h4>
        </td>
    </tr>
    <tr>
        <td align="left">
            <h4><input type="button" value="Search Meter(s)" onclick="javascript:searchForMeters()"/></h4>
        </td>
    </tr>
    <tr>
        <td align="left"><b>DISCOM :</b>
            <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showZones(this.value);">
                <option value="0">Select DISCOM</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    pstmt = con.prepareStatement("select * from discom");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("discom_id")%>"><%=rs.getString("discom_name")%></option>
                <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left"><b>Zone :</b>
            <select name="zone" id ="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showCircles(this.value);">
                <option value="0">Select Zone</option>

            </select>
        </td>
    </tr>

    <tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select Circle</option>

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
                    onChange="showSections(this.value);">
                <option value="0">Select Sub_Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Section :</b>
            <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubStations(this.value);">
                <option value="0">Select Section</option>
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

    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="12" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>

<%                    } else if (meterLoc.equals("feeder")) {

%>

<table border="0" width="150px">

    <tr>
        <td align="left">
            <h4><a href="javascript:void(0)">Administrative Hirarchy</a></h4>
        </td>
    </tr>
    <tr>
        <td align="left"><b>DISCOM :</b>
            <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showZones(this.value);">
                <option value="0">Select DISCOM</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    pstmt = con.prepareStatement("select * from discom");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("discom_id")%>"><%=rs.getString("discom_name")%></option>
                <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left"><b>Zone :</b>
            <select name="zone" id ="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showCircles(this.value);">
                <option value="0">Select Zone</option>

            </select>
        </td>
    </tr>

    <tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select Circle</option>

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
                    onChange="showSections(this.value);">
                <option value="0">Select Sub_Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Section :</b>
            <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubStations(this.value);">
                <option value="0">Select Section</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Substation :</b>
            <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDTRs(this.value,0);">
                <option value="0">Select SubStation</option>
            </select>
        </td>
    </tr>


    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="12" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>

<%            } else if (meterLoc.equals("ht")) {

%>

<table border="0" width="150px">

    <tr>
        <td align="left">
            <h4><a href="javascript:void(0)">Administrative Hirarchy</a></h4>
        </td>
    </tr>
    <tr>
        <td align="left"><b>DISCOM :</b>
            <select name="discom" id ="discom" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showZones(this.value);">
                <option value="0">Select DISCOM</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    pstmt = con.prepareStatement("select * from discom");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("discom_id")%>"><%=rs.getString("discom_name")%></option>
                <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                finally{
                                    con.close();
                                }
                %>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left"><b>Zone :</b>
            <select name="zone" id ="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showCircles(this.value);">
                <option value="0">Select Zone</option>

            </select>
        </td>
    </tr>

    <tr>
        <td align="left">
            <b>Circle :</b>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showDivisions(this.value);">
                <option value="0">Select Circle</option>

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
                    onChange="showSections(this.value);">
                <option value="0">Select Sub_Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            <b>Section :</b>
            <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                    onChange="showSubStations(this.value);">
                <option value="0">Select Section</option>
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
                    onChange="showDTRs(this.value,2);">
                <option value="0">Select Feeder</option>
            </select>
        </td>
    </tr>

    <tr>
        <td align="left">
            <select name="dtr" id="dtr" style="width:150px;font-size:12px;font-family:verdana;" size="12" onChange="getDataReportsInstantData(this.value);">
            </select>
        </td>
    </tr>
</table>

<%            }//end else if
%>