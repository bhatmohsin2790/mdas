<script type="text/javascript" src="date-picker.js"></script>
<div id="sendConfig" style="display: none">
    <center>
        <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
            <tr>
                <td align="center">
                    <input type="button"  value="Send Configuration" onclick="validateSendConfig()"  />
                </td>
            </tr>
        </table>
    </center>
</div> 

<div id="getConfig" style="display: none">
    <center>
        <input type="hidden" name="meterIds" />
        <input type="hidden" name="meterLocation" />
        <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
            <tr>
                <td align="center">
                    <input type="button" value="Get Configuration" onclick="validateGetConfig();" />
                </td>
            </tr>
        </table>
    </center>
</div>

<div id="ODConfig" style="display: none">
    <center>
        <input type="hidden" name="meterIds"/>
        <input type="hidden" name="meterLocation" />
        <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
            <tr>
                <td align="left" style="line-height: 18px;">
                    Data Type: </td>

                <td>  <select id="datatype" name="datatype" onchange="if(this.value=='LS') document.getElementById('ls').style.visibility='visible'; else document.getElementById('ls').style.visibility='hidden'">
                        <option value="0">Select Data type</option>
                        <option value="CD">Complete Data</option>
                        <option value="IP">Instantaneous</option>
                        <option value="LS">LoadSurvey Data</option>
                        <option value="TD">Tamper Data</option>
                    </select>
                </td>
            </tr>
            <tr id="ls" style="visibility: hidden;">
                <td align="left" style="line-height: 18px;">
                    No Of Load SurveyDays:</td>
                <td>
                    <input type="text" name="days" id="lsDays"/>
                </td>
            </tr>
            <tr><td></td>
                <td >
                    <input type="button" value="Send Command" onclick="validateOnDemand()" />
                </td>
            </tr>

        </table>

    </center>
</div>
<div id="ssr" style="display: none">
    <center>
        <input type="hidden" name="meterIds"/>
        <input type="hidden" name="meterLocation" />
        <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
            <tr>
                <td align="center">
                    <input type="radio" name="modemStatus" value="start" /> Start
                    <input type="radio" name="modemStatus" value="stop"/> Stop
                    <input type="radio"  name="modemStatus" value="restart"/> Restart
                </td>
            </tr>
            <tr>                            
                <td align="center"><input type="button" value="Send Command" onclick="validateModemStatus();"/>

                </td>
            </tr>
        </table>

    </center>
</div>

<div id="storeConfig" style="display: none">
    <center>
        <form name="form6"  action="storeConfigAction.jsp" onsubmit="return validateStoreConfig()">
            <input type="hidden" name="meterIds"/>
            <input type="hidden" name="meterLocation" />
            <table style="font-size:12px;padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
                <tr>
                    <td> Time Interval:</td>
                    <td>
                        <select name="timeInterval">
                            <option value="0">select timeinterval</option>
                            <option value="4">30 mins</option>
                            <option value="5" selected>Hourly</option>
                            <option value="6">Daily</option>
                        </select>
                    </td>

                    <td> Master MobileNo:</td>
                    <td><input type="text" name="masterNo" value="9000552025" /></td>
                </tr>

                <tr>
                    <td>APN:</td>
                    <td> <select  name="apn">

                            <option value="0">Select APN</option>
                            <option value="WWW" selected>WWW</option>
                            <option value="AIRTELGPRS.COM">AIRTELGPRS.COM</option>

                        </select>
                    </td>

                    <td> FTP Port:</td>
                    <td><input type="text" name="port" value="21" /></td>
                </tr>
                <tr>
                    <td> FTP UserName:</td>
                    <td><input type="text" name="uname" value="ami"/></td>

                    <td> FTP Password:</td>
                    <td><input type="password" name="pwd" value="ami123"/></td>
                </tr>
                <tr>
                    <td> Server IP:</td>
                    <td><input type="text" name="serverIP" value="255.255.255.255" /></td>

                    <td> Socket Port:</td>
                    <td><input type="text" name="socketPort" value="33000" /></td>
                </tr>
                <!--Additionaylly Added-->
                <tr>
                    <td> Meter Read Start Time:</td>
                    <td><input type="text" name="startTime" value="1200"
                               /></td>

                    <td> Meter Read End Time:</td>
                    <td><input type="text" name="endTime" value="1300"/></td>
                </tr>
                <tr>
                    <td> Modem Meter Retry Count:</td>
                    <td><input type="text" name="modemMeterRetryCount" value="5"
                               /></td>

                    <td> Modem Server Retry Count:</td>
                    <td><input type="text" name="modemServerRetryCount" value="5"/></td>
                </tr>
                <tr>
                    <!--<td> ConsumerID:</td>
                    <td><input type="text" name="consumerID" value="124356789012345"
                               /></td> -->

                    <td> Discom Name:</td>
                    <td><input type="text" name="discommName" value="JKPDD"/></td>

                    <td> Mobile Number1:</td>
                    <td><input type="text" name="mobile1" value="0000000000" /></td>
                </tr>
                <tr>
                    <td> Mobile Number2:</td>
                    <td><input type="text" name="mobile2" value="0000000000" /></td>

                    <td> Mobile Number3:</td>
                    <td><input type="text" name="mobile3" value="0000000000" /></td>
                </tr>
                <tr>
                    <td> Mobile Number4:</td>
                    <td><input type="text" name="mobile4" value="0000000000"/></td>

                    <td> Mobile Number5:</td>
                    <td><input type="text" name="mobile5" value="0000000000" /></td>
                </tr>


                <tr ><td></td>
                    <td >
                        <input type="submit" value="Store Configuration" />
                    </td>
                </tr>
            </table>
        </form>
    </center>
</div>