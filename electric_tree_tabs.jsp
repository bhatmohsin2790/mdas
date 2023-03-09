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
                    var radioButtons = document.getElementsByName("SubStation");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                  substationData(but_value);
                }

                if(tabeId=="cont-2")
                {
                      var but_value;
                    var radioButtons = document.getElementsByName("Feeder");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                 feederData(but_value);

    }



                if(tabeId=="cont-3")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("Dtr");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
             dtrData(but_value);
                }

                if(tabeId=="cont-4")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("HT");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
               htData(but_value);
                }
                if(tabeId=="cont-5")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("DCU");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
               dcuData(but_value);
                }
                if(tabeId=="cont-6")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("DCUmap");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
               dcumapData(but_value);
                }


                return false;
            });
        });
    });
</script>

<script>
function substationData(data_type)
{
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addSubStation.jsp";
        if(data_type==2)
            url="deleteSubStation.jsp";
        if(data_type==3)
            url="updateSubStation.jsp";
        if(data_type==4)
            url="viewSubStation.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
    function showSubstations(emp_value)
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
                var url="getSubstations_1.jsp";
                url=url+"?emp_id="+emp_value;
                xmlHttp.onreadystatechange=showSsStateChanged;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
	}else
	{
		 alert("Please Select Zone ");
	}
}
function showSsStateChanged()
{
 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 {
    var showdata = xmlHttp.responseText;
        //alert("show"+showdata);
    var strar = showdata.split(":");
	 if(strar.length<1)
	 {
		//  alert("Please Select Employee Id");
	 }
	 else if(strar.length>=1)
	 {
	var strname = strar[1];
	//alert("show"+strname);
		for(var j=document.forms[0].ssId.options.length-1;j>=0;j--)
                {
                    document.forms[0].ssId.remove(j);
                }
                var combo = document.getElementById("ssId");
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
function feederData(data_type)
{
    xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addFeeder.jsp";
        if(data_type==2)
            url="deleteFeeder.jsp";
        if(data_type==3)
            url="updateFeeder.jsp";
        if(data_type==4)
            url="viewFeeder.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
function viewDtr(start)
{
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }        
        var url="viewDtr.jsp?start="+start;
        xmlHttp.onreadystatechange=commonAction;        
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
}
    function  dtrData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addDtr.jsp";
        if(data_type==2)
            url="deleteDtr.jsp";
        if(data_type==3)
            url="updateDtr.jsp";
        if(data_type==4)
            url="viewDtr.jsp?start=1";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
        
    }
    function htData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addHT.jsp";
        if(data_type==2)
            url="deleteHT.jsp";
        if(data_type==3)
            url="updateHT.jsp";
        if(data_type==4)
            url="viewHT.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
     function dcuData(data_type)
     {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        if(data_type==1)
            url="addDCU.jsp";
        if(data_type==2)
            url="deleteDCU.jsp";
        if(data_type==3)
            url="updateDCU.jsp";
        if(data_type==4)
            url="viewDCU.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
    }
    function dcumapData(data_type)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
            if(data_type==1)
            url="addDcdMap.jsp";
        if(data_type==2)
            url="deleteDcuMap.jsp";
        if(data_type==3)
            url="updateDCUMap.jsp";
        if(data_type==4)
            url="viewDCUMap.jsp";
        xmlHttp.onreadystatechange=commonAction;            
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        
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
			var url="getCircles_1_260612.jsp"
			url=url+"?emp_id="+emp_value;      
			xmlHttp.onreadystatechange=stateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);
	}else
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
		for(var j=document.forms[0].circleId.options.length-1;j>=0;j--)
                      {
				document.forms[0].circleId.remove(j);
			}

				//var combo = document.forms.addDivision.circle;

                           var combo = document.getElementById("circleId");


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
		//  alert("Please Select Employee Id");
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
function showSubStations(emp_value)
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
			//var url="getSubstations.jsp";
                                                     var url="getSubstations_260612.jsp";
			url=url+"?emp_id="+emp_value;
       
			xmlHttp.onreadystatechange=showSsStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select Zone ");
	}

}
function showSsStateChanged()
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
		for(var j=document.forms[0].ss.options.length-1;j>=0;j--)
                      {
				document.forms[0].ss.remove(j);
			}


                           var combo = document.getElementById("ssId");


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
function showDcu(emp_value)
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
			var url="getDcu.jsp";
			url=url+"?emp_id="+emp_value;
       //alert("url is="+url);
			xmlHttp.onreadystatechange=showDcuStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select Zone ");
	}

}
function showDcuStateChanged()
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
		for(var j=document.forms[0].dcu.options.length-1;j>=0;j--)
                      {
				document.forms[0].dcu.remove(j);
			}


                           var combo = document.getElementById("dcuId");


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
function getDcu(emp_value)
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
			var url="getDcu.jsp";
			url=url+"?emp_id="+emp_value;
       //alert("url is="+url);
			xmlHttp.onreadystatechange=getDcuStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select Zone ");
	}

}
function getDcuStateChanged()
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
		for(var j=document.forms[0].newdcu.options.length-1;j>=0;j--)
                      {
				document.forms[0].newdcu.remove(j);
			}


                           var combo = document.getElementById("newdcuId");


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
function getFeeders()
{


          //code to show the feeders in update feeders while selecting substation
         sstationSel=document.getElementById("ssId");
         var stationid=sstationSel.options[sstationSel.selectedIndex].value;

         showFeeders(stationid);
}

