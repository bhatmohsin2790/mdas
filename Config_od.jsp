<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>
        <script type="text/javascript" src="admin_send_sms.js"></script>   
        <script type="text/javascript" src="Ondemand/ondemand.js"></script>   
    <!--<script type="text/javascript" src="js/IP_ondemand.js"></script> -->
        <%@ page import="java.sql.*" %>
         
        
    </head>
    <body>
        <div id="navigation"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing='0' style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width='0' valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center"></td>
                <td width='14px' style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width='98%' style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                   

                    <%@ include file="config_tabs.jsp"%>   
                    <div id="report_part" style="margin-top: 1%;margin-left: 2%;margin-right: 2%;border:1px solid #87CEEB;min-height:200px;overflow:auto;"></div> 

                    <div id="loading" style="display: none;">
                        <center>
                            <h3 style="padding-top: 5px;">Sending On-Demand</h3>
                           <img src="./images/ODloader.gif"/> 
                        </center>
                    </div>
                    <br></br>
                    <br></br>
                </td>
                <td width='13px' style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>