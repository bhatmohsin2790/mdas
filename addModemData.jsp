<%@ page session="false" %>
<form action=""  name="modem">


    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        
        <tr> <td>        MODEM_SERIAL_NO:</td><td>
                <input name="modem_serial_no" id="modem_serial_no" type="text"></td></tr>
        <tr><td>     MOBILE_NO:</td><td>
                <input name="mobile_no" id="mobile_no" type="text" ></td></tr>
        <tr><td>     IMEI NO:</td><td>
                <input name="imei_no" id="imei_no" type="text" ></td></tr>
        <tr><td>    STATIC IP:</td><td>
                <input name="static_ip" id="static_ip" type="text" ></td></tr>
        <tr><td></td><td>

                <input type="button" value="ADD" onclick="insertModem()"></td></tr>
    </table>
</form>