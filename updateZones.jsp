<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>

<form name="dzone" title="Deleting Zones" >
    <div id="zone">
        <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5" width="350px">
            <tr><th colspan="2"><h2>Update Zone</h2></th></tr>
            <tr>
                <td align="left">Select Zone : </td>
                <td>
                    <select name="zone" id="zoneId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="oldZone();">

                        <option value="-1">Select zone</option>
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
                        %>
                    </select>
                </td>
            </tr>
        </table>
    </div>
    <div id="ztwo" style="visibility:hidden">
        <table bgcolor="#E0ECF8" width="350px">
            <tr>
                <td>Edit Zone:</td>
                <td><input type="text" id="zname"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="button" value="update" onclick="newZone()"/></td>
            </tr>


        </table></div>
</form>