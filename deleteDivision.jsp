<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<form name="division"  >
    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2> Delete Division</h2></th></tr>
        <tr>
            <td>Zone name:</td>
            <td>
                <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">

                    <option value="-1">Select Zone</option>
                    <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
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
                                }
                                finally{
                                    con.close();
                                }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td align="left">Select Circle : </td>
            <td>
                <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showTowns(this.value);">
                    <option value="-1">Select circle</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="left">Select Town : </td>
            <td>
                <select name="circle" id="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showDivisions(this.value);">
                    <option value="-1">Select Town</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>select Division:</td>
            <td>
                <select name="divisionname" id="divisionId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >
                    <option value="-1">Select division</option>
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" value="delete " onclick="deleteDivision()"/></td>
        </tr>
    </table>
</form>