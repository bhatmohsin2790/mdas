<%@ page session="false" %>
<form action=""  name="meterLocation">

    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        <tr><th colspan="4"><h2>Meter Location</h2></th></tr>
        <!--
        <tr>
            <td>
                LOCATIONID:
            </td>
            <td>
                <input name="locid" id="locid" type="text" >
            </td>
        </tr>
        -->
        <input name="locid" id="locid" type="hidden" value="-1">
        <tr><td>
                LOCATIONNAME:</td><td>
                <input name="locname" id="locname" type="text"></td></tr>
        <tr><td></td><td>
                <input type="button"  value="ADD" onclick="insertMeterLocation()"></td></tr>

    </table>
</form>


<!--<html>
    <head>
        <title></title>

    </head>
    <body>
        <form action="InsertMeterLocation.jsp">

 <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
   <tr><th colspan="4"><h2>Meter Location</h2></th></tr>
    <tr><td>
           LOCATIONID:</td><td>
            <input name="locid" id="locid" type="text" ></td></tr>
    <tr><td>
           LOCATIONNAME:</td><td>
            <input name="locname" id="locname" type="text" ></td></tr>
    <tr><td></td><td>
            <input type="submit"  value="ADD" onclick="insertMeterLocation()"></td></tr>



</table>

        </form>
    </body>
</html>-->