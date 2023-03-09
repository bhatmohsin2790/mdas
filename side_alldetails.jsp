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
	{
		 alert("Please Select Subdivision ");
	}
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
    alert("reached here......side all details.jsp...!"+emp_value);
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
<table border="0" style="font-size:12px;" height="450px">
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
                                                                      onChange="showSections(this.value);">
                <option value="-1">Select Sub_Division</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="left">
            Section :
        </td></tr><tr>
        <td>
            <select name="section" id ="section" style="width:150px;height:20px;font-size:12px;font-family:verdana;"
                                                            onChange="showSubStations(this.value);">
                <option value="-1">Select Section</option>
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
            <select name="feeder" id="feeder" style="width:150px;height:20px;font-size:12px;font-family:verdana;" >

                <option value="-1">Select Feeder</option>
            </select>
        </td>
    </tr>
    
</table>
</form>