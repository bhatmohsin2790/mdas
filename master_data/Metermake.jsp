<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>




        </style>
    </head>
    <body>
        <form action="InsertMetermake.jsp">
            <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br><br><br><br><br><br><br><br><br><br>


            <h1 style="position:absolute;font-weight:500; top:100px;left:300px;color:midnightblue;">METERMAKE INFORMATION</h1><br>
            <label style="position:absolute;top:180px;left:100px;">METERMAKEID:</label>
            <input name="metermakeId" type="text" style="position:absolute;top:175px;left:280px;"><br>
            <label style="position:absolute;top:215px;left:100px;">METERMAKENAME:</label>
            <input name="metermakeName" type="text" style="position:absolute;top:210px;left:280px;"><br>
            <label style="position:absolute;top:250px;left:100px;">METER_SERIES:</label>
            <input name="meterSeries" type="text" style="position:absolute;top:245px;left:280px;"><br>
            <label style="position:absolute;top:285px;left:100px;">METER_VERSION:</label>
            <input name="meterVersion" type="text" style="position:absolute;top:280px;left:280px;"><br>
            <label style="position:absolute;top:320px;left:100px;">NO_OF_PARAMS:</label>
            <input name="noofParams" type="text" style="position:absolute;top:315px;left:280px;"><br>
            <label style="position:absolute;top:355px;left:100px;">PARAM_NAMES:</label>
            <input name="paramNames" type="text" style="position:absolute;top:350px;left:280px;"><br>
            <label style="position:absolute;top:390px;left:100px;">B4_TOD_PARAMS:</label>
            <input name="b4_Tod_Params" type="text" style="position:absolute;top:385px;left:280px;"><br>
            <label style="position:absolute;top:425px;left:100px;">D4_PARAMS:</label>
            <input name="d4_Params" type="text" style="position:absolute;top:420px;left:280px;"><br>

            <input type="submit" value="ADD" style="position:absolute;top:480px;left:600px;width:40px;">
            <!--<a href="ViewMetermake.jsp" style="position:absolute;top:500px;left:665px;width:40px;">ViewData</a>
                <a href="" style="position:absolute;top:500px;left:760px;width:40px;">UPDATE</a>
                <a href="" style="position:absolute;top:500px;left:870px;width:40px;">DELETE</a>-->
                        <input type="button" value="ViewData" style="position:absolute;top:480px;left:665px;" onclick="javascript:window.location='<%= "ViewMetermake.jsp" %>';">
                <a href="<%=response.encodeRedirectURL("../meterManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>
        </form>

    </body>
</html>
