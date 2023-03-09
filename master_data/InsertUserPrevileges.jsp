<%@ include file="getConnection.jsp"%>

<%!    PreparedStatement pstmt = null; %>
<%
            String userId = request.getParameter("userId");
            String zones = request.getParameter("zones");
            String circles = request.getParameter("circles");
            String divisions = request.getParameter("divisions");
            String subdivisions = request.getParameter("subdivisions");
            String substations = request.getParameter("substations");
            String feeders = request.getParameter("feeders");
            String dtrs = request.getParameter("dtrs");
            String consumers = request.getParameter("consumers");
            String meters = request.getParameter("meters");
            String feederCurrentData = request.getParameter("feederCurrentData");
            String feederTotalData = request.getParameter("feederTotalData");
            String feederReports = request.getParameter("feederReports");
            String dtrCurrentData = request.getParameter("dtrCurrentData");
            String dtrTotalData = request.getParameter("dtrTotalData");
            String dtrReport = request.getParameter("dtrReport");



            String vsql = "insert into USER_PRIVILEGES values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

            pstmt = con.prepareStatement(vsql);

            pstmt.setString(1, userId);
            pstmt.setString(2, zones);
            pstmt.setString(3, circles);
            pstmt.setString(4, divisions);
            pstmt.setString(5, subdivisions);
            pstmt.setString(6, substations);
            pstmt.setString(7, feeders);
            pstmt.setString(8, dtrs);
            pstmt.setString(9, consumers);
            pstmt.setString(10, meters);
            pstmt.setString(11, feederCurrentData);
            pstmt.setString(12, feederTotalData);
            pstmt.setString(13, feederReports);
            pstmt.setString(14, dtrCurrentData);
            pstmt.setString(15, dtrTotalData);
            pstmt.setString(16, dtrReport);
            pstmt.executeUpdate();
            con.close();


%>
Successfully Stored Data in the Database..........
<a href="<%=response.encodeRedirectURL("User_Previleges.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>