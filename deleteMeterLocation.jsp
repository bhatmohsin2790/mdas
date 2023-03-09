<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<!--<form action="" name="deleteMeterLocation">-->
<!--<form action="meter_management_actions/deleteMeterLocationAction.jsp">-->

<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
    <tr><th colspan="4"><h2>Meter Location</h2></th></tr>
<tr><td>
        LOCATIONID:</td><td>
        <select name="Locid" id="Locid" style="width: 200px;">

            <option value="-1">Select Location</option>
            <%
                Connection condml = new DBUtil().getConnection();
                try {
                    PreparedStatement pstmtdml = condml.prepareStatement("select * from meterlocation");
                    ResultSet rsdml = pstmtdml.executeQuery();
                    while (rsdml.next()) {
            %>
            <option value="<%=rsdml.getString("locationid")%>"><%=rsdml.getString("locationname")%></option>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    con.close();
                }
            %>
        </select></td></tr>
<!--<tr><td>
       LOCATIONNAME:</td><td>
        <input name="locname" type="text" ></td></tr>-->
<tr><td></td><td>
        <input type="button"  value="Delete" onclick="deletetMeterLocation()"></td></tr>



</table>


