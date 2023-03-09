<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
       
        <%@ include file="importpage.jsp"%>
		<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<link rel="stylesheet" type="text/css" href="js2/datatables/datatables.min.css" />
<script type="text/javascript" src="js2/datatables/datatables.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/table.css" />

        <script type="text/javascript">

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

             
             function commonAction()
             {
                    document.getElementById('home_msg').innerHTML = "";
                     document.getElementById("updateDataPart").innerHTML="";
                    document.getElementById("DataPart").innerHTML=document.getElementById("loading").innerHTML;
     if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete")
     {
                    var showData1=xmlHttp.responseText;
                    document.getElementById("DataPart").innerHTML=showData1;
                    $('#dtable').DataTable();
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
function showSubstations(emp_value)
{
        alert("electricmeters");
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
function getDCUData_For_Mapping(dcu_id)
{
    req=GetXmlHttpObject();
                if(req==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                /* Please write your URL and parameters */
                var url="get_Feeders_DCU.jsp?dcu_id="+dcu_id;

                req.onreadystatechange=list_feeders;
                req.open("GET",url,true);
                req.send(null);
            }
            function list_feeders()
            {
                
                if (req.readyState==4 || req.readyState=="complete")
                {
                    document.getElementById("feeders_data").innerHTML = req.responseText;
                    
                }   
            }
        </script>
    </head>
    <body onload="feederData(4);">
        <div id="navigation"></div>
        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                               <b>You are in Electrical Meters</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                   <%@ include file="master_links.jsp"%>

                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                       <!-- <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Alert Area</b>
                            </td>
                        </tr>
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">
                                1. Alert Description 1<br />
                                2. Alert Description 2<br />
                                3. Alert Description 3<br />

                            </td>
                        </tr>-->
                    </table>


                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                   <%@ include file="menu1.jsp"%>
                    <br/>

                    <%@ include file="addmeterElectrical.jsp"%>
                      <br/>
                        <div id="updateDataPart">
                        </div>
                    <div id="DataPart"  align="center" class="table-responsive"></div>
                    <div id="home_msg">
                        <p><h3 align="center"></h3></p>
                    </div>

                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation"></div>
        <%@ include file="bottom.jsp"%>

    </body>
	<div id="loading" style="display: none">
    <table width="100%"><tr><td align="center">
    <img src="./images/loading.jpg"/>
            </td></tr></table>
</div>
</html>
