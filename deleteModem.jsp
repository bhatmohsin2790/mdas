<%@ page session="false" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>



<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">


    <tr><td>         MODEM:</td><td>
            <select name="ModemId" id="ModemId" style="width: 200px;">

                <option value="-1">Select Modem</option>
                <%
                            Connection conn = new DBUtil().getConnection();

                            try {
                                PreparedStatement pstmt = conn.prepareStatement("select * from modem");
                                ResultSet rs = pstmt.executeQuery();
                                while (rs.next()) {
                %>
                <option value="<%=rs.getString("modem_id")%>"><%=rs.getString("modem_serial_no")%></option>
                <%
                                }

                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                             finally
                                        {
                                    conn.close();
                                    }
                %>
            </select>
        </td></tr>
    <tr><td></td><td></td></tr>
    <tr><td></td><td></td></tr>
    <tr><td></td><td>

            <input type="button" value="DELETE" onclick="deleteModem()"></td></tr>
</table>

