<body>
<%@ include file="getConnection.jsp"%>

<%!    Statement stmt = null;
    ResultSet rs = null;
    //Statement pstmt = null;
%>
<%
            String query = "SELECT * FROM MODEM_ALERTS";
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);%>
            <label style="position:absolute;font-weight:500;font-size:x-large;top:50px;left:250px;color:midnightblue;">Modem Alerts Information From Database</label>
            <table cellpadding="15" border="1" align="center" style="background-color:aquamarine;position:absolute;top:120px;left:50px">

    <% while (rs.next()) {%>
    <tr>
        <td width="50"> <%=rs.getString(1)%></td>
        <td width="50"> <%=rs.getString(2)%></td>
         <td width="50"> <%=rs.getString(3)%></td>
        <td width="50"> <%=rs.getString(4)%></td>
         <td width="50"> <%=rs.getString(5)%></td>
    </tr>

    <% }%>
</table>
<%
            con.close();
            rs.close();
            stmt.close();

%>
<a href="<%=response.encodeRedirectURL("ModemAlerts.jsp")%>" style="position:absolute;top:380px;left:450px;color:red;">Back</a>
</body>
