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

function commonAction()
{
        document.getElementById('home_msg').innerHTML = "";
        document.getElementById("updateDataPart").innerHTML="";
       document.getElementById("DataPart").innerHTML=document.getElementById("loading").innerHTML;
     if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete")
     {
        var showData1=xmlHttp.responseText;
        document.getElementById("DataPart").innerHTML=showData1;
        $('#dtable').DataTable();
     }
}//end method                      
        </script>
    </head>
    <body onload="substationData(4);">
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">
                             <b>You are in Electric Hierarchy</b>
                                
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="master_links.jsp"%>

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
                    <br/>

                        <%@ include file="electric_tree_tabs.jsp"%>
                              <br/>
                            
                                         
                         <div id="updateDataPart" style="position:absolute;top:230px;left:600px">

                        </div>
                    <div id="DataPart"  align="center" class="table-responsive"></div>
                    <div id="home_msg">
                        <p><h3 align="center">Electric Level Hierarchy</h3></p>
                    </div>

                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
	<div id="loading" style="display: none">
    <table width="100%"><tr><td align="center">
    <img src="./images/loading.jpg"/>
            </td></tr></table>
</div>
</html>
