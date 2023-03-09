<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<script type="text/javascript" src="jquery.js"></script>

<%@ page import="java.sql.*" %>

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

    document.getElementById("table1").style.display = "";
    //document.getElementById("table1").style.display = "none";


}


function sendMeterId()
{
    document.form1.meterId.value= document.getElementById('dtr').value;
    document.form1.meterLocation="dtr";
}
function Validate()
{



    displayResult();

}
function verifyIP()
{

}







</script>


</head>


<body>
<div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
<%@ include file="top.jsp"%>
<script type="text/javascript" src="date-picker.js"></script>
<form name="form1" action="IPReport.jsp" >
<tr>

	<td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
	<td width=98% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:7px;" valign="top">

            <%-- <%@ include file="menu2.jsp"%> --%>

<p><b>ON DEMAND DATA REPORTS AT ADMIN LEVEL</b></p>

<!-- code by maruthi from here to-->



<table>
      <tr>
        <td valign="top">
        <%@ include file="side_drop_down_2.jsp"%>
        </td>
        <td valign="top">

            <table border="1" bgcolor="#EDF5FA" id="table1" style="display:none">
            <tr>
                <td align="center" colspan="8">TRANSACTIONS DATA </td>
            </tr>

             <tr>
                <td> UserId Id</td>
                <td> From Date</td>
                <td> End Date</td>
                <td> Requested Data</td>
                <td> Number Of Transactions</td>
                <!--<td> Response Time Stamp</td>
                <td> Modem Seroal Number</td>
                <td> Mobile Number</td>-->
                

            </tr>
                <tr>
                <td> 123456</td>
                <td> 16-06-2011 10:05:45</td>
                <td> 17-06-2011 05:45:50</td>
                <td> TRANSACTIONS DATA</td>
                <td> 1</td>
                <!--<td> 17-06-2011 06:05:50</td>
                <td> 123456789</td>
                <td> 9505057890</td>-->
                

            </tr>
        </table>


        </td>
        <tr>
            <td align="center">
                <select name="UserId" id="userid">
                    <option value="0">Select User Id</option>
                    <option value="1">User -------------1</option>
                    <option value="2">User------------- 2</option>
                    <option value="3">User 3</option>
                    <option value="4">User 4</option>
                    <option value="5">User 5</option>
                    <option value="6">User 6</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="center">
                <select name="meterData" id="meterData">
                    <option value="0">Select Meter Data Type</option>
                    <option value="1">INSTANTANEOUSPARAMETERS</option>
                    <option value="2">SNAPSHOT DATA</option>
                    <option value="3">LOADSURVEY DATA</option>
                    <option value="4">BILLING DATA</option>
                    <option value="5">TAMPER DATA</option>
                    <option value="6">TRANSACTIONS DATA</option>
                </select>
            </td>
        </tr>

        <tr>

           <td>StartingDate:
               <input type="text" readonly="true" size="10" name="startingDate"/>
		<a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal.gif" id="sdate"  width=24 height=22 border=0/></a>
	    </td>
        </tr>
        <tr>
           <td>Ending Date:
		<input type="text" readonly="true" size="10" name="endingDate"/>
		<a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal.gif" id="edate"  width=24 height=22 border=0/></a>
	    </td>
        </tr>
        <tr>
              <td align="center">
                  <input type="button" value="Submit" onclick="Validate()"/>
              </td>
        </tr>
    </tr>



    </table>
        <table>

</table>


</td></tr>
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