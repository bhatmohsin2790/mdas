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
           addUserType();
        if(tabeId=="cont-2")
           editUserType();
        if(tabeId=="cont-3")
           delUserType();
       if(tabeId=="cont-4")
           viewUserType();   
        return false;
      });
    });
  });

        </script>
     <script type="text/javascript">
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
      
        <script type="text/javascript">
             function addUserType()
            {
                    xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="addUserType.jsp";
                 xmlHttp.onreadystatechange=displaycommonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
             function delUserType()
            {
                    xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="deleteUserType.jsp";
                 xmlHttp.onreadystatechange=displaycommonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
             function viewUserType()
            {
                 xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="viewUserType.jsp";
                 xmlHttp.onreadystatechange=displaycommonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function editUserType()
            {
                    xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="updateUserType.jsp";
                 xmlHttp.onreadystatechange=displaycommonAction;

                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
             function displaycommonAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").innerHTML="";
                    document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }
            function insertUserType()
            {
              var  userTypeName=document.getElementById("userTypeName").value;
                xmlHttp=GetXmlHttpObject();
                
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/addUserTypeAction.jsp?userTypeName="+escape(userTypeName)+"";                
                xmlHttp.onreadystatechange=commonUserAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function deleteUserTypeAction()
            {
                 var  userTypeSel=document.getElementById('UserTypeName').selectedIndex;                 
                 var userTypeName=document.getElementById('UserTypeName').options[userTypeSel].text;
                xmlHttp=GetXmlHttpObject();
                
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/deleteUserTypeAction.jsp?userTypeName="+escape(userTypeName)+"";      
                
                xmlHttp.onreadystatechange=commonUserAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function updateUserTypeAction()
            {
                  var  userTypeSel=document.getElementById('userTypeName').selectedIndex;                 
                 var userTypeName=document.getElementById('userTypeName').options[userTypeSel].value;
                 var newUT=document.getElementById('newUT').value;
                xmlHttp=GetXmlHttpObject();
                
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="meter_management_actions/updateUserTypeAction.jsp?userTypeName="+escape(userTypeName)+"&newUT="+escape(newUT)+"";     
                
                xmlHttp.onreadystatechange=commonUserAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
                
            }
             function commonUserAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("updateDataPart").style.display="block";
                    document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }//end method
     </script>
    </head>
    <body onload="viewUserType();">
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>User Management</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="userManage_links.jsp"%>




                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>


                   <div class="tab-box" >
                          <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <a href="javascript:;" class="tabLink " id="cont-1">Add</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Modify</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Delete</a>
    <% }else{} %>
    <a href="javascript:;" class="tabLink activeLink " id="cont-4">View</a>
  </div>
                    <div id="updateDataPart" align="center"> </div>
                      <div id="DataPart" align="center"> </div>
                    <div class="tabcontent paddingAll" id="cont-1-1"></div>
                  <div class="tabcontent paddingAll hide" id="cont-2-1"> </div>
                  <div class="tabcontent paddingAll hide" id="cont-3-1"></div>
                  <div class="tabcontent paddingAll hide" id="cont-4-1"> </div>
                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>