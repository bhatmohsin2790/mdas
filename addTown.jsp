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

<form name="section"  >
    <table align="center" bgcolor="#E0ECF5" cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2><u> Add Town</u></h2></th></tr>
        <tr>
            <td>Zone name:</td>
            <td>
                <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">

                    <option value="-1">Select Zone</option>
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
            <td>Circle name:</td>
            <td>
                <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                    <option value="-1">Select Circle</option>
                </select>
            </td>
        </tr>       
        <tr>
            <td>Town name:</td>
            <td><input type="text" name="town" id="townId"/></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" value="add " onclick="insertTown();"/></td>
        </tr>
    </table>
</form>
