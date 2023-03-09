
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
function showTowns(emp_value)
{
    if(emp_value!="-1")
	{           
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
	}
        else
	{
            
        }

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
	for(var j=document.getElementById("townid").options.length-1;j>=0;j--)
                      {
                          document.getElementById("townid").remove(j);
                      }
                      var combo = document.getElementById("townid");
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
}//circlesChanged
function showDivisions(emp_value)
{
       
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    //               alert("A");
    if(emp_value!="-1")
    {        
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
    }
    else
    {        
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
            var combo = document.getElementById("divisionid");
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
function showSubDivisions(emp_value)
{    
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
       // var url="getSubstations.jsp";
         var url="getSubstations_260612.jsp";
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
function showFeeders(emp_value,substation)
{
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
    //var substation=document.getElementById("substation").value;
   
    //    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
    //	for(var j=document.forms[0].division.options.length-1;j>=0;j--){
    //		document.forms[0].division.remove(j);
    //		}
    //-----------End for removing values----------------------------
    //alert("dtr")
    
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
        
        if(i==0)
        {                
                    // var url="getLocationMeters_DCU.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i)+"&substation="+escape(substation);
             var url="getLocationMeters_DCU.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
             //alert(url);
             xmlHttp.onreadystatechange=state_DTR_Changed;
             xmlHttp.open("GET",url,true);
             xmlHttp.send(null);
             //dcuFunction();
        }
        else
        {
            //alert(4)
           // var url="getDTRs_2.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
            var url="getLocationMeters.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);               
            xmlHttp.onreadystatechange=state_DTR_Changed;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function dcuFunction()
{
//     xmlHttp1=GetXmlHttpObject();
//        if (xmlHttp1==null)
//        {
//            alert ("Browser does not support HTTP Request");
//            return;
//        }
//        var url="dcu_reports_menu.jsp";
//        
//         xmlHttp1.onreadystatechange=dcuFunctionAction;
//        xmlHttp1.open("GET",url,true);
//        xmlHttp1.send(null);

    document.getElementById("submenu").style.display="none";
     document.getElementById("home_msg").innerHTML="";
        document.getElementById("DataPart").innerHTML="";
        //document.getElementsByName("dcu_opt")[0].checked = true;
        //document.getElementById('report_header').innerHTML = document.getElementById('dcu_submenu').innerHTML;
       // document.getElementById('report_header').style.display = "display";
        //alert("in dcu");
        getDCUData();
    
}
function dcuFunctionAction()
{
    document.getElementById("report_header").innerHTML="";
    document.getElementById("submenu").style.display="none";
     if (xmlHttp1.readyState==4 || xmlHttp1.readyState=="complete")
    {
        document.getElementById("report_header").innerHTML=xmlHttp1.responseText;
        document.getElementById("home_msg").innerHTML="";
        document.getElementById("DataPart").innerHTML="";
        
    }
    
}
function state_DTR_Changed()
{

    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {

        var showdata = xmlHttp.responseText;
       
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
                    //option.text = strar[i].trim().substring(strar[i].indexOf("_")+1,strar[i].indexOf("-"));
                    
                    option.text = strar[i].substring(strar[i].indexOf("-")+1);
                    option.title=strar[i].substring(strar[i].indexOf("_")+1,strar[i].indexOf("-"));
                    option.value = strar[i].substring(0,strar[i].indexOf("_")).trim();
                  
                  combo.add(option, null); //Standard
                }catch(error) {
                    
                    option.text = strar[i].substring(strar[i].indexOf("-")+1);
                    option.title = strar[i].substring(strar[i].indexOf("_")+1,strar[i].indexOf("-"));
                    option.value = strar[i].substring(0,strar[i].indexOf("_"));
                   
                    combo.options.add(option); // IE only
                }//try
            }//for

        }

    }
}//state_DTR_Changed
function getInstantData(meter_id)
{    
    //document.getElementById("report_header").innerHTML="";
     document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
    xmlHttp=GetXmlHttpObject();
    var ApplyEMF = document.getElementById("AEMF");
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
    document.getElementById('meter_details').style.display = "block";
    document.getElementById("report_header").style.display = "none";
      //to select the instant tab       
                $(".tabLink").removeClass("activeLink");
                $(".tabcontent").addClass("hide");
                $("#cont-1").addClass("activeLink");
                $(".tabcontent").addClass("#cont-1-1");
                $("#cont-1-1").removeClass("hide");
                
               
    
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;        
        document.getElementById("DataPart").innerHTML= showdata;
		$('#dtable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5'
//            'pdfHtml5'
        ]
    });
//                   var but_value;
//                    var radioButtons = document.getElementsByName("instant");
//                    for (var x = 0; x < radioButtons.length; x ++) {
//                        if (radioButtons[x].checked) {
//                            but_value = radioButtons[x].value;
//                        }
//                    }
//                   document.getElementsByName("instant")[but_value-1].checked=true;
                  
        
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
     document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
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
    document.getElementById('meter_details').style.display = "block";
    document.getElementById('report_header').style.display = "none";
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
    
    if(meter_id!=0)
    {
        var meterL="";
        chkboxes = document.getElementsByName('r1');
                for(var i=0;i< chkboxes.length;i++)
                {            
                    if(chkboxes[i].checked)
                        meterL=chkboxes[i].value;
                }
        
        if(meterL=="feeder")
            document.getElementById("cont-10").style.display="";
        else
            document.getElementById("cont-10").style.display="none";
        
        document.getElementById('ip_opt_div1').style.display = "none";
        document.getElementById('date_div').style.display = "none";
        document.getElementById('gdate').style.display = "none";
        // document.getElementById('graphPart').style.display = "none";
        document.getElementById("sDate").value="";
        document.getElementById("eDate").value="";
        document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
        document.getElementsByName("instant")[0].checked=true; //to check latest instant
     
         var chbEMF=document.getElementById("AEMF");

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getInstantData.jsp";
        url=url+"?meter_id="+meter_id+"&ApplyEMF="+(chbEMF.checked?"1":"0");

       
        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    else
        {
            
         document.getElementById("submenu").style.display="none";
        document.getElementById("home_msg").innerHTML="";
        document.getElementById("DataPart").innerHTML="";
        //document.getElementById('report_header').innerHTML = document.getElementById('dcu_submenu').innerHTML;
        document.getElementById("report_header").style.display = "block";
            dcuFunction();
        }
}//showDivisions
function createPDF()
{
    //var s11 = document.getElementById('report_header').innerHTML;
   var s11 = document.getElementById('DataPart').innerHTML;
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

    //alert(s11);
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
    if(document.getElementById("graphDate").value=="")
        {
            alert("please select date");
            document.getElementById("graphDate").focus();
        }
    document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
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
    //document.getElementById('DataPart').innerHTML = "";
    document.getElementById('submenu').style.display = "block";
    //document.getElementById('graphPart').style.display = "block";
    document.getElementById('report_header').style.display = "none";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        gtime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("rph")-1);
        // alert("gtime "+gtime)
        gtime=gtime.replace(";","");
        //alert("gtime  "+gtime)
        graphTime=gtime.split(",");

        rc=showdata.substring(showdata.indexOf("rph")+4,showdata.indexOf("yph")-1);
        //alert("rc  "+rc)
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
   // document.getElementById('DataPart').innerHTML = "";

    document.getElementById('submenu').style.display = "block";
    //document.getElementById('graphPart').style.display = "block";
    document.getElementById('report_header').style.display = "none";
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
                                                
                categories: graphTime,
                min:0,
                max:10

            },
            yAxis: {
                min:0,
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
             scrollbar: {
                enabled: true
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
                categories: graphTime,
                 min: 0,
                 max:10
            },
            yAxis: {
                min: 0,
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
             scrollbar: {
                enabled: true
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

function searchForMeters(){
    var meterLoc;
  var checkboxes=document.getElementsByName("r1");
    for (var i = 0; i < checkboxes.length; i++)
    {
        var button = checkboxes[i];
        if (button.checked)
        {
            meterLoc = button.value;
        }
    }
    if(meterLoc==null){
        alert("select Meter Location (HT/DTR/Feeder)");
        return 0;
    }
    var meterSearchId=document.getElementById("meterSearchId").value;
    var discomSel=document.getElementById("discom");
    var zoneSel=document.getElementById("zone");  
    var circleSel=document.getElementById("circle");
    var divisionSel=document.getElementById("divisionid");
    var subdivSel=document.getElementById("subdivision");
    var townSel=document.getElementById("townid");
    var substationSel=document.getElementById("substation");
    var searchBySel=document.getElementById("searchBy");

    var discomVal=discomSel.options[discomSel.selectedIndex].value; 
    var zoneVal=zoneSel.options[zoneSel.selectedIndex].value; 
    var circleVal=circleSel.options[circleSel.selectedIndex].value;
    var divisionVal=divisionSel.options[divisionSel.selectedIndex].value;
    var subdivVal=subdivSel.options[subdivSel.selectedIndex].value;
    var townVal=townSel.options[townSel.selectedIndex].value;
    var ssVal=substationSel.options[substationSel.selectedIndex].value;
    var searchByVal=searchBySel.options[searchBySel.selectedIndex].value;
   

    var searchType=0;
    var optVal=0;

    if(ssVal>0){      
        searchType=6;
        optVal=ssVal;      
    }
    
    else if(subdivVal>0){       
        searchType=5;
        optVal=subdivVal;      
    }
    else if(divisionVal>0){       
        searchType=4;
        optVal=divisionVal;      
    }
	else if(townVal>0){       
       // searchType=5;
	    searchType=3;
        optVal=townVal;      
    }
    else if(circleVal>0){       
        searchType=2;
        optVal=circleVal;      
    }
    else if(zoneVal>0){       
        searchType=8;
        optVal=zoneVal;      
    }
   else if(discomVal>0 &&  meterSearchId.length==0){       
        searchType=1;
        optVal=discomVal;      
    }
    else if(discomVal>0 && meterSearchId.length>0){       
        searchType=-1;
         optVal=discomVal;  
                
    }
//    else{      
//        searchType=-1;
//        optVal=0;  
//    }//end else

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }

    var url="getSearchMeters.jsp?meterId="+escape(meterSearchId)+"&opt="+escape(optVal)+"&searchType="+escape(searchType)+"&meterLoc="+escape(meterLoc);
      url=url+"&searchBy="+escape(searchByVal);
    //------------Removing the previous values---------------------
    for(var j=document.forms[0].dtr.options.length-1;j>=0;j--){
        document.forms[0].dtr.remove(j);
    }//end for
    //-----------End for removing values----------------------------

    xmlHttp.onreadystatechange=state_DTR_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
    
}//end method


function getDBBackup()
{
       xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDBBackup.jsp";
        xmlHttp.onreadystatechange=getDBBackupAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);   
}
function getDBBackupAction()
{
     document.getElementById('DataPart').style.display = "block";   
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        document.getElementById("DataPart").innerHTML= showdata;
    }
}
function exportInstant(data_type){
         var chbEMF=document.getElementById("AEMF");       
        sdate=document.getElementById("sDate").value;        
        edate=document.getElementById("eDate").value;        
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
         var url="Exports/exportInstant.jsp?data_type="+escape(data_type)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"&ApplyEMF="+(chbEMF.checked?"1":"0"); 
         window.location=url;
}