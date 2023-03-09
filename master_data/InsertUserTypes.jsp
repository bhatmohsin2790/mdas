<%@ include file="getConnection.jsp"%>

<%!
PreparedStatement pstmt=null;
  //Statement pstmt = null;
%>
<%
String userTypeId=request.getParameter("userTypeId");
String userTypeName=request.getParameter("userTypeName");


String vsql="insert into USER_TYPES values(?,?)";

pstmt=con.prepareStatement(vsql);

pstmt.setString(1, userTypeId);
pstmt.setString(2, userTypeName);

pstmt.executeUpdate();
con.close();


%>
Successfully Stored Data in the Database ..........
<a href="<%=response.encodeRedirectURL("User_Types.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>