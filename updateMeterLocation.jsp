<%@ page session="false" %>

<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>


            <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
                <tr><td>Location:</td>
                    <td><select  name="Locid" id="Locid"  onchange="document.getElementById('Locname').value=this.options[this.selectedIndex].text;">

                    <option>select Location</option>

                    <%
                                Statement stmt = null;
                                ResultSet rs = null;
                                Connection con = null;
                                con = new DBUtil().getConnection();
                                try {

                                    stmt = con.createStatement();
                                    rs = stmt.executeQuery("SELECT * FROM  meterlocation");
                                    while (rs.next()) {
                                        out.println("<option value=" + rs.getString("locationid") + " >" + rs.getString("locationname") + "</option>");
                                    }
                                } catch (Exception e) {
                                }

                    %>
                </select>
                    </td></tr>
                <tr><td>Edit Location:</td>
                    <td><input  name="locname" id="Locname" type="text" value=></td></tr>
                <tr><td></td><td></td></tr>
                <tr><td></td><td></td></tr>
                <tr><td></td><td> <input type="button" value="UPDATE"  onclick="updateMeterLocation()"/></td></tr>
            </table>


