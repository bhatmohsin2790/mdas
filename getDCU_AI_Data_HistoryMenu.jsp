<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<form name="dcuDi" action="">
    <%
        try {
            String dcu_id = request.getParameter("dcu_id");
    %>
    <div id="box_style" style="border: 1px solid #A1A1A1;
         background: #FFFFFF;
         width:auto;
         height:auto;
         margin: 5px;
         float:left;
         display: block;
         -moz-border-radius: 5px;
         -webkit-border-radius: 5px;
         border-radius: 5px;
         -moz-box-shadow: 0 6px 10px #A1A1A1;
         -webkit-box-shadow: 0 6px 10px #A1A1A1;">
        <table border="0" align="left">
            <tr>
                <td>Enter From Date &amp; Time :</td>
                <td>
                    <input type="text" id="fromdate" name="fromdate" size="10" />

                    <a href="javascript:show_calendar('dcuDi.fromdate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
                    <input type="text" id="fromtime" size="4" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td><font color="red">(dd-mm-yyyy)</font>&nbsp;&nbsp; &nbsp;&nbsp;
                    <font color="red">(HH:mm)</font></td>
            </tr>
            <tr>
                <td>Enter To Date &amp; Time :</td>
                <td>
                    <input type="text" id="todate" size="10" />
                    <a href="javascript:show_calendar('dcuDi.todate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
                    <input type="text" id="totime" size="4" />
                </td>
                <td><input type="button" value="Get Data" onclick="getHistory_AI()" /></td>
            </tr>
        </table></div>
    <div id="DataPart2"  align="center" style="background:#FFFFFF;clear:both;">
        DCU Reports Home Page.
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</form>