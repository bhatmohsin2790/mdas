<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>

<body>
    <%
                Statement stmt = null;
                ResultSet rs = null;
                Connection conmm = null;
                conmm = new DBUtil().getConnection();
                String query = "select * from metermake";
                stmt = conmm.createStatement();
                rs = stmt.executeQuery(query);%>
    
    <table  cellspacing="0" cellpadding="0" id="dtable">
        <thead>
        <tr>
            
            <td width="130">Meter Make</td>
            <td width="130">Meter Series</td>
            <td width="130">Meter Version</td>
        </tr>
        </thead>
        <tbody>
        <% while (rs.next()) {%>
        <tr>
            <td width="130"> <%=rs.getString(2)%></td>
            <td width="130"> <%=rs.getString(3) == null ? "" : rs.getString(3)%></td>
            <td width="130"> <%=rs.getString(4) == null ? "" : rs.getString(4)%></td>

            <%--
            <td width="25"> <%=rs.getString(1)%></td>
            <td width="25"> <%=rs.getString(5)%></td>
            <td width="180"> <%=rs.getString(6)%></td>
            <td width="60"> <%=rs.getString(7)%></td>
            <td width="60"> <%=rs.getString(8)%></td>
            --%>

        </tr>
        <% }%>
        </tbody>
    </table>
    <%
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conmm != null) {
                    conmm.close();
                }
    %>
</body>