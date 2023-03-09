<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <script type="text/javascript" src="jquery.js"></script>        
    <script type="text/javascript" src="js2/home.js"></script> 
        <%@ page import="java.sql.*" %>
       
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="date-picker.js"></script>

        
<script type="text/javascript" src="bootstrap/bootstrap.js"></script>
<link rel="stylesheet" type="text/css" href="bootstrap/bootstrap.css" />
<%@ include file="importpage.jsp"%>   

<script type="text/javascript" src="js2/highcharts.js"></script>
<script type="text/javascript" src="exporting.js"></script>
<script type="text/javascript" src="js2/gray.js"></script>
<script type="text/javascript" src="js/highstock.js"></script>

<script type="text/javascript" src="js/jquery-1.9.1.js"></script>       
<link rel="stylesheet" type="text/css" href="js2/datatables/datatables.min.css" />
<script type="text/javascript" src="js2/datatables/datatables.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/table.css" />
<style>
    .primaryul{
        border-bottom:3px solid #007bff !important
    }
    .successul{
        border-bottom:3px solid #28a745 !important
    }
    .warningul{
        border-bottom:3px solid #ffc107 !important
    }
</style>  
    </head>
    <body>
        <div id="navigation"></div>
        <table width="100%" border="0" cellpadding="0" cellspacing='0' style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width='0' valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center"></td>
                <td width='14px' style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width='98%' style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                   
                      
                    <div id="report_part" style="margin-top: 1%;margin-left: 2%;margin-right: 2%;border:1px solid #87CEEB;min-height:400px;overflow:auto;">
<!-------------------------------------------------------------------------------------- -->                        
<div class="container">
<div class="row">
    
    <div class="col-md-3 mt-2">
        <div class="card">
            <div class="card-header" >
                Comm.Status
                
            </div>
            <div class="card-body" id="pi_chart">
                
            </div>
        </div>
    </div>
    <div class="col-md-6 mt-2">
        <div class="card">
            <div class="card-header">
                Summary
            </div>
            <div class="card-body" id="week_summary">
                
            </div>
        </div>
    </div>
    <div class="col-md-3 mt-2">
        <div class="card">
            <div class="card-header">
                Comm.Status
            </div>
            <div class="card-body" style="height:210px;">
                <div class="row mt-3"><h5 class="col-md-6 primaryul">DTC Count </h5><h5 class="col-md-6 text-primary" id="amrcount"></h5></div> 
                <div class="row mt-3"><h5 class="col-md-5 text-success" id="dcucount"></h5> <h5 class="col-md-7 successul">Feeder Count</h5></div> 
                <div class="row mt-3"><h5 class="col-md-6 warningul">HT Count </h5><h5 class="col-md-6 text-warning" id="htcount"></h5></div> 
            </div>
        </div>
    </div>
    <div class="clearfix"></div>
    <div class="col-md-12 mt-2">
        <div class="card">
            <div class="card-header">
                Comm.Status
            </div>
            <div class="card-body table-responsive" id="summary_table">
                
            </div>
        </div>
    </div>
</div>
</div>
<!-------------------------------------------------------------------------------------- -->                        
                    </div> 

                    <div id="loading" style="display: none;">
                        <center>
                            <h3 style="padding-top: 5px;">Please wait...</h3>
                           <img src="./images/loading.gif"/> 
                        </center>
                    </div>
                    <br></br>
                    <br></br>
                </td>
                <td width='13px' style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
 <script>
                 
$(document).ready(function() {               
   getCommStatus();
   getLastWeekStatus();
   getTypeCount();
  getSummaryTable();
}); 

</script>
        
</html>