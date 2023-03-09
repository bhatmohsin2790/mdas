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
                            addMake();
                         if(tabeId=="cont-2")
                            editMake();
                         if(tabeId=="cont-3")
                            delMake();
                         if(tabeId=="cont-4")
                            viewMake();
                        return false;
                    });
                });
            });

        </script>
        <!-- Metermake Action -->

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
             function addMake()
             {
                  xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="addMeterMakeData.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
             }
              function editMake()
             {
                  xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="updateMeterMake.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
             }
              function delMake()
             {
                  xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="deleteMeterMake.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
             }
              function viewMake()
             {
                  xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/viewMetermakeAction.jsp";
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
            function insertMetermake(){
                metermakeId=document.getElementById("metermakeId").value;
                metermakeName=document.getElementById("metermakeName").value;
                meterSeries=document.getElementById("meterSeries").value;
                meterVersion=document.getElementById("meterVersion").value;
                noofParams=document.getElementById("noofParams").value;
                paramNames=document.getElementById("paramNames").value;
                b4_Tod_Params=document.getElementById("b4_Tod_Params").value;
                d4_Params=document.getElementById("d4_Params").value;
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/addMetermakeAction.jsp?metermakeId="+escape(metermakeId)+"&metermakeName="+escape(metermakeName)
                    +"&meterSeries="+escape(meterSeries)+"&meterVersion="+escape(meterVersion)+"&noofParams="+escape(noofParams)
                    +"&paramNames="+escape(paramNames)+"&b4_Tod_Params="+escape(b4_Tod_Params)+"&d4_Params="+escape(d4_Params);
                //alert(url);
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }//end method
          
            function deleteMetermake(){

                var metermakeId=document.getElementById("Metermake").value;                
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/deleteMetermakeAction.jsp?metermakeId="+escape(metermakeId);               
                xmlHttp.onreadystatechange=activityAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);

            }
          
            var xmlHttp = getHTTPRequestObject();
            function getMetermake() {
                var userNumber = document.getElementById("Metermakeid").value;               
                var url = "metermakeTag.jsp?metermakeid="+ userNumber;    
                 xmlHttp.onreadystatechange = getpage;
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }

            function getpage() {
                if (xmlHttp.readyState == 4) {
                    if (xmlHttp.status == 200) {
                       var result=xmlHttp.responseText;
                       result=result.split(",");                    
                        document.getElementById('MetermakeName').value =result[1];
                        document.getElementById('MeterSeries').value =result[2];
                        document.getElementById('MeterVersion').value =result[3];
                      //  document.getElementById('NoofParams').value = mmnoparams;
                       // document.getElementById('ParamNames').value = mmparamnames;
                      //  document.getElementById('B4_Tod_Params').value = mmb4params;
                      //  document.getElementById('D4_Params').value = mmd4params;
                    }
                }
            }

            function updateMetermake() {
                         
                var userNumber = document.getElementById("Metermakeid").value;
                metermakeName=document.getElementById("MetermakeName").value;
                meterSeries=document.getElementById("MeterSeries").value;
                meterVersion=document.getElementById("MeterVersion").value;
              //  noofParams=document.getElementById("NoofParams").value;
               // paramNames=document.getElementById("ParamNames").value;
                //b4_Tod_Params=document.getElementById("B4_Tod_Params").value;
               // d4_Params=document.getElementById("D4_Params").value;               
                var url = "meter_management_actions/updateMetermakeAction.jsp?metermakeid="+ escape(userNumber)+"&metermakeName="+escape(metermakeName)
                    +"&meterSeries="+escape(meterSeries)+"&meterVersion="+escape(meterVersion);            
                 xmlHttp.onreadystatechange = activityAction;     
                xmlHttp.open("GET", url, true);
                xmlHttp.send(null);
            }
              function activityAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").style.display="block";
                    document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }//end method
        </script>
    </head>
    <body onload="viewMake();">
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
                        <a href="javascript:;" class="tabLink activeLink " id="cont-4">View</a>

                    </div>
                    <div id="updateDataPart" align="center"> </div>
                    
                    <div class="tabcontent paddingAll" id="cont-1-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-2-1"></div>
                    <div class="tabcontent paddingAll hide" id="cont-3-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-4-1"></div>
                    
                          <div id="DataPart"  align="center" class="table-responsive"></div>

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