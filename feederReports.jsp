<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <script type="text/javascript" src="jquery.js"></script>
        <!--Import part -->
        <%@ include file="importpage.jsp"%>

        <script type="text/javascript"></script>
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
    .tab-box
    {
      border-bottom: 1px solid #DDD;
      padding-bottom:5px;
    }
    .tab-box a
    {
      border:1px solid #DDD;
      color:#666666;
      padding: 5px 15px;
      text-decoration:none;
      background-color: #eee;
      font-size:12px;
    }
    .tab-box a.activeLink
    {
      background-color: #fff;
      border-bottom: 0;
      padding: 6px 15px;
    }
    .tabcontent
    {
      border: 1px solid #ddd; border-top: 0;
    }
    .hide
    {
      display: none;
    }


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
                    getGraphs();
                }

                if(tabeId=="cont-4")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("tamper_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getEventsData(but_value);
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
    function showDivisions(emp_value)
    {
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    //               alert("A");
    if(emp_value!="-1")
    {
    //            alert("B");
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getDivisions.jsp";
    url=url+"?emp_id="+emp_value;

    xmlHttp.onreadystatechange=stateChanged;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }
    else
    {
    //                           alert("C");
    alert("Please Select Subdivision ");
    }
    //                       alert("D");
    }//showDivisions

    function stateChanged()
    {

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

    var showdata = xmlHttp.responseText;

    var strar = showdata.split(":");

    if(strar.length==1)
    {
        //  alert("Please Select Employee Id");
    }
    else if(strar.length>1)
    {
        var strname = strar[1];
        //----- Values inserting into Combo Box Dynamicaly------
        for(var j=document.forms[0].division.options.length-1;j>=0;j--)
        {
            document.forms[0].division.remove(j);
        }
        var combo = document.getElementById("division");
        for(var i=0;i<strar.length;i++)
        {
            // alert(strar[i].substringData(strar[i].indexOf("_")+1));
            var option = document.createElement("option");
            option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
            option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
            try
            {
                combo.add(option, null); //Standard
            }
            catch(error)
            {
                combo.add(option); // IE only
            }//try
        }//for
        //----- End of Values inserting into Combo Box Dynamicaly------
    }

    }
    }//stateChanged

    function showSubDivisions(emp_value)
    {
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getSubDivisions.jsp";
    url=url+"?emp_id="+emp_value;

    xmlHttp.onreadystatechange=state_SubDivision_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }
    else
    {
    alert("Please Select Subdivision ");
    }
    }//showDivisions

    function state_SubDivision_Changed()
    {

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

    var showdata = xmlHttp.responseText;

    var strar = showdata.split(":");

    if(strar.length==1)
    {
        //  alert("Please Select Employee Id");
    }
    else if(strar.length>1)
    {
        var strname = strar[1];
        //----- Values inserting into Combo Box Dynamicaly------
        for(var j=document.forms[0].subdivision.options.length-1;j>=0;j--)
        {
            document.forms[0].subdivision.remove(j);
        }
        var combo = document.getElementById("subdivision");
        for(var i=0;i<strar.length;i++)
        {
            var option = document.createElement("option");
            option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
            option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
            try
            {
                combo.add(option, null); //Standard
            }
            catch(error)
            {
                combo.add(option); // IE only
            }//try
        }//for
        //----- End of Values inserting into Combo Box Dynamicaly------
    }

    }
    }//state_SubDivision_Changed

    function showSections(emp_value)
    {
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getSections.jsp";
    url=url+"?emp_id="+emp_value;

    xmlHttp.onreadystatechange=state_Section_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }
    else
    {
    alert("Please Select Subdivision ");
    }
    }//showDivisions

    function state_Section_Changed()
    {

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

    var showdata = xmlHttp.responseText;

    var strar = showdata.split(":");

    if(strar.length==1)
    {
        //  alert("Please Select Employee Id");
    }
    else if(strar.length>1)
    {
        var strname = strar[1];
        //----- Values inserting into Combo Box Dynamicaly------
        for(var j=document.forms[0].section.options.length-1;j>=0;j--)
        {
            document.forms[0].section.remove(j);
        }
        var combo = document.getElementById("section");
        for(var i=0;i<strar.length;i++)
        {
            var option = document.createElement("option");
            option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
            option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
            try {
                combo.add(option, null); //Standard
            }catch(error) {
                combo.add(option); // IE only
            }//try
        }//for
        //----- End of Values inserting into Combo Box Dynamicaly------
    }

    }
    }//state_Section_Changed

    function showSubStations(emp_value)
    {
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getSubstations.jsp";
    url=url+"?emp_id="+emp_value;

    xmlHttp.onreadystatechange=state_SubStation_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }else
    {
    alert("Please Select Subdivision ");
    }
    }//showDivisions

    function state_SubStation_Changed()
    {

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

    var showdata = xmlHttp.responseText;

    var strar = showdata.split(":");

    if(strar.length==1)
    {
        //  alert("Please Select Employee Id");
    }
    else if(strar.length>1)
    {
        var strname = strar[1];
        //----- Values inserting into Combo Box Dynamicaly------
        for(var j=document.forms[0].substation.options.length-1;j>=0;j--)
        {
            document.forms[0].substation.remove(j);
        }
        var combo = document.getElementById("substation");
        for(var i=0;i<strar.length;i++)
        {
            var option = document.createElement("option");
            option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
            option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
            try
            {
                combo.add(option, null); //Standard
            }
            catch(error)
            {
                combo.add(option); // IE only
            }//try
        }//for
        //----- End of Values inserting into Combo Box Dynamicaly------
    }

    }
    }//state_SubStation_Changed

    function showFeeders(emp_value)
    {
        alert("reached here......feederReports.jsp...!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getFeeders.jsp";
    url=url+"?emp_id="+emp_value;

    xmlHttp.onreadystatechange=state_Feeder_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }
    else
    {
    alert("Please Select Subdivision ");
    }
    }//showDivisions

    function state_Feeder_Changed()
    {

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

    var showdata = xmlHttp.responseText;

    var strar = showdata.split(":");

    if(strar.length==1)
    {
        //  alert("Please Select Employee Id");
    }
    else if(strar.length>1)
    {
        var strname = strar[1];
        //----- Values inserting into Combo Box Dynamicaly------
        for(var j=document.forms[0].feeder.options.length-1;j>=0;j--)
        {
            document.forms[0].feeder.remove(j);
        }
        var combo = document.getElementById("feeder");
        for(var i=0;i<strar.length;i++)
        {
            var option = document.createElement("option");
            option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
            option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
            try
            {
                combo.add(option, null); //Standard
            }
            catch(error) {
                combo.add(option); // IE only
            }//try
        }//for
        //----- End of Values inserting into Combo Box Dynamicaly------
    }

    }
    }//state_Feeder_Changed

    //select Meters list based on opt (option value 0-->Feeders, 1-->DTR's, 2-->HT's)
    function list_change(opt)
    {
    showDTRs(document.getElementById('feeder').value,opt);
    }
    function showDTRs(emp_value,i)
    {

    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    /*
                var url="getDTRs.jsp";
                url=url+"?emp_id="+emp_value;
                url=url+"&opt="+i;
     */
    var url="getDtrIds.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
    xmlHttp.onreadystatechange=state_DTR_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }
    else
    {
    alert("Please Select Subdivision ");
    }
    }//showDivisions

    function state_DTR_Changed()
    {

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

    var showdata = xmlHttp.responseText;
    //alert(showdata);
    showdata = showdata.toString().replace("\n", "");
    showdata = showdata.toString().replace("\n", "");
    showdata = showdata.toString().replace("\n", "");
    showdata = showdata.toString().replace("\n", "");
    //alert(showdata);
    var strar = showdata.split(":");

    if(strar.length==1)
    {
        //  alert("Please Select Employee Id");
    }
    else if(strar.length>1)
    {
        var strname = strar[1];
        //----- Values inserting into Combo Box Dynamicaly------
        for(var j=document.forms[0].dtr.options.length-1;j>=0;j--)
        {

            document.forms[0].dtr.remove(j);
        }
        var combo = document.getElementById("dtr");
        for(var i=0;i<strar.length-1;i++)
        {
            var option = document.createElement("option");
            option.text = strar[i].trim().substring(2);//textb.value;
            option.value = strar[i].substring(0,strar[i].trim().indexOf("_"));//textb.value;

            try
            {
                combo.add(option, null); //Standard
            }catch(error) {
                combo.add(option); // IE only

            }//try
        }//for
        //----- End of Values inserting into Combo Box Dynamicaly------


    }

    }
    }//state_DTR_Changed

    function getInstantData(meter_id)
    {

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
    alert ("Browser does not support HTTP Request");
    return;
    }
    var url="getInstantData.jsp";
    url=url+"?meter_id="+meter_id;

    xmlHttp.onreadystatechange=getInstantaneousData;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }//getInstantanious Data


    function getInstantaneousData()
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
    }//getInstantaneousData


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

    function getGraphs()
    {
       alert("getGraphs");
       document.getElementById("datetable").style.display="";
    }
    function getLoadsurvayData(data_type)
    {
    alert("getLoadSurveydata");
    document.getElementById("datetable").style.display="";
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

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
    alert ("Browser does not support HTTP Request");
    return;
    }
    var url="getEventsData.jsp";
    url=url+"?data_type="+data_type;

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

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
        var url="getInstantData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getInstantanious Data

    //get Main Energy data function
    function getEnergy(e_opt1)
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
    alert ("Browser does not support HTTP Request");
    return;
    }
    var url="";

    if(e_opt1==1)
    url="main_energy.jsp";
    if(e_opt1==2)
    url="tod_energy.jsp";
    if(e_opt1==3)
    url="energy_consumption.jsp";
    if(e_opt1==5)
    url="tod_consumption.jsp";

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
    }
    if(e_opt==2)
    {
    document.getElementById('e_opt_div2').style.display = "block";
    document.getElementById('e_opt_div1').style.display = "none";
    }
    }

    function getDataReportsInstantData(meter_id)
    {

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
    alert ("Browser does not support HTTP Request");
    return;
    }
    var url="getInstantData.jsp";
    url=url+"?meter_id="+meter_id;
    alert(url);
    xmlHttp.onreadystatechange=getInstantaneousData;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

    }//showDivisions

    function createPDF()
    {
    var s11 = document.getElementById('report_header').innerHTML;
    s11 = s11+document.getElementById('DataPart').innerHTML;
    //alert(s11);

    s11 = s11.replace(/class=\"head1\"/g,"style=\"color: #000000;font-weight: bold;\"");
    s11 = s11.replace(/class=\"mtable\"/g,"style=\"background-color: #FFFFFF;border: 1px solid black;border-collapse: collapse;font-family: arial;font-size: 10pt;width: auto;\"");
    s11 = s11.replace(/class=\"td1\"/g,"bgcolor=\"#56A5EC\" style=\"background-color:#56A5EC;border: 1px solid #409040;color: #FFFFFF;font-family: 'Times New Roman',Times,serif;font-size: 15pt;font-weight: bold;padding: 2px 4px;text-align: center;\"");
    s11 = s11.replace(/class=\"td2\"/g,"style=\"border: 1px solid #409040;font-size: 15pt;padding: 2px 4px;text-align: center;\"");
    s11 = s11.replace(/&nbsp;/g," ");
    //s11 = s11.replace(/\n/g,"<br>");
    s11 = s11.replace(/%/g,"%25");

    s11 = s11.replace(/&/g,"%26");

    s11 = s11.replace(/#/g,"%23");

    alert(s11);
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
    alert ("Browser does not support HTTP Request");
    return;
    }
    var url="createPDF.jsp";
    var parameters = "data="+s11;
    alert(url);
    xmlHttp.onreadystatechange=pdf;
    xmlHttp.open("POST",url,true);
    xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlHttp.setRequestHeader("Content-length", parameters .length);
    xmlHttp.send(parameters);

    }
    function pdf()
    {
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
    var showdata = xmlHttp.responseText;
    alert(showdata);
    }
    }//state_DTR_Changed
    function tabber()
    {
    alert();
    document.select.getElementById("dtr");

    }
        </script>
    </head>
