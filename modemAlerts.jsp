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
        return false;
      });
    });
  });

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
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Add</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Modify</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Delete</a>
    <a href="javascript:;" class="tabLink " id="cont-4">View</a>

  </div>
                    <div class="tabcontent paddingAll" id="cont-1-1">
                 <center>
                        <%@ include file="addModemAlerts.jsp"%>
                 </center>

                </div>
                 <div class="tabcontent paddingAll hide" id="cont-2-1">
                 <center>
                        <%@ include file="updateModemAlerts.jsp"%>
                 </center>

                </div>
                 <div class="tabcontent paddingAll hide" id="cont-3-1">
                 <center>
                        <%@ include file="deleteModemAlerts.jsp"%>
                 </center>

                </div>
                 <div class="tabcontent paddingAll hide" id="cont-4-1">
                 <center>
                        <%@ include file="viewModemAlerts.jsp"%>
                 </center>

                </div>




                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>