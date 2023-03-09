<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
    <%@ page contentType="" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
    <head>
        <style>
           #feederstatus td
            {
                
                padding: 0.1em 0.1em 0.1em 0.5em;
                 text-align: left;
            }
            </style>

        <script type="text/javascript" src="jquery.js"></script>
        
        <script type="text/javascript" src="jquery.min.js"></script>
        <script type="text/javascript" src="highcharts.js"></script>
        <script type="text/javascript" src="exporting.js"></script>
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
                            return null;
                        }
                    }
                    return xmlHttp;
                }//GetXmlHttpObject
                function showScreen(ss_id)
                {
                    
                        xmlHttp=GetXmlHttpObject();
                        if (xmlHttp==null)
                        {
                            alert ("Browser does not support HTTP Request");
                            return;
                        }
                        var url="feederStatusScreen.jsp?ss_id="+ss_id;
                        
                        xmlHttp.onreadystatechange=showScreenAction;
                        xmlHttp.open("GET",url,true);
                        xmlHttp.send(null);
                }
                function showScreenAction()
                {
                     if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                        {

                            var showdata = xmlHttp.responseText;
                            document.getElementById('DataPart').style.display = "block";
                            document.getElementById("DataPart").innerHTML=showdata;
                        }
                }
        </script>
        <!--Import part -->
        <%@ include file="importpage.jsp"%>


    </head>
    <body>
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:20px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="color:#ffffff;font-size:12px;letter-spacing:1px;" valign="bottom" align="center">

                                <b> METER SELECTION</b>
                            </td>
                        </tr>

                    </table>
                    <%@ include file="side_feeder_status.jsp"%>

                    


                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>

                    
                    <div id="DataPart"  align="center"style="display:none;width: 100%;padding-top:25px;padding-left:25px" ></div>
                    

                </td>
                
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>
<script>
    document.getElementById("instant_compl_div").style.width = window.screen.width;
    alert(document.getElementById("instant_compl_div").style.width);
</script>
    </body>
</html>