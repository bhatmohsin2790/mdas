<div id="configReports" style="display:none;">
   
<table>
    <tr>
        <td>Command Type:</td>
        <td >
            <select name="requestType" id="requestType" style="width: 200px">
                <option value="0">Select Request Type</option>
                <option value="CONFIG">SEND CONFIGURATION</option>
                <option value="RDCFG">GET CONFIGURATION</option>
                <option value="POTA">POTA</option>
            </select>
        </td>
        <td>Starting Date:</td><td>
            <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
            <a href="javascript:show_calendar('sform.startingDate')"><img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/>
        </td>
        <td>Ending Date:</td><td>
            <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
            <a href="javascript:show_calendar('sform.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
        </td>
        <td></td>
        <td>
            <input type="button" value="Submit" onclick="ValidateSGP()"/>
        </td>
    </tr>
    <tr><td colspan="8"><hr></hr></td>
    </tr>
</table>
</div>
<div id="ODReports" style="display: none">
   
    <table  border=0 cellpadding=0 cellspacing=0 >     
       <tr>
            <td>Command Type:</td>
            <td >
                <select name="meterData" id="meterData" style="width: 200px">
                    <option value="0">Select Meter Data Type</option>
                    <option value="IP">INSTANT DATA</option>
                    <option value="LS">LOADSURVEY DATA</option>
                    <option value="CD">COMPLETE DATA</option>
                    <option value="TD">TAMPER DATA</option>
                </select>
            </td>            
               
            <td>Starting Date:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
                <a href="javascript:show_calendar('sform.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
            </td>                
            <td>Ending Date:
                <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
                <a href="javascript:show_calendar('sform.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
            </td>                
            <td align="center">
                <input type="button" value="Submit" onclick="ValidateOD()"/>
            </td>
        </tr>
        <tr><td colspan="5"><hr></hr></td></tr>
    </table>
</div>
<div id="statusReports" style="display: none">
    <table >
        <tr>
            <td>Command Type</td>
            <td align="center">
                <select name="requestType" id="requestType" style="width: 200px">
                    <option value="0">Select Request Type</option>
                    <option value="start">START</option>
                    <option value="stop">STOP</option>
                    <option value="restart">RESTART</option>
                        
                </select>
            </td>               
                
            <td>Starting Date:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
                <a href="javascript:show_calendar('sform.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
            </td>                
            <td>Ending Date:
                <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
                <a href="javascript:show_calendar('sform.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
            </td>                
            <td align="center">
                <input type="button" value="Submit" onclick="ValidateSSR()"/>
            </td>
        </tr>
        <tr><td colspan="5"><hr></hr></td></tr>
    </table>
</div>