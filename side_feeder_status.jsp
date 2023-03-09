<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<script type="text/javascript" src="admin_hirarchy.js"></script>
<form>
<table border="0" width="150px" height="450px">

            
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
                            onChange="showScreen(this.value);">
                        <option value="0">Select SubStation</option>
                    </select>
                </td>
            </tr>


           
        </table>
            </form>