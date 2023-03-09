
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="date-picker.js"></script>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
        
        <script type="text/javascript" src="js/jquery.mtz.monthpicker.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.9.1.custom.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.9.1.custom.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />

		<link rel="stylesheet" type="text/css" href="js2/datatables/datatables.min.css" />
        <script type="text/javascript" src="js2/datatables/datatables.min.js"></script>
    <script type="text/javascript" src="js2/datatables/jszip.min.js"></script>
	<script type="text/javascript" src="js2/datatables/pdfmake.min.js"></script>
	<script type="text/javascript" src="js2/datatables/vfs_fonts.js"></script>
	<script type="text/javascript" src="js2/datatables/buttons.html5.min.js"></script>

        <link rel="stylesheet" type="text/css" href="css/table.css" />

<%@ page import="java.sql.*" %>
<%@ include file="importpage.jsp"%>

<style>
    .button_style
    {
        background-color:#EEEEEE;
        border:1px solid #DDDDDD;
        color:#666666;
        padding:3px 15px;
        text-decoration:none;
        float:left;
    }
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
    /*.tabcontent { border: 1px solid #ddd; border-top: 0; padding-top:45px }*/
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
                document.getElementById("report_part").innerHTML="";
                 if(tabeId=="cont-1")
                  {
                    document.getElementById("reportHeader").innerHTML="<h3>Consumption Report</h3>";  
                    document.getElementById("dates").innerHTML=document.getElementById("datesRange").innerHTML;  
                    document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                  }
                if(tabeId=="cont-2")
                 {
                   document.getElementById("reportHeader").innerHTML="<h3>Power On/Off Report</h3>";  
                   document.getElementById("dates").innerHTML=document.getElementById("singleDate").innerHTML;  
                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                 }
                 if(tabeId=="cont-3")
                 {
                   document.getElementById("reportHeader").innerHTML="<h3>Site Last Alerts </h3>";  
                   document.getElementById("dates").innerHTML=document.getElementById("alertButton").innerHTML;  
                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                 }
                 if(tabeId=="cont-4")
                 {
                   document.getElementById("reportHeader").innerHTML="<h3>All Sites Status</h3>";  
                   document.getElementById("selectDiv").innerHTML="";
                   document.getElementById("dates").innerHTML=document.getElementById("powerDate").innerHTML;  
//                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                   
                 }
                 if(tabeId=="cont-5")
                 {
//                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                   document.getElementById("reportHeader").innerHTML="<h3>Non-Communicating Sites </h3>";
                   document.getElementById("selectDiv").innerHTML="";
                   document.getElementById("dates").innerHTML=document.getElementById("nonComm").innerHTML;  
                   
                 }
                 if(tabeId=="cont-6")
                 {
//                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                   document.getElementById("reportHeader").innerHTML="<h3>Break Down History of a Site <h5>(Based on Tamper Data)</h5> </h3>";
                   document.getElementById("selectDiv").innerHTML="";
                   document.getElementById("dates").innerHTML=document.getElementById("breakDown").innerHTML;  
                   
                 }
                 if(tabeId=="cont-7")
                 {
//                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                   document.getElementById("reportHeader").innerHTML="<h3>New Sites Added</h3>";
                   document.getElementById("selectDiv").innerHTML="";
                   document.getElementById("dates").innerHTML=document.getElementById("newSites").innerHTML;  
                   
                 }
                if(tabeId=="cont-8")
                 {
//                   document.getElementById("selectDiv").innerHTML=document.getElementById("selection").innerHTML;  
                   document.getElementById("reportHeader").innerHTML="<h3>Billing Summary</h3>";
                   document.getElementById("selectDiv").innerHTML="";
                   document.getElementById("dates").innerHTML=document.getElementById("billSummary").innerHTML;  
                  initializeMonthPicker();
                 }
				 if(tabeId=="cont-9")
                 {
                   document.getElementById("reportHeader").innerHTML="<h3>Communication Summary</h3>";
                   document.getElementById("selectDiv").innerHTML="";
                   document.getElementById("dates").innerHTML=document.getElementById("cont-9-dates").innerHTML;  
                  
                 }
                return false;
            });
        });
    });
