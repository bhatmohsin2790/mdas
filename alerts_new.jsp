<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="pragma" content="-1" />

        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>

        <!--Import part -->
        <%@ include file="importpage.jsp"%>
        <%@page import="java.io.*"%>


        <script type="text/javascript" language="jscript">
            var meterLocation;
            var substationId;
            function sendMeterId()
            {
       
                mSel=document.getElementById("dtr");
                meter=mSel.options[mSel.selectedIndex].title;
                //alert(meter);
                document.getElementById("startingDate").value="";
                document.getElementById("endingDate").value="";
                document.getElementById("DataPart").innerHTML="";

            }
            function showAlerts()
            {
                document.getElementById("DataPart").innerHTML="";              
                date=document.getElementById("startingDate").value;
                endDate=document.getElementById("endingDate").value;
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var values=new Array();
                checkboxes = document.getElementsByName('alert');
                for(var i in checkboxes)
                {
                    if(checkboxes[i].checked)
                    { 
                        values=values+(i)+",";
             
                    }                        
                }
                if(meter=="All" && values=="0,1,")
                {
                    alert("please select only one checkbox at a time");
                }
                var url="alertReport_new.jsp?meterId="+escape(meter)+"&date="+escape(date)+"&endDate="+escape(endDate)+
                    "&values="+escape(values)+"&start=1&location="+escape(meterLocation)+"&substationId="+escape(substationId);
                // alert(url); 
                xmlHttp.onreadystatechange=showAlertsAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function  Alerts(start)
            {
                date=document.getElementById("startingDate").value;
                endDate=document.getElementById("endingDate").value;
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="alertReport.jsp?meterId="+escape(meter)+"&date="+escape(date)+"&endDate="+escape(endDate)+"&start="+escape(start);

                xmlHttp.onreadystatechange=showAlertsAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function showAlertsAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("button").style.visibility="visible";
                    document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                }//end i
            }
            function selectall(source)
            {
                checkboxes = document.getElementsByName('alert');
                for(var i in checkboxes)
                    checkboxes[i].checked = source.checked;
            }
            function deselect(source)
            {
                checkbox = document.getElementsByName('allalert');
                for(var i in checkbox)
                    checkbox[i].checked = source.unchecked;

            }
            function getAlertsHirarchy(meterLoc)
            { 
                meterLocation=meterLoc;
                if(meterLoc=="feeder")
                {                      
                    document.getElementById("checkboxpart").innerHTML=document.getElementById("dcucheckBoxes").innerHTML;
                    document.getElementById("DataPart").innerHTML=""; 
                }
                if(meterLoc=="dtr" || meterLoc=="ht")
                {
                    document.getElementById("checkboxpart").innerHTML=document.getElementById("metercheckBoxes").innerHTML;
                    document.getElementById("DataPart").innerHTML=""; 
                }
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }

                var url="getHirarchyForAlerts.jsp?meterLoc="+escape(meterLoc);   
                xmlHttp.onreadystatechange=insertAlertHirarchy;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null); 
            }
            function insertAlertHirarchy()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("getHirarchy").innerHTML=xmlHttp.responseText;
                }
            }
            function sendFeederMeterId()
            {
                substationSel=document.getElementById("substation");
                substationId=substationSel.options[substationSel.selectedIndex].value;               
                if(substationId!="0")
                {
                    showDTRs(substationId,0); 
                    meter="All";
                }//cal this after selecting the substation only
       
                if(substationId=="0")
                {
                    mSel=document.getElementById("dtr");
                    meter=mSel.options[mSel.selectedIndex].title;   
                }
        
                document.getElementById("startingDate").value="";
                document.getElementById("endingDate").value="";
                document.getElementById("DataPart").innerHTML=""; 
                if(meter=="All")
                { document.getElementById("dcuPowerFail").style.visibility="visible";}
                else
                    document.getElementById("dcuPowerFail").style.visibility="hidden";
        
                checkboxes = document.getElementsByName('alert');
                for(var i in checkboxes)
                {if(checkboxes[i].checked)
                        checkboxes[i].checked =false;
                }
        
        
            }
           
            function getCheckBoxes()
            {
                document.getElementById("checkboxpart").innerHTML=document.getElementById("metercheckBoxes").innerHTML;
                document.getElementsByName("r1").item(2).checked=true;
            }
        </script>


    </head>
    <body onload='getCheckBoxes();'>
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Select Meter</b>
                            </td>
                        </tr>

                    </table>
                    </br>
                    <%@ include file="side_alerts.jsp"%>

                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>

                    <div id="button"  style="padding-top: 6px">
                        <form name="alert_form">
                            <table align="center" cellpadding="5" cellspacing="5">
                                <tr><td colspan="5"> 
                                        <div id="checkboxpart"></div>

                                    </td></tr>
                                <tr>
                                    <td>From:

                                        <input type="text" readonly="true" size="10" name="startingDate" id="startingDate"style="border:1px solid #666666;"/>
                                    </td><td style="padding-top:0px;">
                                        <a href="javascript:show_calendar('alert_form.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
                                    </td>

                                    <td >To:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                        <input type="text" readonly="true" size="10" name="endingDate" id="endingDate"style="border:1px solid #666666;"/>
                                    </td><td style="padding-top:0px;">
                                        <a href="javascript:show_calendar('alert_form.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
                                    </td>

                                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Get Report" onclick="showAlerts();"/></td></tr>
                            </table>
                        </form>
                    </div>
                    <div id="DataPart"  align="center"></div>
                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>
        </table>
        <div id="navigation" ></div>
        <div id="dcucheckBoxes" style="visibility:hidden">
            <table><tr>
                    <td ><input type="checkbox" id="a5" name="alert" value="5" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;CRC Failed</td>
                    
                    <td id="dcuPowerFail"><input type="checkbox" id="a6" name="alert" value="6" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;DCU Power Fail</td>
                   <td ><input type="checkbox" id="a7" name="alert" value="7" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;Invalid Meter Data</td>
                </tr></table>
        </div>
        <div id="metercheckBoxes" style="visibility: hidden;">
            <table>
                <tr><td><input type="checkbox" onclick="selectall(this);" name="allalert" id="all"/>&nbsp;&nbsp;&nbsp;Select All</td><td></td><td></td></tr>
                <tr>
                    <td><input type="checkbox" id="a1" name="alert" value="1" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;Meter-Com Failed</td>
                    <td colspan="2"><input type="checkbox" id="a2" name="alert" value="2" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;AMR Power Failed</td>
                    <td colspan="2"><input type="checkbox" id="a3" name="alert" value="3" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;DTR Power Failed</td>
                    <td colspan="2"><input type="checkbox" id="a4" name="alert" value="4" onclick="deselect(this);"/>&nbsp;&nbsp;&nbsp;CRC Failed</td>


                </tr> </table>
        </div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>

<%
    //code to delete image files


%>