<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
       
        <%@ include file="importpage.jsp"%>
        <script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="js2/datatables/datatables.min.css" />
<script type="text/javascript" src="js2/datatables/datatables.min.js"></script>
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
                        if(tabeId=="cont-1")
                            addMeter();
                        if(tabeId=="cont-2")
                            editMeter();
                        if(tabeId=="cont-3")
                            delMeter();
                        if(tabeId=="cont-4")
                            viewMeter();
                        if(tabeId=="cont-5")
                            changeMeterSummary(); //Kumar
                        return false;
                    });
                });
            });

        </script>

        <!--  MeterData information insertion  -->
        <script type="text/javascript">
            function GetXmlHttpObject()
            {
                var xmlHttp=null;
                if (window.XMLHttpRequest) {
                    xmlHttp = new window.XMLHttpRequest;
                }
                else {
                    try {
                        xmlHttp = new ActiveXObject("MSXML2.XMLHTTP.3.0");
                    }
                    catch(ex) {
                        alert("Ajax is not Supported for Internet Explorer");
                        //return null;
                    }
                }
                return xmlHttp;
            }//GetXmlHttpObject
            function addMeter()
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="addMeterData.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function editMeter()
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="updateMeter.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function changeMeterSummary()
            {
                //alert("in change meter summary");
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="changeMeterSummary.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function delMeter()
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="deleteMeter.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function viewMeter()
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/viewMeterAction.jsp?start=1";
               
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);                 
            }
            function viewMeters(start)
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/viewMeterAction.jsp?start="+escape(start);
             
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);                 
            }
            function commonAction()
            {
                document.getElementById("DataPart").innerHTML=document.getElementById("loading").innerHTML;
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").innerHTML="";
                    document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                    $('#dtable').DataTable();
                }//end if
            }
            function insertMeter()
            {               
                metersno=document.getElementById("metersno").value;
                meterMakeSel=document.getElementById("meterMake");
                meterMake=meterMakeSel.options[meterMakeSel.selectedIndex].value;
                meterLocSel=document.getElementById("meterLoc");
                meterLoc=meterLocSel.options[meterLocSel.selectedIndex].value;
                meterCTR=document.getElementById("meterCTR").value;
                meterPTR=document.getElementById("meterPTR").value;
                adoptedCTR=document.getElementById("adoptedCTR").value;
                adoptedPTR=document.getElementById("adoptedPTR").value;
//                meter_statusSel=document.getElementById("meter_status");
//                meter_status=meter_statusSel.options[meter_statusSel.selectedIndex].value;
//                metering_pointsSel=document.getElementById("metering_points");
//                metering_points=metering_pointsSel.options[metering_pointsSel.selectedIndex].value;
                accuracy=document.getElementById("accuracy").value;
                meterType=document.getElementById("meterType").value;
                mf=document.getElementById("mf").value;
                modem_Serial_No=document.getElementById("modem_Serial_No").value;
                locationCode=document.getElementById("locationCode").value;
                consumerId=document.getElementById("consumerId").value;
                



                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/addMeterAction.jsp?metersno="+escape(metersno)+"&meterMake="+escape(meterMake)+"&meterLoc="+escape(meterLoc)
                    +"&meterCTR="+escape(meterCTR)+"&meterPTR="+escape(meterPTR)+"&adoptedCTR="+escape(adoptedCTR)+"&adoptedPTR="+escape(adoptedPTR)
                    +"&accuracy="+escape(accuracy)+"&meterType="+escape(meterType)
                    +"&mf="+escape(mf)+"&modem_Serial_No="+escape(modem_Serial_No)+"&locationCode="+escape(locationCode)+"&consumerId="+escape(consumerId);
                //alert(url);
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }//end method         

            function deleteMeter()
            {
                meterid=document.getElementById("Meterid").value;
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/deleteMeterAction.jsp?meterid="+escape(meterid);
                //alert(url);
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }//end method
            function updateMeter()
            {
                meterSel=document.getElementById("oldmeter").selectedIndex;
                meterId=document.getElementById("oldmeter").options[meterSel].value;                
                meterMakeSel=document.getElementById("meterMake");
                meterMake=meterMakeSel.options[meterMakeSel.selectedIndex].value;
                meterLocSel=document.getElementById("meterLoc");
                meterLoc=meterLocSel.options[meterLocSel.selectedIndex].value;
                meterCTR=document.getElementById("meterCTR").value;
                meterPTR=document.getElementById("meterPTR").value;
                adoptedCTR=document.getElementById("adoptedCTR").value;
                adoptedPTR=document.getElementById("adoptedPTR").value;
                accuracy=document.getElementById("accuracy").value;
                meterType=document.getElementById("meterType").value;
                mf=document.getElementById("mf").value;
                modem_Serial_No=document.getElementById("modem_Serial_No").value;
                locationCode=document.getElementById("locationCode").value;
                consumerId=document.getElementById("consumerId").value;
                
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/updateMeterAction.jsp?meterid="+escape(meterId)+"&meterMake="+escape(meterMake)+"&meterLoc="+escape(meterLoc)
                    +"&meterCTR="+escape(meterCTR)+"&meterPTR="+escape(meterPTR)+"&adoptedCTR="+escape(adoptedCTR)+"&adoptedPTR="+escape(adoptedPTR)
                    +"&accuracy="+escape(accuracy)+"&meterType="+escape(meterType)
                    +"&mf="+escape(mf)+"&modem_Serial_No="+escape(modem_Serial_No)+"&locationCode="+escape(locationCode)+"&consumerId="+escape(consumerId);
                //alert(url);
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function changeMeterInfo()
            {

               var meterno = document.getElementById("meterno");
                var cc = document.getElementById("cc").value;
                
                var replacedmeter  = document.getElementById("replacedmeter").value;
               
                var metertext = $( "#meterno option:selected" ).text().trim();
                
               
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/changeMeter.jsp?meterno="+escape(metertext)+"&replacedmeter="+escape(replacedmeter)+"&cc="+cc;
                       
                //alert(url);
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);

            }
            function activityAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    
                    document.getElementById("updateDataPart").style.display="display";
                    document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }//end method
            function getmeterdetails(meterId)
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }                
                var url="meterDetails.jsp?meter_id="+escape(meterId);        
                xmlHttp.onreadystatechange=oldMeterAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function oldMeterAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    meterdata=xmlHttp.responseText;
                    var  data=new Array();
                    data= meterdata.split(",");
                    document.getElementById("meterMake").value=data[1];
                    document.getElementById("meterLoc").value=data[2];
                    document.getElementById("meterCTR").value=data[3];
                    document.getElementById("meterPTR").value=data[4];
                    document.getElementById("adoptedCTR").value=data[5];
                    document.getElementById("adoptedPTR").value=data[6];
                    document.getElementById("accuracy").value=data[7];
                    document.getElementById("mf").value=data[8];
                    document.getElementById("meterType").value=data[9];
                    document.getElementById("modem_Serial_No").value=data[10];
                    document.getElementById("locationCode").value=data[11];
                    document.getElementById("consumerId").value=data[12];

          
                       
                }//end if
            }

			function getDetailsFromWS(consumercode){
                
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }                
                var url="getDetailsFromWS.jsp?consumercode="+escape(consumercode);
                
                xmlHttp.onreadystatechange=getDetailsFromWSAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function getDetailsFromWSAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    var meterdata=xmlHttp.responseText;
                  //alert(meterdata);  
                    var  data=new Array();
                    data= meterdata.split(",");
                    
                    document.getElementById("cc").value=data[0];
                    document.getElementById("cname").value=data[1];
                    document.getElementById("addr1").value=data[2];
                    document.getElementById("addr2").value=data[3];
                    document.getElementById("load").value=data[4];
                    document.getElementById("sdo").value=data[5];
                    document.getElementById("feeder").value=data[6];
                    
                       
                }//end if
            }
        </script>





    </head>
    <body onload="viewMeter();">
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Meter Management</b>
                            </td>
                        </tr>

                    </table>
                    <br/>
                    <%@ include file="meterManage_links.jsp"%>




                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br/>
                    <div class="tab-box" >
                        <%
                            if (session.getAttribute("user_type").equals("Administrator")) {
                        %>
                        <a href="javascript:;" class="tabLink " id="cont-1">Add</a>
                        <a href="javascript:;" class="tabLink " id="cont-2">Modify</a>
                        <a href="javascript:;" class="tabLink " id="cont-3">Delete</a>
                        <% } else {
                            }%>
                        <a href="javascript:;" class="tabLink activeLink" id="cont-4">View</a>
                        <a href="javascript:;" class="tabLink" id="cont-5">Meter Change Summary</a>

                    </div>
                    <div id="updateDataPart" align="center">

                    </div>
                    <div class="tabcontent paddingAll" id="cont-1-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-2-1"></div>
                    <div class="tabcontent paddingAll hide" id="cont-3-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-4-1"> </div>

                    <div id="DataPart" align="center"> </div>



                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
        <div id="loading" style="display: none">
    <table width="100%"><tr><td align="center">
    <img src="./images/loading.jpg"/>
            </td></tr></table>
</div>
</html>