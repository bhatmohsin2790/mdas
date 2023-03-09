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

        <script type="text/javascript">
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

                }else
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
                        for(var j=document.forms[0].division.options.length-1;j>=0;j--){
                            document.forms[0].division.remove(j);
                        }
                        var combo = document.getElementById("division");
                        for(var i=0;i<strar.length;i++)
                        {
                            // alert(strar[i].substringData(strar[i].indexOf("_")+1));
                            var option = document.createElement("option");
                            option.text = strar[i].substring(2);//textb.value;
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

                }else
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
                        for(var j=document.forms[0].subdivision.options.length-1;j>=0;j--){
                            document.forms[0].subdivision.remove(j);
                        }
                        var combo = document.getElementById("subdivision");
                        for(var i=0;i<strar.length;i++)
                        {
                            var option = document.createElement("option");
                            option.text = strar[i].substring(2);//textb.value;
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

                }else
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
                        for(var j=document.forms[0].section.options.length-1;j>=0;j--){
                            document.forms[0].section.remove(j);
                        }
                        var combo = document.getElementById("section");
                        for(var i=0;i<strar.length;i++)
                        {
                            var option = document.createElement("option");
                            option.text = strar[i].substring(2);//textb.value;
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
                        for(var j=document.forms[0].substation.options.length-1;j>=0;j--){
                            document.forms[0].substation.remove(j);
                        }
                        var combo = document.getElementById("substation");
                        for(var i=0;i<strar.length;i++)
                        {
                            var option = document.createElement("option");
                            option.text = strar[i].substring(2);//textb.value;
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
            }//state_SubStation_Changed

            function showFeeders(emp_value)
            {
                    alert("reached here.....dtrReports.jsp....!"+emp_value);
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

                }else
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
                        for(var j=document.forms[0].feeder.options.length-1;j>=0;j--){
                            document.forms[0].feeder.remove(j);
                        }
                        var combo = document.getElementById("feeder");
                        for(var i=0;i<strar.length;i++)
                        {
                            var option = document.createElement("option");
                            option.text = strar[i].substring(2);//textb.value;
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

                }else
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
                        for(var j=document.forms[0].dtr.options.length-1;j>=0;j--){

                            document.forms[0].dtr.remove(j);
                        }
                        var combo = document.getElementById("dtr");
                        for(var i=0;i<strar.length-1;i++)
                        {
                            var option = document.createElement("option");
                            option.text = strar[i].trim().substring(2);//textb.value;
                            option.value = strar[i].substring(0,strar[i].trim().indexOf("_"));//textb.value;

                            try {
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
                //alert(url);
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
        </script>
    </head>
    <body>
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>You r in Dtr Reports</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="side_dtr_reports.jsp"%>

                   <!-- <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Alert Area</b>
                            </td>
                        </tr>
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">
                                1. Alert Description 1<br />
                                2. Alert Description 2<br />
                                3. Alert Description 3<br />

                            </td>
                        </tr>
                    </table> -->


                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>
                    <div id="submenu" style="float:left;display:none;width: 100%;">
                        <%@ include file="dtr_tabs.jsp"%>
                    </div>
                    <div id="report_header" style="float:left;display:none;width:100%;">
                        <%@ include file="report_header.jsp"%>
                    </div><br/>
                    <div id="DataPart" style="float:left;display:none;width: 100%;"></div>
                    <div id="">
                        <p><h3 align="center">DTR Reports</h3></p>
                    </div>
                    
                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>