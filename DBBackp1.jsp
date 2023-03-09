<%
String sqlDeveloperPath = "C:\\Softwares\\sqldeveloper\\sqldeveloper.exe";
Runtime.getRuntime().exec("cmd /c start " + sqlDeveloperPath);
%>
<jsp:forward page="./alerts.jsp"/>