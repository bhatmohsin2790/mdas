<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
    <%@ page contentType="" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
    <head>

        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>
        <script type="text/javascript" src="load_survay_graphs.js"></script>
        <script type="text/javascript" src="jquery.min.js"></script>
        <script type="text/javascript" src="highcharts.js"></script>
        <script type="text/javascript" src="exporting.js"></script>

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
                    <%@ include file="side_drop_down_for_data_reports.jsp"%>

                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">


                            </td>
                        </tr>

                    </table>


                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>

                    <div id="submenu" style="float:left;display:none;width: 100%;">
                        <%@ include file="reports_menu.jsp"%>
                    </div>
                    <div id="report_header" style="float:left;display:none;width:100%;">

                    </div><br/>
                    <div id="DataPart"  style="float:left;display:none;width: 100%;" ></div>
                    <div id="home_msg">
                        <p><b>Welcome</b></p>
                        <img src="images/home_right.gif" align="right" style="padding-top:0px;padding-left:10px;padding-bottom:5px;"/>
                        <p>The consumers are broadly classified into LT and HT/EHT consumers. As per the supply code governing the distribution of Electricity, consumers who receive power at 11KV and above are classified as HT/EHT consumers. The HT/EHT consumer meters are presently read manually and data is transmitted to the corporate office where bills are prepared and mailed to them.</p>

                        <p>Our system automates the process of reading meter data, demand rising, from HT/EHT consumers. AMI proposes their Automated Meter Reading and web enabled services for the HT/EHT consumers.</p>

                        <p>The proposed system is capable of acquiring data from intelligent meters located at the suppliers premises, convert the data into common data structure, transmit the data securely to a central server, revalidate the data at the central server, aggregate the data to historical data available at the server, generate various reports using the collected data, give directions based on transactions made by the system and the analysis of data and provide the reports to specified persons.</p>
                    </div>
                    <%--<div id="graphPart"  style="overflow: scroll;width:1000px; height:450px;display:none" ></div> --%>

                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
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