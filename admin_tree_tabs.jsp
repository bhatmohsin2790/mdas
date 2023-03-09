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
                    var radioButtons = document.getElementsByName("zone");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    zonesData(but_value);
                }

                if(tabeId=="cont-2")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("circle");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    circlesData(but_value);

                }
                if(tabeId=="cont-3")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("division");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    TownData(but_value);
                }
                if(tabeId=="cont-4")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("subdivision");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    divisionData(but_value);
                }

                if(tabeId=="cont-5")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("section");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    sectionData(but_value);
                }

                if(tabeId=="cont-6")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("discomDetails");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    discomData(but_value);
                }
                if(tabeId=="cont-7")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("subdivision");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    subdivisionData(but_value);
                }
                return false;
            });
        });
    });
</script>

<script>

    function zonesData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addZones.jsp";
        if(data_type==2)
            url="deleteZones.jsp";
        if(data_type==3)
            url="updateZones.jsp";
        if(data_type==4)
            url="viewZones.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
    function circlesData(data_type)
    {    
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addCircles.jsp";
        if(data_type==2)
            url="deleteCircles.jsp";
        if(data_type==3)
            url="updateCircles.jsp";
        if(data_type==4)
            url="viewCircles.jsp";
        
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
    function divisionData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addDivision.jsp";
        if(data_type==2)
            url="deleteDivision.jsp";
        if(data_type==3)
            url="updateDivision.jsp";
        if(data_type==4)
            url="viewDivision.jsp";
        
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function TownData(data_type)
    {
//        alert(""+data_type);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addTown.jsp";
        if(data_type==2)
            url="deleteTown.jsp";
        if(data_type==3)
            url="updateTown.jsp";
        if(data_type==4)
            url="viewTown.jsp";
        
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function subdivisionData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addSubdivision.jsp";
        if(data_type==2)
            url="deleteSubdivision.jsp";
        if(data_type==3)
            url="updateSubdivision.jsp";
        if(data_type==4)
            url="viewSubdivision.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);        
    }
    function  sectionData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addSection.jsp";
        if(data_type==2)
            url="deleteSection.jsp";
        if(data_type==3)
            url="updateSection.jsp";
        if(data_type==4)
            url="viewSection.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
    function  discomData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addDiscom.jsp";
        if(data_type==2)
            url="deleteDiscom.jsp";
        if(data_type==3)
            url="updateDiscom.jsp";
        if(data_type==4)
            url="viewDiscom.jsp";
        
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
    function  townData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        if(data_type==1)
            var url="addTown.jsp";
        if(data_type==2)
            var url="deleteTown.jsp";
        if(data_type==3)
            var url="updateTown.jsp";
        if(data_type==4)
            var url="viewTown.jsp";
        
        xmlHttp.onreadystatechange=commonAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }

