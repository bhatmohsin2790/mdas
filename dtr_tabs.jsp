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
    }
    .tab-box a.activeLink {
        background-color: #fff;
        border-bottom: 0;
        padding: 6px 15px;
    }
    .tabcontent { border: 0px solid #ddd; border-top: 0;}
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
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("instant");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getInstantData2(but_value);
                }

                if(tabeId=="cont-2")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("e_opt1");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getEnergy(but_value);
                }

                if(tabeId=="cont-3")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("loadsurvay_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getLoadsurvayData(but_value);
                }

                if(tabeId=="cont-4")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("tamper_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getEventsData(but_value);
                }

                if(tabeId=="cont-5")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("snapshot_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getSnapshotData(but_value);
                }

                return false;
            });
        });
    });
</script>

<script>

    function getLoadsurvayData(data_type)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getLoadsurvayData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=insertLoadsurvayData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getLoadsurvayData

    function insertLoadsurvayData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//insertLoadsurvayData

    function getEventsData(data_type)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getEventsData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=insertEventsData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getEventData

    function insertEventsData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//insertEventsData


    function getSnapshotData(data_type)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSnapshotData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=insertSnapshotData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getSnapshotData

    function insertSnapshotData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//insertLoadsurvayData

    function getInstantData2(data_type)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getInstantData.jsp";
        url=url+"?data_type="+data_type;

        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getInstantanious Data

    //get Main Energy data function
    function getEnergy(e_opt1)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";

        if(e_opt1==1)
            url="main_energy.jsp";
        if(e_opt1==2)
            url="tod_energy.jsp";
        if(e_opt1==3)
            url="energy_consumption.jsp";
        if(e_opt1==5)
            url="tod_consumption.jsp";

        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function getEnergyData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }//getEnergyData

    function getEnergyOptions(e_opt)
    {
        if(e_opt==1)
        {
            document.getElementById('e_opt_div1').style.display = "block";
            document.getElementById('e_opt_div2').style.display = "none";
        }
        if(e_opt==2)
        {
            document.getElementById('e_opt_div2').style.display = "block";
            document.getElementById('e_opt_div1').style.display = "none";
        }
    }
</script>
<div class="tab-box">
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">Instantaneous Data</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Energy</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Load Survey Data</a>
    <a href="javascript:;" class="tabLink " id="cont-4">Events Data</a>
    <a href="javascript:;" class="tabLink " id="cont-5">Snapshot Data</a>
    <a href="javascript:;" class="tabLink " id="cont-6">Transactions</a>
</div>

<div style="float:right;">Print  <input type="button" name="pdf" value="PDF" onclick="createPDF();"></div>

<div class="tabcontent paddingAll" id="cont-1-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <div class="button_style"> <input type="radio" name="instant" id="instant" value="1" checked onclick="getInstantData2(this.value)"> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="instant" id="instant" value="2" onclick="getInstantData2(this.value)"> Complete Data</div>
</div>

<div class="tabcontent paddingAll hide" id="cont-2-1">
    <div class="button_style"><input type="radio" name="e_opt" value="1" checked onclick="getEnergyOptions(this.value)"> Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="e_opt" value="2" onclick="getEnergyOptions(this.value)"> Demand</div>
    <br />
    <div id="e_opt_div1" style="float:left;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt1" value="1" checked onclick="getEnergy(this.value)"> Main Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="2" onclick="getEnergy(this.value)"> TOD Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="3" onclick="getEnergy(this.value)"> Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="4" onclick="getEnergy(this.value)"> Midnight Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <!--<div class="button_style"><input type="radio" name="e_opt1" value="5" onclick="getEnergy(this.value)"> TOD Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
    </div>
    <div id="e_opt_div2" style="float:left;display:none;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt1" value="6" onclick="getEnergy(this.value)"> Max Demand &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="7" onclick="getEnergy(this.value)"> TOD MD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="8" onclick="getEnergy(this.value)"> CMD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="9" onclick="getEnergy(this.value)"> MD Reset Dates &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    </div>
</div>

<div class="tabcontent paddingAll hide" id="cont-3-1">
   <div class="button_style"><input type="radio" name="loadsurvay_opt" id="loadsurvay_opt" value="10" checked onclick="getLoadsurvayData(this.value)"> Load Survay &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-4-1">
    <div class="button_style"><input type="radio" name="tamper_opt" id="tamper_opt" value="11" checked onclick="getEventsData(this.value)"> Tamper &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-5-1">
    <div class="button_style"><input type="radio" name="snapshot_opt" id="snapshot_opt" value="12" checked onclick="getSnapshotData(this.value)"> SnapShot &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-6-1">
    <div class="button_style"><input type="radio" name="transactin" id="transactin" value="13" checked onclick=""> Transactions &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
</div>