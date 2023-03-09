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
            function showDayWiseDetails()
            {
                
                xmlHttp=GetXmlHttpObject();
                 if (xmlHttp==null)
                {
                         alert ("Browser does not support HTTP Request");
                         return;
                 }
                 
                 discom=document.getElementById("discom").options[document.getElementById('discom').selectedIndex].value
                 zone=document.getElementById("zone").options[document.getElementById('zone').selectedIndex].value
                 
                 circle=document.getElementById("circle").options[document.getElementById('circle').selectedIndex].value
                
                 division=document.getElementById("division").options[document.getElementById('division').selectedIndex].value
                 subdiv=document.getElementById("subdivision").options[document.getElementById('subdivision').selectedIndex].value
                 section=document.getElementById("section").options[document.getElementById('section').selectedIndex].value
                 subs=document.getElementById("substation").options[document.getElementById('substation').selectedIndex].value
                 feeder=document.getElementById("feeder").options[document.getElementById('feeder').selectedIndex].value
                 date=document.getElementById("startingDate").value;
                 
                 var url="getDayWiseDetails.jsp?discom="+escape(discom)+"&zone="+escape(zone)+"&circle="+escape(circle)+"&division="+escape(division)+"&subdiv="+escape(subdiv)+"&section="+escape(section)+"&substation="+escape(subs)+"&feeder="+escape(feeder)+"&date="+escape(date)+"";
			//alert("url is"+url);

			xmlHttp.onreadystatechange=showDetailsAction;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);
                 
            }
            function showDetailsAction()
            {
                 

   
    document.getElementById('DataPart').style.display = "block";
    
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        document.getElementById('DataPart').style.visibility="visible";
        document.getElementById("DataPart").innerHTML= showdata;
    }
            }
        </script>

    </head>
    <body>
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 >
            <%@ include file="top.jsp"%>
            <tr>
                <td colspan="2" align="center" ><h3 >AMR Daywise Meter Reports</h3></td></tr>
            <tr>
                <td>
                   
                    <%@ include file="sidedayWiseDetails.jsp"%>

                </td>
                    <td>
                        <div id="DataPart" style="overflow:scroll;width:300px;height:400px;visibility:hidden"align="center"   ></div>
                    </td>
               
                
            </tr>


        </table>
                     
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>