</script>
<script type="text/javascript">

    function insertDiscom(){

        discomName=document.getElementById("discomName").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addDiscomAction.jsp?discomName="+escape(discomName);
        xmlHttp.onreadystatechange=insertDiscomAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertDiscomAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertZone(){
        discomSel=document.getElementById("discomid");
        discom=discomSel.options[discomSel.selectedIndex].value;
        zone=document.getElementById("zoneName").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addZoneAction.jsp?zoneName="+escape(zone)+"&discom="+escape(discom);
        xmlHttp.onreadystatechange=insertZoneAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertZoneAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertCircle(){
        zoneSel=document.getElementById("zoneId");
        zone=zoneSel.options[zoneSel.selectedIndex].value;
        circle=document.getElementById("circleName").value;
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addCircleAction.jsp?zoneId="+escape(zone)+"&circleName="+escape(circle);
        xmlHttp.onreadystatechange=insertCircleAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertCircleAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function insertDivision(){
        townSel=document.getElementById("townId");
        town=townSel.options[townSel.selectedIndex].value;      
        division=document.getElementById("divisionName").value; 
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addDivisionAction.jsp?townId="+escape(town)+"&divisionName="+escape(division);
        xmlHttp.onreadystatechange=insertDivisionAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertDivisionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertSubDivision()
    {
        divisionSel=document.getElementById("divisionId");
        division=divisionSel.options[divisionSel.selectedIndex].value;
        // alert(division);
        subdivision=document.getElementById("subdivisionname").value;
        //alert(subdivision);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addSubDivisionAction.jsp?divisionId="+escape(division)+"&subdivisionname="+escape(subdivision);
        //alert("url is "+url);
        xmlHttp.onreadystatechange=insertSubDivisionAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function insertSubDivisionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertSection()
    {

        subdivisionSel=document.getElementById("subdivisionId");

        subdivision=subdivisionSel.options[subdivisionSel.selectedIndex].value;

        //alert(subdivision);
        section=document.getElementById("sectionId").value;
        //alert(section);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addSectionAction.jsp?subdivisionId="+escape(subdivision)+"&sectionname="+escape(section);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=insertSectionAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function insertSectionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function insertTown()
    {
        circleSel=document.getElementById("circleId");
        circle=circleSel.options[circleSel.selectedIndex].value;
        //alert(subdivision);
        town=document.getElementById("townId").value;
        //alert(section);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addTownAction.jsp?circleId="+escape(circle)+"&townname="+escape(town);
//        alert("url is "+url);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function deleteTown()
    {
        townSelect=document.getElementById("townId");
        townId=townSelect.options[townSelect.selectedIndex].value;
        //alert(sectionId);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteTownAction.jsp?townId="+escape( townId);
        //alert("url is "+url);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function activityAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
</script>
<script type="text/javascript">


    function showCircles(emp_value)
    {        
        if(emp_value!="-1")
        {
            //alert("emp value is"+emp_value);
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            //var url="getCircles_1.jsp";
            var url="getCircles_1_260612.jsp"
            url=url+"?emp_id="+emp_value;    
            xmlHttp.onreadystatechange=stateChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        else
        {
            alert("Please Select Zone ");
        }
    }
    function stateChanged()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            var strar = showdata.split(":");
            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].circleId.options.length-1;j>=0;j--){
                    document.forms[0].circleId.remove(j);
                }
                var combo = document.getElementById("circleId");
                for(var i=0;i<strar.length;i++)
                {                
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try 
                    {
                        combo.add(option, null); //Standard
                    }
                    catch(error) 
                    {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }
        }
    }//stateChanged
    function showDivisions(emp_value)
    {
        if(emp_value!="-1")
        {
            //alert("emp value is"+emp_value);
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getDivisions_1.jsp";
            url=url+"?emp_id="+emp_value;
            //alert("url is="+url);
            xmlHttp.onreadystatechange=showDivisionsStateChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }else
        {
            alert("Please Select Zone ");
        }
    }
    function showDivisionsStateChanged()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            //alert("show"+showdata);
            var strar = showdata.split(":");
            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //alert("show"+strname);
                for(var j=document.forms[0].divisionname.options.length-1;j>=0;j--)
                {
                    document.forms[0].divisionname.remove(j);
                }
                var combo = document.getElementById("divisionId");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
            }
        }
    }
    function showSubDivisions(emp_value)
    {
        if(emp_value!="-1")
        {
            //alert("emp value is"+emp_value);
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getSubDivisions_1.jsp";
            url=url+"?emp_id="+emp_value;
            //alert("url is="+url);
            xmlHttp.onreadystatechange=showSubDivisionsStateChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }else
        {

            alert("Please Select Zone ");
        }
    }
    function showSubDivisionsStateChanged()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            //alert("show"+showdata);
            var strar = showdata.split(":");
            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];

                //alert("show"+strname);
                for(var j=document.forms[0].subdivisionname.options.length-1;j>=0;j--)
                {
                    document.forms[0].subdivisionname.remove(j);
                }
                var combo = document.getElementById("subdivisionId");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
            }
        }
    }

    function showSections(emp_value)
    {
        if(emp_value!="-1")
        {
            //alert("emp value is"+emp_value);
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getSections_1.jsp";
            url=url+"?emp_id="+emp_value;
            //alert("url is="+url);
            xmlHttp.onreadystatechange=showSectionsStateChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }else
        {
            alert("Please Select Zone ");
        }
    }
    function showSectionsStateChanged()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            //alert("show"+showdata);
            var strar = showdata.split(":");
            if(strar.length==1)
            {
                alert("No Sections are available");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //alert("show"+strname);
                for(var j=document.forms[0].section.options.length-1;j>=0;j--)
                {
                    document.forms[0].section.remove(j);
                }
                var combo = document.getElementById("sectionId");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
            }
        }
    }
    function showTowns(emp_value)
    {    
        if(emp_value!="-1")
        {
            //alert("emp value is"+emp_value);
            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getTowns.jsp";
            url=url+"?emp_id="+emp_value;                        
            xmlHttp.onreadystatechange=showTownsStateChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }else
        {}
    }
    function showTownsStateChanged()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            var strar = showdata.split(":");
            if(strar.length==1)
            {
                alert("No towns are available");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                for(var j=document.getElementById("townId").options.length-1;j>=0;j--)
                {
                    document.getElementById("townId").remove(j);
                }
                var combo = document.getElementById("townId");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
            }
        }
    }

