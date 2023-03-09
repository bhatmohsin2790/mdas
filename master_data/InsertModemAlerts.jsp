<%@ include file="getConnection.jsp"%>

<%!
PreparedStatement pstmt=null;
  //Statement pstmt = null;
%>
<%
String alertId=request.getParameter("alertId");
String meterId=request.getParameter("meterId");
String alertCode=request.getParameter("alertCode");
String alertDesc=request.getParameter("alertDesc");
String alert_Gen_Date=request.getParameter("alert_Gen_Date");

String vsql="insert into MODEM_ALERTS values(?,?,?,?,?)";

pstmt=con.prepareStatement(vsql);

pstmt.setString(1, alertId);
pstmt.setString(2, meterId);
pstmt.setString(3, alertCode);
pstmt.setString(4, alertDesc);
pstmt.setString(5, alert_Gen_Date);
pstmt.executeUpdate();
con.close();


%>
Successfully Stored Data in the Database ..........
<a href="<%=response.encodeRedirectURL("ModemAlerts.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>