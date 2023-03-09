<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
    <head>
        <!--<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> -->
        <META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE"/>
        <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE"/>
        <META HTTP-EQUIV="EXPIRES" CONTENT="0"/>
        <link rel="stylesheet" type="text/css" href="style/styles.css" />
        <title>Meter Data Acquisition System</title>
        <script>
       
        </script>
    </head>
    <body>
        <%
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
            response.setDateHeader("Expires", 0);
            session.invalidate();
        %>
        <div id="total_main" align="center">
            <div id="total_main2">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td class="header" colspan='4'>

                            <table width="100%" border="0" cellpadding='0' cellspacing='0' style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;background:url(images/body.png)">
                                <tr>
                                    <td align="right">
                                        <img src="images/j&k.png" align="center" height="80px">
                                    </td>
                                    <td align="left" style="padding-top:0px;">
                                        <img src="images/mdas_title_1.png">
                                    </td>

                                </tr>

                            </table>
                        </td>
                    </tr> <tr >
                        <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                        <td style="background:url(images/bg-content-center.png);height: 30px"colspan="2" >Welcome</td>
                        <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
                        <table border="0"  width="300"  align="center" cellspacing="0">
                            <tr><td>&nbsp;</td></tr>


                            <tr ><td align="center" ><font  color="red">
                                        You Have Logged Out Successfully</td></font></tr><br><br>

                                    <tr><td align="center"><a href="<%=response.encodeRedirectURL("login2.jsp")%>"><u><font size ="3"color="black">Go to Login Page</a></u></font></td></tr>
                                    </b>

                                    <tr><td>&nbsp;</td></tr>
                                    <tr><td>&nbsp;</td></tr>
                                    </table>


                                    </div>
                                    <%@include file="footer.jsp" %>
                                    </div>
                                    </body>
                                    </html>
