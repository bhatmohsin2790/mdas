<%@ include file="getConnection.jsp"%>

<%!    PreparedStatement pstmt = null; %>
<%
            String userId = request.getParameter("userId");
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");
            String zoneId = request.getParameter("zoneId");
            String circleId = request.getParameter("circleId");
            String isActive = request.getParameter("isActive");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");


            String vsql = "insert into USERS values(?,?,?,?,?,?,?,?)";

            pstmt = con.prepareStatement(vsql);

            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            pstmt.setString(3, userType);
            pstmt.setString(4, zoneId);
            pstmt.setString(5, circleId);
            pstmt.setString(6, isActive);
            pstmt.setString(7, firstName);
            pstmt.setString(8, lastName);
            pstmt.executeUpdate();
            con.close();


%>
Successfully Stored Data in the Database..........
<a href="<%=response.encodeRedirectURL("Users.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>