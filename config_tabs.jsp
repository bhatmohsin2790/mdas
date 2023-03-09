
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="date-picker.js"></script>

<%@ page import="java.sql.*" %>
<%@ include file="importpage.jsp"%>

<style>
    .button_style
    {
        background-color:#EEEEEE;
        border:1px solid #DDDDDD;
        color:#666666;
        padding:3px 15px;
        text-decoration:none;
        float:left;
    }
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
    /*.tabcontent { border: 1px solid #ddd; border-top: 0; padding-top:45px }*/
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
                document.getElementById("report_part").innerHTML="";
                document.getElementById("data_part").innerHTML="";
                 if(tabeId=="cont-1")
                   getSendingOD();
                if(tabeId=="cont-2")
                  getODLogs();
                return false;
            });
        });
    });
</script>
<script>
var reportType;    
function getSendingOD(){
    reportType="sending";

xmlHttp=GetXmlHttpObject();
if (xmlHttp==null)
{
    alert ("Browser does not support HTTP Request");
    return;
}
var url="Ondemand/sendingOD.jsp";
xmlHttp.onreadystatechange=loadPage;
xmlHttp.open("GET",url,false);
xmlHttp.send(null);
}
function getODLogs(){
    reportType="logs";
xmlHttp=GetXmlHttpObject();
if (xmlHttp==null)
{
    alert ("Browser does not support HTTP Request");
    return;
}
var url="Ondemand/OndemandLogs.jsp";
xmlHttp.onreadystatechange=loadPage;
xmlHttp.open("GET",url,false);
xmlHttp.send(null);
}
function loadPage(){
if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
{
    var showdata = xmlHttp.responseText;
    document.getElementById("data_part").innerHTML= showdata;
}
}
</script>



<div class="tab-box" style="padding-top: 10px">
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Sending On-Demand</a>
    <a href="javascript:;" class="tabLink " id="cont-2">On-Demand Logs</a>           
</div>
<div class="tabcontent paddingAll" id="cont-1-1">
      
</div> 
<div class="tabcontent hide" id="cont-2-1">           
       
</div> 

<div id="data_part" bgcolor="#FFE4E1" style="margin-top: 1%;margin-left: 2%;margin-right: 2%;width:96%"></div>




