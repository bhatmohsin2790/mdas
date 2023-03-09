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
        <form action="InsertUserPrevileges.jsp">
            <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br>      <br><br><br> <br>     <br><br><br>        <br><br><br>        <br><br><br>        <br><br><br>        <br>
            <h1 style="position:absolute;font-weight:500;top:85px;left:350px;color:midnightblue;">USER PRIVILEGES</h1>
            <label style="position:absolute;top:150px;left:80px;">USER_ID:</label>
            <select name="userId" style="position:absolute;top:145px;width:80px;left:170px;">
                <option>admin</option>
                <option>zone_2</option>
                <option>zone_3</option>
                <option>zone_4</option>
            </select><br>

            <input name="zones" type="checkbox" style="position:absolute;top:200px;left:80px;">
            <label style="position:absolute;top:200px;left:105px;">ZONES</label>
            <input name="circles" type="checkbox" style="position:absolute;top:200px;left:300px;">
            <label style="position:absolute;top:200px;left:325px;">CIRCLES</label>

            <input name="divisions" type="checkbox" style="position:absolute;top:200px;left:560px;">
            <label style="position:absolute;top:200px;left:585px;">DIVISIONS</label>
            <input name="subdivisions" type="checkbox" style="position:absolute;top:200px;left:780px;">
            <label style="position:absolute;top:200px;left:805px;">SUBDIVISIONS</label>

            <input name="substations" type="checkbox" style="position:absolute;top:250px;left:80px;">
            <label style="position:absolute;top:250px;left:105px;">SUBSTATIONS</label>
            <input name="feeders" type="checkbox" style="position:absolute;top:250px;left:300px;">
            <label style="position:absolute;top:250px;left:325px;">FEEDERS</label>
            <input name="dtrs" type="checkbox" style="position:absolute;top:250px;left:560px;">
            <label style="position:absolute;top:250px;left:585px;">DTRS</label>
            <input name="consumers" type="checkbox" style="position:absolute;top:250px;left:780px;">
            <label style="position:absolute;top:250px;left:805px;">CONSUMERS</label>



            <input name="meters" type="checkbox" style="position:absolute;top:300px;left:80px;">
            <label style="position:absolute;top:300px;left:105px;">METERS</label>
            <input name="feederCurrentData" type="checkbox" style="position:absolute;top:300px;left:300px;">
            <label style="position:absolute;top:300px;left:325px;">FEEDERCURRENTDATA</label>
            <input name="feederTotalData" type="checkbox" style="position:absolute;top:300px;left:560px;">
            <label style="position:absolute;top:300px;left:585px;">FEEDERTOTALDATA</label>
            <input name="feederReports" type="checkbox" style="position:absolute;top:300px;left:780px;">
            <label style="position:absolute;top:300px;left:805px;">FEEDERREPORTS</label>


            <input name="dtrCurrentData" type="checkbox" style="position:absolute;top:350px;left:80px;">
            <label style="position:absolute;top:350px;left:105px;">DTRCURRENTDATA</label>
            <input name="dtrTotalData" type="checkbox" style="position:absolute;top:350px;left:300px;">
            <label style="position:absolute;top:350px;left:325px;">DTRTOTALDATA</label>
            <input name="dtrReport" type="checkbox" style="position:absolute;top:350px;left:560px;">
            <label style="position:absolute;top:350px;left:585px;">DTRREPORTS</label>

            <input type="submit" value="ADD" style="position:absolute;top:450px;left:750px;">
            <!--<a href="ViewUserPrivileges.jsp" style="position:absolute;top:450px;left:850px;">ViewData</a>-->
            <input type="button" value="ViewData" style="position:absolute;top:450px;left:850px;" onclick="javascript:window.location='<%= "ViewUserPrivileges.jsp"%>';">


                <a href="<%=response.encodeRedirectURL("../userManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>

</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

        </form>
    </body>
</html>
