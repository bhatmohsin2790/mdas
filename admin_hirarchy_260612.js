
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
            return null;
        }
    }
    return xmlHttp;
}//GetXmlHttpObject
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

        xmlHttp.onreadystatechange=zonesChanged;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {

        alert("Please Select discom ");
    }

}//showzones
function zonesChanged()
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
            for(var j=document.forms[0].zone.options.length-1;j>=0;j--){
                document.forms[0].zone.remove(j);
            }
            var combo = document.getElementById("zone");
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
function showCircles(emp_value)
{
    if(emp_value!="-1")
    {
       
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getCircles_1.jsp";
        url=url+"?emp_id="+emp_value;

        xmlHttp.onreadystatechange=circlesChanged;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
       
        alert("Please Select zone ");
    }

}//showcircles
function circlesChanged()
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
            for(var j=document.forms[0].circle.options.length-1;j>=0;j--){
                document.forms[0].circle.remove(j);
            }
            var combo = document.getElementById("circle");
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
}//circlesChanged
function showDivisions(emp_value)
{
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    //               alert("A");
    if(emp_value!="-1")
    {
        //            alert("B");
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDivisions_1.jsp";
        url=url+"?emp_id="+emp_value;

        xmlHttp.onreadystatechange=stateChanged;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        //                           alert("C");
        alert("Please Select Subdivision ");
    }
//                       alert("D");
}//showDivisions
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
            for(var j=document.forms[0].division.options.length-1;j>=0;j--){
                document.forms[0].division.remove(j);
            }
            var combo = document.getElementById("division");
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
}//stateChanged
function showSubDivisions(emp_value)
{
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSubDivisions.jsp";
        url=url+"?emp_id="+emp_value;

        xmlHttp.onreadystatechange=state_SubDivision_Changed;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function state_SubDivision_Changed()
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
            for(var j=document.forms[0].subdivision.options.length-1;j>=0;j--){
                document.forms[0].subdivision.remove(j);
            }
            var combo = document.getElementById("subdivision");
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
        //----- End of Values inserting into Combo Box Dynamicaly------
        }

    }
}//state_SubDivision_Changed
function showSections(emp_value)
{
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSections.jsp";
        url=url+"?emp_id="+emp_value;

        xmlHttp.onreadystatechange=state_Section_Changed;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function state_Section_Changed()
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
            for(var j=document.forms[0].section.options.length-1;j>=0;j--){
                document.forms[0].section.remove(j);
            }
            var combo = document.getElementById("section");
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
        //----- End of Values inserting into Combo Box Dynamicaly------
        }

    }
}//state_Section_Changed
function showSubStations(emp_value)
{
    //Not this method
//        alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSubstations.jsp";
        url=url+"?emp_id="+emp_value;

        xmlHttp.onreadystatechange=state_SubStation_Changed;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function state_SubStation_Changed()
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
            for(var j=document.forms[0].substation.options.length-1;j>=0;j--){
                document.forms[0].substation.remove(j);
            }
            var combo = document.getElementById("substation");
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
        //----- End of Values inserting into Combo Box Dynamicaly------
        }

    }
}//state_SubStation_Changed
function showFeeders(emp_value)
{
        alert("reached here.....admin hirarchy 260612....!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getFeeders.jsp";
        url=url+"?emp_id="+emp_value;

        xmlHttp.onreadystatechange=state_Feeder_Changed;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function state_Feeder_Changed()
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
            for(var j=document.forms[0].feeder.options.length-1;j>=0;j--){
                document.forms[0].feeder.remove(j);
            }
            var combo = document.getElementById("feeder");
            for(var i=0;i<strar.length;i++)
            {
                // alert(strar[i]);
                var option = document.createElement("option");
                option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
                //  alert(strar[i]);
                // alert(strar[i]+"<---->"+strar[i].substring(0, strar[i].indexOf("_")));

                //alert(option.text+" : "+option.value);
                try {
                    combo.add(option, null); //Standard
                }catch(error) {
                    combo.add(option); // IE only
                }//try
            }//for
        //----- End of Values inserting into Combo Box Dynamicaly------
        }

    }
}//state_Feeder_Changed
//select Meters list based on opt (option value 0-->Feeders, 1-->DTR's, 2-->HT's)
function list_change(opt)
{
    showDTRs(document.getElementById('feeder').value,opt);
}
function getHirarchy(meterLoc)
{    
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }

    var url="getHirarchy.jsp?meterLoc="+escape(meterLoc);
    
    xmlHttp.onreadystatechange=insertHirarchy;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}//end method
