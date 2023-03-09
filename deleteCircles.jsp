<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<form name="circle" action="" >
    <table align="center" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2> Delete Circle</h2></th></tr>
        <tr>
            <td align="left">Select Zone : </td>
            <td>
                <select name="zone" id="zone" style="width:150px;height:20px;font-size:12px;font-family:verdana;" onchange="showCircles(this.value);">
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
                        finally{
                            con.close();
                        }
                    %>

                </select>
            </td>
        </tr>
        <tr>
            <td>Select Circle:</td>
            <td>
                <select name="circle" id="circleId" style="width:150px;height:20px;font-size:12px;font-family:verdana;">
                    <option value="-1">Select circle</option>


                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" value="delete " onclick="deleteCircles()"/></td>
        </tr>


    </table>
</form>
