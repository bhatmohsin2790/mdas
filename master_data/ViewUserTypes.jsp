<html>
    <head>

    <body>
<%@ include file="getConnection.jsp"%>

<%!    Statement stmt = null;
    ResultSet rs = null;
    //Statement pstmt = null;
%>
<%
            String query = "SELECT * FROM USER_TYPES";
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);%>
            <label style="position:absolute;font-weight:500;font-size:x-large;top:50px;left:250px;color:midnightblue;">User Types Information From Database</label>
            <table cellpadding="15" border="1" align="center" style="background-color:aquamarine;position:absolute;top:120px;left:400px">

    <% while (rs.next()) {%>
    <tr>
        <td width="25"> <%=rs.getString(1)%></td>
        <td width="50"> <%=rs.getString(2)%></td>
    </tr>

    <% }%>
</table>
<%
            con.close();
            rs.close();
            stmt.close();

%>
<a href="<%=response.encodeRedirectURL("User_Types.jsp")%>" style="position:absolute;top:55px;left:900px;color:red;">Back</a>
</body>
