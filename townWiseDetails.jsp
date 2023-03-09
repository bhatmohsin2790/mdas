<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.sql.*" errorPage="" %>
    <head>

        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>
        <script type="text/javascript" src="jquery.min.js"></script>
        <script type="text/javascript" src="highcharts.js"></script>
        <script type="text/javascript" src="date-picker.js"></script>
        <!--Import part -->
        <script type="text/javascript">
            
        </script>

    </head>
    <body>
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 >
            <%@ include file="top.jsp"%>
            <tr><td  style="height:1px;background-color:  #9624AB;"></td></tr>
            <tr>
                
                <td  align="center" ><h3 ><font color="  #9624AB"> AMR Meter Reports</font></h3></td></tr>
            <tr>
                <td >

                    <%@ include file="sidetownWiseDetails.jsp"%>

                </td></tr>
                    <tr><td  style="height:1px;background-color:#ddd;"></td></tr>
                    <tr>
                    <td>
                        <div id="DataPart" style="overflow:scroll;width:100%;height:400px;visibility:hidden"align="center"   ></div>
                    </td>


            </tr>


        </table>

        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>