function insertHirarchy(){

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        document.getElementById("getHirarchy").innerHTML=xmlHttp.responseText;
    }

}//end method
//test method
function test(emp_value){
    alert("what is happening here"+emp_value);
}
function showDTRs(emp_value,i)
{
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    if(emp_value!="-1")
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        /*
                                var url="getDTRs.jsp";
                                url=url+"?emp_id="+emp_value;
                                url=url+"&opt="+i;
                     */
        //var url="getDTRs.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
        var url="getLocationMeters.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
        alert(url);
        xmlHttp.onreadystatechange=state_DTR_Changed;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function state_DTR_Changed()
{

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

        var showdata = xmlHttp.responseText;
        //alert(showdata);
        showdata = showdata.toString().replace("\n", "");
        showdata = showdata.toString().replace("\n", "");
        showdata = showdata.toString().replace("\n", "");
        showdata = showdata.toString().replace("\n", "");
        //alert(showdata);
        var strar = showdata.split(":");

        if(strar.length==1)
        {
        //  alert("Please Select Employee Id");
        }
        else if(strar.length>1)
        {
            var strname = strar[1];
            //----- Values inserting into Combo Box Dynamicaly------
            for(var j=document.forms[0].dtr.options.length-1;j>=0;j--)
            {

                document.forms[0].dtr.remove(j);
            }
            var combo = document.getElementById("dtr");
            for(var i=0;i<strar.length-1;i++)
            {
                var option = document.createElement("option");
              

                try {
                    option.text = strar[i].trim().substring(strar[i].indexOf("_")+1,strar[i].indexOf("-"));
                    option.value = strar[i].substring(0,strar[i].trim().indexOf("_"));
                    combo.add(option, null); //Standard
                }catch(error) {
                    option.text = strar[i].substring(strar[i].indexOf("_")+1,12);
                    option.value = strar[i].substring(0,strar[i].indexOf("_"));
                    combo.options.add(option); // IE only

                }//try
            }//for
       


        }

    }
}//state_DTR_Changed
function getInstantData(meter_id)
{    
    xmlHttp=GetXmlHttpObject();
    var ApplyEMF = document.getElementById("ApplyEMF");
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getInstantData.jsp";
    url=url+"?meter_id="+meter_id+"&ApplyEMF="+(ApplyEMF.checked?"1":"0");
    xmlHttp.onreadystatechange=getInstantaneousData;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

}//getInstantanious Data
function getInstantaneousData()
{
    
    document.getElementById('home_msg').innerHTML = "";
    document.getElementById('submenu').style.display = "block";
    document.getElementById('DataPart').style.display = "block";
    document.getElementById('report_header').style.display = "block";
    
    // alert($('#example').tabs().selectedIndex);
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        
        document.getElementById("DataPart").innerHTML= showdata;
        
    // document.getElementById('ictd').style.display = "block";
        
    }
}//getInstantaneousData
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

