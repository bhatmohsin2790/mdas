<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="jquery.js"></script>

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
.tabcontent { border: 1px solid #ddd; border-top: 0;}
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


  function gendMeterId()
{
    document.form6.meterIds.value= document.getElementById('dtr').value;
    document.form6.meterLocation="dtr";
}

function Validate()
{
     var imei = document.form6.imei.value;
            if(isNaN(imei)|| imei.indexOf(" ")!=-1){
              alert("Enter numeric value");return false; }
        if (imei.length < 15 ){
                alert("IMEI should be 15  characters"); return false;
           }

        var x = document.form6.masterNo.value;
        if(isNaN(x)|| x.indexOf(" ")!=-1){
              alert("Enter numeric value");return false; }
        if (x.length < 10 ){
                alert("mobile number should be 10  characters"); return false;
           }
           var port=document.form6.port.value;
           if(port.length>2){
               alert("port number should be 2 numbers");return valse;
           }
           var socketport=document.form6.socketPort.value;
           if(isNaN(socketport)|| x.indexOf(" ")!=-1){
              alert("socketport should be numeric value");return false; }
          var consumerID=document.form6.consumerID.value;
          if(isNaN(consumerID)|| x.indexOf(" ")!=-1){
              alert("consumerID should be numeric value");return false; }

          var mobile1=document.form6.mobile1.value;
          if(isNaN(mobile1)||mobile1.indexOf(" ")!=-1){
              alert("mobile should be numeric value");return false; }
           if (mobile1.length < 10 ){
                alert("mobile1 should be 10  characters"); return false;
           }
            var mobile2=document.form6.mobile2.value;
          if(isNaN(mobile2)||mobile2.indexOf(" ")!=-1){
              alert("mobile should be numeric value");return false; }
           if (mobile2.length < 10 ){
                alert("mobile2 should be 10  characters"); return false;
           }
            var mobile3=document.form6.mobile3.value;
          if(isNaN(mobile3)||mobile3.indexOf(" ")!=-1){
              alert("mobile should be numeric value");return false; }
           if (mobile3.length < 10 ){
                alert("mobile3 should be 10  characters"); return false;
           }
            var mobile4=document.form6.mobile4.value;
          if(isNaN(mobile4)||mobile4.indexOf(" ")!=-1){
              alert("mobile should be numeric value");return false; }
           if (mobile4.length < 10 ){
                alert("mobile4 should be 10  characters"); return false;
           }
            var mobile5=document.form6.mobile5.value;
          if(isNaN(mobile5)||mobile5.indexOf(" ")!=-1){
              alert("mobile should be numeric value");return false; }
           if (mobile1.length < 10 ){
                alert("mobile5 should be 10  characters"); return false;
           }

}
function verifyIP()
{
   IPvalue=document.form6.serverIP.value;

errorString = "";
theName = "IPaddress";

var ipArray=IPvalue.split(".");

if (IPvalue == "0.0.0.0")
errorString = errorString + theName + ': '+IPvalue+' is a special IP address and cannot be used here.(4)';
else if (IPvalue == "255.255.255.255")
errorString = errorString + theName + ': '+IPvalue+' is a special IP address and cannot be used here.(5)';
if
(!ipArray||!ipArray[0]||!ipArray[1]||!ipArray[2]||!ipArray[3]||ipArray.length>4)
    errorString = errorString + theName + ': '+IPvalue+' is not a valid IP address.(1)';
else {
for (i = 0; i < 4; i++) {
thisSegment = ipArray[i];
if (thisSegment > 255) {
errorString = errorString + theName + ': '+IPvalue+' is not a valid IP address.(2)';
i = 4;
}
if ((i == 0) && (thisSegment > 255)) {
errorString = errorString + theName + ': '+IPvalue+' is a special IP address and cannot be used here.(3)';
i = 4;
}
}
}
extensionLength = 3;
if (errorString == "")
alert ("That is a valid IP address.(0)");
else {
alert (errorString);
return false;
}
return false;
}






  function sendMeterId()
{
    var len =document.select.dtr.length;
           
         i = 0;
      var  chosen = "" ;
       
        for (i = 0; i < len; i++)
        {
           

                 if (document.select.dtr[i].selected)
                                {
                                       
                              chosen = chosen + document.select.dtr[i].value+",";
                               
                               }
         }
          //alert("choosen field  is"+chosen);
          document.form1.meterIds.value= chosen;
       document.form2.meterIds.value= chosen;
       document.form3.meterIds.value= chosen;
       document.form4.meterIds.value= chosen;
       document.form5.meterIds.value= chosen;
       document.form6.meterIds.value= document.getElementById('dtr').value;
        //return chosen
      
 }

/*function GetSelectedItem() {

len = document.getElementById('dtr').length;
i = 0
chosen = ""

for (i = 0; i < len; i++) {
if (document.f1.s1[i].selected) {
chosen = chosen + document.f1.s1[i].value + "\n"
}
}
alert("valueis"+chosen)
return chosen
} */
</script>


</head>

<body>
<div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
<%@ include file="top.jsp"%>

<tr>
   
	<td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">
<%@ include file="menu1.jsp" %>
            
              
              
              
<p><b>ON DEMAND DATA & CONFIGURATION SETTINGS </b></p><br></br>

<!-- code by maruthi from here to-->

<div class="tab-box" >
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Send Configuration</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Get Configuration</a>
    <a href="javascript:;" class="tabLink " id="cont-3">On-Demand Request</a>
    <a href="javascript:;" class="tabLink " id="cont-4">Start/Stop/Restart</a>
    <a href="javascript:;" class="tabLink " id="cont-5">POTA Request</a>
    <a href="javascript:;" class="tabLink " id="cont-6">Store Configuration</a>
  </div>

<table ><tr><td valign="top">
        <%@ include file="side_drop_down.jsp"%></td>
        <td></td>

        <td valign="right">
  <div class="tabcontent paddingAll" id="cont-1-1">
     <center>
         <form name="form1" action="sendConfigAction.jsp" >
              <input type="hidden" name="meterIds"/>
              <input type="hidden" name="meterLocation" />
          <table width=400px valign="top" style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="3"cellspacing="3">
                        <tr>
                       <td align="center">
                           <input type="submit"  value="Send Configuration"  />
                       </td>
                  </tr>
          </table>
           </form>
      </center
      
  </div>



  <div class="tabcontent paddingAll hide" id="cont-2-1">
      <center>
           <form name="form2" action="getConfigAction.jsp" >
              <input type="hidden" name="meterIds" />
              <input type="hidden" name="meterLocation" />
          <table width=400px valign="top" style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="3"cellspacing="3">
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
        <form  name="form3" action="onDemandAction.jsp">
                 <input type="hidden" name="meterIds"/>
      <input type="hidden" name="meterLocation" />
            <table width=400px valign="top" style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="3"cellspacing="3">
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
                <input type="submit" value="Get Data" />
            </td>
        </tr>

      </table>
        </form>
    </center>
  </div>
<div class="tabcontent paddingAll hide" id="cont-4-1">
    <center>
        
        <form  name="form4" action="setModemStatusAction.jsp" >
            <input type="hidden" name="meterIds"/>
        <input type="hidden" name="meterLocation" />
            <table width=400px valign="top" style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="3"cellspacing="3">
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
        <form name="form5"action="potaAction.jsp">
            <input type="hidden" name="meterIds"/>
            <input type="hidden" name="meterLocation" />
            <table width=400px valign="top" style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
        <tr>

            <td align="center">Date:</td>
            <td>

		<input type="text" readonly="true" size="10" name="startingDate"/>
		<a href="javascript:show_calendar('form5.startingDate')"> <img src="images/cal.gif" id="sdate"  width=24 height=22 border=0/></a>
	    </td>
        </tr>
        <tr>
            <td>Send POTA Request:
            </td>
            <td><input type="submit"value="POTA Request" />
            </td>
        </tr>

      </table>
        </form>
    </center>
  </div>
<div class="tabcontent paddingAll hide" id="cont-6-1">
   <center>
       <form name="form6"  action="storeConfigAction.jsp">
              <input type="hidden" name="meterIds"/>
              <input type="hidden" name="meterLocation" />
          <table valign="top" style="font-size:12px;padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center">
                            <tr>
                  <td> Time Interval:</td>
                  <td>
                      <select name="timeInterval">
                          <option value="3">select timeinterval</option>
                          <option value="4">30 mins</option>
                          <option value="5">Hourly</option>
                          <option value="6">Daily</option>
                      </select>
                  </td>

                  <td>
                      Modem SerialNo:
                  </td>
                  <td> <input type="text" name="modemNo"/></td>
              </tr>
              <tr>
                  <td> Modem IMEINo:</td>
                  <td><input type="text" name="imei" value="123456789012345"
                             onchange="return Validate()"/></td>

                  <td> Master MobileNo:</td>
                  <td><input type="text" name="masterNo" value="9000552025" onchange="return Validate()"/></td>
              </tr>
              <tr>
                  <td>APN:</td>
                  <td> <select  name="apn">

                           <option value="0">Select APN</option>
                            <option value="WWW">WWW</option>
                             <option value="AIRTELGPRS.COM">AIRTELGPRS.COM</option>

                      </select>
                  </td>

                  <td> FTP Port:</td>
                  <td><input type="text" name="port" value="21" onchange="return Validate()"/></td>
              </tr>
              <tr>
                  <td> FTP UserName:</td>
                  <td><input type="text" name="uname" value="mdas"/></td>

                  <td> FTP Password:</td>
                  <td><input type="password" name="pwd" value="mdas@123"/></td>
              </tr>
              <tr>
                  <td> Server IP:</td>
                  <td><input type="text" name="serverIP" value="255.255.255.255" onchange="verifyIP()"/></td>

                  <td> Socket Port:</td>
                  <td><input type="text" name="socketPort" value="33000" onchange="return Validate()"/></td>
              </tr>
              <tr>
                  <td> ConsumerID:</td>
                  <td><input type="text" name="consumerID" value="1320"
            onchange="return Validate()"/></td>

                  <td> Meter Type:</td>
                  <td><input type="text" name="meterType" value="124356789012345"/></td>
              </tr>
               <tr>
                  <td> Mobile Number1:</td>
                  <td><input type="text" name="mobile1" value="0000000000" onchange="return Validate()"/></td>

                  <td> Mobile Number2:</td>
                  <td><input type="text" name="mobile2" value="0000000000" onchange="return Validate()"/></td>
              </tr>
              <tr>
                  <td> Mobile Number3:</td>
                  <td><input type="text" name="mobile3" value="0000000000" onchange="return Validate()"/></td>

                  <td> Mobile Number4:</td>
                  <td><input type="text" name="mobile4" value="0000000000"onchange="return Validate()"/></td>
              </tr>
              <tr>
                  <td> Mobile Number5:</td>
                  <td><input type="text" name="mobile5" value="0000000000" onchange="return Validate()"/></td>
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

</td></tr>
</table>
                       
<!-- upto here-->

	</td>
	<td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
</tr>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

</body>
</html>