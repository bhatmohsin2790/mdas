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
<link rel="stylesheet" type="text/css" href="css/table.css" />
        <style type="">
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
                       addModem();
                    if(tabeId=="cont-2")
                       editModem();
                    if(tabeId=="cont-3")
                       delModem();
                   if(tabeId=="cont-4")
                       viewModem();               
                        return false;
                    });
                });
            });

        </script>
       

        <!--  Modem information insertion  -->
        <script type="text/javascript">
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
           
            function addModem()
            {
                    xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="addModemData.jsp";
                 xmlHttp.onreadystatechange=commonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
             function editModem()
            {
                    xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="updateModem.jsp";
                 xmlHttp.onreadystatechange=commonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
             function delModem()
            {
                    xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="deleteModem.jsp";
                 xmlHttp.onreadystatechange=commonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
             function viewModem()
            {
                 xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/viewModemAction.jsp?start=1";
                 xmlHttp.onreadystatechange=commonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
          
            function viewModemData(start)
            {
                   xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/viewModemAction.jsp?start="+escape(start);
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

            function insertModem(){                
                modem_serial_no=document.getElementById("modem_serial_no").value;
                imei_no=document.getElementById("imei_no").value;
                mobile_no=document.getElementById("mobile_no").value;
                static_ip=document.getElementById("static_ip").value;
               // is_dcuSel=document.getElementById("is_dcu");
              //  is_dcu=is_dcuSel.options[is_dcuSel.selectedIndex].value;                          

                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/addModemAction.jsp?modem_serial_no="+escape(modem_serial_no) +"&mobile_no="+escape(mobile_no)+"&imei_no="+escape(imei_no)+"&static_ip="+escape(static_ip);
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }//end method
            function deleteModem()
            {
                modemSel=document.getElementById("ModemId").selectedIndex;
                modemId=document.getElementById("ModemId").options[modemSel].value;

                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/deleteModemAction.jsp?modem_id="+escape(modemId);                
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);                
            }
              function updateModem()
            {
                modemSel=document.getElementById("ModemId").selectedIndex;
                modemId=document.getElementById("ModemId").options[modemSel].value;
                
                modemSerialNo=document.getElementById("Modem_serial_no").value;
                mobileNo=document.getElementById("Mobile_no").value;
                imei_no=document.getElementById("imei_no").value;
                static_ip=document.getElementById("static_ip").value;

                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/updateModemAction.jsp?modem_id="+escape(modemId)+"&modemSerialNo="+escape(modemSerialNo)+"&mobileNo="+escape(mobileNo)+"&imei_no="+escape(imei_no)+"&static_ip="+escape(static_ip);
                
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);                
            }
            function activityAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").style.display="displsy";
                    document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }//end method    
           function getModemData(modemId)
           {
               xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="getModemsData.jsp?modem_id="+escape(modemId);                
                xmlHttp.onreadystatechange=getModemDataAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);    
           }
           function getModemDataAction()
           {
               if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    var result=xmlHttp.responseText;
                   document.getElementById("Modem_serial_no").value=result.split(",")[1];
                   document.getElementById("Mobile_no").value=result.split(",")[2];
                   document.getElementById("imei_no").value=result.split(",")[3];
                   document.getElementById("static_ip").value=result.split(",")[4];
                }//end if
               
           }


        </script>
    </head>
        <body onload="viewModem();">
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
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
                        <a href="javascript:;" class="tabLink " id="cont-1">Add</a>
                        <a href="javascript:;" class="tabLink " id="cont-2">Modify</a>
                        <a href="javascript:;" class="tabLink " id="cont-3">Delete</a>
                        <% }else{} %>
                        <a href="javascript:;" class="tabLink activeLink" id="cont-4">View</a>

                    </div>
                    <div id="updateDataPart" align="center"> </div>
                    
                    <div id="DataPart" align="center" class="table-responsive"> </div>
                    
                     <div class="tabcontent paddingAll" id="cont-1-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-2-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-3-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-4-1"> </div>
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