<body>
    <!--<form name="form1">  -->
<div id="navigation"></div>
<table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
    <%@ include file="top.jsp"%>
    <tr>
    <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
        <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
            <tr>
                <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                    <b>You r in Feeder Reports</b>
                </td>
            </tr>
            
        </table>
          <br></br>
            <%@ include file="side_feeder_reports.jsp"%>




        </td>
        <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
        <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:15px;padding-bottom:10px;padding-top:10px;" valign="top">
            <%
              // if(document.form.getElementsByName('feeder'))
                %>
                <%@ include file="menu1.jsp"%>
<br/>
    <div class="tab-box">
        <a href="javascript:;" class="tabLink activeLink" id="cont-1">Instantaneous Parameters</a>
        <a href="javascript:;" class="tabLink " id="cont-2">Energy</a>
        <a href="javascript:;" class="tabLink " id="cont-3">Load Survey Data</a>
        <a href="javascript:;" class="tabLink " id="cont-4">Events Data</a>
        <a href="javascript:;" class="tabLink " id="cont-5">Transaction Data</a>
    </div>

    <div style="float:right;">Print  <input type="button" name="pdf" value="PDF" onclick="createPDF();"/></div>

    <div class="tabcontent paddingAll" id="cont-1-1">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <div class="button_style"> <input type="radio" name="instant" id="instant" value="1" checked onclick="getInstantData2(this.value)"/> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="instant" id="instant" value="2" onclick="getInstantData2(this.value)"/> Complete Data</div>
    </div>

    <div class="tabcontent paddingAll hide" id="cont-2-1">
        <div class="button_style"><input type="radio" name="e_opt" value="1" checked onclick="getEnergyOptions(this.value)"/> Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt" value="2" onclick="getEnergyOptions(this.value)"/> Demand</div>
        <br />
        <div id="e_opt_div1" style="float:left;clear:both;">
            <div class="button_style"><input type="radio" name="e_opt1" value="1" checked onclick="getEnergy(this.value)"/> Main Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="button_style"><input type="radio" name="e_opt1" value="2" onclick="getEnergy(this.value)"/> TOD Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="button_style"><input type="radio" name="e_opt1" value="3" onclick="getEnergy(this.value)"/> Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="button_style"><input type="radio" name="e_opt1" value="4" onclick="getEnergy(this.value)"/> Midnight Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <!--<div class="button_style"><input type="radio" name="e_opt1" value="5" onclick="getEnergy(this.value)"> TOD Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
        </div>
        <div id="e_opt_div2" style="float:left;display:none;clear:both;">
            <div class="button_style"><input type="radio" name="e_opt1" value="6" onclick="getEnergy(this.value)"/> Max Demand &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="button_style"><input type="radio" name="e_opt1" value="7" onclick="getEnergy(this.value)"/> TOD MD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="button_style"><input type="radio" name="e_opt1" value="8" onclick="getEnergy(this.value)"/> CMD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
            <div class="button_style"><input type="radio" name="e_opt1" value="9" onclick="getEnergy(this.value)"/> MD Reset Dates &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        </div>
    </div>

    <div class="tabcontent paddingAll hide" id="cont-3-1">
       <div class="button_style"><input type="radio" name="loadsurvay_opt" id="loadsurvay_opt" value="10" checked onclick="getLoadsurvayData(this.value)"/> Load Survay &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
       <div class="button_style"> <input type="radio" name="loadsurvay_opt" id="loadsurvay_opt" value="13" onclick="getGraphs()"/> Graph &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

       <table id="datetable" style="display:none">
           <tr align="center">
               <td>StartingDate:
               <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"/>
		<a href="javascript:show_calendar('form1.startingDate')"> <img src="images/cal.gif" id="sdate"  width=24 height=22 border=0/></a>
	       </td>
           </tr>
           <tr>
           <td>Ending Date:
               <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"/>
		<a href="javascript:show_calendar('form1.endingDate')"> <img src="images/cal.gif" id="edate"  width=24 height=22 border=0/></a>
	    </td>
        </tr>
       </table>
       <table>
           <tr>
               <td>

               </td>
           </tr>
       </table>


    </div>
    <div class="tabcontent paddingAll hide" id="cont-4-1">
        <div class="button_style"><input type="radio" name="tamper_opt" id="tamper_opt" value="11" checked onclick="getEventsData(this.value)"/> Tamper &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
    <div class="tabcontent paddingAll hide" id="cont-5-1">
        <div class="button_style"><input type="radio" name="snapshot_opt" id="snapshot_opt" value="12" checked onclick="getSnapshotData(this.value)"/> SnapShot &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
            </td>
            <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
        </tr>


    </table>
    <div id="navigation"></div>
    <%@ include file="bottom.jsp"%>
<!--</form> -->
</body>
</html>