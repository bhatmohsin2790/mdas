function getCommunicationSummary(){
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
   var fromDate=document.getElementById("startingDate").value;
   var toDate=document.getElementById("endingDate").value;
          
   document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
   
    var url="Analysis/comm_summary_dayise.jsp?from="+escape(fromDate)+"&to="+escape(toDate);
   
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);
}

function getBreakDownHistory(){
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
   var fromDate=document.getElementById("startingDate").value;
   var toDate=document.getElementById("endingDate").value;
   var meterNoSel=document.getElementById("meters");
   var meterNo=meterNoSel.options[meterNoSel.selectedIndex].value;
       
   document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
    var url="Analysis/getBreakDownHistory.jsp?meterNo="+escape(meterNo)+"&fromDate="+escape(fromDate)+"&toDate="+escape(toDate);
    //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);
}
function getMeters(meterType){
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
function getConsumptionAnal(){
    
   xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
   var fromDate=document.getElementById("startingDate").value;
   var toDate=document.getElementById("endingDate").value;
    var townSel=document.getElementById("town");
    var townId=townSel.options[townSel.selectedIndex].value;
     metersSel=document.getElementsByName("Mtype");
     var catSel=document.getElementById("SCriteria");
     var category=catSel.options[catSel.selectedIndex].value;
               var meterType ;
                for(var i=0;i<metersSel.length;i++){
                    if(metersSel[i].checked==true)
                        meterType=metersSel[i].value;
                }
                
                if(meterType==null){
                    alert("Select meter type");
                    return;
                }
                document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
    var url="Analysis/Consumption.jsp?townId="+escape(townId)+"&fromDate="+escape(fromDate)+"&toDate="+escape(toDate)+"&meterType="+meterType+"&category="+escape(category);
   //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null); 
}
function getNewSites(){
   xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
   var fromDate=document.getElementById("startingDate").value;
   var toDate=document.getElementById("endingDate").value;
   document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
    var url="Analysis/newSites.jsp?fromDate="+escape(fromDate)+"&toDate="+escape(toDate);
   //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);  
}
function getPowerAnal(){
    document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
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
                    return;
                }
    var reportDate=document.getElementById("startingDate").value;
    var townSel=document.getElementById("town");
    var townId=townSel.options[townSel.selectedIndex].value;
    var catSel=document.getElementById("SCriteria");
    var category=catSel.options[catSel.selectedIndex].value;              
    var url="Analysis/powerOnOff.jsp?townId="+escape(townId)+"&reportDate="+escape(reportDate)+"&metersType="+meterType+"&category="+category;
   //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);  
}
function getAllAlerts(){
    document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
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
                    return;
                }
    var townSel=document.getElementById("town");
    var townId=townSel.options[townSel.selectedIndex].value;
    var catSel=document.getElementById("SCriteria");
    var category=catSel.options[catSel.selectedIndex].value;              
    var url="Analysis/getAllAlerts.jsp?townId="+escape(townId)+"&metersType="+meterType+"&category="+escape(category);
   //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);  
}
function getPowerOnOff10hr(){
     document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
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
        return;
    }
        
    var catSel=document.getElementById("SCriteria");
    var category=catSel.options[catSel.selectedIndex].value;
     if (category == "all") {
        var url = "Analysis/powerOnOff10hr.jsp?townId=0&metersType=" + meterType + "&category=" + escape(category);
    }
    else {
        var townSel = document.getElementById("town");
        var townId = townSel.options[townSel.selectedIndex].value;
        var url = "Analysis/powerOnOff10hr.jsp?townId=" + escape(townId) + "&metersType=" + meterType + "&category=" + escape(category);

    }
    //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);    
}
function getNonCommMeters(){
     document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
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
        return;
    }
    var url="";
    
    
    var catSel=document.getElementById("SCriteria");
    var category=catSel.options[catSel.selectedIndex].value;
   // var reportDate=document.getElementById("ncDate").value;
    if(category=="all"){
       url="Analysis/getNonCommMeters.jsp?townId=0&metersType="+meterType+"&category="+escape(category);
	   //+"&reportDate="+escape(reportDate);
   }
   else{
       var townSel=document.getElementById("town");
       var townId=townSel.options[townSel.selectedIndex].value;
        url="Analysis/getNonCommMeters.jsp?townId="+escape(townId)+"&metersType="+meterType+"&category="+escape(category);
		//+"&reportDate="+escape(reportDate);
        
    }
        //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);    
}

function getBillingSummary(){
     document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
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
        return;
    }
    var url="";
    
    
    var catSel=document.getElementById("SCriteria");
    var category=catSel.options[catSel.selectedIndex].value;
    var reportDate=document.getElementById("month").value;
    if(category=="all"){
       url="Analysis/getNonCommMeters.jsp?townId=0&metersType="+meterType+"&category="+escape(category)+"&reportDate="+escape(reportDate);
   }
   else{
       var townSel=document.getElementById("town");
       var townId=townSel.options[townSel.selectedIndex].value;
        url="Analysis/getBillingSummary.jsp?townId="+escape(townId)+"&metersType="+meterType+"&category="+escape(category)+"&reportDate="+escape(reportDate);
        
    }
        //alert(url);
    xmlHttp.onreadystatechange=analysis_commonAction;
    xmlHttp.open("GET",url,false);
    xmlHttp.send(null);    
}


function getExcel(tableId){
table=document.getElementById(''+tableId+'');
if (!table.nodeType) table = document.getElementById(table);
excelDownload(table.outerHTML, "Export.xls", "application/vnd.ms-excel");
}
function excelDownload(strData, strFileName, strMimeType) {
var D = document,
A = arguments,
a = D.createElement("a"),
d = A[0],
n = A[1],
t = A[2] || "text/plain";

//build download link:
a.href = "data:" + strMimeType + "," + escape(strData);


if (window.MSBlobBuilder) {
var bb = new MSBlobBuilder();
bb.append(strData);
return navigator.msSaveBlob(bb, strFileName);
} /* end if(window.MSBlobBuilder) */

 

if ('download' in a) {
a.setAttribute("download", n);
a.innerHTML = "downloading...";
D.body.appendChild(a);
setTimeout(function() {
var e = D.createEvent("MouseEvents");
e.initMouseEvent("click", true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
a.dispatchEvent(e);
D.body.removeChild(a);
}, 66);
return true;
} /* end if('download' in a) */
; //end if a[download]?

//do iframe dataURL download:
var f = D.createElement("iframe");
D.body.appendChild(f);
f.src = "data:" + (A[2] ? A[2] : "application/octet-stream") + (window.btoa ? ";base64" : "") + "," + (window.btoa ? window.btoa : escape)(strData);
setTimeout(function() {
D.body.removeChild(f);
}, 333);
return true;
} /* end download library function () */

function analysis_commonAction(){
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        document.getElementById("report_part").innerHTML= showdata;
         $('#dtable').DataTable( {
                                dom: 'Bfrtip',
                                buttons: [
                                    'copyHtml5',
                                    'excelHtml5',
                                    'csvHtml5'
                                ]
                            } );
    }
  }