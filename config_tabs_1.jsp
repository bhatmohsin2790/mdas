
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
                return false;
            });
        });
    });
</script>

<script type="text/javascript">
   
</script>
<script type="text/javascript">
    function storeConfig(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("storeConfig").innerHTML;
    }
    function sendConfig(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("sendConfig").innerHTML;
    }
    function getConfig(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("getConfig").innerHTML;
    }
    function ODConfig(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("ODConfig").innerHTML;
    }
    function ssr(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("ssr").innerHTML;
    }
    function pota(){
        document.getElementById("data_part").innerHTML="";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("pota").style.visibility="visible";
    }
    function configReports(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("configReports").innerHTML;
    }
    function ODReports(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("ODReports").innerHTML;
    }
    function statusReports(){
        document.getElementById("pota").style.visibility="hidden";
        document.getElementById("update_part").innerHTML="";
        document.getElementById("data_part").innerHTML=document.getElementById("statusReports").innerHTML;
    }
</script>


<div class="tab-box" style="padding-top: 10px">
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Settings</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Reports</a>           
</div>
<div class="tabcontent paddingAll" id="cont-1-1">
    <div class="button_style"><input type="radio" name="settings" onclick="storeConfig();">Store Config</div>
    <div class="button_style"><input type="radio" name="settings" onclick="sendConfig();">Send Config</div>
    <div class="button_style"><input type="radio" name="settings" onclick="getConfig();">Get Config</div>
    <div class="button_style"><input type="radio" name="settings" onclick="ODConfig();">On-Demand Request</div>
    <div class="button_style"><input type="radio" name="settings" onclick="ssr();">Start/Stop/Restart</div>
    <div class="button_style"><input type="radio" name="settings" onclick="pota();">POTA </div>            
</div> 
<div class="tabcontent hide" id="cont-2-1">           
    <div class="button_style"><input type="radio" name="configReports" onclick="configReports();">CONFIG/POTA</div>           
    <div class="button_style"><input type="radio" name="configReports" onclick="ODReports();">On-Demand Request</div>
    <div class="button_style"><input type="radio" name="configReports" onclick="statusReports();">Start/Stop/Restart</div>

</div> 
<form name="sform" action="#">
<div id="data_part" style="padding-top: 40px;">
    
        
   
</div>
     </form>
<div id="update_part" style="padding-top: 30px;text-align: center; width:500px;height:100px;overflow: scorll;"></div> 


<%@include file="settings_part.jsp" %>
<%@include file="reports_part.jsp" %> 
<div id="pota" style="visibility: hidden;">
    <center>
        <form name="form5" action="#" >
            <input type="hidden" name="meterIds"/>
            <input type="hidden" name="meterLocation" />
            <table width=400px style="padding-left:5px;padding-top:5px;background-color:#EDF5FA;" align="center" cellpadding="5" cellspacing="5">
                <tr>

                    <td align="center">Date:</td>
                    <td>

                        <input type="text" readonly="true" size="10" id="potaDate" name="startingDate"/>
                        <a href="javascript:show_calendar('form5.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
                    </td>
                </tr>
                <tr>
                    <td>Send POTA Request:
                    </td>
                    <td><input type="button" value="Send Command" onclick="validatePota();"/>
                    </td>
                </tr>

            </table>
        </form>
    </center>
</div>


