<body>
    <%@ include file="getConnection.jsp"%>

    <%!    Statement stmt = null;
        ResultSet rs = null;
        //Statement pstmt = null;
    %>
    <%
                String query = "SELECT * FROM METERMAKE";
                stmt = con.createStatement();
                rs = stmt.executeQuery(query);%>
    <label style="position:absolute;font-weight:500;font-size:x-large;top:50px;left:250px;color:midnightblue;">Metermake Information From Database</label>
    <table cellpadding="15" border="1" align="center" style="background-color:aquamarine;position:absolute;top:100px;left:90px">

        <% while (rs.next()) {%>
        <tr>
            <td width="25"> <%=rs.getString(1)%></td>
            <td width="50"> <%=rs.getString(2)%></td>
            <td width="25"> <%=rs.getString(3)%></td>
            <td width="50"> <%=rs.getString(4)%></td>
            <td width="25"> <%=rs.getString(5)%></td>
            <td width="180"> <%=rs.getString(6)%></td>
            <td width="60"> <%=rs.getString(7)%></td>
            <td width="60"> <%=rs.getString(8)%></td>
        </tr>

        <% }%>
    </table>
    <%
                con.close();
                rs.close();
                stmt.close();

    %>
    <a href="<%=response.encodeRedirectURL("Metermake.jsp")%>" style="position:absolute;top:530px;left:450px;color:red;">Back</a>
</body>
