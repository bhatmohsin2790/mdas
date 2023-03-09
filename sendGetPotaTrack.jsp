<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>
        <!--Import part -->
        <%@ include file="importpage.jsp"%>
        <%@ page import="java.sql.*" %>
     
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
                                  <b>CONFIG / POTA Tracking</b>

                            </td>
                        </tr>

                    </table>
                   
                    <%@ include file="side_configurations.jsp"%>

                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                  

                        <%@ include file="configurationReports_1.jsp"%>
                        
                        <br></br><br></br><br></br>
                        <div id="DataPart" align="center">

                        </div>


                    <div id="home_msg">

                    </div>

                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>