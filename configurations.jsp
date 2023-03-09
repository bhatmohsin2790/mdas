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
            showPage(value)
            {
                alert("selectd"+value);
            }
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

                                <b>Configurations</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="config_links.jsp"%>




                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>




                    <div id="DataPart" style="float:left;display:none;width: 100%;"></div>
                    <div id="">
                        <br/><br/><br/>
                        <p>
                            <h2 align="center">Please select Configuration Options from left Side Window.</h2>
                            <br/><br/>
                            <h3 align="center">Based on your privileges options are displayed.</h3>
                            <br/>
                            <h3 align="center">Here We can Configure ON Demand & Pota Configuration Settings for the Modem.</h3>
                        </p>
                    </div>

                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>