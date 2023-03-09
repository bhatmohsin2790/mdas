<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>

<body>
    <%

                Statement stmtvml = null;
                ResultSet rsvml = null;
                Connection conv = null;
                conv = new DBUtil().getConnection();
                String query1 = "select * from meterlocation";
                stmtvml = conv.createStatement();
                rsvml = stmtvml.executeQuery(query1);%>
   
    <table id="dtable"  cellspacing="0" cellpadding="0">
        <thead>
        <tr>
            <td >Meter Location Id</td>
            <td >Meter Location Name</td>
        </tr>
        </thead>
        <tbody>

        <% while (rsvml.next()) {%>
        <tr>
            <td > <%=rsvml.getString(1)%></td>
            <td > <%=rsvml.getString(2)%></td>
        </tr>
        <% }%>
        </tbody>
    </table>
    <%
                if (rsvml != null) {
                    rsvml.close();
                }
                if (stmtvml != null) {
                    stmtvml.close();
                }
                if (conv != null) {
                    conv.close();
                }
    %>
</body>