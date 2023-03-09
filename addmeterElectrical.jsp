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
              dcuMapping();
          }

               


                return false;
            });
        });
    });
</script>

<script>
function dcuMapping()
{
    xmlHttp=GetXmlHttpObject();
     if (xmlHttp==null)
     {
         alert ("Browser does not support HTTP Request");
               return;
         }
         var url="dcu_mapping.jsp";
         xmlHttp.onreadystatechange=dcuMappingAction;
          xmlHttp.open("GET",url,true);
          xmlHttp.send(null);
    
}
function dcuMappingAction()
{
                    document.getElementById('home_msg').innerHTML = "";
                    document.getElementById("updateDataPart").innerHTML="";
                    document.getElementById("DataPart").style.display="block";
                    var showData1=xmlHttp.responseText;
                    document.getElementById("DataPart").innerHTML=showData1;
}
function feederData(data_type)
{
      xmlHttp=GetXmlHttpObject();
     if (xmlHttp==null)
     {
         alert ("Browser does not support HTTP Request");
               return;
         }
    if(data_type==1)
          var url="addFeederMeter.jsp";
     if(data_type==2)
         var url="deleteFeederMeter.jsp";
     if(data_type==3)
       var url="updateFeederMeter.jsp";
     if(data_type==4)
        var url="viewFeederMeter.jsp";
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
         if(data_type==1)
             var url="addDtrMeter.jsp";
          if(data_type==2)
              var url="deleteDtrMeter.jsp";
          if(data_type==3)
            var url="updateDtrMeter.jsp";
        if(data_type==4)
             var url="viewDtrMeter.jsp";
        xmlHttp.onreadystatechange=commonAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        }

    


</script>
<script type="text/javascript">
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

</script>
<script type="text/javascript">
    function insertDtrMeter()
    {
        dtrSel=document.getElementById("dtrId");
        dtrId=dtrSel.options[dtrSel.selectedIndex].value;
        
        meterSel=document.getElementById("meterId");
        meter=meterSel.options[meterSel.selectedIndex].value;
       
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/addDtrMeterAction.jsp?dtrId="+escape(dtrId)+"&meterId="+escape(meter);
        //alert(url);
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
    function insertFeederMeter()
    {
         feederS=document.getElementById("feederId");
        feederid=feederS.options[feederS.selectedIndex].value;
        
        meterSelected=document.getElementById("meterId");
        meterId=meterSelected.options[meterSelected.selectedIndex].value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/addFeederMeterAction.jsp?feederId="+escape(feederid)+"&meterId="+escape(meterId);
        //alert(url);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
   
    function showdtrMeter(emp_value)
    {
         xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="getDtrMappedMeters.jsp?emp_id="+escape(emp_value);
        xmlHttp.onreadystatechange=showdtrMeterAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function showdtrMeterAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata=xmlHttp.responseText;        
          
           document.getElementById("mappedMeter").value=showdata.substring(showdata.indexOf("_")+1);
        }
    }
    function deleteDtrMeter()
    {
         dtrS=document.getElementById("dtrId");
        dtrid=dtrS.options[dtrS.selectedIndex].value;        
        meterName=document.getElementById("mappedMeter").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/deleteDtrMeterAction.jsp?dtrId="+escape(dtrid)+"&meterId="+escape(meterName);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    
    function updateDtrMeter()
    {
        dtrSel=document.getElementById("dtrId");
        dtrId=dtrSel.options[dtrSel.selectedIndex].value;

        meterSel=document.getElementById("newmeterId");
        meter=meterSel.options[meterSel.selectedIndex].value;
        oldMeter=document.getElementById("mappedMeter").value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/updateDtrMeterAction.jsp?dtrId="+escape(dtrId)+"&meterId="+escape(meter)+"&oldmeter="+escape(oldMeter);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
  
    function showFeederMeter(emp_value)
    {
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
      alert ("Browser does not support HTTP Request");
      return;
    }
    var url="getFeederMappedMeters.jsp?emp_id="+escape(emp_value);
    xmlHttp.onreadystatechange=showFeederMeterAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
    }
    function showFeederMeterAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata=xmlHttp.responseText;
           document.getElementById("feederMeter").value=showdata.substring(showdata.indexOf("_")+1);
        }
    }
    function deleteFeederMeter()
    {
         feederS=document.getElementById("feederId");
        feederid=feederS.options[feederS.selectedIndex].value;
        meterName=document.getElementById("feederMeter").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/deleteFeederMeterAction.jsp?feederId="+escape(feederid)+"&meterId="+escape(meterName);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
   
    function updateFeederMeter()
    {
        fSel=document.getElementById("feederId");
        feederId=fSel.options[fSel.selectedIndex].value;

        meterSel=document.getElementById("newmeterId");
        meter=meterSel.options[meterSel.selectedIndex].value;
        oldMeter=document.getElementById("feederMeter").value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
          alert ("Browser does not support HTTP Request");
          return;
        }
        var url="master_data_actions/updateFeederMeterAction.jsp?feederId="+escape(feederId)+"&meterId="+escape(meter)+"&oldmeter="+escape(oldMeter);
        xmlHttp.onreadystatechange=activityAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }    
        
</script>
<div class="tab-box">
   <!-- <a href="javascript:;" class="tabLink activeLink" id="cont-1">SubStation</a> -->
    <a href="javascript:;" class="tabLink activeLink " id="cont-2">Feeder</a>
    <a href="javascript:;" class="tabLink " id="cont-3">DTR</a> 
    <a href="javascript:;" class="tabLink " id="cont-4">DCU-Feeder</a> 
</div>


<div class="tabcontent paddingAll " id="cont-2-1">
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <%
                           if(session.getAttribute("user_type").equals("Administrator"))
                           {
                        %>
     <div class="button_style"> <input type="radio" name="Feeder" id="Feeder" value="1"   onclick="feederData(this.value)"> Add &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="Feeder" id="Feeder" value="2" onclick="feederData(this.value)"> Delete</div>
    <div class="button_style"><input type="radio" name="Feeder" id="Feeder" value="3" onclick="feederData(this.value)"> Update</div>
     <% }else{} %>
    <div class="button_style"><input type="radio" name="Feeder" id="Feeder" value="4" checked  onclick="feederData(this.value)"> View</div>
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
    <div class="button_style"><input type="radio" name="Dtr" id="Dtr" value="4" checked onclick="dtrData(this.value)"> View</div>
</div>

