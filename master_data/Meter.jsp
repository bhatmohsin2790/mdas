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
        <form action="InsertMeterData.jsp">
        <div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(../images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(../images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(../images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">



          <br><br><br> <br>

          
         
        
            
            <h1 style="position:absolute;font-weight:500;top:90px;left:230px;color:midnightblue;">METER DATA INFORMATION</h1>

            <label style="position:absolute;top:170px;left:80px;">METERID:</label>
            <input name="meterid" type="text" style="position:absolute;top:170px;left:250px;"><br>
            <label style="position:absolute;top:170px;left:480px;">METER_SERIAL_NO:</label>
            <input name="metersno" type="text" style="position:absolute;top:170px;left:700px;"><br>

         <label style="position:absolute;top:205px;left:80px;">METERMAKE:</label>
            <select name="metermake" style="position:absolute;width:205px;height:23px;top:205px;left:250px;">
                <option>LNT</option>
                <option>SECURE</option>
                <option>DLMS</option>
            </select><br>
            <label style="position:absolute;top:205px;left:480px;">METERLOCATION:</label>
            <select name="meterloc"style="position:absolute;top:205px;width:205px;height:23px;left:700px;">
                <option>FEEDER</option>
                <option>DTR</option>
                <option>HT</option>
                <option>LT</option>

            </select><br>

            <label style="position:absolute;top:240px;left:80px;">PROG_PT_PRI:</label>
            <input name="prog_PT_PRI" type="text" style="position:absolute;top:240px;left:250px;"><br>
            <label style="position:absolute;top:240px;left:480px;">PROG_PT_SEC:</label>
            <input name="prog_PT_SEC" type="text" style="position:absolute;top:240px;left:700px;"><br>

            <label style="position:absolute;top:275px;left:80px;">PROG_CT_PRI:</label>
            <input name="prog_CT_PRI"type="text" style="position:absolute;top:275px;left:250px;"><br>
            <label style="position:absolute;top:275px;left:480px;">PROG_CT_SEC:</label>
            <input name="prog_CT_SEC"type="text" style="position:absolute;top:275px;left:700px;"><br>

            <label style="position:absolute;top:310px;left:80px;">METER_CLASS:</label>
            <input name="meterClass" type="text" style="position:absolute;top:310px;left:250px;"><br>
            <label style="position:absolute;top:310px;left:480px;">METER_RATING:</label>
            <input name="meterRating"type="text" style="position:absolute;top:310px;left:700px;"><br>

            <label style="position:absolute;top:345px;left:80px;">METER_TYPE:</label>
            <input name="meterType"type="text" style="position:absolute;top:345px;left:250px;"><br>
            <label style="position:absolute;top:345px;left:480px;">METER_SCALING:</label>
            <input name="meterScaling"type="text" style="position:absolute;top:345px;left:700px;"><br>

            <label style="position:absolute;top:380px;left:80px;">METER_PROG:</label>
            <input name="meterProg" type="text" style="position:absolute;top:380px;left:250px;"><br>
            <label style="position:absolute;top:380px;left:480px;">METER_CUM_COUNT:</label>
            <input name="meter_Cum_Count" type="text" style="position:absolute;top:380px;left:700px;"><br>

            <label style="position:absolute;top:415px;left:80px;">MAN_NAME:</label>
            <input name="man_name" type="text" style="position:absolute;top:415px;left:250px;"><br>
            <label style="position:absolute;top:415px;left:480px;">MAN_CODE</label>
            <input name="man_Code" type="text" style="position:absolute;top:415px;left:700px;"><br>

            <label style="position:absolute;top:450px;left:80px;">RST_COUNT:</label><!--CUM_MAX_DMD_RST_COUNT-->
            <input name="rst_Count" type="text" style="position:absolute;top:450px;left:250px;"><br>
            <label style="position:absolute;top:450px;left:480px;">MIOS_MEM_ID:</label>
            <input name="mios_Mem_Id" type="text" style="position:absolute;top:450px;left:700px;"><br>

            <label style="position:absolute;top:485px;left:80px;">METER_ADD_INFO:</label><!--CUM_MAX_DMD_RST_COUNT-->
            <input name="meter_Add_Info" type="text" style="position:absolute;top:485px;left:250px;"><br>
            <label style="position:absolute;top:485px;left:480px;">METER_TIMESTAMP:</label>
            <input name="meter_Timestamp" type="text" style="position:absolute;top:485px;left:700px;"><br>

            <label style="position:absolute;top:520px;left:80px;">LOG_TIMESTAMP:</label><!--CUM_MAX_DMD_RST_COUNT-->
            <input name="log_Timestamp" type="text" style="position:absolute;top:520px;left:250px;"><br>
            <label style="position:absolute;top:520px;left:480px;">MODEM_SERIAL_NO:</label>
            <input name="modem_Serial_No" type="text" style="position:absolute;top:520px;left:700px;"><br>

            <label style="position:absolute;top:555px;left:80px;">MODEM_IMEI:</label>
            <input name="modem_Imei" type="text" style="position:absolute;top:555px;left:250px;"><br>






            <input type="submit" value="ADD" style="position:absolute;top:600px;left:580px;width:80px;">
            <!--<a href="ViewMeterData.jsp" style="position:absolute;top:530px;left:700px;width:80px;">ViewData</a>-->
            <input type="button" value="ViewData" style="position:absolute;top:600px;left:700px;" onclick="javascript:window.location='<%= "ViewMeterData.jsp"%>';">
            <!--<a href="InsertMeterData.jsp" style="position:absolute;top:500px;left:600px;width:40px;">ADD</a>
            <a href="Metermake.html" style="position:absolute;top:500px;left:675px;width:40px;">VIEW</a>
            <a href="integration.jsp" style="position:absolute;top:500px;left:760px;width:40px;">UPDATE</a>
            <a href="MeterLocation.html" style="position:absolute;top:500px;left:870px;width:40px;">DELETE</a>-->

                <a href="<%=response.encodeRedirectURL("../meterManage.jsp")%>" style="position:absolute;top:50px;left:900px;">Back</a>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

        </form>
    </body>
</html>
