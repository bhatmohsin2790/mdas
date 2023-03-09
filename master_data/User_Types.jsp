<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title></title>
        <script type="text/javascript" src="jquery.js">
            function viewTypes(){

      
            }



        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <form action="InsertUserTypes.jsp">
            <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br>        <br><br><br>            <br><br><br>        <br><br><br>           <br><br><br>        <br><br><br> <br>
            <h1 style="position:absolute;font-weight:500;top:120px;left:350px;color:midnightblue;">USER TYPES</h1>
            <label style="position:absolute;top:200px;left:80px;">USER_TYPE_ID:</label>
            <input name="userTypeId" type="text"  style="position:absolute;top:195px;left:260px;"><br>
            <label style="position:absolute;top:235px;left:80px;">USER_TYPE_NAME:</label>
            <input name="userTypeName" type="text"  style="position:absolute;top:230px;left:260px;"><br>
            <input type="submit" value="ADD" style="position:absolute;top:290px;left:330px;">
            <!--<a href="ViewUserTypes.jsp" style="position:absolute;top:230px;left:420px;">ViewData</a>-->


            <input type="button" value="ViewData" style="position:absolute;top:290px;left:420px;" onclick="javascript:window.location='<%= "ViewUserTypes.jsp"%>';">
            <!--<input type="button" value="Update" style="position:absolute;top:230px;left:530px;width:80px;color: #3a93d2;" onclick="javascript:window.location='<%= "UpdateUserTypes.jsp"%>';">-->
                <a href="<%=response.encodeRedirectURL("../userManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

        </form>


    </body>
</html>