function showModems()
{


 		xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null)
			{
			  alert ("Browser does not support HTTP Request");
			  return;
			}
			var url="getModems.jsp";

			xmlHttp.onreadystatechange=showModemStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);



}
function showModemStateChanged()
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
	
		for(var j=document.forms[0].modem.options.length-1;j>=0;j--)
                      {
				document.forms[0].modem.remove(j);
			}


                           var combo = document.getElementById("modemId");


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
function showMapedModems(emp_value)
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
			var url="getModems_1.jsp";
			url=url+"?empid="+emp_value;
       //alert("url is="+url);
       document.getElementById("newdcuId").value=emp_value;
       dSel=document.getElementById("dcuId");
       oldDcu=dSel.options[dSel.selectedIndex].text;
       document.getElementById("dcuName").value=oldDcu;

			xmlHttp.onreadystatechange=showMappedModemsStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select DCU ");
	}



}
function showMappedModemsStateChanged()
{

 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 {

    var showdata = xmlHttp.responseText;
        //alert("show"+showdata);

    var strar = showdata.split(":");

	 if(strar.length==1)
	 {
		  alert("no mapping available for this DCU ");
	 }
	  else if(strar.length>1)
	 {
	var strname = strar[1];

	 //alert("show"+strname);

                     document.getElementById("mappedModem").value=strname.substring( strname.indexOf("_")+1);
	 }
         showModems();
 }


}
function showModemMapping(emp_value)
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
			var url="getModems_1.jsp";
			url=url+"?empid="+emp_value;
       //alert("url is="+url);


			xmlHttp.onreadystatechange=showModemMappingStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select DCU ");
	}



}
function showModemMappingStateChanged()
{

 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 {

    var showdata = xmlHttp.responseText;
       //alert("show"+showdata);

    var strar = showdata.split(":");

	 if(strar.length==1)
	 {
		  alert("no mapping available for this DCU ");
	 }
	  else if(strar.length>1)
	 {
	var strname = strar[1];

	 //alert("show"+strname);

                     document.getElementById("mappedModem").value=strname.substring( strname.indexOf("_")+1);
	 }

 }


}

function showFeeders(emp_value)
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
			var url="getFeeders_1.jsp";
			url=url+"?emp_id="+emp_value;
       //alert("url is="+url);
			xmlHttp.onreadystatechange=showFeedersStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select Zone ");
	}

}
function showFeedersStateChanged()
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
		for(var j=document.forms[0].feeder.options.length-1;j>=0;j--)
                      {
				document.forms[0].feeder.remove(j);
			}


                           var combo = document.getElementById("feederId");


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

