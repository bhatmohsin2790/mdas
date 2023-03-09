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
    var reportType;
    $(document).ready(function() {
        $(".tabLink").each(function(){
            $(this).click(function(){
                tabeId = $(this).attr('id');
                $(".tabLink").removeClass("activeLink");
                $(this).addClass("activeLink");
                $(".tabcontent").addClass("hide");
                $("#"+tabeId+"-1").removeClass("hide")
                document.getElementById("report_part").innerHTML="";
                 if(tabeId=="cont-1")
                  {
                      reportType="SystemOverload";
                    document.getElementById("dates").innerHTML=document.getElementById("monthDiv").innerHTML;  
                    initializeMonthPicker();    
             }
                if(tabeId=="cont-2")
                 {
                     reportType="AmrDataAvailability";
                   document.getElementById("dates").innerHTML=document.getElementById("monthDiv").innerHTML;  
                   initializeMonthPicker();
                 }
                return false;
            });
        });
    });
</script>




<div class="tab-box" style="padding-top: 10px">
    <!--<a href="#" class="tabLink " id="cont-1">System OverLoad</a>-->
    <a href="#" class="tabLink " id="cont-2">Data Availability</a>
              
</div>
<div class="tabcontent paddingAll" id="cont-1-1"></div> 
<div class="tabcontent hide" id="cont-2-1"></div> 

<div id="data_part"  style="border:1px solid #87CEEB;margin-top: 1%;margin-left: 2%;margin-right: 2%;width:96%;min-height:50px;">
    <form name="form1" action="#">
   
    <div id="dates" style="padding-top:10px;"></div>
    </form>
</div>
<div id="monthDiv" style="float: left;padding-top: 15px;padding-left: 5px;display: none;">
    <table ><tr><td>Select Month:</td><td> <input type="text" id="month"  /></td>      
            <td rowspan="2"><input type="button" value="Get Report" onclick="getMonthlyReports();"/></td></tr>
    </table>
</div>




