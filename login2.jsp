<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link rel="stylesheet" type="text/css" href="style/styles.css" />
        <title>Meter Data Acquisition System</title>
    </head>
    <body>
        <div id="total_main" align="center">
            <div id="total_main2">
                <table width=100% border=0 cellpadding=0 cellspacing=0>
                    <tr>
                        <td class="header" colspan=4>

                            <table width="100%" border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;color:#FFFFFF;background:url(images/body.png)">
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
                        <table> <tr>
                                <td style="padding-top:40px;padding-left: 15px;"><img src="images/login_icon.gif" align="center" height="150px"></td>
                                <td style="padding-top:40px;padding-left: 100px;">

                                    <html:form action="Login.do" method="POST">
                                        <div style="width:400px;height:150px;-webkit-border-radius: 59px 53px 61px 43px;-moz-border-radius: 59px 53px 61px 43px;border-radius: 59px 53px 61px 43px;border:1px solid #1420BD;background:rgba(220,227,227,0.8);-webkit-box-shadow: #B3B3B3 7px 7px 7px;-moz-box-shadow: #B3B3B3 7px 7px 7px; box-shadow: #B3B3B3 7px 7px 7px;">
                                            <div style="padding-left: 45px"><table cellspacing="3" cellpadding="1" border="0" align="center" width="268" style="font-family: Arial; font-size: 12px;">
                                                    <tbody>
                                                        <tr>
                                                            <td height="25px" valign="top" colspan="3"  align="left"> LOGIN</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center" valign="bottom" style="border-bottom: 1px solid rgb(204, 204, 204);color:red;" colspan="3"><html:errors /></td>
                                                        </tr>
                                                        <tr>
                                                            <td height="30px"><strong>User Name</strong></td><td><strong> : </strong></td>
                                                            <td><html:text property="userid" size="15" maxlength="30" style="border:1px solid #a8a8ef;-moz-border-radius: 10px;-webkit-border-radius: 10px;-moz-box-shadow: 0 1px 6px #E4E4E4;-webkit-box-shadow: 0 1px 6px #E4E4E4;border-radius: 10px;padding-right: 5px;padding-left: 5px;" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td height="30px"><strong>Password</strong></td><td><strong> : </strong></td>
                                                            <td><html:password property="password" size="15" maxlength="30" style="border:1px solid #a8a8ef;-moz-border-radius: 10px;-webkit-border-radius: 10px;-moz-box-shadow: 0 1px 6px #E4E4E4;-webkit-box-shadow: 0 1px 6px #E4E4E4;border-radius: 10px;padding-right: 5px;padding-left: 5px;" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td height="30px">&nbsp;</td>
                                                            <td align="right" colspan="2" style="padding-right: 20px;">
                                                                <html:submit style="border:1px solid #a8a8ef;-moz-border-radius: 10px;-webkit-border-radius: 10px;-moz-box-shadow: 0 1px 6px #E4E4E4;-webkit-box-shadow: 0 1px 6px #E4E4E4;border-radius: 10px;padding-right: 5px;padding-left: 5px;">Login</html:submit></td>
                                                            </tr>
                                                        </tbody>
                                                    </table></div>
                                            </div>
                                    </html:form></td>
                            </tr></table>


                        </div>
                        <%@include file="footer.jsp" %>
                        </div>
                        </body>
                        </html>