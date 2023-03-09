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
function showTowns(emp_value)
{
    alert("admin send sms");
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
       //alert("url is="+url);
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
        alert("reached here.........!"+emp_value);
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
function showFeeders(emp_value)
{
        alert("reached here.....admin send sms.js....!"+emp_value);
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
                var option = document.createElement("option");
                option.text = strar[i].substring(strar[i].indexOf("_")+1);//textb.value;
                option.value = strar[i].substring(0, strar[i].indexOf("_"));//textb.value;
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
function getConfigHirarchy(meterLoc)
{
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }

    var url="getHirarchySM.jsp?meterLoc="+escape(meterLoc);
    xmlHttp.onreadystatechange=insertConfigHirarchy;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}//end method
function insertConfigHirarchy(){

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
        alert("reached here.........!"+emp_value);
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
        //old
        //var url="getDTRs.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
        var url="getLocationMeters.jsp?emp_id="+escape(emp_value)+"&opt="+escape(i);
        xmlHttp.onreadystatechange=state_DTR_Changed;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }else
    {
        alert("Please Select Subdivision ");
    }
}//showDivisions
function getInstantData(meter_id)
{

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

}//getInstantanious Data
function getInstantaneousData()
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
}//getInstantaneousData
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
function getDataReportsInstantData(meter_id)
{

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getInstantData.jsp";
    url=url+"?meter_id="+meter_id;
    //alert(url);
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
}//state_DTR_Changed
function searchConfigMeters(meterLoc){
    var meterSearchId=document.getElementById("meterSearchId").value;
   
    var townSel=document.getElementById("townId");
    var substationSel=document.getElementById("substation");   
   
    var townVal=townSel.options[townSel.selectedIndex].value;
    var ssVal=substationSel.options[substationSel.selectedIndex].value;
   
   

    var searchType=0;
    var optVal=0;

    if(ssVal>0){      
        searchType=6;
        optVal=ssVal;      
    }
    else if(townVal>0){       
        searchType=5;
        optVal=townVal;      
    }
    else if(subdivVal>0){       
        searchType=4;
        optVal=subdivVal;      
    }
    else if(divisionVal>0){       
        searchType=3;
        optVal=divisionVal;      
    }
    else if(circleVal>0){       
        searchType=2;
        optVal=circleVal;      
    }
   else if(discomVal>0){       
        searchType=1;
        optVal=discomVal;      
    }
    else{      
        searchType=-1;
        optVal=0;  
    }//end else

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }

    var url="getSearchMeters.jsp?meterId="+escape(meterSearchId)+"&opt="+escape(optVal)+"&searchType="+escape(searchType)+"&meterLoc="+escape(meterLoc);
   // alert(url);

    //------------Removing the previous values---------------------
    for(var j=document.forms[0].dtr.options.length-1;j>=0;j--){
        document.forms[0].dtr.remove(j);
    }//end for
    //-----------End for removing values----------------------------

    xmlHttp.onreadystatechange=state_DTR_Changed;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
    
}
    
