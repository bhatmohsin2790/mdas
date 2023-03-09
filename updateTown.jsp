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
<form name="s1" id="form1" >
    <div id="ssone">
        <table bgcolor="#E0ECF8" cellpadding="5" cellspacing="5"  id="table1" width="350px">
            <tr><th colspan="2"><h2><u> Edit town</u></h2></th></tr>
            <tr><td>&nbsp;</td>
                <td>&nbsp;</td></tr>
            <tr>
                <td >Zone name:</td>
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
                                    }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Circle name:</td>
                <td>
                    <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showTowns(this.value);">
                        <option value="-1">Select Circle</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td align="left">Select town : </td>
                <td>
                    <select name="town" id="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                        <option value="-1">Select town</option>
                    </select>
                </td>
            </tr></table></div>
    <div id="sstwo" >
        <table bgcolor="#E0ECF8" width="350px"  >
            <tr>
                <td align="left">Edit Name : </td>
                <td><input type="text" name="news" id="tname"></td>
            </tr>            
            <tr><td></td>
                <td><input type="button" value="update" onclick="newTown()"></td>
            </tr></table>
    </div>
</form>
