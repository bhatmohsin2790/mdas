
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
    document.getElementById('DataPart').innerHTML=showdata;
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

function getModemStatusReports(meterId,requestType,startDate,endDate)
{
    xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null)
			{
			  alert ("Browser does not support HTTP Request");
			  return;
			}
			var url="getModemStatusReports.jsp";
			url=url+"?meterId="+meterId;
                        url=url+"&requestType="+requestType;
                        url=url+"&startDate="+startDate;
                        url=url+"&endDate="+endDate;

			xmlHttp.onreadystatechange=displayResult;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);
}

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

  getModemStatusReports(meterId,requestType,startDate,endDate);
}

</script>

<script type="text/javascript" src="date-picker.js"></script>
<div  style="float: left;width: 100%;padding-top: 10px;padding-left:100px">
    <h3><b>Modem Status Reports </b></h3>
<form  name="sform" action=""  style="border:1px solid #999999;width:850px;padding:20px 0px 20px 20px;" >
<script type="text/javascript" src="date-picker.js"></script>
<table ><tr>
        <td valign="top">
            <div id="od">
            </div>
        </td>
    </tr>

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
       

           <td>StartingDate:
               <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
		<a href="javascript:show_calendar('sform.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
	    </td>
       
           <td>Ending Date:
               <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
		<a href="javascript:show_calendar('sform.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
	    </td>
        
              <td align="center">
                  <input type="button" value="Submit" onclick="Validate()"/>
              </td>
        </tr>
</table>



</form>
</div>