function showDtrs(emp_value)
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
			var url="getDTRs_1.jsp";
			url=url+"?emp_id="+emp_value;
       //alert("url is="+url);
			xmlHttp.onreadystatechange=showDtrsStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select Zone ");
	}

}
function showDtrsStateChanged()
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
		for(var j=document.forms[0].dtr.options.length-1;j>=0;j--)
                      {
				document.forms[0].dtr.remove(j);
			}


                           var combo = document.getElementById("dtrId");


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
function showHT(emp_value)
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
			var url="getHT.jsp";
			url=url+"?emp_id="+emp_value;
       //alert("url is="+url);
			xmlHttp.onreadystatechange=showHTStateChanged;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{

		 alert("Please Select Zone ");
	}

}
function showHTStateChanged()
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
		for(var j=document.forms[0].ht.options.length-1;j>=0;j--)
                      {
				document.forms[0].ht.remove(j);
			}


                           var combo = document.getElementById("htId");


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
    function insertSubStation(){
       ssSel=document.getElementById("subdivisionId");
      subdiv=ssSel.options[ssSel.selectedIndex].value;      
       ss=document.getElementById("ssId").value;       
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addSubStationAction.jsp?subdivId="+escape(subdiv)+"&ssname="+escape(ss);
        xmlHttp.onreadystatechange=insertSubStationAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertSubStationAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function insertDCU(){

       ssSel=document.getElementById("ssId");
      substation=ssSel.options[ssSel.selectedIndex].value;
     dcu=document.getElementById("dcuId").value;     
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addDcuAction.jsp?substationId="+escape(substation)+"&dcu="+escape(dcu);
        //alert(url);
        xmlHttp.onreadystatechange=insertDCUAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertDCUAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function insertDCUMap(){

       dcuSel=document.getElementById("dcuId");
       dcu=dcuSel.options[dcuSel.selectedIndex].value;    

       modemSel=document.getElementById("modemId");
       modem= modemSel.options[ modemSel.selectedIndex].value;
      //alert(modem);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addDcuMapAction.jsp?dcuId="+escape(dcu)+"&modemId="+escape(modem);
        xmlHttp.onreadystatechange=insertDCUMapAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertDCUMapAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertFeeder(){

       ssSel=document.getElementById("ssId");
      substation=ssSel.options[ssSel.selectedIndex].value;
      dcuSel=document.getElementById("dcuId");
     dcu=   dcuSel.options[   dcuSel.selectedIndex].value;
       feeder=document.getElementById("feederId").value;       
       cVoltage=document.getElementById("Cvoltage").value;      
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addFeederAction.jsp?substationId="+escape(substation)+"&dcuId="+escape(dcu)+"&feedername="+escape(feeder)+"&cVoltage="+escape(cVoltage);
        xmlHttp.onreadystatechange=insertFeederAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertFeederAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertDtr(){

    feederSel=document.getElementById("feederId");
     feeder=feederSel.options[feederSel.selectedIndex].value;
     dtrCapacity=document.getElementById("dtrCapacity").value;
   // alert(dtrCapacity);
   dtr=document.getElementById("dtrId").value;
       //alert(dtr);

        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addDtrAction.jsp?feederId="+escape(feeder)+"&dtrName="+escape(dtr)+"&dtrCapacity="+escape(dtrCapacity);
        xmlHttp.onreadystatechange=insertDtrAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertDtrAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

    function insertHT(){

      feederSel=document.getElementById("feederId");
     feeder= feederSel.options[ feederSel.selectedIndex].value;
      consumer=document.getElementById("consumer").value;
        address =document.getElementById("address").value;
        mobileNo=document.getElementById("mobile").value;
        phoneNo=document.getElementById("phone").value;
        emailId=document.getElementById("email").value;
        altEmail=document.getElementById("altemail").value;
        consession=document.getElementById("concession").value;
        agrmntFromDate=document.getElementById("startingDate").value;
        agrmntToDate=document.getElementById("endingDate").value;
        conletterNo=document.getElementById("ConletterNo").value;
        rebate=document.getElementById("rebate").value;
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/addHtAction.jsp?feederId="+escape(feeder)+"&consumerName="+escape(consumer)+"&address="+escape(address)+"&mobileno="+escape(mobileNo)+"&phoneno="+escape(phoneNo)+"&emailid="+escape(emailId)+"&altemail="+escape(altEmail)+"&consession="+escape(consession)+"&fromDate="+escape(agrmntFromDate)+"&toDate="+escape(agrmntToDate)+"&conletterNo="+escape(conletterNo)+"&rebate="+escape(rebate);
        //alert("url is "+url);
        xmlHttp.onreadystatechange=insertHtAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function insertHtAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    </script>
<script type="text/javascript">
    function deleteHT()
    {
       htSel=document.getElementById("htId");
      ht=htSel.options[ htSel.selectedIndex].value;

     // alert(  ht);


        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteHtAction.jsp?htId="+escape(ht);
        xmlHttp.onreadystatechange=deleteHtAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function deleteHtAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteDtr()
    {
     dtrSel=document.getElementById("dtrId");
      dtr=dtrSel.options[ dtrSel.selectedIndex].value;

      //alert(  dtr);


        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteDtrAction.jsp?dtrId="+escape(dtr);
        xmlHttp.onreadystatechange=deleteDtrAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function deleteDtrAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteFeeder()
    {
     feederSel=document.getElementById("feederId");
     feeder= feederSel.options[  feederSel.selectedIndex].value;

      //alert(  feeder);


        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteFeederAction.jsp?feederId="+escape(feeder);
        xmlHttp.onreadystatechange=deleteFeederAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function deleteFeederAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteSs()
    {
     ssSel=document.getElementById("ssId");
     ss= ssSel.options[  ssSel.selectedIndex].value;

     // alert(  ss);


        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteSsAction.jsp?ssId="+escape(ss);
        xmlHttp.onreadystatechange=deleteSsAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function deleteSsAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteDcu()
     {
     dcuSel=document.getElementById("dcuId");
   dcu= dcuSel.options[  dcuSel.selectedIndex].value;

     // alert(  dcu);


        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteDcuAction.jsp?dcuId="+escape(dcu);
        xmlHttp.onreadystatechange=deleteDcuAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function deleteDcuAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method
    function deleteDCUMap()
     {

    modem=document.getElementById("mappedModem").value;
     //alert( modem);


        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/deleteDcuMapAction.jsp?modemSlNo="+escape(modem);
        xmlHttp.onreadystatechange=deleteDcuMapAction;



        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }//end method
    function deleteDcuMapAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }//end method

</script>
<script type="text/javascript">
    function updateMapping()
    {
        dcuId=document.getElementById("newdcuId").value;
        //alert("dcu"+dcuId);
        mappedModem=document.getElementById("mappedModem").value;
       // alert("old"+mappedModem);
        modemSel=document.getElementById("modemId");
        newModem=modemSel.options[modemSel.selectedIndex].text;
        //alert("new"+newModem);
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateDcuMapAction.jsp?dcuId="+escape(dcuId)+"&mappedModem="+escape(mappedModem)+"&newModem="+escape(newModem);
       //fffffffalert(url);

        xmlHttp.onreadystatechange=updateMappingAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function updateMappingAction()
    {
         if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function oldHT()
    {
        document.getElementById("hone").style.visibility="hidden";
        document.getElementById("htwo").style.visibility="visible";
        htSel=document.getElementById("htId");
        var htName=htSel.options[htSel.selectedIndex].text;
        var htId=htSel.options[htSel.selectedIndex].value;
        document.getElementById("newHtId").value=htId;
        document.getElementById("htname").value=htName;
        htssSel=document.getElementById("ssId");
        htssSelected=htssSel.options[htssSel.selectedIndex].value;
        xmlHttp=GetXmlHttpObject();

        //here write the code to get substation id/dcuid

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getFeeders_1.jsp?emp_id="+escape(htssSelected);//substation or dcu(doubt)
       // alert("url is "+url);

        xmlHttp.onreadystatechange=oldHTAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        // code to get and display consumer details into the form
         xmlHttp1=GetXmlHttpObject();

        if (xmlHttp1==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url1="getConsumerDetails.jsp?emp_id="+escape(htId);
        
        xmlHttp1.onreadystatechange=consumerDetailsAction;
        xmlHttp1.open("GET",url1,true);
        xmlHttp1.send(null);
    }
    function consumerDetailsAction()
    {
        if (xmlHttp1.readyState==4 || xmlHttp1.readyState=="complete")
 {
     var showdata = xmlHttp1.responseText;
     var strar=showdata.split("_");
     
     document.getElementById("newHtAddress").value=strar[0];
      document.getElementById("newMobileNo").value=strar[1];
       document.getElementById("newPhoneNo").value=strar[2];
       document.getElementById("newEmailId").value=strar[3];
       document.getElementById("newAltEmail").value=strar[4];
       document.getElementById("newConsession").value=strar[7];
       document.getElementById("startingDate").value=strar[5];
       document.getElementById("endingDate").value=strar[6];
        document.getElementById("newConletterNo").value=strar[8];
         document.getElementById("Rebate").value=strar[9];

 }

    }
    function oldHTAction()
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
		for(var j=document.forms[0].newfeeder.options.length-1;j>=0;j--)
                      {
				document.forms[0].newfeeder.remove(j);
			}

                           var combo = document.getElementById("newfeeder");


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
    function newHT()
    {
        var newName= document.getElementById("htname").value;
         htSel=document.getElementById("htId");
        var htConsumerId=htSel.options[htSel.selectedIndex].value;
        var address=document.getElementById("newHtAddress").value;
        var mobileno=document.getElementById("newMobileNo").value;
        var phoneno=document.getElementById("newPhoneNo").value;
        var email=document.getElementById("newEmailId").value;
        var altemail=document.getElementById("newAltEmail").value;
        var fromDate=document.getElementById("startingDate").value;
        var toDate=document.getElementById("endingDate").value;
        var concession=document.getElementById("newConsession").value;
        var conletterNo=document.getElementById("newConletterNo").value;
        var rebate=document.getElementById("Rebate").value;
         newfeederSel=document.getElementById("newfeeder");
        var newfeederId=newfeederSel.options[newfeederSel.selectedIndex].value;

         xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateHtAction.jsp?htId="+escape(htConsumerId)+"&htName="+escape(newName)+"&address="+escape(address)+"&mobileNo="+escape(mobileno)+"&phoneNo="+escape(phoneno)+"&emailId="+escape(email)+"&altemail="+escape(altemail)+"&fromDate="+escape(fromDate)+"&toDate="+escape(toDate)+"&concession="+escape(concession)+"&conletterNo="+escape(conletterNo)+"&rebate="+escape(rebate)+"&feederId="+escape(newfeederId);
       // alert("url is "+url);

        xmlHttp.onreadystatechange=newHTAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newHTAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function oldFeeder()
{
    feedSel=document.getElementById("feederId");
    feedId=feedSel.options[feedSel.selectedIndex].value;
    feedName=feedSel.options[feedSel.selectedIndex].text;
   document.getElementById("newfeederId").value=feedId;
   document.getElementById("newFeederName").value=feedName;

   sectSel=document.getElementById("subdivisionId");
    sectId=sectSel.options[sectSel.selectedIndex].value;
//code to get substations in dropdown list to change
 xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSubstations_260612.jsp?emp_id="+escape(sectId);
       // alert("url is "+url);

        xmlHttp.onreadystatechange=oldFeederAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
//code to get feeder details from database and display in updation part
       /*  xmlHttp1=GetXmlHttpObject();

        if (xmlHttp1==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url1="getFeederDetails.jsp?emp_id="+escape(feedId);
        xmlHttp1.onreadystatechange=FeederDetailsAction;
        xmlHttp1.open("GET",url1,true);
        xmlHttp1.send(null);   */

}
function FeederDetailsAction()
{
    if (xmlHttp1.readyState==4 || xmlHttp1.readyState=="complete")
 {
     var showdata=xmlHttp1.responseText;

     document.getElementById("newVoltage").value=showdata;
 }
 }
 function newFeeder()
 {
     feederId=document.getElementById("newfeederId").value;
     feederName=document.getElementById("newFeederName").value;
     classVoltage=document.getElementById("newVoltage").value;
     ssIdSel=document.getElementById("newssId");
     ssSelect=ssIdSel.options[ssIdSel.selectedIndex].value;
     dcuIdSel=document.getElementById("newdcuId");
     dcuSelect=dcuIdSel.options[dcuIdSel.selectedIndex].value;
     xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
         var url="master_data_actions/updateFeederAction.jsp?feederId="+escape(feederId)+"&feederName="+escape(feederName)+"&classVoltage="+escape(classVoltage)+"&ssSelect="+escape(ssSelect)+"&dcuSelect="+escape(dcuSelect);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newFeederAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

 }
 function newFeederAction()
 {
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";

            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
            document.getElementById("DataPart").style.display="display";

        }//end if
 }

function oldFeederAction()
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
		for(var j=document.forms[0].newss.options.length-1;j>=0;j--)
                      {
				document.forms[0].newss.remove(j);
			}

                           var combo = document.getElementById("newssId");


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
    function oldSs()
    {        
        ssSel=document.getElementById("ssId");
        var ssid=ssSel.options[ssSel.selectedIndex].value;
        var ssName=ssSel.options[ssSel.selectedIndex].text;
        document.getElementById("sstwo").style.visibility="visible";
        document.getElementById("newsid").value=ssid;
        document.getElementById("ssname").value=ssName;
        var divid = document.getElementById("divisionId").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
//        var url="getSections.jsp?emp_id="+escape(sdid);
        var url="getSubDivisions.jsp?emp_id="+escape(divid);        
        xmlHttp.onreadystatechange=oldSsAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function oldSsAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
           var showdata = xmlHttp.responseText;
          // alert(showdata);
        var strar = showdata.split(":");
	 if(strar.length==1)
	 {
		//  alert("Please Select Employee Id");
	 }
	 else if(strar.length>1)
	 {
            var strname = strar[1];
	//----- Values inserting into Combo Box Dynamicaly------
            for(var j=document.forms[0].newsubdivisionId.options.length-1;j>=0;j--)
            {
                document.forms[0].newsubdivisionId.remove(j);
            }
            var combo = document.getElementById("newsubdivisionId");
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
    function newSs()
    {
        var newName= document.getElementById("ssname").value;
        var newsdId = document.getElementById("newsubdivisionId").value;       
        var ssId=document.getElementById("newsid").value;        
        
        //alert("new Section name is"+newSname);
        if(newName==-1)
            alert("section name should be select");
        //alert("sd id "+sdId);
         xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateSubstationAction.jsp?newsdId="+escape(newsdId)+"&ssName="+escape(newName)+"&ssId="+escape(ssId);
       // alert("url is "+url);

        xmlHttp.onreadystatechange=newSsAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newSsAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";

            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
            document.getElementById("DataPart").style.display="display";

        }//end if
    }
    function oldDtr()
    {

        dtSel=document.getElementById("dtrId");
         var dtid=dtSel.options[dtSel.selectedIndex].value;
        var dtName=dtSel.options[dtSel.selectedIndex].text;

        document.getElementById("newdtrId").value=dtid;
        document.getElementById("dtrName").value=dtName;
     ssSel=document.getElementById("ssId");
          var ssid=ssSel.options[ssSel.selectedIndex].value;
        xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getFeeders_1.jsp?emp_id="+escape(ssid);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=oldDtrAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        //code to get dtr capacity from db
         xmlHttp2=GetXmlHttpObject();

        if (xmlHttp2==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDtrCapacity.jsp?emp_id="+escape(dtid);
        //alert("url is "+url);

        xmlHttp2.onreadystatechange=oldDtrCapacityAction;

        xmlHttp2.open("GET",url,true);
        xmlHttp2.send(null);

    }
   function oldDtrCapacityAction()
    {
        if (xmlHttp2.readyState==4 || xmlHttp2.readyState=="complete")
 {
     var showdata = xmlHttp2.responseText;
    // alert(showdata);
     document.getElementById("newCapacity").value=showdata;
 }

    }
    function oldDtrAction()
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
		for(var j=document.forms[0].newfeeder.options.length-1;j>=0;j--)
                      {
				document.forms[0].newfeeder.remove(j);
			}

                           var combo = document.getElementById("newfeederId");


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
    function newDtr()
   {
       var dtrId=document.getElementById("newdtrId").value;

        var newName= document.getElementById("dtrName").value;
        newCapacity=document.getElementById("newCapacity").value;
        //alert(newCapacity);
         fSel=document.getElementById("newfeederId");
        var fId=fSel.options[fSel.selectedIndex].value;


        if(fId==-1)
            alert("feeder name should be select");
        //alert("sd id "+sdId);
         xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateDtrAction.jsp?dtrId="+escape(dtrId)+"&dtrName="+escape(newName)+"&feederName="+escape(fId)+"&newCapacity="+escape(newCapacity);


        xmlHttp.onreadystatechange=newDtrAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function newDtrAction()
    {
       if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";

            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
            document.getElementById("DataPart").style.display="display";

        }

    }
    function oldDcu()
    {

        dcuSel=document.getElementById("dcuId");
        var dcuName=dcuSel.options[dcuSel.selectedIndex].text;
       var dcuId=dcuSel.options[dcuSel.selectedIndex].value;
       document.getElementById("dcuid").value=dcuId;
        document.getElementById("dcuName").value=dcuName;
        ssSel=document.getElementById("subdivisionId");
          var ssid=ssSel.options[ssSel.selectedIndex].value;
          xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSubstations_260612.jsp?emp_id="+escape(ssid);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=oldDcuAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function oldDcuAction()
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
		for(var j=document.forms[0].newss.options.length-1;j>=0;j--)
                      {
				document.forms[0].newss.remove(j);
			}

                           var combo = document.getElementById("newss");


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
    function newDcu()
    {
        var newName= document.getElementById("dcuName").value;
        //alert("new name is "+newName);
         dcuSel=document.getElementById("dcuId");
        var dcuId=dcuSel.options[dcuSel.selectedIndex].value;
       ssSel=document.getElementById("newss");
        var ssId=ssSel.options[ssSel.selectedIndex].value;
        if(ssId==-1)
            {alert("please select substation");}
        //alert("sd id "+sdId);
         xmlHttp=GetXmlHttpObject();

        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="master_data_actions/updateDcuAction.jsp?dcuId="+escape(dcuId)+"&dcuName="+escape(newName)+"&ssId="+escape(ssId);
        //alert("url is "+url);

        xmlHttp.onreadystatechange=newDcuAction;

        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function newDcuAction(){
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="display";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    </script>

<div class="tab-box">
    <a href="javascript:;" class="tabLink activeLink" id="cont-1">SubStation</a>
    <a href="javascript:;" class="tabLink " id="cont-5">DCU</a>
    <!--<a href="javascript:;" class="tabLink " id="cont-6">DCU_Mapping</a> -->
    <a href="javascript:;" class="tabLink " id="cont-2">Feeder</a>
    <a href="javascript:;" class="tabLink " id="cont-3">DTR</a>
    <a href="javascript:;" class="tabLink " id="cont-4">HT</a>


</div>



<div class="tabcontent paddingAll" id="cont-1-1">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <div class="button_style"> <input type="radio" name="SubStation" id="SubStation" value="1"   onclick="substationData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="SubStation" id="SubStation" value="2" onclick="substationData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="SubStation" id="SubStation" value="3" onclick="substationData(this.value)"> Update</div>
    <% }else{} %>
    <div class="button_style"><input type="radio" name="SubStation" id="SubStation" value="4" checked onclick="substationData(this.value)"> View</div>
</div>

<div class="tabcontent paddingAll hide" id="cont-2-1">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <div class="button_style"> <input type="radio" name="Feeder" id="Feeder" value="1"    onclick="feederData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="Feeder" id="Feeder" value="2" onclick="feederData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="Feeder" id="Feeder" value="3" onclick="feederData(this.value)"> Update</div>
    <% }else{} %>
    <div class="button_style"><input type="radio" name="Feeder" id="Feeder" value="4" checked onclick="feederData(this.value)"> View</div>
</div>

<div class="tabcontent paddingAll hide" id="cont-3-1">
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <div class="button_style"> <input type="radio" name="Dtr" id="Dtr" value="1"    onclick="dtrData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="Dtr" id="Dtr" value="2" onclick="dtrData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="Dtr" id="Dtr" value="3" onclick="dtrData(this.value)"> Update</div>
   <% }else{} %>
    <div class="button_style" ><input type="radio" name="Dtr" id="Dtr" value="4" checked onclick="dtrData(this.value)"> View

    </div>

</div>

<div class="tabcontent paddingAll hide" id="cont-4-1">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <div class="button_style"> <input type="radio" name="HT" id="HT" value="1"   onclick="htData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="HT" id="HT" value="2" onclick="htData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="HT" id="HT" value="3" onclick="htData(this.value)"> Update</div>
    <% }else{} %>
    <div class="button_style"><input type="radio" name="HT" id="HT" value="4" checked onclick="htData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-5-1">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <div class="button_style"> <input type="radio" name="DCU" id="DCU" value="1"   onclick="dcuData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="DCU" id="DCU" value="2" onclick="dcuData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="DCU" id="DCU" value="3" onclick="dcuData(this.value)"> Update</div>
    <% }else{} %>
    <div class="button_style"><input type="radio" name="DCU" id="DCU" value="4" checked onclick="dcuData(this.value)"> View</div>
</div>
<div class="tabcontent paddingAll hide" id="cont-6-1">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <div class="button_style"> <input type="radio" name="DCUmap" id="DCUmap" value="1"   onclick="dcumapData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="DCUmap" id="DCUmap" value="2" onclick="dcumapData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="DCUmap" id="DCUmap" value="3" onclick="dcumapData(this.value)"> Update</div>
    <% }else{} %>
    <div class="button_style"><input type="radio" name="DCUmap" id="DCUmap" value="4" checked onclick="dcumapData(this.value)"> View</div>
</div>