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
        <form action="InsertMeterLocation.jsp">
            <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

            <h1 style="position:absolute;font-weight:500;top:100px;left:350px;color:midnightblue;">METER LOCATION</h1>
            <br><br>
            <label style="position:absolute;top:180px;left:100px;">LOCATIONID:</label>
            <input name="locid" type="text" style="position:absolute;top:175px;left:280px;"><br>
            <label style="position:absolute;top:215px;left:100px;">LOCATIONNAME:</label>
            <input name="locname" type="text" style="position:absolute;top:210px;left:280px;"><br>
            <input type="submit"  value="ADD" style="position:absolute;top:250px;left:500px;width:40px;">
            <!--<a href="ViewMeterLocation.jsp" style="position:absolute;top:250px;left:565px;width:40px;">ViewData</a>
            <a href="" style="position:absolute;top:250px;left:660px;width:40px;">UPDATE</a>
            <a href="" style="position:absolute;top:250px;left:770px;width:40px;">DELETE</a>-->
            <input type="button" value="ViewData" style="position:absolute;top:250px;left:580px;" onclick="javascript:window.location='<%= "ViewMeterLocation.jsp"%>';">
                <a href="<%=response.encodeRedirectURL("../meterManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>
        </form>
    </body>
</html>
