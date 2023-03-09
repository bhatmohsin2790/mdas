<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>

<form name="circle" action="" >
    <div id="cone">
        <table align="center" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5" width="350px">
            <tr><th colspan="2"><h2> Update Circle</h2></th></tr>
            <tr>
                <td align="left">Select Zone : </td>


                <td>
                    <select name="zone" id="zoneId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">

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
            <tr>
                <td>Select Circle:</td>
                <td>
                    <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="oldCircle();">
                        <option value="-1">Select circle</option>


                    </select>
                </td>
            </tr>
        </table>
    </div>
    <div id="ctwo" >
        <table bgcolor="#E0ECF8" width="350px">
            <tr>
                <td>
                    CircleId:</td>
                <td><input type="text" id="cirid" readonly></td>
            <tr>
                <td>
                    Change CircleName:</td>
                <td><input type="text" id="cname"></td>
            </tr>
            <tr>
                <td>Select Zone:</td>
                <td>
                    <select name="zonename" id="newzoneId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >
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
                                    }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td></td>
                <td><input type="button" value="update " onclick="newCircle()"/></td>
            </tr>


        </table>
    </div>
</form>