//function getEventsData(data_type)
//{
// var values=new Array();
//    checkboxes = document.getElementsByName('R-Phase');
//    for(var i in checkboxes)
//     {
//         if(checkboxes[i].checked)
//             {
//                 alert("value is"+checkboxes[i].value);
//            // values=values+(++i)+",";
//
//             }
//     }
//     alert("values are"+values);
//    xmlHttp=GetXmlHttpObject();
//    if (xmlHttp==null)
//    {
//        alert ("Browser does not support HTTP Request");
//        return;
//    }
//    var url="getEventsData.jsp";
//    url=url+"?data_type="+data_type;
//alert(url);
//    xmlHttp.onreadystatechange=insertEventsData;
//    xmlHttp.open("GET",url,true);
//    xmlHttp.send(null);
//
//}//getEventData
//
//function insertEventsData()
//{
//    document.getElementById('home_msg').innerHTML = "";
//
//    document.getElementById('submenu').style.display = "block";
//    document.getElementById('DataPart').style.display = "block";
//    document.getElementById('report_header').style.display = "block";
//    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
//    {
//        var showdata = xmlHttp.responseText;
//        document.getElementById("DataPart").innerHTML= showdata;
//    }
//}//insertEventsData


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
    var ApplyEMF = document.getElementById("ApplyEMF");
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getInstantData.jsp";
    url=url+"?data_type="+data_type+"&ApplyEMF="+(ApplyEMF.checked?"1":"0");

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
function getDataReportsInstantData(meter_id)
{
    
    document.getElementById('ip_opt_div1').style.display = "none";
    document.getElementById('date_div').style.display = "none";
    document.getElementById('gdate').style.display = "none";
    // document.getElementById('graphPart').style.display = "none";
    document.getElementById("sDate").value="";
    document.getElementById("eDate").value="";
     
       

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getInstantData.jsp";
    url=url+"?meter_id="+meter_id;
    
    
    xmlHttp.onreadystatechange=getInstantaneousData;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

}//showDivisions
function createPDF()
{
    var s11 = document.getElementById('report_header').innerHTML;
    s11 = s11+document.getElementById('DataPart').innerHTML;
    //alert(s11);

    s11 = s11.replace(/class=\"head1\"/g,"style=\"color: #000000;font-weight: bold;\"");
    s11 = s11.replace(/class=\"mtable\"/g,"style=\"background-color: #FFFFFF;border: 1px solid black;border-collapse: collapse;font-family: arial;font-size: 10pt;width: auto;\"");
    s11 = s11.replace(/class=\"td1\"/g,"bgcolor=\"#56A5EC\" style=\"background-color:#56A5EC;border: 1px solid #409040;color: #FFFFFF;font-family: 'Times New Roman',Times,serif;font-size: 15pt;font-weight: bold;padding: 2px 4px;text-align: center;\"");
    s11 = s11.replace(/class=\"td2\"/g,"style=\"border: 1px solid #409040;font-size: 15pt;padding: 2px 4px;text-align: center;\"");
    s11 = s11.replace(/&nbsp;/g," ");
    //s11 = s11.replace(/\n/g,"<br>");
    s11 = s11.replace(/%/g,"%25");

    s11 = s11.replace(/&/g,"%26");

    s11 = s11.replace(/#/g,"%23");

    alert(s11);
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="createPDF.jsp";
    var parameters = "data="+s11;
    //alert(url);
    xmlHttp.onreadystatechange=pdf;
    xmlHttp.open("POST",url,true);
    xmlHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xmlHttp.setRequestHeader("Content-length", parameters .length);
    xmlHttp.send(parameters);

}
function pdf()
{
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        alert(showdata);
    }
}//pdf creation
var rph=new Array();
var yph=new Array();
var bph=new Array();
var graphTime=new Array();
var kwh=new Array();
function getGraphs(e_opt)
{
    sdate=document.getElementById("graphDate").value;
       
    var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
    xmlHttp=GetXmlHttpObject();
 
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    if(e_opt==1)
    {
        //alert("voltage");
        var url="getVoltageGraph.jsp?sdate="+escape(sdate)+"&meter_id="+escape(SelectedOption)+"";
        // url=url+"?meter_id="+meter_id;
        xmlHttp.onreadystatechange=getVoltageGraphData;

    }
    if(e_opt==2)
    {
        //alert("current");
        var url="getCurrentGraph.jsp?sdate="+escape(sdate)+"&meter_id="+escape(SelectedOption)+"";
        //url//=url+"?meter_id="+meter_id;
        xmlHttp.onreadystatechange=getCurrentGraphData;

    }
    
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
function getEnergyGraph(e_opt)
{
    sdate=document.getElementById("energygraphDate").value;
    var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
    xmlHttp=GetXmlHttpObject();

    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    if(e_opt==1)
    {
            
        var url="getKWHGraph.jsp?sdate="+escape(sdate)+"&meter_id="+escape(SelectedOption)+"";
   
        xmlHttp.onreadystatechange=getKWHGraphData;

    }
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);


}
function getKWHGraphData()
{
    document.getElementById('home_msg').innerHTML = "";
    document.getElementById('DataPart').innerHTML = "";
    document.getElementById('submenu').style.display = "block";
    //document.getElementById('graphPart').style.display = "block";
    document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        
        gtime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("kwh")-1);
        graphTime=gtime.split(",");
        for(i=0;i<graphTime.length;i++)
        {

            graphTime[i]=+graphTime[i].split(":").join("");
        }
            
        kwhdata=showdata.substring(showdata.indexOf("kwh")+4);
        kwh=kwhdata.split(",");
        for(k=0;k<kwh.length;k++)
        {
            kwh[k]=+kwh[k];
        }
            
        kwhGraph();

    }
}
function getVoltageGraphData()
{
    document.getElementById('home_msg').innerHTML = "";
    document.getElementById('DataPart').innerHTML = "";
    document.getElementById('submenu').style.display = "block";
    //document.getElementById('graphPart').style.display = "block";
    document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        gtime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("rph")-1);
        gtime=gtime.replace(";","");
        graphTime=gtime.split(",");

        rc=showdata.substring(showdata.indexOf("rph")+4,showdata.indexOf("yph")-1);

        rph=rc.split(",");
        for(i=0;i<rph.length;i++)
        {
            rph[i]=+rph[i];
        }

        yc=showdata.substring(showdata.indexOf("yph")+4,showdata.indexOf("bph")-1);
        yph=yc.split(",");
        for(j=0;j<yph.length;j++)
        {
            yph[j]=+yph[j];
        }

        bc=showdata.substring(showdata.indexOf("bph")+4);
        bph=bc.split(",");
        for(k=0;k<bph.length;k++)
        {
            bph[k]=+bph[k];
        }

        //document.getElementById("DataPart").innerHTML= showdata;
        //setTimeout("currentGraph()",3000);
        voltageGraph();
    }

}
function getCurrentGraphData()
{

    document.getElementById('home_msg').innerHTML = "";
    document.getElementById('DataPart').innerHTML = "";

    document.getElementById('submenu').style.display = "block";
    //document.getElementById('graphPart').style.display = "block";
    document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        
        gtime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("rph")-1);
        gtime=gtime.replace(";","");
        graphTime=gtime.split(",");     
                         
            
            
        rc=showdata.substring(showdata.indexOf("rph")+4,showdata.indexOf("yph")-1);

        rph=rc.split(",");
        for(i=0;i<rph.length;i++)
        {
            rph[i]=+rph[i];
        }

        yc=showdata.substring(showdata.indexOf("yph")+4,showdata.indexOf("bph")-1);
        yph=yc.split(",");
        for(j=0;j<yph.length;j++)
        {
            yph[j]=+yph[j];
        }

        bc=showdata.substring(showdata.indexOf("bph")+4);
        bph=bc.split(",");
        for(k=0;k<bph.length;k++)
        {
            bph[k]=+bph[k];
        }

        //document.getElementById("DataPart").innerHTML= showdata;
        //setTimeout("currentGraph()",3000);
        currentGraph();
    }



}
function currentGraph()
{

    var chart;


    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'DataPart',
                defaultSeriesType: 'line',
                marginRight: 130,
                marginBottom: 55,
                width:window.size,
                                                
                borderColor: "#4572A7",
                borderRadius: 15,
                borderWidth: 1,
                margin: [80, 80, 160,160]
                                                                                           
                                                
            },
            title: {
                text: 'Currents Graph',
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            xAxis: {
                gridLineWidth: 1,
                lineColor: '#000',
                tickColor: '#000',
                tickInterval:3,
                labels: {
                    style: {
                        color: '#000',
                        font: '11px Trebuchet MS, Verdana, sans-serif'
                    }
                },
                                            
                title: {
                    text: ' Time(hh:mm:ss)'

                },
                                                
                categories: graphTime

            },
            yAxis: {
                minorTickInterval: 'auto',
                lineColor: '#000',
                lineWidth: 1,
                tickWidth: 1,
                tickColor: '#000',
                labels: {
                    style: {
                        color: '#000',
                        font: '11px Trebuchet MS, Verdana, sans-serif'
                    }
                },
                title: {
                    text: 'currents (A)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                    this.x+'(hh:mm:ss)'+ '</b><br/> '+ this.y +'';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: [{
                name: 'BPhase',
                data: bph
            }, {
                name: 'RPhase',
                data: rph
            }, {
                name: 'YPhase',
                data: yph
            },],
            exporting: {
                enabled: true
            }
        });


    });




}
function voltageGraph()
{

    var chart;


    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'DataPart',
                defaultSeriesType: 'line',
                marginRight: 100,
                marginBottom: 95,
                width:window.size,
                borderColor: "#4572A7",
                borderRadius: 15,
                borderWidth: 1,
                margin: [80, 80, 160,160]
            },
            title: {
                text: 'Voltage Graph',
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            xAxis: {
                gridLineWidth: 1,
                lineColor: '#000',
                tickColor: '#000',
                tickInterval:3,
                labels: {
                    style: {
                        color: '#000',
                        font: '11px Trebuchet MS, Verdana, sans-serif'
                    }
                },
                title: {
                    text: 'Time(hh:mm:ss)'

                },
                categories: graphTime
            },
            yAxis: {
                minorTickInterval: 'auto',
                lineColor: '#000',
                lineWidth: 1,
                tickWidth: 1,
                tickColor: '#000',
                
                labels: {
                    style: {
                        color: '#000',
                        font: '11px Trebuchet MS, Verdana, sans-serif'
                    }
                },
                title: {
                    text: 'voltages (V)'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                    this.x +'(hh:mm:ss)'+'</b><br/> '+ this.y +'';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: [{
                name: 'BPhase',
                data: bph
            }, {
                name: 'RPhase',
                data: rph
            }, {
                name: 'YPhase',
                data: yph
            },],
            exporting: {
                enabled: true
            }
        });


    });

}
function kwhGraph()
{


    var chart;


    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: 'DataPart',
                defaultSeriesType: 'line',
                marginRight: 100,
                marginBottom: 25,
                width:2500
            },
            title: {
                text: 'KWH Graph',
                x: -20 //center
            },
            subtitle: {
                text: '',
                x: -20
            },
            xAxis: {
                title: {
                    text: 'Time(hh:mm:ss)'

                },
                categories: graphTime
            },
            yAxis: {
                title: {
                    text: 'kwh'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                    this.x +'(hh:mm:ss)'+'</b><br/> '+ this.y +'';
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -10,
                y: 100,
                borderWidth: 0
            },
            series: [{
                name: 'kwh',
                data: kwh
            }]
        });


    });
}

