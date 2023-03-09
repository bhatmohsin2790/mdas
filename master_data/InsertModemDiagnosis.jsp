<%@ include file="getConnection.jsp"%>

<%!
PreparedStatement pstmt=null;
  //Statement pstmt = null;
%>
<%
String diagnosisId=request.getParameter("diagnosisId");
String meterId=request.getParameter("meterId");
String modemDateTime=request.getParameter("modemDateTime");
String batteyVoltage=request.getParameter("batteyVoltage");
String networkStrength=request.getParameter("networkStrength");
String networkStatus=request.getParameter("networkStatus");
String modemTemp=request.getParameter("modemTemp");
String modemMeterComFailCount=request.getParameter("modemMeterComFailCount");
String modemServerComFailCount=request.getParameter("modemServerComFailCount");
String modemSystemLoggedDateTime=request.getParameter("modemSystemLoggedDateTime");
String consumerId=request.getParameter("consumerId");

String vsql="insert into MODEM_DIAGNOSIS values(?,?,?,?,?,?,?,?,?,?,?)";

pstmt=con.prepareStatement(vsql);

pstmt.setString(1, diagnosisId);
pstmt.setString(2, meterId);
pstmt.setString(3, modemDateTime);
pstmt.setString(4, batteyVoltage);
pstmt.setString(5, networkStrength);
pstmt.setString(6, networkStatus);
pstmt.setString(7, modemTemp);
pstmt.setString(8, modemMeterComFailCount);
pstmt.setString(9, modemServerComFailCount);
pstmt.setString(10, modemSystemLoggedDateTime);
pstmt.setString(11, consumerId);
pstmt.executeUpdate();
con.close();


%>
Successfully Stored Data in the Database ..........
<a href="<%=response.encodeRedirectURL("ModemDiagnosis.jsp")%>" style="position:absolute;top:100px;left:300px;">Back</a>