</script>

<div class="tab-box" style="padding-top: 10px">
    <a href="#" class="tabLink " id="cont-1">Consumption</a>
    <a href="#" class="tabLink " id="cont-2">Power On/Off</a>           
    <!--<a href="#" class="tabLink " id="cont-3">Last Alerts</a>-->
    <a href="#" class="tabLink " id="cont-4">All Sites Status</a>
    <a href="#" class="tabLink " id="cont-5">Non-Communicating Sites</a>
    <a href="#" class="tabLink " id="cont-6">Break Down History</a>
    <a href="#" class="tabLink " id="cont-7">New Sites Added</a>
    <a href="#" class="tabLink " id="cont-8">Billing Summary</a>
	<a href="#" class="tabLink " id="cont-9">Communication Summary</a>
   <!-- <input type="button" value="Excel" onclick="getExcel('analysReports')"style="float: right;margin-right: 15px;"/> -->
</div>
<div class="tabcontent paddingAll" id="cont-1-1"></div> 
<div class="tabcontent hide" id="cont-2-1"></div> 
<div class="tabcontent hide" id="cont-3-1"></div>
<div class="tabcontent hide" id="cont-4-1"></div>   
<div class="tabcontent hide" id="cont-5-1"></div>
<div class="tabcontent hide" id="cont-6-1"></div>
<div class="tabcontent hide" id="cont-7-1"></div>
<div class="tabcontent hide" id="cont-8-1"></div>
 
<div id="reportHeader" style="text-align: center;width: 100%"></div>
<div id="data_part"  style="border:1px solid #87CEEB;margin-left: 2%;margin-right: 2%;width:96%;min-height:50px;">
    <form name="form1" action="#">
     <div id="selectDiv"></div>
    
    <div id="dates" style="padding-top:10px;"></div>
    </form>
</div>
<div id="cont-9-dates" style="display: none">
   <table> <tr id="dates" >
            <td> From:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate" />
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
            </td>
             <td>To :
                 <input type="text" readonly="true" size="10" name="endingDate" id="endingDate" />
                 <a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
             </td>
            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Submit" onclick="getCommunicationSummary();" />
            </td>
        </tr>
    </table>
</div>
<div id="datesRange" style="display: none">
   <table> <tr id="dates" >
            <td> From:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate" />
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
            </td>
             <td>To :
                 <input type="text" readonly="true" size="10" name="endingDate" id="endingDate" />
                 <a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
             </td>
            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Submit" onclick="getConsumptionAnal();" />
            </td>
        </tr>
    </table>
</div>
<div id="singleDate" style="display: none">
    
        <table> <tr id="dates">
            <td> Select Date:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate" />
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
            </td>
                
            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Submit" onclick="getPowerAnal();" />
            </td>
        </tr> 
    </table>
</div>
<div id="powerDate" style="display: none">
    
        <table> 
            <tr>
            <td> 
                <select name="SCriteria" id="SCriteria" onchange="getTowns(this.value,2)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
                    <option value="-1">Select Criteria</option>  
                    <option value="all">All</option>
                     <option value="ZW">Zone Wise</option>
                     <option value="TW">Town Wise</option>
                     <option value="DW">Division Wise</option>
                    <option value="SD">Subdivision Wise</option>
                    <!--<option value="FD">Feeder Wise</option>-->
                </select> 
            </td>
            <td id="towns"></td>
            <td id="MT"></td>
        </tr> 
            <tr id="dates">
<!--            <td> Select Date:
                <input type="text" readonly="true" size="10" name="startingDate" id="powerDate"/>
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
            </td>-->
                
            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Get Details" onclick="getPowerOnOff10hr();" />
            </td>
        </tr> 
    </table>
</div>
<div id="alertButton" style="display: none">
     <table>
         <tr><td style="padding-left: 20px;"><input type="button" value="Get Details" onclick="getAllAlerts()"/></td></tr>
    </table>
