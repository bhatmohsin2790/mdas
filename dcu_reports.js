
function getHistory_Instant()
{
    document.getElementById("DataPart2").innerHTML= document.getElementById("wait_div").innerHTML;
    var feeder_id = document.getElementById("selfeeder").value;
    var dcu_id = document.getElementById("substation").value;
    var from_date = document.getElementById("fromdate").value;
    var from_time = document.getElementById("fromtime").value;
    var to_date = document.getElementById("todate").value;
    var to_time = document.getElementById("totime").value;
    //alert(from_date);
    if(document.getElementById("substation").value==-1)
    {
        alert('Select dcu ...');
    }
    else
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDCU_Instant_History_Data.jsp?dcu_id="+dcu_id+"&feeder_id="+feeder_id+"&from_date="+from_date+"&to_date="+to_date+"&from_time="+from_time+"&to_time="+to_time;
        xmlHttp.onreadystatechange=getDCU_Instant_History_Data;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
}
function getHistory_DI()
{
    document.getElementById("DataPart2").innerHTML= document.getElementById("wait_div").innerHTML;
    var dcu_id = document.getElementById("substation").value;
    var from_date = document.getElementById("fromdate").value;
    var from_time = document.getElementById("fromtime").value;
    var to_date = document.getElementById("todate").value;
    var to_time = document.getElementById("totime").value;
    //alert(from_date);
    if(document.getElementById("substation").value==-1)
    {
        alert('Select dcu ...');
    }
    else
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDCU_DI_History_Data.jsp?dcu_id="+dcu_id+"&from_date="+from_date+"&to_date="+to_date+"&from_time="+from_time+"&to_time="+to_time;
        xmlHttp.onreadystatechange=getDCU_Instant_History_Data;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
}
function getHistory_AI()
{
    document.getElementById("DataPart2").innerHTML= document.getElementById("wait_div").innerHTML;
    var dcu_id = document.getElementById("substation").value;
    var from_date = document.getElementById("fromdate").value;
    var from_time = document.getElementById("fromtime").value;
    var to_date = document.getElementById("todate").value;
    var to_time = document.getElementById("totime").value;
    //alert(from_date);
    if(document.getElementById("substation").value==-1)
    {
        alert('Select dcu ...');
    }
    else
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDCU_AI_History_Data.jsp?dcu_id="+dcu_id+"&from_date="+from_date+"&to_date="+to_date+"&from_time="+from_time+"&to_time="+to_time;
        xmlHttp.onreadystatechange=getDCU_Instant_History_Data;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
}
function getHistory_LS()
{
    document.getElementById("DataPart2").innerHTML= document.getElementById("wait_div").innerHTML;
    var feeder_id = document.getElementById("selfeeder").value;
    var dcu_id = document.getElementById("substation").value;
    var from_date = document.getElementById("fromdate").value;
    var to_date = document.getElementById("todate").value;
    //alert(from_date);
    if(document.getElementById("substation").value==-1)
    {
        alert('Select dcu ...');
    }
    else
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDCU_LS_History_Data.jsp?dcu_id="+dcu_id+"&feeder_id="+feeder_id+"&from_date="+from_date+"&to_date="+to_date;
        xmlHttp.onreadystatechange=getDCU_Instant_History_Data;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
}
function getHistory_Tamper()
{
    document.getElementById("DataPart2").innerHTML= document.getElementById("wait_div").innerHTML;
    var feeder_id = document.getElementById("selfeeder").value;
    var dcu_id = document.getElementById("substation").value;
    var from_date = document.getElementById("fromdate").value;
    var to_date = document.getElementById("todate").value;
    //alert(from_date);
    if(document.getElementById("substation").value==-1)
    {
        alert('Select dcu ...');
    }
    else
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getDCU_Tamper_History_Data.jsp?dcu_id="+dcu_id+"&feeder_id="+feeder_id+"&from_date="+from_date+"&to_date="+to_date;
        xmlHttp.onreadystatechange=getDCU_Instant_History_Data;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
}
function getDCUData()
{
    
    if(document.getElementById("substation").value==-1)
    {
        alert('Select dcu ...');
    }
    else
    {
       
        document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
       // alert(document.getElementById("substation").value)
        var dcu_opt = get_radio_value();
        var myOpts = document.getElementById('dtr').options;
        //alert(myOpts.length);
        var meter_ids = "";
        for(var loop=1;loop<myOpts.length;loop++)
        {
            if(loop==myOpts.length-1)
                meter_ids = meter_ids + myOpts[loop].value;
            else
                meter_ids = meter_ids + myOpts[loop].value + ",";
        }
       // alert(meter_ids);
        //alert(dcu_opt);
        //this is for instantanious data
        //alert("dcu_opt "+dcu_opt)
        if(dcu_opt==1)
        {
            var url="getDCU_Instant_Data.jsp?dcu_id="+meter_ids;
            //alert(url);
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for instantanious historical data
        if(dcu_opt==2)
        {
            alert("123")
            var url="getDCU_Instant_Data_HistoryMenu.jsp?dcu_id="+meter_ids
            //alert(url);
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for analog data
        if(dcu_opt==3)
        {
            var url="getDCU_AI_Data.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_AI_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        
        //this is for analog history data
        if(dcu_opt==4)
        {
            var url="getDCU_AI_Data_HistoryMenu.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_AI_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for digital data
        if(dcu_opt==5)
        {
            var url="getDCU_DI_Data.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_AI_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for digital historical data
        if(dcu_opt==6)
        {
            var url="getDCU_DI_Data_HistoryMenu.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for soe data
        if(dcu_opt==7)
        {
            var url="getDCU_SOE_Data.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_AI_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for ls data
        if(dcu_opt==8)
        {
            var url="getDCU_LS_Data.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_AI_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for LS historical data
        if(dcu_opt==9)
        {
            var url="getDCU_LS_Data_HistoryMenu.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for tamper data
        if(dcu_opt==10)
        {
            var url="getDCU_Tamper_Data.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_AI_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }

        //this is for Tamper historical data
        if(dcu_opt==11)
        {
            var url="getDCU_Tamper_Data_HistoryMenu.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        
        //this is for Billing data
        if(dcu_opt==12)
        {
            var url="getDCU_Billing_Data.jsp?dcu_id="+meter_ids;
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        
        //this is for Transformation loss report
        if(dcu_opt==13)   //for Transformation loss report
        {
            var url="getDCU_Transfrm_Loss_Date_Selection.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        if(dcu_opt==14)  // for miscellaneous reports
        {
            var url="getDCU_Miscellaneous_Report.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        if(dcu_opt==15)   //to send ondemand to dCU
        {
            var ssId=document.getElementById("substation").value;            
            if(ssId==0) alert("please select Substation");
            var url="DCU_ondemand.jsp?dcu_id="+ssId;
           // alert(url);
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
        if(dcu_opt==16)  // for OD Reports
        {
            var url="getDCU_OD_Report.jsp?dcu_id="+meter_ids
            xmlHttp.onreadystatechange=getDCU_Instant_Data;
            xmlHttp.open("GET",url,true);
            xmlHttp.send(null);
        }
    }
}
function getDCU_Instant_Data()
{
    document.getElementById('DataPart').style.display = "block";
    //document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
    }
}
function getDCU_Instant_History_Data()
{
    document.getElementById('DataPart2').style.display = "block";
    //document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart2").innerHTML= showdata;
    }
}
function getDCU_AI_Data()
{
    document.getElementById('DataPart').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
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
function get_radio_value() {
            var inputs = document.getElementsByName("dcu_opt");
            var i1 = 0;
            for (var i = 0; i < inputs.length; i++) {
              if (inputs[i].checked) {
                  i1 = 1;
                return inputs[i].value;
              }
            }
            document.getElementsByName("dcu_opt")[0].checked = true;
            return 1;
          }
function getDCU_Loss_Report()
{
    var dcu_id = document.getElementById("substation").value;
    var fdate = document.getElementById("fromdate").value;
    var tdate = document.getElementById("todate").value;
    var myOpts = document.getElementById('dtr').options;
        //alert(myOpts.length);
        var meter_ids = "";
        for(var loop=1;loop<myOpts.length;loop++)
        {
            if(loop==myOpts.length-1)
                meter_ids = meter_ids + myOpts[loop].title;
            else
                meter_ids = meter_ids + myOpts[loop].title + ",";
        }
    var url = "getDCU_Transfrm_Loss_Report.jsp?dcu_id="+meter_ids+"&fdate="+fdate+"&tdate="+tdate;
	//alert(url);
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    xmlHttp.onreadystatechange=getDCU_Transfrm_Loss_Report;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
function getDCU_Transfrm_Loss_Report()
{
    document.getElementById('DataPart2').style.display = "block";
    //document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart2").innerHTML= showdata;
    }
}
function getDCUConfig()
{
	var ssId=document.getElementById("substation").value;            
    if(ssId==0){alert("please select Substation");return;}
	mDASIP=document.getElementById("mDASIP").value;
	mDASFreq=document.getElementById("mDASFreq").value;
	lDMSIP=document.getElementById("lDMSIP").value;
	lDMSFreq=document.getElementById("lDMSFreq").value;
        
        Vrl=document.getElementById("Vrl").value;
        Vrh=document.getElementById("Vrh").value;
        Vyl=document.getElementById("Vyl").value;
        Vyh=document.getElementById("Vyh").value;
        Vbl=document.getElementById("Vbl").value;
        Vbh=document.getElementById("Vbh").value;
        
        Irl=document.getElementById("Irl").value;
        Irh=document.getElementById("Irh").value;
        Iyl=document.getElementById("Iyl").value;
        Iyh=document.getElementById("Iyh").value;
        Ibl=document.getElementById("Ibl").value;
        Ibh=document.getElementById("Ibh").value;
        

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
	var url="sendDCU_config.jsp?ssId="+escape(ssId)+"&mDASIP="+escape(mDASIP)+"&mDASFreq="+escape(mDASFreq)+"&lDMSIP="+escape(lDMSIP)+"&lDMSFreq="+escape(lDMSFreq);
	url=url+"&Vrl="+escape(Vrl)+"&Vrh="+escape(Vrh)+"&Vyl="+escape(Vyl)+"&Vyh="+escape(Vyh)+"&Vbl="+escape(Vbl)+"&Vbh="+escape(Vbh);
        url=url+"&Irl="+escape(Irl)+"&Irh="+escape(Irh)+"&Iyl="+escape(Iyl)+"&Iyh="+escape(Iyh)+"&Ibl="+escape(Ibl)+"&Ibh="+escape(Ibh);
        //alert(url);
    xmlHttp.onreadystatechange=getDCUConfigAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
function getDCUConfigAction(){
	document.getElementById('DataPart2').style.display = "block";
    //document.getElementById('report_header').style.display = "block";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
            var showdata = xmlHttp.responseText;
			//alert(showdata);
            document.getElementById("DataPart2").innerHTML= showdata;
    }
}
function editEmailId()
{
	document.getElementById('DataPart2').style.display = "block";
    var ssId=document.getElementById("substation").value;            
    if(ssId==0){alert("please select Substation");return;}
    var url="editDCUEmail.jsp?ssId="+escape(ssId);
    var left = (screen.width/2)-250;
    var top = (screen.height/2)-250;
	 xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
   // window.open (url, "mywindow","location=50,status=1,scrollbars=1, width=500,height=500,top="+top+",left="+left);
     xmlHttp.onreadystatechange=editEmailIdAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
function editEmailIdAction()
{
	 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
            var showdata = xmlHttp.responseText;
			//alert(showdata);
            var url="http://"+showdata.trim()+"/Home.cgi";
			//alert(url);
			 var left = (screen.width/2)-500;
             var top = (screen.height/2)-250;
			window.open (url, "mywindow","location=50,status=1,scrollbars=0, width=1000,height=500,top="+top+",left="+left);
           
    }
}
