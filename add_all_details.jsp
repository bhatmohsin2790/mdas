<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="pragma" content="-1" />

        <script type="text/javascript" src="jquery.js"></script>

        <!--Import part -->
        <%@ include file="importpage.jsp"%>
        <%@page import="java.io.*"%>   
        <script type="text/javascript">
            function getdetailsPage()
            {
                  
            }
            function addDetails()
            {                              
                document.getElementById("dtrcheck").style.visibility="visible";
                var dtrname=document.getElementById("location").value;                
                dtrcapacity=document.getElementById("capacity").value;                                                                              
                meterSlNo=document.getElementById("meter_slno").value;                  
                metermake=document.getElementById("meterMake").value;                  
                meterlocation=document.getElementById("meterLoc").value;                 
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                                
                var url="add_details.jsp?feederid="+escape(feederid)+"&dtrname="+escape(dtrname)+"&dtrcapacity="+escape(dtrcapacity)+"&modemSlNo="+escape(modemSlNo)+"&mobile="+escape(mobile)+"&meterSlNo="+escape(meterSlNo)+"&metermake="+escape(metermake)+"&meterlocation="+escape(meterlocation);
                                
                xmlHttp.onreadystatechange=addDetailsAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function addDetailsAction()
            {
                  
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    showdata = xmlHttp.responseText;
                 
                    if(showdata.indexOf('$')==3)
                    {
                        alert("All details are available for this meter if u want to update just click on the update button");
                        document.getElementById("UpdateDataPart").innerHTML= showdata;
                        document.getElementById("update").style.visibility="visible";
                        document.getElementById("dtrcheck").style.visibility="hidden";
                    }
                    else
                    {
                        document.getElementById("UpdateDataPart").innerHTML= showdata;
                        document.getElementById("dtrcheck").style.visibility="hidden";
                    }
                }
            }
            function checkdtr()
            {
                dtrname=document.getElementById("location").value;
                if(dtrname=="")
                {
                    alert("please enter dtr name");
                    document.getElementById("location").focus();
                }
                       
            }
              
            function checklocation()
            {
                  
                feederid=document.getElementById("feeder").value;
                  
                if(feederid==-1)
                {
                    alert("please select feeder");
                }
            }
            function checkmodem()
            {
                modemSlNo=document.getElementById("modem_slno").value;
                if(modemSlNo.length<8)
                {
                    alert("modem Serial no should  be 8 nos");
                    document.getElementById("modem_slno").focus();
                }
            }
            function checkmobile()
            {
                mobile=document.getElementById("mobileno").value;
                if(mobile.length<10)
                {
                    alert("mobile number should  be l 10 nos");
                    document.getElementById("mobileno").focus();
                }
            }
            function clearDetails()
            {
                document.getElementById("UpdateDataPart").innerHTML="";
                document.getElementById("location").value='';
                document.getElementById("capacity").value='';
                document.getElementById("modem_slno").value='';
                document.getElementById("mobileno").value='';
                document.getElementById("meter_slno").value='';
                document.getElementById("meterMake").value=-1;
                document.getElementById("meterLoc").value=-1;
                document.getElementById("check").style.visibility="hidden";
                document.getElementById("dtrcheck").style.visibility="hidden";
            }
            function updateDetails()
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }

                var url="update_details.jsp?feederid="+escape(feederid)+"&dtrname="+escape(dtrname)+"&dtrcapacity="+escape(dtrcapacity)+"&modemSlNo="+escape(modemSlNo)+"&mobile="+escape(mobile)+"&meterSlNo="+escape(meterSlNo)+"&metermake="+escape(metermake)+"&meterlocation="+escape(meterlocation);
                                
                xmlHttp.onreadystatechange=updateDetailsAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function updateDetailsAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    showdata = xmlHttp.responseText;
                    document.getElementById("UpdateDataPart").innerHTML= showdata;
                    document.getElementById("update").style.visibility="hidden";
                   
                }
            }
            function GetXmlHttpObject()
            {
                var xmlHttp=null;
                try
                {
                    // Firefox, Opera 8.0+, Safari
                    xmlHttp=new XMLHttpRequest();
                }
                catch (e)
                {
                    //Internet Explorer
                    try
                    {
                        xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
                    }
                    catch (e)
                    {
                        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
                    }
                }
                return xmlHttp;
            }//GetXmlHttpObject
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

                                <b>Select Feeder</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="side_alldetails.jsp"%>

                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>                    
                    <div id="UpdateDataPart"  align="center"></div>
                    <div id="ProgressPart"  align="center">

                        <img src="images/progress.gif"id="dtrcheck" style="visibility:hidden"/></div>
                    <div id="DataPart"  align="center" >
                        <table align="center" bgcolor="#E0ECF5" cellpadding="5" cellspacing="5">
                            <tr><th colspan="4"><h2>ADD Meter details</h2></th></tr>
                            <tr>
                                <td>Dtr LocationName:</td>
                                <td colspan="3"><input type="text" name="location" id="location" onclick="checklocation();"/>

                                </td>
                            </tr>

                            <tr>
                                <td>Dtr Capacity:</td>
                                <td colspan="3"><input type="text" name="capacity" id="capacity" onselect="checkdtr();"onclick="checkdtr();"/></td>
                            </tr>
                            <tr>
                                <td>Modem SlNo:</td>
                                <td colspan="3"><input type="text" name="modem" id="modem_slno" /></td>
                            </tr>
                            <tr>
                                <td>Mobile No:</td>
                                <td colspan="3"><input type="text" name="mobile" id="mobileno" onselect="checkmodem();" onclick="checkmodem();"/></td>
                            </tr>
                            <tr>
                                <td>Meter SlNo:</td>
                                <td colspan="3"><input type="text" name="meter" id="meter_slno" onselect="checkmobile();" onclick="checkmobile();"/></td>
                            </tr>
                            <tr><td>
                                    METERMAKE:</td><td colspan="3">
                                    <select name="meterMake" id="meterMake" style="width: 200px;">

                                        <option value="-1">Select Metermake</option>
                                        <%
                                            con = new DBUtil().getConnection();

                                            try {
                                                pstmt = con.prepareStatement("select * from metermake");
                                                rs = pstmt.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString("metermakeid")%>"><%=rs.getString("metermakename")%></option>
                                        <%
                                                }

                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                con.close();
                                            }
                                        %>
                                    </select></td></tr>
                            <tr>
                                <td>
                                    METERLOCATION:</td><td colspan="3">
                                    <select name="meterLoc" id="meterLoc" style="width: 200px;">
                                        <option value="-1">Select MeterLocation</option>
                                        <%
                                            con = new DBUtil().getConnection();

                                            try {
                                                pstmt = con.prepareStatement("select * from meterlocation");
                                                rs = pstmt.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getString("locationid")%>"><%=rs.getString("locationname")%></option>
                                        <%
                                                }

                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            } finally {
                                                con.close();
                                            }
                                        %>

                                    </select></td></tr>
                            <tr>
                                <td></td>

                                <td><input type="button" value="add " onclick="addDetails()"/></td>
                                <td><input type="button" value="reset" onclick="clearDetails()"/></td>
                                <td><input type="button" value="update " id="update" onclick="updateDetails()" style="visibility:hidden"/></td>
                            </tr>

                            <tr>
                                <td colspan="2">Note:Please dont enter single quote in dtr location name</td>

                                <td></td>
                                <td></td>
                            </tr>
                            <tr>

                                <td colspan="2">Note:click reset every time, while inserting new meter details</td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                    </div>


                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>

