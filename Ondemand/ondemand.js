 function getTowns(criteria,reportType){
     //reportType =1 for config/ondemand log reports and 2 for analysis reports
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
                        document.getElementById('towns').innerHTML = xmlHttp.responseText;
                    }
                }
                document.getElementById('towns').innerHTML = "";
                document.getElementById('MT').innerHTML = "";
                var url;
                if(reportType==1){
                   url="Ondemand/getAllTowns.jsp";				
				}
            if(reportType==2){
                var catSel=document.getElementById("SCriteria");
                var category=catSel.options[catSel.selectedIndex].value;
                //alert(category);
                if(category=="-1"){
                    return 0;
                }
               else if(category=="all")
                  url="Analysis/getMeterTypes.jsp?category="+escape(category);
                else if(category=="ZW")
                 url="Analysis/getAllZones.jsp";
              else if(category=="TW")
                 url="Analysis/getAllTowns.jsp";
             else if(category=="DW")
                 url="Analysis/getAllDivisions.jsp";
               else if(category=="SD")
                 url="Analysis/getAllSubdivisions.jsp";
               else if(category=="FD")
                 url="Analysis/getAllFeeders.jsp";
			}
                        if(reportType==3){
                var catSel=document.getElementById("SCriteria");
                var category=catSel.options[catSel.selectedIndex].value;
                //alert(category);
                if(category=="-1"){
                    return 0;
                }
               
             else if(category=="TW")
                 url="Analysis/getAllTowns_1.jsp";
              
			}
			xmlHttp.open("GET", url,true);
			 xmlHttp.send(null);
            } //function()
            function getSubstation(townId){
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
                        document.getElementById('SS').innerHTML = xmlHttp.responseText;
                    }
                }
                document.getElementById('SS').innerHTML = "";
                xmlHttp.open("GET", "Ondemand/getSSNames.jsp?townId="+townId,true);
                xmlHttp.send(null);
            } //function()   
            function getFeeders(SSid){
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
                        document.getElementById('FD').innerHTML = xmlHttp.responseText;
                    }
                }
                document.getElementById('FD').innerHTML = "";
                xmlHttp.open("GET", "Ondemand/getFeederNames.jsp?SSid="+SSid,true);
                xmlHttp.send(null);
            } //function()  
            function getMeterTypes(report_type){
                //report_type=1 for config/ondemand reports and report_type=2 for analysis reports
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
                        document.getElementById('MT').innerHTML = xmlHttp.responseText;
                    }
                }
                document.getElementById('MT').innerHTML = "";
                var url;
                if(report_type==1)
                url="Ondemand/getMeterTypes.jsp?townId="+document.forms[0].town.value+"&ssId="+document.forms[0].SS.value;
            if(report_type==2){
                var catSel=document.getElementById("SCriteria");
                var category=catSel.options[catSel.selectedIndex].value;
                url="Analysis/getMeterTypes.jsp?category="+category;
            }
            if(report_type==3){
                var catSel=document.getElementById("SCriteria");
                var category=catSel.options[catSel.selectedIndex].value;
                url="Analysis/getMeterTypes_1.jsp?category="+category;
            }
            xmlHttp.open("GET", url,true);
                xmlHttp.send(null);
            } //function()   
            function getDTRs(selectedValue){
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
               if(reportType=="sending"){
                     document.getElementById('commandSelection').style.display="block";
                      document.getElementById('dates').style.display="none";
               }
               if(reportType=="logs"){
                     document.getElementById('commandSelection').style.display="none";
                      document.getElementById('dates').style.display="block";
               }
                if(selectedValue=="DTR") {
                    xmlHttp.open("GET", "Ondemand/getDTRs.jsp?ssID="+document.forms[0].SS.value,true);
                   // document.getElementById('buttonRow').style.display="block";
                  
                }
                else if(selectedValue=="HT"){
                    xmlHttp.open("GET", "Ondemand/getHTs.jsp?ssID="+document.forms[0].SS.value,true);
                   // document.getElementById('buttonRow').style.display="block";  
                    
                }
                
                xmlHttp.send(null);
            } //function()             
            
            function sendCommandToModems(){
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
                if(selectedValue=="DTR") 
                    xmlHttp.open("GET", "./sendSMSToModem.jsp?meters="+document.forms[0].meters.value,true);
                xmlHttp.send(null);
                alert("End");
            }//sendCommandToModems()
            function togglecheckboxes(master,group){
                var cbarray = document.getElementsByName(group);
                for(var i = 0; i < cbarray.length; i++){
                    var cb = document.getElementById(cbarray[i].id);
                    cb.checked = master.checked;
                }
            }// togglecheckboxes()     
            function getOptions(value){
                //               alert(value);
                if(value=="DPCD" || value=="DPLS"){
                    document.getElementById('lsDays').style.display="";
                }else{
                    document.getElementById('lsDays').style.display="none";
                }
                if(value=="MN"){
                    document.getElementById('mnCB').style.display="";
                }else{
                    document.getElementById('mnCB').style.display="none";
                }
                if(value=="SLNO"){
                    document.getElementById('slnoCB').style.display="";
                }else{
                    document.getElementById('slnoCB').style.display="none";
                }
                if(value=="APNPortsChangeD"){
                    document.getElementById('apnCB').style.display="";
                }else{
                    document.getElementById('apnCB').style.display="none";
                }
                if(value=="APNPortsChangeS"){
                    document.getElementById('apnSCB').style.display="";
                }else{
                    document.getElementById('apnSCB').style.display="none";
                }           
                if(value=="FLGT"){
                    document.getElementById('flgtCB').style.display="";
                }else{
                    document.getElementById('flgtCB').style.display="none";
                }       
                if(value=="FLGI"){
                    document.getElementById('flgiCB').style.display="";
                }else{
                    document.getElementById('flgiCB').style.display="none";
                }            
                if(value=="INST"){
                    document.getElementById('instCB').style.display="";
                }else{
                    document.getElementById('instCB').style.display="none";
                }               
            }
            function sendSMSToModem(){
              
               document.getElementById("report_part").innerHTML= document.getElementById("loading").innerHTML;
               
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var requiredParams;
                var commandType=document.getElementById("CTM").value;
                
                metersSel=document.getElementsByName("meters");
                var checkedMeters=new Array();
                for(var i=0;i<metersSel.length;i++){
                    if(metersSel[i].checked==true)
                        checkedMeters=checkedMeters+metersSel[i].value+",";
                }
                if(checkedMeters.length==0)
                {
                    alert("Please select atleast one meter");
                    return;
                } 
if(commandType=="RST" || commandType=="FNS" || commandType=="FN1"){ requiredParams="NA";} 
if(commandType=="INST"){ requiredParams=document.getElementById("instFreq").value;}
if(commandType=="MN") { requiredParams= document.getElementById("MNValue").value;}
if(commandType=="APNPortsChangeS") { requiredParams= document.getElementById("serverIPS").value+","+document.getElementById("apnNameS").value+","+document.getElementById("apnPass").value;}
if(commandType=="FLGI"){requiredParams= document.getElementById("instStatus").value+","+document.getElementById("discomName").value;}
if(commandType=="DPCD" || commandType=="DPLS"){requiredParams= document.getElementById("lsDates").value;} 
if(commandType=="DPTD" || commandType=="DPIP"){ requiredParams="NA";}
if(commandType=="POTA" || commandType=="CONFIG" || commandType=="RDCFG"){ requiredParams="NA";} 
if(commandType=="SLNO"){requiredParams= document.getElementById("SLNoValue").value;} 
if(commandType=="FLGT"){requiredParams= document.getElementById("readTime").value+","+document.getElementById("transmitTime").value;}  
                var url="Ondemand/sendSMSToModem.jsp?CTM="+escape(commandType)+"&meters="+escape(checkedMeters)+"&requiredParams="+escape(requiredParams);
                alert(url);
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
            function commonAction(){
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    var showdata = xmlHttp.responseText;
                    document.getElementById("report_part").innerHTML= showdata;
                    scrollTable();
                }
            }
function getLogsReport(){
   
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var reportDate=document.getElementById("startingDate").value;
                metersSel=document.getElementsByName("meters");
                var checkedMeters=new Array();
                for(var i=0;i<metersSel.length;i++){
                    if(metersSel[i].checked==true)
                        checkedMeters=checkedMeters+metersSel[i].value+",";
                }
                if(checkedMeters.length==0)
                {
                    alert("Please select atleast one meter");
                    return;
                } 

                var url="Ondemand/OndemandLogReports.jsp?reportDate="+escape(reportDate)+"&meters="+escape(checkedMeters);
                //alert(url);
                xmlHttp.onreadystatechange=commonAction;
                xmlHttp.open("GET",url,false);
                xmlHttp.send(null);
}            