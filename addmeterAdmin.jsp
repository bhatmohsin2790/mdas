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
                   addhtData();
               if(tabeId=="cont-2")
                  deletehtData();
              if(tabeId=="cont-3")
                updatehtData();
              if(tabeId=="cont-4")
                 viewhtData();
                return false;
            });
        });
    });
</script>
<script type="text/javascript">
    function addhtData()
    {
        xmlHttp=GetXmlHttpObject();
         if (xmlHttp==null)
         {
             alert ("Browser does not support HTTP Request");
                   return;
             }
             var url="addHTMeter.jsp";
                 xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                 xmlHttp.send(null);
    }
    function deletehtData()
    {
        xmlHttp=GetXmlHttpObject();
         if (xmlHttp==null)
         {
             alert ("Browser does not support HTTP Request");
                   return;
             }
             var url="deleteHTMeter.jsp";
                 xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                 xmlHttp.send(null);
    }
    function updatehtData()
    {
        xmlHttp=GetXmlHttpObject();
         if (xmlHttp==null)
         {
             alert ("Browser does not support HTTP Request");
                   return;
             }
             var url="updateHTMeter.jsp";
                 xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                 xmlHttp.send(null);
    }
    function viewhtData()
    {
        xmlHttp=GetXmlHttpObject();
         if (xmlHttp==null)
         {
             alert ("Browser does not support HTTP Request");
                   return;
             }
             var url="viewHTMeter.jsp";
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
			//var url="getCircles_1.jsp";
                        
                                                     var url="getCircles_1_260612.jsp";
			url=url+"?emp_id="+emp_value;
       //alert("url is="+url);
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
  // alert("show"+showdata);

    var strar = showdata.split(":");

	 if(strar.length==1)
	 {
		//  alert("Please Select Employee Id");
	 }
	 else if(strar.length>1)
	 {
	var strname = strar[1];

	//----- Values inserting into Combo Box Dynamicaly------
		for(var j=document.forms[0].circle.options.length-1;j>=0;j--)
                      {
				document.forms[0].circle.remove(j);
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
       //alert("url is="+url);
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
		for(var j=document.forms[0].substationId.options.length-1;j>=0;j--)
                      {
				document.forms[0].substationId.remove(j);
			}


                           var combo = document.getElementById("substationId");


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

function showSubStations(emp_value)
{
	if(emp_value!="-1")
	{
           
 		xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null)
			{
			  alert ("Browser does not support HTTP Request");
			  return;
			}
			//var url="getSubstations_1.jsp";
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
    var strar = showdata.split(":");
	 if(strar.length==1)
	 {
		//  alert("Please Select Employee Id");
	 }
	 else if(strar.length>1)
	 {
	var strname = strar[1];
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
    function addHTMeter()
    {
        htSel=document.getElementById("htId");
        htId=htSel.options[htSel.selectedIndex].value;

        meterSel=document.getElementById("meterId");
        meter=meterSel.options[meterSel.selectedIndex].value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/addHTMeterAction.jsp?htId="+escape(htId)+"&meterId="+escape(meter);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function activityAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            document.getElementById("updateDataPart").style.display="block";
            document.getElementById("DataPart").style.display="blockaddHTMeter";
            document.getElementById("updateDataPart").innerHTML=xmlHttp.responseText;
        }//end if
    }
    function deleteHTMeter()
    {
        htSel=document.getElementById("htId");
        htId=htSel.options[htSel.selectedIndex].value;

        meter=document.getElementById("mappedMeter").value;
      

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/deleteHTMeterAction.jsp?htId="+escape(htId)+"&meterId="+escape(meter);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
  
    function updateHTMeter()
    {
        htSel=document.getElementById("htId");
        htId=htSel.options[htSel.selectedIndex].value;

        meter=document.getElementById("mappedMeter").value;
        
       mSel=document.getElementById("newmeterId");
       newmeter=mSel.options[mSel.selectedIndex].value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/updateHTMeterAction.jsp?htId="+escape(htId)+"&oldmeter="+escape(meter)+"&newmeter="+escape(newmeter);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
   
    function showhtMeter(emp_value)
    {
         xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="getHTMappedMeters.jsp?emp_id="+escape(emp_value);
        xmlHttp.onreadystatechange=showhtMeterAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function showhtMeterAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata=xmlHttp.responseText;
           document.getElementById("mappedMeter").value=showdata.substring(showdata.indexOf("_")+1);
        }
    }
</script>
<div class="tab-box">
    <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
    <a href="" class="tabLink " id="cont-1" >ADD</a>
    <a href="javascript:;" class="tabLink " id="cont-2">DELETE</a>
    <a href="javascript:;" class="tabLink " id="cont-3">UPDATE</a>
    <% }else{} %>
    <a href="javascript:;" class="tabLink activeLink" id="cont-4">VIEW</a>


</div>

 

        






