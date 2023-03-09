<%@ include file="getConnection.jsp"%>

<%!
PreparedStatement pstmt=null;
  //Statement pstmt = null;
%>
<%
String metermakeId=request.getParameter("metermakeId");
String metermakeName=request.getParameter("metermakeName");
String meterSeries=request.getParameter("meterSeries");
String meterVersion=request.getParameter("meterVersion");
String noofParams=request.getParameter("noofParams");
String paramNames=request.getParameter("paramNames");
String b4_Tod_Params=request.getParameter("b4_Tod_Params");
String d4_Params=request.getParameter("d4_Params");

String vsql="insert into METERMAKE values(?,?,?,?,?,?,?,?)";

pstmt=con.prepareStatement(vsql);

pstmt.setString(1, metermakeId);
pstmt.setString(2, metermakeName);
pstmt.setString(3, meterSeries);
pstmt.setString(4, meterVersion);
pstmt.setString(5, noofParams);
pstmt.setString(6, paramNames);
pstmt.setString(7, b4_Tod_Params);
pstmt.setString(8, d4_Params);
pstmt.executeUpdate();
con.close();


%>
Successfully Stored Data in the Database ..........
<a href="<%=response.encodeRedirectURL("Metermake.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>