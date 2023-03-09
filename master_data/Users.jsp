add<!--
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
      <form action="InsertUsers.jsp">
          <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br>        <br><br><br>       <br><br>        <br><br><br>        <br>
    <h1 style="position:absolute;font-weight:500;top:95px;left:370px;color:midnightblue;">USERS</h1>
        <label style="position:absolute;top:180px;left:80px;">USER_ID:</label>
        <input name="userId" type="text"  readonly style="position:absolute;top:175px;left:210px;"><br>
        <label style="position:absolute;top:215px;left:80px;">PASSWORD:</label>
        <input name="password" type="text"  readonly style="position:absolute;top:210px;left:210px;"><br>
        <label style="position:absolute;top:250px;left:80px;">USER_TYPE:</label>
        <input name="userType" type="text"  readonly style="position:absolute;top:245px;left:210px;"><br>
        <label style="position:absolute;top:285px;left:80px;">ZONE_ID:</label>
        <input name="zoneId" type="text"  readonly style="position:absolute;top:280px;left:210px;"><br>
        <label style="position:absolute;top:320px;left:80px;">CIRCLE_ID:</label>
        <input name="circleId" type="text"  readonly style="position:absolute;top:315px;left:210px;"><br>
        <label style="position:absolute;top:355px;left:80px;">IS_ACTIVE:</label>
        <input name="isActive" type="text"  readonly style="position:absolute;top:350px;left:210px;"><br>
        <label style="position:absolute;top:390px;left:80px;">FIRST_NAME:</label>
        <input name="firstName" type="text"  readonly style="position:absolute;top:390px;left:210px;"><br>
        <label style="position:absolute;top:425px;left:80px;">LAST_NAME:</label>
        <input name="lastName" type="text"  readonly style="position:absolute;top:420px;left:210px;"><br>
        <input type="text" readonly  style="position:absolute;top:390px;left:210px;"><br>
        <input type="submit" value="ADD" style="position:absolute;top:490px;left:280px;">
        <!--<a href="ViewUsers.jsp" style="position:absolute;top:450px;left:400px;">ViewData</a>-->
                <input type="button" value="ViewData" style="position:absolute;top:490px;left:400px;" onclick="javascript:window.location='<%= "ViewUsers.jsp" %>';">
                <a href="<%=response.encodeRedirectURL("../userManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>
      </form>
  </body>
</html>
