<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
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
    }
    .tab-box a.activeLink {
        background-color: #fff;
        border-bottom: 0;
        padding: 6px 15px;
    }
    .tabcontent { border: 0px solid #ddd; border-top: 0;}
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
           document.getElementById("sDate").value="";
          document.getElementById("eDate").value="";

                if(tabeId=="cont-1")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("instant");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getInstantData2(but_value);
                }

                if(tabeId=="cont-2")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("e_opt1");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getEnergy(but_value);
                }

                if(tabeId=="cont-3")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("loadsurvay_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getLoadsurvayData(but_value);
                }

                if(tabeId=="cont-4")
                {
                     document.getElementById("startingDate").value="";
                     document.getElementById("endingDate").value="";
                    document.getElementById("DataPart").innerHTML="";

                    getEventsDates();
                }

                if(tabeId=="cont-5")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("snapshot_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getSnapshotData(but_value);
                }

                return false;
            });
        });
    });
    
</script>


<script>
function getEventsDates()
{
      document.getElementById("startingDate").value="";
     document.getElementById("endingDate").value="";
    document.getElementById("etd").style.visibility="visible";

}
    function getLoadsurvayData(data_type)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getLoadsurvayData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=insertLoadsurvayData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getLoadsurvayData

    function insertLoadsurvayData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//insertLoadsurvayData

    function getEventsData(data_type)
    {

        document.getElementById('home_msg').innerHTML = "";
        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        var sdate=document.getElementById("startingDate").value;
        var edate=document.getElementById("endingDate").value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getEventsData.jsp";
        url=url+"?data_type="+escape(data_type)+"&sdate="+escape(sdate)+"&edate="+escape(edate);

        xmlHttp.onreadystatechange=insertEventsData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getEventData

    function insertEventsData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//insertEventsData


    function getSnapshotData(data_type)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSnapshotData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=insertSnapshotData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getSnapshotData

    function insertSnapshotData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//insertLoadsurvayData

    function getInstantData2(data_type)
    {

       document.getElementById('ip_opt_div1').style.display = "none";
       document.getElementById("DataPart").innerHTML="";
       document.getElementById("graphPart").style.display = "none";
       //document.getElementById('date_div').style.display = "none";
       document.getElementById('gdate').style.display = "none";

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        sdate=document.getElementById("sDate").value;
        edate=document.getElementById("eDate").value;

        var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var url="getInstantData.jsp?data_type="+escape(data_type)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"&start=1";
        //url=url+"?data_type="+data_type;
        //url=url+"&meter_id="+SelectedOption;

        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getInstantanious Data

    function getInstantData(start)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        sdate=document.getElementById("sDate").value;
        edate=document.getElementById("eDate").value;
        var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var url="getInstantData.jsp?data_type=2&start="+escape(start)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"";
        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }

    //get Main Energy data function
    function getEnergy(e_opt1)
    {
        document.getElementById('e_opt_div3').style.display = "none";
            document.getElementById('egdate').style.display = "none";
            document.getElementById('graphPart').style.display = "none";

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
    var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
//alert(SelectedOption);
        if(e_opt1==1)
            url="main_energy.jsp?meter_id="+SelectedOption+"&start=1";
        if(e_opt1==2)
            url="tod_energy.jsp?meter_id="+SelectedOption+"&start=1";
        if(e_opt1==3)
            url="energy_consumption.jsp?meter_id="+SelectedOption+"&start=1";
        if(e_opt1==5)
            url="tod_consumption.jsp?meter_id="+SelectedOption+"&start=1";
        if(e_opt1==6)
            url="max_demand.jsp?meter_id="+SelectedOption+"&start=1";

        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function mainEnergy(start)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
      var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
    var url="main_energy.jsp?meter_id="+escape(SelectedOption)+"&start="+escape(start);
     xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function tod_energy(start)
    {
       xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
     var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
    var  url="tod_energy.jsp?meter_id="+escape(SelectedOption)+"&start="+escape(start);
     xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function energy_consumption(start)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
      var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
    var  url="energy_consumption.jsp?meter_id="+SelectedOption+"&start="+escape(start);
     xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function max_demand(start)
     {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
      var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
    var  url="max_demand.jsp?meter_id="+SelectedOption+"&start="+escape(start);
     xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }

    function getEnergyData()
    {

        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//getEnergyData

    function getEnergyOptions(e_opt)
    {
        if(e_opt==1)
        {
            document.getElementById('e_opt_div1').style.display = "block";
            document.getElementById('e_opt_div2').style.display = "none";
            document.getElementById('e_opt_div3').style.display = "none";
            document.getElementById('egdate').style.display = "none";
            getEnergy(1);
        }
        if(e_opt==2)
        {
            document.getElementById('e_opt_div2').style.display = "block";
            document.getElementById('e_opt_div1').style.display = "none";
            document.getElementById('e_opt_div3').style.display = "none";
            document.getElementById('egdate').style.display = "none";
            getEnergy(6);
        }
        if(e_opt==3)
            {
                document.getElementById('e_opt_div1').style.display = "none";
            document.getElementById('e_opt_div2').style.display = "none";
            document.getElementById('e_opt_div3').style.display = "block";
             document.getElementById("DataPart").innerHTML="";
    
    
    document.getElementById("energygraphDate").value="";
    document.getElementById('egdate').style.display = "block";
            }
    }
    function getInstantOptions()
   {
    document.getElementById("DataPart").innerHTML="";
    document.getElementById("graphPart").style.display = "none";
    document.getElementById('date_div').style.display = "none";
    document.getElementById("graphDate").value="";
    document.getElementById('gdate').style.display = "block";
       document.getElementById('ip_opt_div1').style.display = "block";



    }
    function getDates()
    {
         document.getElementById("DataPart").style.display="none";
         document.getElementById("sDate").value="";
         document.getElementById("eDate").value="";
         document.getElementById("graphPart").style.display = "none";
         document.getElementById('date_div').style.display = "block";
         document.getElementById('ip_opt_div1').style.display = "none";
         document.getElementById("gdate").style.display = "none";
    }
</script>

<div class="tab-box" id="example">
    <a href="javascript:;" class="tabLink activeLink " id="cont-1">Instantaneous Data</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Energy</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Load Survey Data</a>
    <a href="javascript:;" class="tabLink " id="cont-4">Events Data</a>
    <a href="javascript:;" class="tabLink " id="cont-5">Snapshot Data</a>
    <a href="javascript:;" class="tabLink " id="cont-6">Reliable Indices</a>
</div>

<div style="float:right;"><input type="button" name="print" value="Print" onclick="print();">  <input type="button" name="pdf" value="PDF" onclick="createPDF();"></div>
<script type="text/javascript" src="date-picker.js"></script>
<div class="tabcontent paddingAll" id="cont-1-1">

    <div class="button_style"> <input type="radio" name="instant" id="instant" value="1" checked onclick="getInstantData2(this.value)"> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="instant" id="instant" value="2" onclick="getDates()"> Complete Data </div>

    <div class="button_style"><input type="radio" name="instant" id="instant" value="3" onclick="getInstantOptions()"> Graphs</div>

    </br>
    <div id="date_div" style="float:left;clear:both;display:none">
    <form name="iReports">
    <table><tr><td id="ictd" >
    <b>Starting Date:</b>
    <input type="text" readonly="true" size="10" name="startingDate" id="sDate"/>
    <a href="javascript:show_calendar('iReports.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
    &nbsp;
    <b>Endiing Date:</b>
    <input type="text" readonly="true" size="10" name="endingDate" id="eDate"/>
    <a href="javascript:show_calendar('iReports.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
    <input type="button" size="30" id="" value="Get Data" onclick="getInstantData2(2)">
    </td></tr>
    </table></form>
     </div>
    <form name="graphicalReports">
    <table><tr><td id="gdate" style="display:none" >
    <b>Select Date:</b>
    <input type="text" readonly="true" size="10" name="startingDate" id="graphDate"/>
    <a href="javascript:show_calendar('graphicalReports.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
    &nbsp;

    </td></tr>
    </table></form>
    <div id="ip_opt_div1" style="float:left;clear:both;display:none">
    <div class="button_style"><input type="radio" name="instant_1"  value="1"   onclick="getGraphs(this.value)"> Voltage Graph</div>
    <div class="button_style"><input type="radio" name="instant_1"  value="2" onclick="getGraphs(this.value)"> Current Graph</div>

    </div>

</div>

<div class="tabcontent paddingAll hide" id="cont-2-1">
    <div class="button_style"><input type="radio" name="e_opt" value="1" checked onclick="getEnergyOptions(this.value)"> Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="e_opt" value="2" onclick="getEnergyOptions(this.value)"> Demand</div>
    <div class="button_style"><input type="radio" name="e_opt" value="3" onclick="getEnergyOptions(this.value)"> Graphs</div>
    
    <form name="energygraphicalReports">
    <table><tr><td id="egdate" style="display:none" >
    <b>Select Date:</b>
    <input type="text" readonly="true" size="10" name="startingDate" id="energygraphDate"/>
    <a href="javascript:show_calendar('energygraphicalReports.startingDate')"> <img src="images/cal1.gif" id="esdate"  width=24 height=22 border=0/></a>
    &nbsp;

    </td></tr>
    </table></form>
    <div id="e_opt_div1" style="float:left;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt1" value="1" checked onclick="getEnergy(this.value)"> Main Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="2" onclick="getEnergy(this.value)"> TOD Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="3" onclick="getEnergy(this.value)"> Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
<!--        <div class="button_style"><input type="radio" name="e_opt1" value="4" onclick="getEnergy(this.value)"> Midnight Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
        <!--<div class="button_style"><input type="radio" name="e_opt1" value="5" onclick="getEnergy(this.value)"> TOD Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
    </div>
    <div id="e_opt_div2" style="float:left;display:none;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt1" value="6" onclick="getEnergy(this.value)"> Max Demand &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="7" onclick="getEnergy(this.value)"> TOD MD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="8" onclick="getEnergy(this.value)"> CMD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="9" onclick="getEnergy(this.value)"> MD Reset Dates &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
    <div id="e_opt_div3" style="float:left;display:none;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt2" value="1" onclick="getEnergyGraph(this.value)"> KWH Graph &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        
    </div>

</div>

<div class="tabcontent paddingAll hide" id="cont-3-1">
   <div class="button_style"><input type="radio" name="loadsurvay_opt" id="loadsurvay_opt" value="10" checked onclick="getLoadsurvayData(this.value)"> Load Survay &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-4-1">
    <form name="f_reports" action="" >
    <table><tr>
            <td>
                
            </td>
            <td id="etd" style="visibility:hidden">
    <b>Starting Date:</b>
    <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
    <a href="javascript:show_calendar('f_reports.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
    &nbsp;
    <b>Endiing Date:</b>
    <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
    <a href="javascript:show_calendar('f_reports.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
    &nbsp;
    <input type="button" size="30" id="evnt_search" value="Get Data" onclick="getEventsData()">
    </td></tr>
    </table>
</form>
</div>
<div class="tabcontent paddingAll hide" id="cont-5-1">
    <div class="button_style"><input type="radio" name="snapshot_opt" id="snapshot_opt" value="12" checked onclick="getSnapshotData(this.value)"> SnapShot &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-6-1">
    <div class="button_style"><input type="radio" name="snapshot_opt" id="reliable_opt"   onclick=""> SAIDI &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="snapshot_opt" id="reliable_opt"   onclick=""> SAIFI &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>