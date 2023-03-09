<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
    <head>

        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>
        
       
        <!--Import part -->
        <%@ include file="importpage.jsp"%>
        <%@page import="java.io.*"%>
        <script type="text/javascript">
            window.onload=discomPage;
                    function discomPage()
                    {
                         xmlHttp=GetXmlHttpObject();
                                     if (xmlHttp==null)
                                     {
                                         alert ("Browser does not support HTTP Request");
                                               return;
                                      }
                                      var url="discomScreen.jsp"
                                        xmlHttp.onreadystatechange=discomPageAction;
                                        xmlHttp.open("GET",url,true);
                                        xmlHttp.send(null);
                    }
                    function discomPageAction()
                    {
                        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                              {
                                        
                                          document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                               }
                    }
                    function getDashBoard()
                    {
                        xmlHttp=GetXmlHttpObject();
                                     if (xmlHttp==null)
                                     {
                                         alert ("Browser does not support HTTP Request");
                                               return;
                                      }
                                      var url="dashBoardScreen.jsp"
                                        xmlHttp.onreadystatechange=getDashBoardAction;
                                        xmlHttp.open("GET",url,true);
                                        xmlHttp.send(null);
                    }
                    function getDashBoardAction()
                    {
                        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                              {

                                          document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                               }
                    }
                    function callme()
                    {
                        
                        window.open('meterComFail.jsp','','width=350,height=450,menubar=1,status=1,scrollbars=1,left=300,top=120');
                    }
                    
                 </script>
        
        
        
    


    </head>
    <body>
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=500px valign="top" style="padding-left:0px;padding-top:0px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Dash Board</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="side_dashBoard.jsp"%>

                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    
                    <br></br>


                    
                    <div id="DataPart"  >
                        
                    </div>



                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>

        