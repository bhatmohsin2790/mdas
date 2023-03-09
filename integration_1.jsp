<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title></title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_send_sms.js"></script>

        <%@ page import="java.sql.*" %>
        <%@ include file="importpage.jsp"%>

        <style>
            .tab-box {
                border-bottom: 1px solid #DDD;
                padding-bottom:5px;
            }
            .tab-box a {
                border:1px solid #DDD;
                color:#666666;
                padding: 5px 15px;
                text-decoration:none;
                background-color: #eee;
                font-size:12px;
            }
            .tab-box a.activeLink {
                background-color: #fff;
                border-bottom: 0;
                padding: 6px 15px;
            }
            .tabcontent { border: 1px solid #ddd; border-top: 0; padding-top:45px }
            .hide { display: none;}


        </style>
        <script type="text/javascript">
            $(document).ready(function() {
                $(".tabLink").each(function(){
                    $(this).click(function(){
                        tabeId = $(this).attr('id');
                        $(".tabLink").removeClass("activeLink");
                        $(this).addClass("activeLink");
                        $(".tabcontent").addClass("hide");
                        $("#"+tabeId+"-1").removeClass("hide")
                        return false;
                    });
                });
            });
        </script>

        <script type="text/javascript">

            //send config
            function validateSendConfig(){

                hirType=document.sideConfigForm.r1;
                //alert(hirType.length);
                for (var i=0; i < hirType.length; i++)
                {
                    if (hirType[i].checked)
                    {
                        document.form1.meterLocation.value = hirType[i].value;
                    }
                }//end for

                //alert("Hirarchy Type :"+document.form1.meterLocation.value);

                var sel=document.getElementById("dtr").options;
                var meterIds="";
                for(i=0;i<sel.length;i++){
                    if(sel[i].selected){
                        meterIds+=sel[i].title+",";
                    }
                }//end for
                alert(meterIds);
                document.form1.meterIds.value=meterIds;
                //alert("MeterIds "+document.form1.meterIds.value);
                //alert(meterIds.split(",").length);
                if(meterIds.split(",").length > 1){
                    return true;
                }else{
                    alert("Please Select at Least One Meter to Send Send Config SMS");
                    return false;
                }//end else

            }//end method

            //get config
            function validateGetConfig(){

                hirType=document.sideConfigForm.r1;
                //alert(hirType.length);
                for (var i=0; i < hirType.length; i++)
                {
                    if (hirType[i].checked)
                    {
                        document.form2.meterLocation.value = hirType[i].value;
                    }
                }//end for

                //alert("Hirarchy Type :"+document.form2.meterLocation.value);

                var sel=document.getElementById("dtr").options;
                var meterIds="";
                for(i=0;i<sel.length;i++){
                    if(sel[i].selected){
                        meterIds+=sel[i].title+",";
                    }
                }//end for
                //alert(meterIds);
                document.form2.meterIds.value=meterIds;
                //alert("MeterIds "+document.form2.meterIds.value);

                if(meterIds.split(",").length > 1){
                    return true;
                }else{
                    alert("Please Select at Least One Meter to Send Get Config SMS");
                    return false;
                }//end else

            }//end method

            //on demand
            function validateOnDemand(){

                hirType=document.sideConfigForm.r1;
                //alert(hirType.length);
                for (var i=0; i < hirType.length; i++)
                {
                    if (hirType[i].checked)
                    {
                        document.form3.meterLocation.value = hirType[i].value;
                    }
                }//end for

                //alert("Hirarchy Type :"+document.form3.meterLocation.value);

                var sel=document.getElementById("dtr").options;
                var meterIds="";
                for(i=0;i<sel.length;i++){
                    if(sel[i].selected){
                        meterIds+=sel[i].title+",";
                    }
                }//end for
                //alert(meterIds);
                document.form3.meterIds.value=meterIds;
                //alert("MeterIds "+document.form3.meterIds.value);

                if(meterIds.split(",").length > 1){
                    return true;
                }else{
                    alert("Please Select at Least One Meter to Send OnDemand SMS");
                    return false;
                }//end else

            }//end method

            //modem status
            function validateModemStatus(){

                hirType=document.sideConfigForm.r1;
                //alert(hirType.length);
                for (var i=0; i < hirType.length; i++)
                {
                    if (hirType[i].checked)
                    {
                        document.form4.meterLocation.value = hirType[i].value;
                    }
                }//end for

                //alert("Hirarchy Type :"+document.form4.meterLocation.value);

                var sel=document.getElementById("dtr").options;
                var meterIds="";
                for(i=0;i<sel.length;i++){
                    if(sel[i].selected){
                        meterIds+=sel[i].title+",";
                    }
                }//end for
                //alert(meterIds);
                document.form4.meterIds.value=meterIds;
                //alert("MeterIds "+document.form4.meterIds.value);

                if(meterIds.split(",").length > 1){
                    return true;
                }else{
                    alert("Please Select at Least One Meter to Set Modem Status SMS");
                    return false;
                }//end else

            }//end method

            //pota
            function validatePota(){

                hirType=document.sideConfigForm.r1;
                //alert(hirType.length);
                for (var i=0; i < hirType.length; i++)
                {
                    if (hirType[i].checked)
                    {
                        document.form5.meterLocation.value = hirType[i].value;
                    }
                }//end for

                //alert("Hirarchy Type :"+document.form5.meterLocation.value);

                var sel=document.getElementById("dtr").options;
                var meterIds="";
                for(i=0;i<sel.length;i++){
                    if(sel[i].selected){
                        meterIds+=sel[i].title+",";
                    }
                }//end for
                //alert(meterIds);
                document.form5.meterIds.value=meterIds;
                //alert("MeterIds "+document.form5.meterIds.value);

                if(meterIds.split(",").length > 1){
                    return true;
                }else{
                    alert("Please Select at Least One Meter to Send Pota Request SMS");
                    return false;
                }//end else

            }//end method

            //Store Config
            function validateStoreConfig(){

                hirType=document.sideConfigForm.r1;
                //alert(hirType.length);
                for (var i=0; i < hirType.length; i++)
                {
                    if (hirType[i].checked)
                    {
                        document.form6.meterLocation.value = hirType[i].value;
                    }
                }//end for

                //alert("Hirarchy Type :"+document.form6.meterLocation.value);

                var sel=document.getElementById("dtr").options;
                var meterIds="";
                for(i=0;i<sel.length;i++){
                    if(sel[i].selected){
                        meterIds+=sel[i].title+",";
                    }
                }//end for
                //alert(meterIds);
                document.form6.meterIds.value=meterIds;
                //alert("MeterIds "+document.form6.meterIds.value);

                if(meterIds.split(",").length > 1 && meterIds.split(",").length == 2){
                    return true;
                }else{
                    alert("Please Select Only one Meter For Storing the configuration");
                    return false;
                }//end else

            }//end method
        </script>


    </head>
    <body>
        <div class="tab-box" style="padding-top: 10px">
            <a href="javascript:;" class="tabLink activeLink" id="cont-1">Send Configuration</a>
            <a href="javascript:;" class="tabLink " id="cont-2">Get Configuration</a>
            <a href="javascript:;" class="tabLink " id="cont-3">On-Demand Request</a>
            <a href="javascript:;" class="tabLink " id="cont-4">Start/Stop/Restart</a>
            <a href="javascript:;" class="tabLink " id="cont-5">POTA Request</a>
            <a href="javascript:;" class="tabLink " id="cont-6">Store Configuration</a>
        </div>


        <div class="tabcontent paddingAll" id="cont-1-1">
            <center>
                <form name="form1" action="sendConfigAction.jsp" onsubmit="return validateSendConfig()">
                    <input type="hidden" name="meterIds"/>
                    <input type="hidden" name="meterLocation" />
                    <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">

                        <tr>
                            <td align="center">
                                <input type="submit"  value="Send Configuration"  />
                            </td>
                        </tr>


                    </table>
                </form>
            </center>
        </div>

        <div class="tabcontent paddingAll hide" id="cont-2-1">
            <center>
                <form name="form2" action="getConfigAction.jsp" onsubmit="return validateGetConfig()">
                    <input type="hidden" name="meterIds" />
                    <input type="hidden" name="meterLocation" />
                    <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">

                        <tr>
                            <td align="center">
                                <input type="submit" value="Get Configuration" />
                            </td>
                        </tr>


                    </table>
                </form>
            </center>
        </div>

        <div class="tabcontent paddingAll hide" id="cont-3-1">
            <center>
                <form  name="form3" action="onDemandAction.jsp" onsubmit="return validateOnDemand()">
                    <input type="hidden" name="meterIds"/>
                    <input type="hidden" name="meterLocation" />
                    <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
                        <tr>
                            <td align="left" style="line-height: 18px;">
                                Data Type: </td>

                            <td>  <select name="datatype">
                                    <option value="0">Select Data type</option>
                                    <option value="CD">Complete Data</option>
                                    <option value="IP">Instantaneous Parameters</option>
                                    <option value="LS">LoadSurvey Data</option>
                                    <option value="TD">Tamper Data</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" style="line-height: 18px;">
                                No Of Load SurveyDays:</td>
                            <td>
                                <input type="text" name="days"/>
                            </td>
                        </tr>
                        <tr><td></td>
                            <td >
                                <input type="submit" value="Send Command" />
                            </td>
                        </tr>

                    </table>
                </form>
            </center>
        </div>
        <div class="tabcontent paddingAll hide" id="cont-4-1">
            <center>

                <form  name="form4" action="setModemStatusAction.jsp" onsubmit="return validateModemStatus()">
                    <input type="hidden" name="meterIds"/>
                    <input type="hidden" name="meterLocation" />
                    <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
                        <tr>
                            <td align="center">
                                <input type="radio" name="modemStatus" value="1" checked/> Start
                                <input type="radio" name="modemStatus" value="0"/> Stop
                                <input type="radio"  name="modemStatus" value="2"/> Restart
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Send Command:
                            </td>
                            <td><input type="submit" value="Send Command" />

                            </td>
                        </tr>


                    </table>
                </form>
            </center>
        </div>
        <script type="text/javascript" src="date-picker.js"></script>
        <div class="tabcontent paddingAll hide" id="cont-5-1">
            <center>
                <form name="form5"action="potaAction.jsp" onsubmit="return validatePota()">
                    <input type="hidden" name="meterIds"/>
                    <input type="hidden" name="meterLocation" />
                    <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
                        <tr>

                            <td align="center">Date:</td>
                            <td>

                                <input type="text" readonly="true" size="10" name="startingDate"/>
                                <a href="javascript:show_calendar('form5.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
                            </td>
                        </tr>
                        <tr>
                            <td>Send POTA Request:
                            </td>
                            <td><input type="submit"value="Send Command" />
                            </td>
                        </tr>

                    </table>
                </form>
            </center>
        </div>
        <div class="tabcontent paddingAll hide" id="cont-6-1">
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
        <script type="text/javascript">
            $(document).ready(function() {
                $(".tabLink").each(function(){
                    $(this).click(function(){
                        tabeId = $(this).attr('id');
                        $(".tabLink").removeClass("activeLink");
                        $(this).addClass("activeLink");
                        $(".tabcontent").addClass("hide");
                        $("#"+tabeId+"-1").removeClass("hide")
                        return false;
                    });
                });
            });
        </script>



        <!-- upto here-->




    </body>
</html>