function searchForMeters(meterId){

    var meterSearchId=document.getElementById("meterSearchId").value;
    var discomSel=document.getElementById("discom");
    var zoneSel=document.getElementById("zone");
    var circleSel=document.getElementById("circle");

    var circleVal=circleSel.options[circleSel.selectedIndex].value;
    var zoneVal=zoneSel.options[zoneSel.selectedIndex].value;
    var discomVal=discomSel.options[discomSel.selectedIndex].value;

    var searchType=0;
    var optVal=0;

    if(circleVal>0){
        //if circle is selected searchType=3
        searchType=3;
        optVal=circleVal;
        //alert("Circle is Selected")
    }else if(zoneVal>0){
        //if zone is selected searchType=2
        searchType=2;
        optVal=zoneVal;
        //alert("Zone is Selected")
    }else if(discomVal>0){
        //if discom is selected searchType=1
        searchType=1;
        optVal=discomVal;
        //alert("Discom is Selected")
    }else{
        //nothing is selected searchType=0
        searchType=-1;
        optVal=0;
    //alert("Freeform Search")
    }//end else

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }

    var url="getSearchMeters.jsp?meterId="+escape(meterSearchId)+"&opt="+escape(optVal)+"&searchType="+escape(searchType);
//    alert(url);

    //------------Removing the previous values---------------------
    for(var j=document.forms[0].dtr.options.length-1;j>=0;j--){
        document.forms[0].dtr.remove(j);
    }//end for
    //-----------End for removing values----------------------------

    xmlHttp.onreadystatechange=state_DTR_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
    
}//end method