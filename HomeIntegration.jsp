<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
       <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	
	<td width=108% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br><br><br>
          <br><br><br><br><br>
          <br><br><br><br><br><br><br><br><br><br><br>
       




        <h3 style="position:absolute;font-weight:500;font-size: xx-large;top:110px;left:380px;color:midnightblue;">MASTER DATA</h3>
        <label style="position:absolute;top:180px;left:80px;"><font size="+2">Meter Management</font></label>
        <a href="<%=response.encodeRedirectURL("master_data/Meter.jsp")%>" style="position:absolute;top:240px;left:80px;"><font size="+1">Meter Data Information</font></a>
        <a href="<%=response.encodeRedirectURL("master_data/Metermake.jsp")%>" style="position:absolute;top:280px;left:80px;"><font size="+1">Metermake</font></a>
        <a href="<%=response.encodeRedirectURL("master_data/MeterLocation.jsp")%>" style="position:absolute;top:320px;left:80px;"><font size="+1">Meter Location</font></a>
        <a href="<%=response.encodeRedirectURL("master_data/ModemAlerts.jsp")%>" style="position:absolute;top:360px;left:80px;"><font size="+1">Modem Alerts</font></a>
        <a href="<%=response.encodeRedirectURL("master_data/ModemDiagnosis.jsp")%>" style="position:absolute;top:400px;left:80px;"><font size="+1">Modem Diagnosis</font></a>

        <label style="position:absolute;top:180px;left:700px;"><font size="+2">User Management</font></label>
        <a href="<%=response.encodeRedirectURL("master_data/Users.jsp")%>" style="position:absolute;top:240px;left:700px;"><font size="+1">Users</font></a>
        <a href="<%=response.encodeRedirectURL("master_data/User_Types.jsp")%>" style="position:absolute;top:280px;left:700px;"><font size="+1">User Types</font></a>
        <a href="<%=response.encodeRedirectURL("master_data/User_Privileges.jsp")%>" style="position:absolute;top:320px;left:700px;"><font size="+1">User Privileges</font></a>
      </table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>


    </body>
</html>