</script>
<script type="text/javascript">

    function deleteDiscom()
    {
        discomSelect=document.getElementById("discomID");
        discomId=discomSelect.options[discomSelect.selectedIndex].value;
        //alert(sectionId);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteDiscomAction.jsp?discomId="+escape(discomId);
        //alert("url is "+url);
        xmlHttp.onreadystatechange=delDiscomAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function delDiscomAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function delZone()
    {
        zoneSelect=document.getElementById("zoneId");
        zoneId=zoneSelect.options[zoneSelect.selectedIndex].value;
        //alert(zoneId);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteZoneAction.jsp?zoneId="+escape(zoneId);
        // alert("url is "+url);
        xmlHttp.onreadystatechange=delZoneAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function delZoneAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteSection()
    {
        sectionSelect=document.getElementById("sectionId");
        sectionId=sectionSelect.options[sectionSelect.selectedIndex].value;
        //alert(sectionId);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteSectionAction.jsp?sectionId="+escape( sectionId);
        //alert("url is "+url);
        xmlHttp.onreadystatechange=delSectionAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function delSectionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";

            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;

        }//end if
    }//end method
    function deleteSd()
    {

        subSel=document.getElementById("subdivisionId");


        subdivision=subSel.options[subSel.selectedIndex].value;
        //alert(sectionId);

        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteSubdivisionAction.jsp?subdivisionId="+escape( subdivision);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=delSdAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function delSdAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteDivision()
    {

        divisionSel=document.getElementById("divisionId");


        division=divisionSel.options[divisionSel.selectedIndex].value;
        //alert(sectionId);

        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteDivisionAction.jsp?divisionId="+escape(division);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=delDivisionAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function delDivisionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteCircles()
    {

        circleSel=document.getElementById("circleId");


        circle=circleSel.options[circleSel.selectedIndex].value;
        //alert(sectionId);

        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteCircleAction.jsp?circleId="+escape(circle);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=delCirclesAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function delCirclesAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function oldTown()
    {

        townSel=document.getElementById("townId");
        var tId=townSel.options[townSel.selectedIndex].value;

        var tName=townSel.options[townSel.selectedIndex].text;
        document.getElementById("sstwo").style.visibility="visible";        
        document.getElementById("tname").value=tName;
        dSel=document.getElementById("divisionId");
        var did=dSel.options[dSel.selectedIndex].value;
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSubDivisions.jsp?emp_id="+escape(did);
        // alert("url is "+url);
        xmlHttp.onreadystatechange=oldTownAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function oldTownAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            //alert("show"+showdata);
            var strar = showdata.split(":");
            //alert("strar is:" +strar);
            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].newsd.options.length-1;j>=0;j--)
                {
                    document.forms[0].newsd.remove(j);
                }

                var combo = document.getElementById("newsd");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for

            }
        }
    }
    function newTown()
    {
//        alert("new Town");
        var newName= document.getElementById("tname").value;
        townSel=document.getElementById("townId");
        var tId=townSel.options[townSel.selectedIndex].value;  
//        alert("tId "+tId);
//        alert("newName "+newName);
        if(townSel==-1)
        {
            alert("please select subdivision");}
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateTownAction.jsp?tId="+escape(tId)+"&tName="+escape(newName);
//        alert(url);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newSection()
    {
        var newName= document.getElementById("sname").value;
        //alert("new name is "+newName);
        sectinSel=document.getElementById("sectionId");
        var sId=sectinSel.options[sectinSel.selectedIndex].value;
        //alert("section id "+sId);
        newSd=document.getElementById("newsd");
        var newSdname=newSd.options[newSd.selectedIndex].value;
        if(newSdname==-1)
        {alert("please select subdivision");}
        //alert("new Subdivision name is"+newSdname);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateSectionAction.jsp?sId="+escape(sId)+"&sName="+escape(newName)+"&sdId="+escape(newSdname);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newSectionAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
</script>
<script type="text/javascript">
    function oldSection()
    {

        sectinSel=document.getElementById("sectionId");
        var sId=sectinSel.options[sectinSel.selectedIndex].value;

        var sName=sectinSel.options[sectinSel.selectedIndex].text;
        document.getElementById("sstwo").style.visibility="visible";
        document.getElementById("sid").value=sId;
        document.getElementById("sname").value=sName;
        dSel=document.getElementById("divisionId");
        var did=dSel.options[dSel.selectedIndex].value;
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSubDivisions.jsp?emp_id="+escape(did);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=oldSectionAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function oldSectionAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;
            //alert("show"+showdata);

            var strar = showdata.split(":");
            //alert("strar is:" +strar);

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];

                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].newsd.options.length-1;j>=0;j--)
                {
                    document.forms[0].newsd.remove(j);
                }

                var combo = document.getElementById("newsd");


                for(var i=0;i<strar.length;i++)
                {

                    var option = document.createElement("option");

                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;

                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for

            }
        }
    }
    function newSection()
    {
        var newName= document.getElementById("sname").value;
        //alert("new name is "+newName);
        sectinSel=document.getElementById("sectionId");
        var sId=sectinSel.options[sectinSel.selectedIndex].value;
        //alert("section id "+sId);
        newSd=document.getElementById("newsd");
        var newSdname=newSd.options[newSd.selectedIndex].value;
        if(newSdname==-1)
        {alert("please select subdivision");}
        //alert("new Subdivision name is"+newSdname);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateSectionAction.jsp?sId="+escape(sId)+"&sName="+escape(newName)+"&sdId="+escape(newSdname);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newSectionAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newSectionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function oldSd()
    {

        sdSel=document.getElementById("subdivisionId");
        var sdid=sdSel.options[sdSel.selectedIndex].value;
        var sdName=sdSel.options[sdSel.selectedIndex].text;
        document.getElementById("sdid").value=sdid;
        document.getElementById("sdname").value=sdName;
        cSel=document.getElementById("circleId");
        var cid=cSel.options[cSel.selectedIndex].value;
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDivisions.jsp?emp_id="+escape(cid);
        // alert("url is "+url);

        xmlHttp.onreadystatechange=oldSdAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function oldSdAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;
            //alert("show"+showdata);

            var strar = showdata.split(":");
            //alert("strar is:" +strar);

            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];

                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].newd.options.length-1;j>=0;j--)
                {
                    document.forms[0].newd.remove(j);
                }

                var combo = document.getElementById("newd");


                for(var i=0;i<strar.length;i++)
                {

                    var option = document.createElement("option");

                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;

                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for

            }
        }
    }
    function newSd()
    {
        var newName= document.getElementById("sdname").value;
        //alert("new name is "+newName);
        sdSel=document.getElementById("subdivisionId");
        var sdId=sdSel.options[sdSel.selectedIndex].value;
        //alert("sd id "+sdId);
        dSel=document.getElementById("newd");
        var dId=dSel.options[dSel.selectedIndex].value;
        if(dId==-1)
        {alert("please select division");}
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateSubdivisionAction.jsp?sdId="+escape(sdId)+"&sdName="+escape(newName)+"&dId="+escape(dId);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newSdAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newSdAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function oldDivision()
    {
        dSel=document.getElementById("divisionId");
        var dId=dSel.options[dSel.selectedIndex].value;
        var dName=dSel.options[dSel.selectedIndex].text;
        document.getElementById("divid").value=dId;
        document.getElementById("dname").value=dName;
        zoneSelected=document.getElementById("zoneId");
        var oldzoneId=zoneSelected.options[zoneSelected.selectedIndex].value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getCircles_1_260612.jsp?emp_id="+escape(oldzoneId);
        //        var url="getTowns.jsp?emp_id="+escape(oldzoneId);
        //alert(url);
        xmlHttp.onreadystatechange=olddivAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function olddivAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            var strar = showdata.split(":");
            if(strar.length==1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].newcircle.options.length-1;j>=0;j--)
                {
                    document.forms[0].newcircle.remove(j);
                }
                var combo = document.getElementById("newcircle");
                for(var i=0;i<strar.length;i++)
                {
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }
                    catch(error)
                    {
                        combo.add(option); // IE only
                    }//try
                }//for
            }
        }
    }
    function newDivision()
    {
        var newName= document.getElementById("dname").value;
        dSel=document.getElementById("divisionId");
        var dId=dSel.options[dSel.selectedIndex].value;
        cSel=document.getElementById("newcircle");
        var cId=cSel.options[cSel.selectedIndex].value;
        tSel=document.getElementById("townId");
        var tId=tSel.options[tSel.selectedIndex].value;
        if(cId ==-1)
            alert("please select circle");
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateDivisionAction.jsp?dId="+escape(dId)+"&dName="+escape(newName)+"&cId="+escape(cId)+"&tId="+escape(tId);

        xmlHttp.onreadystatechange=newDivisionAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newDivisionAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function oldCircle()
    {

        cSel=document.getElementById("circleId");

        var cId=cSel.options[cSel.selectedIndex].value;
        var cName=cSel.options[cSel.selectedIndex].text;

        document.getElementById("cirid").value=cId;
        document.getElementById("cname").value=cName;

    }

    function newCircle()
    {
        var newName= document.getElementById("cname").value;
        //alert("new name is "+newName);
        cSel=document.getElementById("circleId");
        var cId=cSel.options[cSel.selectedIndex].value;
        //alert("cirlce id "+cId);
        zSel=document.getElementById("newzoneId");
        var zId=zSel.options[zSel.selectedIndex].value;
        if(zId==-1)
        {
            alert("please select zone");
        }
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateCircleAction.jsp?cId="+escape(cId)+"&cName="+escape(newName)+"&zId="+escape(zId);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newCircleAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newCircleAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function oldZone()
    {

        zSel=document.getElementById("zoneId");

        var zName=zSel.options[zSel.selectedIndex].text;
        document.getElementById("ztwo").style.visibility="visible";

        document.getElementById("zname").value=zName;
    }
    function newZone()
    {
        var newName= document.getElementById("zname").value;
        //alert("new name is "+newName);
        zSel=document.getElementById("zoneId");
        var zId=zSel.options[zSel.selectedIndex].value;
        // alert("zone id "+zId);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateZoneAction.jsp?zId="+escape(zId)+"&zName="+escape(newName);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newZoneAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newZoneAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function showZones(emp_value)
    {

        if(emp_value!="-1")
        {

            xmlHttp=GetXmlHttpObject();
            if (xmlHttp==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            }
            var url="getZones_1.jsp";
            url=url+"?emp_id="+emp_value;

            xmlHttp.onreadystatechange=districtChanged;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);

        }else
        {

            alert("Please Select discom ");
        }

    }//showzones
    function districtChanged()
    {

        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {

            var showdata = xmlHttp.responseText;

            var strar = showdata.split(":");

            if(strar.length<1)
            {
                //  alert("Please Select Employee Id");
            }
            else if(strar.length>=1)
            {
                var strname = strar[1];
                //----- Values inserting into Combo Box Dynamicaly------
                for(var j=document.forms[0].district.options.length-1;j>=0;j--){
                    document.forms[0].district.remove(j);
                }
                var combo = document.getElementById("district");
                for(var i=0;i<strar.length;i++)
                {
                    // alert(strar[i].substringData(strar[i].indexOf("_")+1));
                    var option = document.createElement("option");
                    option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                    option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                    try {
                        combo.add(option, null); //Standard
                    }catch(error) {
                        combo.add(option); // IE only
                    }//try
                }//for
                //----- End of Values inserting into Combo Box Dynamicaly------
            }

        }
    }//zonesChanged
    function showEditDiscom()
    {
        discomSel=document.getElementById("oldDiscom");
        var dicomName=discomSel.options[discomSel.selectedIndex].text;
        document.getElementById("editDiscom").style.visibility="visible";

        document.getElementById("newDiscom").value=dicomName;
    
    }
    function updateDiscom()
    {
        var newDiscomName= document.getElementById("newDiscom").value;     
        dSel=document.getElementById("oldDiscom");
        var dId=dSel.options[dSel.selectedIndex].value;      
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateDiscomAction.jsp?dId="+escape(dId)+"&dName="+escape(newDiscomName);     
        
        xmlHttp.onreadystatechange=newZoneAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    
    }

</script>
<div class="tab-box">
    <a href="javascript:;" class="tabLink activeLink " id="cont-6">Discom</a>
    <a href="javascript:;" class="tabLink " id="cont-1">Zone</a>
    <a href="javascript:;" class="tabLink " id="cont-2">Circle</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Town</a>
    <a href="javascript:;" class="tabLink " id="cont-4">Division</a>
    <!--<a href="javascript:;" class="tabLink " id="cont-5">Section</a> -->
    <a href="javascript:;" class="tabLink " id="cont-7">SubDivision</a>

</div>
<div class="tabcontent paddingAll" id="cont-6-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        System.out.println("session.getAttribute(user_type)\t" + session.getAttribute("user_type"));
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"> <input type="radio" name="discomDetails" id="discomDetails" value="1"  onclick="discomData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="discomDetails" id="discomDetails" value="2" onclick="discomData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="discomDetails" id="discomDetails" value="3" onclick="discomData(this.value)"> Update</div>
        <%         } else {
         }%>
    <div class="button_style"><input type="radio" name="discomDetails" id="discomDetails" value="4"  checked onclick="discomData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll  hide" id="cont-1-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"> <input type="radio" name="zone" id="zone" value="1"  onclick="zonesData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="zone" id="zone" value="2" onclick="zonesData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="zone" id="zone" value="3" onclick="zonesData(this.value)"> Update</div>
        <% } else {
       }%>
    <div class="button_style"><input type="radio" name="zone" id="zone" value="4" checked onclick="zonesData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-2-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"> <input type="radio" name="circle" id="circle" value="1"   onclick="circlesData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="circle" id="circle" value="2" onclick="circlesData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="circle" id="circle" value="3" onclick="circlesData(this.value)"> Update</div>
        <% } else {
       }%>
    <div class="button_style"><input type="radio" name="circle" id="circle" value="4" checked onclick="circlesData(this.value)"> View</div>
