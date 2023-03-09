<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<table border="1" cellspacing="0" cellpadding="0" width="50%">
    <tr><td style="height:1px;background-color:#ddd;">Event</td>
        <td style="height:1px;background-color:#ddd;">Mail IDs</td>
    </tr>
<%
    try {
        PreparedStatement ps = null;
        String sql = "";
        ResultSet rs = null;

        Connection con = new DBUtil().getConnection();
        sql = "select e.event_type,c.emailid  from CRITICAL_EVENTS c,events e where e.event_code=c.event_code";
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) { %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
        </tr>
      <%  }//while
    } catch (Exception e) {
        //e.printStackTrace();
        out.println("Error,Try again..." + e.getMessage());
    }
%>
</table>