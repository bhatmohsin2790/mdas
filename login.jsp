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
                <td class="header" colspan=3>
                    <%@include file="header.jsp" %>
                </td>
            </tr>

            <tr>
                <td class="body_left"></td>
                <td class="body_center">

                    <table border="0" width="100%">
                    <tr>
                        <td style="padding-top:20px;padding-left:10px;padding-right:20px;padding-bottom:10px;">
                            <p> The consumers are broadly classified into LT and HT/EHT consumers. As per the supply code governing the distribution of Electricity, consumers who receive power at 11KV and above are classified as HT/EHT consumers. The HT/EHT consumer meters are presently read manually and data is transmitted to the corporate office where bills are prepared and mailed to them.</p>
                            <p>Our system automates the process of reading meter data, demand rising, from HT/EHT consumers. AMI proposes their Automated Meter Reading and web enabled services for the HT/EHT consumers. </p>
                            <p>The proposed system is capable of acquiring data from intelligent meters located at the suppliers premises, convert the data into common data structure, transmit the data securely to a central server, revalidate the data at the central server, aggregate the data to historical data available at the server, generate various reports using the collected data, give directions based on transactions made by the system and the analysis of data and provide the reports to specified persons. </p>
                        </td>
                        <td valign="top" style="padding-top:20px;">
                            <html:form action="Login.do" method="POST">
                            <div style="width: 268px;  -moz-border-radius: 6px 6px 6px 6px; -moz-box-shadow: 0 1px 6px #E4E4E4;
                            border: 1px solid #D9E7FE;
                            float: left;
                            padding: 12px 20px 12px 12px;">
                            <table cellspacing="3" cellpadding="1" border="0" align="center" width="268" style="font-family: Arial; font-size: 12px;">
                            <tbody>
                            <tr>
                                <td height="25px" valign="top" colspan="3"  align="left"><strong><font style=" -moz-border-radius: 2px 2px 2px 2px;-moz-box-shadow: 0 5px 6px #E4E4E4;border: 1px solid #D47EFF;padding: 2px 2px 2px 2px;letter-spacing:2px;">MDAS LOGIN</font></strong></td>
                            </tr>
                            <tr>
                                <td align="center" valign="bottom" style="border-bottom: 1px solid rgb(204, 204, 204);color:red;" colspan="3"><html:errors /></td>
                            </tr>
                            <tr>
                                <td height="30px"><strong>User ID</strong></td><td><strong> : </strong></td>
                                <td><html:text property="userid" size="15" maxlength="30"  style=" -moz-border-radius: 6px 6px 6px 6px;-moz-box-shadow: 0 5px 6px #E4E4E4;border: 1px solid #D47EFF;padding: 2px 2px 2px 2px;"/></td>
                            </tr>
                            <tr>
                                <td height="30px"><strong>Password</strong></td><td><strong> : </strong></td>
                                <td><html:password property="password" size="15" maxlength="30"  style=" -moz-border-radius: 6px 6px 6px 6px;-moz-box-shadow: 0 5px 6px #E4E4E4;border: 1px solid #D47EFF;padding: 2px 2px 2px 2px;"/></td>
                            </tr>
                            <tr>
                                <td height="30px">&nbsp;</td>
                                <td align="right" colspan="2" style="padding-right: 20px;">
                                    <html:submit style=" -moz-border-radius: 6px 6px 6px 6px;-moz-box-shadow: 0 5px 6px #D9E7FE;border: 1px solid #D47EFF;padding: 2px 2px 2px 2px;letter-spacing:1px;">Login</html:submit></td>
                            </tr>
                            </tbody>
                            </table>
                            </div>
                            </html:form>
                        </td>
                    </tr>
                    </table>
                </td>
                <td class="body_right">
                </td>
            </tr>

            <tr>
                <td class="bottom" colspan=3>
                    <%@include file="footer.jsp" %>
                </td>
            </tr>
            </table>
  </div>
 </div>
</body>
</html>