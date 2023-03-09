<%@ include file="getConnection.jsp"%>

<%!
PreparedStatement pstmt=null;
  //Statement pstmt = null;
%>
<%
String locid=request.getParameter("locid");
String locname=request.getParameter("locname");
String vsql="insert into METERLOCATION values(?,?)";

pstmt=con.prepareStatement(vsql);

pstmt.setString(1, locid);
pstmt.setString(2, locname);
pstmt.executeUpdate();
con.close();


%>
Successfully Stored Data in the Database ..........
<a href="<%=response.encodeRedirectURL("MeterLocation.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>