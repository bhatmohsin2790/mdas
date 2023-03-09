/* 
 * This file contains only rapdrp reports functions 
 *  such as CE/MD and AE/JE reports
 */
function getDateReports(){
    document.getElementById("report_part").innerHTML="";
        
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    metersSel=document.getElementsByName("Mtype");
   var meterType ;
    for(var i=0;i<metersSel.length;i++){
        if(metersSel[i].checked==true)
            meterType=metersSel[i].value;
    }
    if(meterType==null)
    {
        
        alert("Please select meter type");
        return 0;
    }
    var reportDate=document.getElementById("date").value;
    if(reportDate==""){
        
         alert("Please select Date");
        return 0;
    }
    var url;
    var townSel=document.getElementById("town");
    var townId=townSel.options[townSel.selectedIndex].value;
   document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML; 
    if(reportType=="ElectricInstant")
      url="RAPDRP/InstantElectric.jsp?townId="+escape(townId)+"&reportDate="+escape(reportDate)+"&metersType="+meterType;
    if(reportType=="SupplyAvailability")
        url="RAPDRP/SupplyAvailability.jsp?townId="+escape(townId)+"&reportDate="+escape(reportDate)+"&metersType="+meterType;
//   alert(url);
    xmlHttp.onreadystatechange=commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null); 
    
}

function getMonthlyReports(){
    document.getElementById("report_part").innerHTML="";
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    
    
    var reportMonth=document.getElementById("month").value;
    if(reportMonth==""){
         alert("Please select Month");
        return 0;
    }
    var url;
    document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
    if(reportType=="TamperSummary"){
        var townSel=document.getElementById("town");
        var townId=townSel.options[townSel.selectedIndex].value;
        var meterNoSel=document.getElementById("meters");
        var meterNo=meterNoSel.options[meterNoSel.selectedIndex].text;
        metersSel=document.getElementsByName("Mtype");
        var meterType ;
        for(var i=0;i<metersSel.length;i++){
            if(metersSel[i].checked==true)
                meterType=metersSel[i].value;
        }
        if(meterType==null)
        {
            alert("Please select meter type");
            return;
        }
        url="RAPDRP/TamperSummary.jsp?townId="+escape(townId)+"&reportMonth="+escape(reportMonth)+"&metersType="+meterType+"&meterNo="+meterNo;
    }   
  if(reportType=="SystemOverload")
      url="RAPDRP/SystemOverload.jsp?reportMonth="+escape(reportMonth);
  if(reportType=="AmrDataAvailability")
      url="RAPDRP/AmrDataAvailability.jsp?reportMonth="+escape(reportMonth);
    
   //alert(url);
    xmlHttp.onreadystatechange=commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null); 
}
function getMeters(meterType){
    if(reportType!="TamperSummary"){
        return 0;
    }
      var xmlHttp;
        try {
            xmlHttp = new XMLHttpRequest();// Firefox, Opera 8.0+, Safari
        } catch (e)
        {
            try {
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP"); // Internet Explorer
            } catch (e)
            {
                try {
                    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                } catch (e)
                {
                    alert("No AJAX!?");
                    return false;
                }
            }
        }        
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState == 4) {
                document.getElementById('metersPart').innerHTML = xmlHttp.responseText;
            }
        }
        document.getElementById('metersPart').innerHTML = "";

        if(meterType=="DTR") {
            xmlHttp.open("GET", "RAPDRP/getDTRs.jsp?townId="+document.forms[0].town.value,true);
        }
        else if(meterType=="HT"){
            xmlHttp.open("GET", "RAPDRP/getHTs.jsp?townId="+document.forms[0].town.value,true);
        }
        xmlHttp.send(null);
    }
function scrollTable(){   
   $("#scrollableTable").chromatable({	
				
				height: "400px",
				scrolling: "yes"
				
			});	
			
}