</div>
<div id="selection" style="display: none;">
    <table border="0"  style="margin-top: 1%;margin-left: 2%;margin-right: 2%;width:96%">
                <tr>
                <td> 
                    <select name="SCriteria" id="SCriteria" onchange="getTowns(this.value,2)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
                      <option value="-1">Select Criteria</option>  
                      <option value="TW">Town Wise</option>
                      <option value="SD">Subdivision Wise</option>
                      <!--<option value="FD">Feeder Wise</option>-->
                    </select> 
                </td>
                <td id="towns"></td>
               <td id="MT"></td>
                </tr>             
            </table> 
</div>
<div id="nonComm" style="display: none;">

    <table> 
        <tr>
            <td> 
                <select name="SCriteria" id="SCriteria" onchange="getTowns(this.value,2)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
                    <option value="-1">Select Criteria</option>  
                    <option value="all">All</option>
                    <option value="ZW">Zone Wise</option>
                    <option value="TW">Town Wise</option>
                    <option value="DW">Division Wise</option>
                    <option value="SD">Subdivision Wise</option>
                    <!--<option value="FD">Feeder Wise</option>-->
                </select> 
            </td>
            <td id="zones"></td>
            <td id="towns"></td>
            <td id="MT"></td>
        </tr> 
        <tr id="dates">
<!--            <td> Select Date:<sub>(optional)</sub> 
                <input type="text" readonly="true" size="10" name="startingDate" id="ncDate" />
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>

            </td>-->

            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Submit" onclick="getNonCommMeters();" />
            </td>
        </tr> 
    </table>
</div>
<div id="newSites" style="display:none;">
    <table> <tr id="dates" >
            <td> From:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate" />
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
            </td>
             <td>To :
                 <input type="text" readonly="true" size="10" name="endingDate" id="endingDate" />
                 <a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
             </td>
            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Get Details" onclick="getNewSites();" />
            </td>
        </tr>
    </table>
</div>
<div id="breakDown" style="display: none;">
    <form name="form2" action="#">
    <table border="0"  style="margin-top: 1%;margin-left: 2%;margin-right: 2%;width:96%">
                <tr>
                <td> 
                    <select name="SCriteria" id="SCriteria"  onchange="getTowns(this.value,3)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
                      <option value="-1">Select Criteria</option>  
                      <option value="TW">TownWise</option>
                      <!--<option value="SD">Subdivision Wise</option>-->
                    </select> 
                </td>
                <td id="towns"></td>
               <td id="MT"></td>
               <td >
                        <div id="metersPart"  ></div>
                    </td>
                </tr>             
            </table> 
      
    </form>
    <table> <tr >
            <td> From:
                <input type="text" readonly="true" size="10" name="startingDate" id="startingDate" />
                <a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
            </td>
             <td>To :
                 <input type="text" readonly="true" size="10" name="endingDate" id="endingDate" />
                 <a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
             </td>
            <td colspan="4" id="metersPart" style="padding-left: 10px;">
                <input type="button" value="Get Details" onclick="getBreakDownHistory();" />
            </td>
        </tr>
    </table>
</div>
<div id="billSummary" style="display: none;">

    <table> 
        <tr>
            <td> 
                <select name="SCriteria" id="SCriteria" onchange="getTowns(this.value,2)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
                    <option value="-1">Select Criteria</option>  
                    <option value="all">All</option>
                    <option value="ZW">Zone Wise</option>
                    <option value="TW">Town Wise</option>
                    <option value="DW">Division Wise</option>
                    <option value="SD">Subdivision Wise</option>
                    <!--<option value="FD">Feeder Wise</option>-->
                </select> 
            </td>
            <td id="zones"></td>
            <td id="towns"></td>
            <td id="MT"></td>
            <td>Select Month:</td><td> <input type="text" id="month"  /></td> 
            <td>
                <input type="button" value="Get Details" onclick="getBillingSummary();" />
            </td>
        </tr> 
        
    </table>
</div>
