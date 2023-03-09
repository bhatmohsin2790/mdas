<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>


<%
    Connection con = new DBUtil().getConnection();
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<form name="addDivision" >
    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2><u> Add Division</u></h2></th></tr>
        <tr>
            <td>Zone name:</td>
            <td>
                <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;"  onChange="showCircles(this.value);">
                    <option value="-1">Select zone</option>
                    <%
                        try {
                            pstmt = con.prepareStatement("select * from zone");
                            rs = pstmt.executeQuery();
                            while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("zoneid")%>"><%=rs.getString("zonename")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            con.close();
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td align="left">Select Circle : </td>
            <td>
                <select name="circleId" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onChange="showTowns(this.value)">
                    <option value="-1">Select Circle</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="left">Select Town : </td>
            <td>
                <select name="town" id="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                    <option value="-1">Select Town</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>Division name:</td>
            <td><input type="text" id="divisionName"  name="division"/></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button"  value="add " onclick="insertDivision()"/></td>
        </tr>


    </table>
</form>