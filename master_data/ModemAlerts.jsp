<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
      <form action="InsertModemAlerts.jsp">
          <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br>        <br><br><br>        <br><br><br>        <br><br><br>        <br><br><br>        <br>

    <h1 style="position:absolute;font-weight:500;top:100px;left:230px;color:midnightblue;">MODEM ALERTS</h1>
        <label style="position:absolute;top:190px;left:80px;">ALERT_ID:</label>
        <input name="alertId" type="text"  style="position:absolute;top:185px;left:330px;"><br>
        <label style="position:absolute;top:225px;left:80px;">METER_ID:</label>
        <input name="meterId" type="text"  style="position:absolute;top:220px;left:330px;"><br>
        <label style="position:absolute;top:260px;left:80px;">ALERT_CODE:</label>
        <input name="alertCode" type="text"  style="position:absolute;top:255px;left:330px;"><br>
        <label style="position:absolute;top:295px;left:80px;">ALERT_DESC:</label>
        <input name="alertDesc" type="text" readonly style="position:absolute;top:290px;left:330px;"><br>
        <label style="position:absolute;top:330px;left:80px;">ALERT_GENERATED_DATE:</label>
        <input name="alert_Gen_Date" type="text"  style="position:absolute;top:325px;left:330px;"><br>
        <input type="submit" value="ADD" style="position:absolute;top:380px;left:400px;">
        <!--<a href="ViewModemAlerts.jsp" style="position:absolute;top:335px;left:490px;">ViewData</a>-->
                <input type="button" value="ViewData" style="position:absolute;top:380px;left:490px;" onclick="javascript:window.location='<%= "ViewModemAlerts.jsp" %>';">
                <a href="<%=response.encodeRedirectURL("../HomeIntegration.jsp)%>" style="position:absolute;top:50px;left:900px;">Back</a>
<a href="<%=response.encodeRedirectURL("../meterManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

      </form>
  </body>
</html>

