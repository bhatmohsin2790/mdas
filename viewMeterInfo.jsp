<%@ page session="false" %>
<html>
    <head><title></title></head>
    <body>
        <form action="InsertMeterData.jsp">

<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">

 <tr><th colspan="4"><h2>Meter Information</h2></th></tr>
    <tr><td>

            METERID:</td><td>
            <input name="meterid" type="text" ></td>
    <td>
            METER_SERIAL_NO:</td><td>
            <input name="metersno" type="text" ></td></tr>
    <tr><td>
        METERMAKE:</td><td>
            <select name="metermake" >
                <option>LNT</option>
                <option>SECURE</option>
                <option>DLMS</option>
            </select></td>
    <td>
            METERLOCATION:</td><td>
            <select name="meterloc">
                <option>FEEDER</option>
                <option>DTR</option>
                <option>HT</option>
                <option>LT</option>

            </select></td></tr>
    <tr><td>

            PROG_PT_PRI:</td><td>
            <input name="prog_PT_PRI" type="text" ></td>
    <td>
            PROG_PT_SEC:</td><td>
            <input name="prog_PT_SEC" type="text" ></td></tr>
    <tr><td>

            PROG_CT_PRI:</td><td>
            <input name="prog_CT_PRI"type="text" ></td>
    <td>
            PROG_CT_SEC:</td><td>
            <input name="prog_CT_SEC"type="text" ></td></tr>
    <tr><td>

            METER_CLASS:</td><td>
            <input name="meterClass" type="text" ></td>
    <td>
            METER_RATING:</td><td>
            <input name="meterRating"type="text"></td></tr>
    <tr><td>
           METER_TYPE:</td><td>
            <input name="meterType"type="text" ></td>
   <td>
           METER_SCALING:</td><td>
            <input name="meterScaling"type="text" ></td></tr>
    <tr><td>

           METER_PROG:</td><td>
            <input name="meterProg" type="text"></td>
  <td>
           METER_CUM_COUNT:</td><td>
           <input name="meter_cum_count" type="text"></td></tr>
    <tr><td>

            MAN_NAME:</td><td>
            <input name="man_name" type="text"></td>
      <td>       MAN_CODE:</td><td>
            <input name="man_Code" type="text"></td></tr>

      <tr><td>       RST_COUNT:</td><td>
            <input name="rst_Count" type="text" ></td>
      <td>     MIOS_MEM_ID:</td><td>
            <input name="mios_Mem_Id" type="text" ></td></tr>

    <tr><td>         METER_ADD_INFO:</td><td>
            <input name="meter_Add_Info" type="text"></td>
   <td>        METER_TIMESTAMP:</td><td>
            <input name="meter_Timestamp" type="text"></td></tr>

     <tr><td>       LOG_TIMESTAMP:</td><td>
            <input name="log_Timestamp" type="text" ></td>
    <td>        MODEM_SERIAL_NO:</td><td>
            <input name="modem_Serial_No" type="text" ></td></tr>

      <tr><td>     MODEM_IMEI:</td><td>
            <input name="modem_Imei" type="text" ></td></tr>




      <tr><td></td><td></td><td>

            <input type="submit" value="View" ></td></tr>





</table>


        </form>
    </body>
</html>
