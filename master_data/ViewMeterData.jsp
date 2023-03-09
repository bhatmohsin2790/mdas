<body>
<%@ include file="getConnection.jsp"%>

<%!    Statement stmt = null;
    ResultSet rs = null;
    //Statement pstmt = null;
%>
<%
            String query = "SELECT * FROM METER";
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);%>
            <label style="position:absolute;font-weight:500;font-size:x-large;top:50px;left:250px;color:midnightblue;">Meter Data Information From Database</label>
            <table cellpadding="15" border="1" align="center" style="background-color:aquamarine;position:absolute;top:120px;left:10px">

    <% while (rs.next()) {%>
    <tr>
        <td width="25"> <%=rs.getString(1)%></td>
        <td width="50"> <%=rs.getString(2)%></td>
        <td> <%=rs.getString(3)%></td>
        <td> <%=rs.getString(4)%></td>
        <td> <%=rs.getString(5)%></td>
        <td> <%=rs.getString(6)%></td>
        <td> <%=rs.getString(7)%></td>
        <td> <%=rs.getString(8)%></td>
        <td> <%=rs.getString(9)%></td>
        <td> <%=rs.getString(10)%></td>
        <td> <%=rs.getString(11)%></td>
        <td> <%=rs.getString(12)%></td>
        <td> <%=rs.getString(13)%></td>
        <td> <%=rs.getString(14)%></td>
        <td> <%=rs.getString(15)%></td>
        <td> <%=rs.getString(16)%></td>
        <td> <%=rs.getString(17)%></td>
        <td> <%=rs.getString(18)%></td>
        <td> <%=rs.getString(19)%></td>
        <td> <%=rs.getString(20)%></td>
        <td> <%=rs.getString(21)%></td>
        <td> <%=rs.getString(22)%></td>
        <td> <%=rs.getString(23)%></td>

    </tr>

    <% }%>
</table>
<%
            con.close();
            rs.close();
            stmt.close();

%>
<a href="<%=response.encodeRedirectURL("Meter.jsp")%>" style="position:absolute;top:380px;left:450px;color:red;">Back</a>
</body>