</div> 
<div class="tabcontent paddingAll hide" id="cont-3-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"> <input type="radio" name="division" id="town" value="1"   onclick="TownData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="division" id="town" value="2" onclick="TownData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="division" id="town" value="3" onclick="TownData(this.value)"> Update</div>
        <% } else {
         }%>
    <div class="button_style"><input type="radio" name="division" id="town" value="4"  checked onclick="TownData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-4-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"> <input type="radio" name="division" id="division" value="1"   onclick="divisionData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="division" id="division" value="2" onclick="divisionData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="division" id="division" value="3" onclick="divisionData(this.value)"> Update</div>
        <%         } else {
            }
        %>
    <div class="button_style"><input type="radio" name="division" id="division" value="4" checked  onclick="divisionData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-5-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"> <input type="radio" name="section" id="section" value="1"  onclick=" sectionData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="section" id="section" value="2" onclick="sectionData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="section" id="section" value="3" onclick="sectionData(this.value)"> Update</div>
        <% } else {
            }
        %>
    <div class="button_style"><input type="radio" name="section" id="section" value="4" checked onclick="sectionData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-7-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
        if (session.getAttribute("user_type").equals("Administrator")) {
    %>
    <div class="button_style"><input type="radio" name="subdivision" id="subdivision" value="1"  onclick=" subdivisionData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="subdivision" id="subdivision" value="2" onclick="subdivisionData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="subdivision" id="subdivision" value="3" onclick="subdivisionData(this.value)"> Update</div>
        <%         } else {
            }
        %>
    <div class="button_style"><input type="radio" name="subdivision" id="subdivision" value="4" checked onclick="subdivisionData(this.value)"> View</div>
</div>    

