<%@ page session="false" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="" name="substation">
            <table>
                <tr><td height="30px">
        <label>SubstationId:</label></td>
                    <td><select style="width:160px;"><option>Select substationID</select><br/></td>
                <tr><td height="30px"><label>Meter:</label></td>
                    <td><input type="text" style="width:160px;"><br/></td>
                <tr><td height="50px" colspan="2" align="center" ><input type="submit" value="UPDATE" ><br/></td></tr></table>
        </form>
    </body>
</html>