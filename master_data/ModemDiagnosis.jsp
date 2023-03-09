<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="jquery.js"></script>
        <link rel="stylesheet" type="text/css" href="pro_drop_1/pro_drop_1.css" />
    </head>
    <body>
        <form action="InsertModemDiagnosis.jsp" >
            <div id="navigation"></div>
<table width=100%  border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>

<tr>

	
	<td width=108% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">

           <%@ include file="menu1.jsp"%>

          <br><br><br>     <br>   <br><br><br> <br><br><br> <br><br><br><br>
        <h3 style="position:absolute;font-weight:500;top:120px;left:280px;color:midnightblue;">MODEM DIAGNOSIS</h3>
        <label style="position:absolute;top:170px;left:80px;">DIAGNOSIS_ID:</label>
        <input name="diagnosisId" type="text" style="position:absolute;top:165px;left:440px;"><br>
        <label style="position:absolute;top:205px;left:80px;">METER_ID:</label>
        <input name="meterId" type="text" style="position:absolute;top:200px;left:440px;"><br>

        <label style="position:absolute;top:240px;left:80px;">MODEM_DATE_TIME:</label>
        <input name="modemDateTime" type="text" style="position:absolute;top:235px;left:440px;"><br>
        <label style="position:absolute;top:275px;left:80px;">BATTERY_VOLTAGE:</label>
        <input name="batteyVoltage" type="text" style="position:absolute;top:270px;left:440px;"><br>
        <label style="position:absolute;top:310px;left:80px;">NETWORK_STRENGTH:</label>
        <input name="networkStrength" type="text" style="position:absolute;top:305px;left:440px;"><br>
        <label style="position:absolute;top:345px;left:80px;">NETWORK_STATUS:</label>
        <input name="networkStatus" type="text" style="position:absolute;top:340px;left:440px;"><br>
        <label style="position:absolute;top:380px;left:80px;">MODEM_TEMPRATURE:</label>
        <input name="modemTemp" type="text" style="position:absolute;top:375px;left:440px;"><br>
        <label style="position:absolute;top:415px;left:80px;">MODEM_METER_COM_FAIL_COUNT:</label>
        <input name="modemMeterComFailCount" type="text" style="position:absolute;top:410px;left:440px;"><br>

        <label style="position:absolute;top:450px;left:80px;">MODEM_SERVER_COM_FAIL_COUNT:</label>
        <input name="modemServerComFailCount" type="text" style="position:absolute;top:445px;left:440px;"><br>
        <label style="position:absolute;top:485px;left:80px;">MODEM_SYSTEM_LOGGED_DATE_TIME:</label>
        <input name="modemSystemLoggedDateTime" type="text" style="position:absolute;top:480px;left:440px;"><br>
        <label style="position:absolute;top:520px;left:80px;">CONSUMER_ID:</label>
        <input name="consumerId" type="text" style="position:absolute;top:515px;left:440px;"><br>
        <input  type="submit" value="ADD" style="position:absolute;top:550px;left:510px;">
        <!--<a href="ViewModemDiagnosis.jsp" style="position:absolute;top:525px;left:600px;">ViewData</a>-->
                <input type="button" value="ViewData" style="position:absolute;top:550px;left:600px;" onclick="javascript:window.location='<%= "ViewModemDiagnosis.jsp" %>';">
                <a href="<%=response.encodeRedirectURL("../dataReportsHome.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>
        </form>


    </body>
</html>
