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





function displayResult()
{

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 {

    var showdata = xmlHttp.responseText;
    document.getElementById('od').innerHTML=showdata;
 }


}

function GetXmlHttpObject()
{
var xmlHttp=null;
try
 {
 // Firefox, Opera 8.0+, Safari
 xmlHttp=new XMLHttpRequest();
 }
catch (e)
 {
 //Internet Explorer
 try
  {
  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
  }
 catch (e)
  {
  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
 }
return xmlHttp;
}//GetXmlHttpObject

function getConfigurationReports(meterId,requestType,startDate,endDate)
{



 		xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null)
			{
			  alert ("Browser does not support HTTP Request");
			  return;
			}
			var url="getConfigurationReports.jsp";
			url=url+"?meterId="+meterId;
                        url=url+"&requestType="+requestType;
                        url=url+"&startDate="+startDate;
                        url=url+"&endDate="+endDate;

			xmlHttp.onreadystatechange=displayResult;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);


}//showDivisions

function sendMeterId()
{
    document.form1.meterId.value= document.getElementById('dtr').value;
    document.form1.meterLocation="dtr";
}
function Validate()
{

    var meter=document.getElementById('dtr');
    var meterId=meter.options[meter.selectedIndex].value;

    var meterType=document.getElementById('requestType');
    var requestType=meterType.options[meterType.selectedIndex].value;

    var startDate=document.getElementById('startingDate').value;

    var endDate=document.getElementById('endingDate').value;

    getConfigurationReports(meterId,requestType,startDate,endDate);


}
function verifyIP()
{

}







</script>

<script type="text/javascript" src="date-picker.js"></script>
</head>


<body>
<div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<tr>

	<td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">

          <%@ include file="menu1.jsp"%>
          <p><b>CONFIGURATION REPORTS </b></p><br></br>

<!-- code by maruthi from here to-->

<form  name="sform" action="">
<script type="text/javascript" src="date-picker.js"></script>
<table ><tr><td valign="top">
        <%@ include file="side_drop_down.jsp"%></td>
        <td valign="top">

            <div id="od">

            </div>


        </td></tr>

        <tr>
            <td align="center">
                <select name="requestType" id="requestType">
                    <option value="0">Select Request Type</option>
                    <option value="CONFIG">SEND CONFIGURATION</option>
                    <option value="RDCFG">GET CONFIGURATION</option>
                    <option value="POTA">POTA</option>
               
                </select>
            </td>
        </tr>

        <tr>

           <td>StartingDate:
               <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
		<a href="javascript:show_calendar('sform.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
	    </td>
        </tr>
        <tr>
           <td>Ending Date:
               <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
		<a href="javascript:show_calendar('sform.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
	    </td>
        </tr>
        <tr>
              <td align="center">
                  <input type="button" value="Submit" onclick="Validate()"/>
              </td>
        </tr>
</table>

                  

</form>


<!-- upto here-->

	</td>
	<td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
</tr>
</table>
<div id="navigation"></div>
<%@ include file="bottom.jsp"%>

</body>
</html>