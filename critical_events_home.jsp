<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <%@page import="in.amitech.db.DBUtil"%>
    <head>
        <script type="text/javascript" src="jquery.js"></script>
        <!--Import part -->
        <%@ include file="importpage.jsp"%>
        <style>
            .tab-box {
                border-bottom: 1px solid #DDD;
                padding-bottom:5px;
            }
            .tab-box a {
                border:1px solid #DDD;
                color:#666666;
                padding: 5px 15px;
                text-decoration:none;
                background-color: #eee;
                font-size:12px;
            }
            .tab-box a.activeLink {
                background-color: #fff;
                border-bottom: 0;
                padding: 6px 15px;
            }
            .tabcontent { border: 1px solid #ddd; border-top: 0;}
            .hide { display: none;}


        </style>
        <script type="text/javascript">
            $(document).ready(function() {
                $(".tabLink").each(function(){
                    $(this).click(function(){
                        tabeId = $(this).attr('id');
                        $(".tabLink").removeClass("activeLink");
                        $(this).addClass("activeLink");
                        $(".tabcontent").addClass("hide");
                        $("#"+tabeId+"-1").removeClass("hide")
                        if(tabeId=="cont-1")
                            addCriticalEvents();
                        if(tabeId=="cont-2")
                            updateCriticalEvents();
                        if(tabeId=="cont-3")
                        {//deleteCriticalEvents();
                            document.getElementById("DataPart").innerHTML="";
                            document.getElementById("emailid").value=-1;
                        }
                        if(tabeId=="cont-4")
                            viewCriticalEvents();
                        return false;
                    });
                });
            });

        </script>

        <!--  MeterData information insertion  -->
        <script type="text/javascript">
            function GetXmlHttpObject()
            {
                var xmlHttp=null;
                if (window.XMLHttpRequest) {
                    xmlHttp = new window.XMLHttpRequest;
                }
                else {
                    try {
                        xmlHttp = new ActiveXObject("MSXML2.XMLHTTP.3.0");
                    }
                    catch(ex) {
                        alert("Ajax is not Supported for Internet Explorer");
                        //return null;
                    }
                }
                return xmlHttp;
            }//GetXmlHttpObject
            function addCriticalEvents()
            {
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="addCriticalEvents.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function updateCriticalEvents(){
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="updateCriticalEvents.jsp";
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function deleteCriticalEvents(){
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                mailSel=document.getElementById("mailid");
                var mail=mailSel.options[mailSel.selectedIndex].value;                
                var url="deleteCriticalEvents.jsp?mailid="+escape(mail);
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null); 
            }
            function addEvents(){
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                } 
                var values=new Array();
                checkboxes = document.getElementsByName('R-Phase');
                for(var i=0;i < checkboxes.length;i++)
                {            if(checkboxes[i].checked ==true)
                    {                 
                        values=values+checkboxes[i].value+",";
                    }
                }
                if(values.length==0)
                {
                    alert("Please select atleast one checkbox");
                    return;
                }
                var mailIds=document.getElementById("email_id").value;
                //alert(values+" mail ids  "+mailIds.trim());
                var url="addCriticalEventsAction.jsp?values="+escape(values)+"&mail_ids="+escape(mailIds);
                //alert(url);
                xmlHttp.onreadystatechange=addEventsAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function addEventsAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").innerHTML="";
                    document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }
            function viewCriticalEvents()
            {
                
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="viewCriticalEvents.jsp?start=1";              
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);                 
            }           
            function commonAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").innerHTML="";
                    document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }
            function getMappedEvents(){
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                mailSel=document.getElementById("updatemailid");
                var mail=mailSel.options[mailSel.selectedIndex].value; 
                var url="getMappedCriticalEvents.jsp?mailid="+escape(mail);               
                xmlHttp.onreadystatechange=getMappedEventsAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null); 
            }
            function getMappedEventsAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {                    
                    var response=xmlHttp.responseText;
                    var events=response.split(",");
                    var checkboxes=document.getElementsByName('R-Phase');
                    for(var i=0;i<events.length-1;i++){
                        for(var j=0;j<checkboxes.length;j++){
                            if(checkboxes[j].value==parseInt(events[i]))
                                checkboxes[j].checked=true;
                        }
                      
                    }
                    

                }//end if
            }
            function updateEvents(){
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                } 
                var values=new Array();
                checkboxes = document.getElementsByName('R-Phase');
                for(var i=0;i < checkboxes.length;i++)
                {            if(checkboxes[i].checked ==true)
                    {                 
                        values=values+checkboxes[i].value+",";
                    }
                }
                if(values.length==0)
                {
                    alert("Please select atleast one checkbox");
                    return;
                }
                mailSel=document.getElementById("updatemailid");
                var mail=mailSel.options[mailSel.selectedIndex].value; 
                var url="updateCriticalEventsAction.jsp?values="+escape(values)+"&mail="+escape(mail);
                //alert(url);
                xmlHttp.onreadystatechange=addEventsAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
        </script>





    </head>
    <body >
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Meter Management</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="meterManage_links.jsp"%>




                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>
                    <div class="tab-box" >
                        <%
                            try {
                                if (session.getAttribute("user_type").equals("Administrator")) {
                        %>
                        <a href="javascript:;" class="tabLink " id="cont-1">Add</a>
                        <a href="javascript:;" class="tabLink " id="cont-2">Modify</a>
                        <a href="javascript:;" class="tabLink " id="cont-3">Delete</a> 
                        <% } else {
                                }
                            } catch (Exception e) {
                            }
                        %>
                        <a href="javascript:;" class="tabLink activeLink" id="cont-4">View</a>

                    </div>
                    <div id="updateDataPart" align="center">

                    </div>
                    <div class="tabcontent paddingAll" id="cont-1-1"> </div>
                    <div class="tabcontent paddingAll hide" id="cont-2-1"></div>
                    <div class="tabcontent paddingAll hide" id="cont-3-1">
                        <table style="padding-top: 15px;text-align: center;">
                            <tr>
                                <td>Select Mail ID:</td>
                                <td>
                                    <select id="mailid">
                                        <option value="-1">Select Mail</option>
                                        <%
                                        Connection con = null;
                                            try {
                                                con = new DBUtil().getConnection();
                                                ResultSet rs = con.prepareStatement("select distinct(emailid) from critical_events").executeQuery();
                                                while (rs.next()) {%>
                                        <option value='<%=rs.getString("emailid")%>'><%=rs.getString("emailid")%></option>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        finally{
                                            con.close();
                                        }
                                        %>

                                    </select>
                                </td>
                            </tr>
                            <tr><td colspan="2"><input type="button" value="Delete" onclick="deleteCriticalEvents();"/></td></tr>
                        </table>
                    </div>
                    <div class="tabcontent paddingAll hide" id="cont-4-1"> </div>

                    <div id="DataPart" align="center"> </div>



                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>