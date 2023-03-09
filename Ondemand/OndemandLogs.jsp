<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title</title>
        
    </head>
    <body>
        <form name="form1" action="#">
            <table border="0" bgcolor="#FFE4E1" style="margin-top: 1%;margin-left: 2%;margin-right: 2%;width:96%">
                <tr>
                <td> 
                    <select name="SCriteria" onchange="getTowns(this.value,1)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
                      <option value="-1">Select Criteria</option>  
                      <option value="TW">TownWise</option>
                    </select> 
                </td>
                <td id="towns">

                </td>
                <td id="SS">

                </td>
                <td id="FD">

                </td>                
                </tr>             
                <tr>
                    <td id="MT" colspan="4"></td>
                </tr>                   
                <tr>
                    <td colspan="4" >
                        <div id="metersPart" width="50%" style="background-color:#87CEEB"></div>
                    </td>
                </tr>
                <tr id="commandSelection" style="display:none">
                <td>Type of Request
                                    <select name="CTM" id="CTM" onChange="getOptions(this.value)">
                                    <option value="RST">RESTART</option>  
                                    <option value="FNS">STOP THE MODEM</option>      
                                    <option value="FN1">START</option> 
                                    <option value="INST">CHANGE INSTANTANEOUS FREQENCY</option>
                                    <option value="MN">CHANGE MASTER NUMBER</option>                                     
                                    <option value="APNPortsChangeS">APN and Ports Change [STATIC IP]</option>
                                    <option value="FLGI">CHANGE DISCOM NAME</option>
                                    <option value="DPCD">ONDEMAND COMPLETE DATA</option>
                                    <option value="DPLS">ONDEMAND LOADSURVEY DATA</option>
                                    <option value="DPTD">ONDEMAND TAMPER DATA</option>
                                    <option value="DPIP">ONDEMAND INSTANTANEOUS</option>
                                    <option value="POTA">POTA [Over the Air Programming]</option>
                                    <option value="CONFIG">SEND CONFIGURATION TO MODEM</option>
                                    <option value="RDCFG">READ CONFIGURATION FROM MODEM</option>
                                    <option value="SLNO">CHANGE MODEM_SERIAL_NUMBER</option>     
                                    <option value="FLGT">CHANGE SCHEDULE TIMES</option>
                                 </select>    
                
                <td>
                <td colspan="3">
                    <div id="lsDays" style="display:none">
                         No. of Loadsurvey Dates:
                                    <select name="lsDays" id="lsDates">
                                    <option value="02">02</option>
                                    <option value="05">05</option>
                                    <option value="10">10</option>
                                    <option value="15">15</option>
                                    <option value="20">20</option>
                                    <option value="25">25</option>
                                    <option value="30">30</option>
                                    <option value="35">35</option>
                                    </select>  
                    </div>
                    <div id="mnCB" style="display:none"> Enter Master Number: <input type="text" value="8129818344" name="MNValue" id="MNValue"/></div>
                    <div id="slnoCB" style="display:none"> Enter Modem Serial No: <input type="text" value="" name="SLNoValue" id="SLNoValue"/></div>
                    <div id="apnCB" style="display:none"> Enter Server IP: <input type="text" value="172.18.2.26" name="serverIPD"/> &nbsp;&nbsp;&nbsp;Enter APN Name: <input type="text" value="AIRTELGPRS.COM" name="apnNameD"/></div>
                    <div id="apnSCB" style="display:none">Server IP: <input type="text" value="172.18.2.26" name="serverIPS" id="serverIPS"/> APN Name: <input type="text" value="jkapdrp.com" name="apnNameS" id="apnNameS"/> Password: <input type="text" value="111" name="apnPass" id="apnPass"/></div>
                    <div id="flgtCB" style="display:none"> Read Time: <input type="text" value="0100" name="readTime" id="readTime"/> Transmit Time: <input type="text" value="" name="transmitTime" id="transmitTime"/></div>
                    <div id="flgiCB" style="display:none"> Instant Status: <input type="text" value="0" name="instStatus" id="instStatus"/> DiscomName: <input type="text" value="JKPDD" name="discomName" id="discomName"/></div>
                    <div id="instCB" style="display:none"> Instant Frequency: <input type="text" value="15" name="instFreq" id="instFreq"/></div>
                </td>                   
                </tr>
                <tr id="dates" style="display:none">
                    <td> Select Date:
                        <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
                        <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
                    </td>
                   <!-- <td>Ending Date:
                        <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
                        <a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
                    </td> -->
                   <td colspan="4" id="metersPart" style="padding-left: 10px;">
                       <input type="button" value="Get Logs" onclick="getLogsReport()" />
                    </td>
                </tr>
                              
            </table>
        </form>       
    </body>
</html>
