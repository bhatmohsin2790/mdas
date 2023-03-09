<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
<script language="JavaScript">
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
           //alert("emp value is"+emp_value);
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
	{}
//                       alert("D");
}//showDivisions

function stateChanged()
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
       // alert("name is:"+strname);
	//----- Values inserting into Combo Box Dynamicaly------
		for(var j=document.forms[0].division.options.length-1;j>=0;j--)
                       {
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
	{}
}

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
	{}
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
			//var url="getSubstations.jsp";
                                              var url="getSubstations_260612.jsp";
			url=url+"?emp_id="+emp_value;

			xmlHttp.onreadystatechange=state_SubStation_Changed;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{}
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
function showTowns(emp_value)
{
        alert("side alerts_1");
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
function showFeeders(emp_value)
{
    alert("reached here.....side alerts_1.jsp....!"+emp_value);
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
	{}
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
     reset();

    if(document.getElementById("dtr").length==0)
        {
            fSel=document.getElementById("feeder");
            feederId=fSel.options[fSel.selectedIndex].value;

            showDTRs(feederId,opt);
        }





}
function reset()
{
               var selObject=document.getElementById("dtr");
               if(selObject.options.length>0)
                   {
               for(var j=0;j<=selObject.options.length;j++)
               {
                   selObject.remove(0);
		}
                   }
}

function showDTRs(emp_value,i)
{

//    alert("reached here.........!"+emp_value);
    //------------Removing the previous values---------------------
	//for(var j=document.forms[0].division.options.length-1;j>=0;j--){
	//	document.forms[0].division.remove(j);
	//	}
   //-----------End for removing values----------------------------
	if(emp_value!="-1")
	{
 		xmlHttp=GetXmlHttpObject();
			if (xmlHttp==null)
			{
			  alert ("Browser does not support HTTP Request");
			  return;
			}
			var url="getDTRs_2.jsp";
			url=url+"?emp_id="+emp_value;
                        url=url+"&opt="+i;

			xmlHttp.onreadystatechange=state_DTR_Changed;
			xmlHttp.open("GET",url,true);
			xmlHttp.send(null);

	}else
	{}
}//showDivisions

function state_DTR_Changed()
{

 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
 {

    var showdata = xmlHttp.responseText;
   var strar = showdata.split(":");

	 if(strar.length==1)
	 {
		  alert(" No Meters Found");
	 }
	 else if(strar.length>1)
	 {
	var strname = strar[1];
        
	//----- Values inserting into Combo Box Dynamicaly------
		for(var j=document.forms[0].dtr.options.length-1;j>=0;j--){

				document.forms[0].dtr.remove(j);
			}
				var combo = document.getElementById("dtr");
			for(var i=0;i<strar.length-1;i++)
			{
				var option = document.createElement("option");
				option.text = strar[i].trim().substring(strar[i].trim().indexOf("_")+1);//textb.value;

                                option.value = strar[i].substring(0,strar[i].trim().indexOf("_"));//textb.value;

				try {
					combo.add(option, null); //Standard
				    }catch(error) {
					combo.add(option); // IE only

				}//try
			}//for
	//----- End of Values inserting into Combo Box Dynamicaly------


	 }

 }
}//state_DTR_Changed

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





</script>

<form  name="select">
<table border="0" style="font-size:12px;">
    <tr>
        <td align="left" style="line-height: 18px;">
            Circle :
        </td></tr><tr>
        <td>
            <select name="circle" id="circle" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                                       onChange="showDivisions(this.value);">
                <option value="-1">Select Circle</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                PreparedStatement pstmt = null;
                                ResultSet rs = null;
                                try {
                                    pstmt = con.prepareStatement("select * from circle");
                                    rs = pstmt.executeQuery();
                                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("circleid")%>"><%=rs.getString("circlename")%></option>
                <%
                                    }

                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                %>
            </select>
        </td>

    </tr>
    <tr>
        <td align="left">
            Division :
        </td></tr><tr>
        <td>
            <select name="division" id="division" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                                       onChange="showSubDivisions(this.value);">
                <option value="-1">Select Division</option>
            </select>
        </td>

    </tr>
    <tr>
        <td align="left">
            Sub Division :
        </td></tr><tr>
        <td>
            <select name="subdivision" id="subdivision" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                                      onChange="showTowns(this.value);">
                <option value="-1">Select Sub-Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Town :
        </td></tr><tr>
        <td>
            <select name="town" id ="townId" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                            onChange="showSubStations(this.value);">
                <option value="-1">Select Town</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Substation :
        </td></tr><tr>
        <td>
            <select name="substation" id="substation" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                           onChange="showFeeders(this.value);">
                <option value="-1">Select SubStation</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Feeder :
        </td></tr><tr>
        <td>
            <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;">

                <option value="-1">Select Feeder</option>
            </select>
        </td>
    </tr>
    <tr>
         <td align="center" colspan="2">
            <input type="radio" name="r1" value="feeder"  onclick="list_change(0);"> Feeder
            <input type="radio" name="r1" value="dtr" onclick="list_change(1);"> DTR
            <input type="radio" name="r1" value="ht" onclick="list_change(2);"> HT
        </td>
    </tr>
    <tr>
         <td align="center" colspan="2" valign="top">
             <select name="dtr" id="dtr"  style="width:150px;font-size:12px;font-family:verdana;" size="8"  onclick="sendMeterId()" >
            </select>
        </td>
    </tr>
    
</table>
</form>