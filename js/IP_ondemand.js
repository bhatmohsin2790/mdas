//send config
function validateSendConfig(){
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var meterType;
    hirType=document.sideConfigForm.r1; 
    for (var i=0; i < hirType.length; i++)
    {
        if (hirType[i].checked)
        {
            meterType = hirType[i].value;
        }
    }//end for
    var sel=document.getElementById("dtr").options;
    var meterIds="";
    for(i=0;i<sel.length;i++){
        if(sel[i].selected){
            meterIds+=sel[i].title+",";
        }
    }//end for
    if(meterIds.length==0){
        alert("Please select meter/s");
        return;
    }
    var url="sendConfig.jsp?meterLocation="+escape(meterType)+"&meterIds="+escape(meterIds);  
    alert(url);
    xmlHttp.onreadystatechange=commonConfigAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);       
                
}//end method
//get config
function validateGetConfig(){

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var meterType;
    hirType=document.sideConfigForm.r1; 
    for (var i=0; i < hirType.length; i++)
    {
        if (hirType[i].checked)
        {
            meterType = hirType[i].value;
        }
    }//end for
    var sel=document.getElementById("dtr").options;
    var meterIds="";
    for(i=0;i<sel.length;i++){
        if(sel[i].selected){
            meterIds+=sel[i].title+",";
        }
    }//end for
    if(meterIds.length==0){
        alert("Please select meter/s");
        return;
    }
    var url="getConfig.jsp?meterLocation="+escape(meterType)+"&meterIds="+escape(meterIds);  
    // alert(url);
    xmlHttp.onreadystatechange=commonConfigAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);  

}//end method
//on demand
function validateOnDemand()
{
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
                                    
    hirType=document.sideConfigForm.r1;
    var meterType;
    hirType=document.sideConfigForm.r1; 
    for (var i=0; i < hirType.length; i++)
    {
        if (hirType[i].checked)
        {
            meterType = hirType[i].value;
        }
    }//end for     
                                    
    var sel=document.getElementById("dtr").options;
    var meterIds="";
    for(i=0;i<sel.length;i++){
        if(sel[i].selected){
            meterIds+=sel[i].title+",";
        }
    }//end for       
    if(meterIds.length==0){
        alert("Please select meter/s");
        return;
    }
    var type=document.getElementById("datatype");
    var dataType=type.options[type.selectedIndex].value;
    var lsDays="";
    if(dataType=="LS") lsDays=document.getElementById("lsDays").value;       
    var url="sendOnDemand.jsp?meterLocation="+escape(meterType)+"&meterIds="+escape(meterIds)+"&dataType="+escape(dataType)+"&lsDys="+lsDays;  
    alert(url);
    xmlHttp.onreadystatechange=commonConfigAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);  
                                    
                                    
                                    
}//end method
//modem status
function validateModemStatus(){

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var meterType;
    hirType=document.sideConfigForm.r1; 
    for (var i=0; i < hirType.length; i++)
    {
        if (hirType[i].checked)
        {
            meterType = hirType[i].value;
        }
    }//end for
    var sel=document.getElementById("dtr").options;
    var meterIds="";
    for(i=0;i<sel.length;i++){
        if(sel[i].selected){
            meterIds+=sel[i].title+",";
        }
    }//end for
        
    if(meterIds.length==0){
        alert("Please select meter/s");
        return;
    }
    command=document.getElementsByName("modemStatus")
    var commandType;
    for(var i=0;i<command.length;i++){
        if(command[i].checked) {
            commandType=command[i].value;
        }
    }
       
    var url="startStopRestart.jsp?meterLocation="+escape(meterType)+"&meterIds="+escape(meterIds)+"&commandType="+escape(commandType);  
    //alert(url);
    xmlHttp.onreadystatechange=commonConfigAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

}//end method
//pota
function validatePota(){

    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var meterType;
    hirType=document.sideConfigForm.r1; 
    for (var i=0; i < hirType.length; i++)
    {
        if (hirType[i].checked)
        {
            meterType = hirType[i].value;
        }
    }//end for
    var sel=document.getElementById("dtr").options;
    var meterIds="";
    for(i=0;i<sel.length;i++){
        if(sel[i].selected){
            meterIds+=sel[i].title+",";
        }
    }//end for
    if(meterIds.length==0){
        alert("Please select meter/s");
        return;
    }
    potaDate=document.getElementById("potaDate").value;
       
    var url="sendPota.jsp?meterLocation="+escape(meterType)+"&meterIds="+escape(meterIds)+"&potaDate="+escape(potaDate);  
    alert(url);
    xmlHttp.onreadystatechange=commonConfigAction;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

}//end method
//Store Config
function validateStoreConfig(){

    hirType=document.sideConfigForm.r1;
    //alert(hirType.length);
    for (var i=0; i < hirType.length; i++)
    {
        if (hirType[i].checked)
        {
            document.form6.meterLocation.value = hirType[i].value;
        }
    }//end for

    //alert("Hirarchy Type :"+document.form6.meterLocation.value);

    var sel=document.getElementById("dtr").options;
    var meterIds="";
    for(i=0;i<sel.length;i++){
        if(sel[i].selected){
            meterIds+=sel[i].title+",";
        }
    }//end for
    //alert(meterIds);
    if(meterIds.length==0){
        alert("Please select meter/s");
        return;
    }
    document.form6.meterIds.value=meterIds;
    //alert("MeterIds "+document.form6.meterIds.value);

    if(meterIds.split(",").length > 1 && meterIds.split(",").length == 2){
        return true;
    }else{
        alert("Please Select Only one Meter For Storing the configuration");
        return false;
    }//end else

}//end method
function commonConfigAction(){
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        document.getElementById("update_part").innerHTML=xmlHttp.responseText;
    }
}
function ValidateSGP()
{
    var meter=document.getElementById("dtr");
    var meterId=meter.options[meter.selectedIndex].title;     

    var meterType=document.getElementById('requestType');
    var requestType=meterType.options[meterType.selectedIndex].value;

    var startDate=document.getElementById('startingDate').value;

    var endDate=document.getElementById('endingDate').value;

    getSGPReports(meterId,requestType,startDate,endDate);
}
function getSGPReports(meterId,requestType,startDate,endDate)
{
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getConfigurationReports.jsp";
    url=url+"?meterId="+meterId;
    url=url+"&requestType="+requestType;
    url=url+"&startDate="+startDate;
    url=url+"&endDate="+endDate;       
    xmlHttp.onreadystatechange=displayResult;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
function ValidateOD()
{    
    var meter=document.getElementById('dtr');
    var meterId=meter.options[meter.selectedIndex].value;
    
    var meterType=document.getElementById('meterData');
    var meterDataType=meterType.options[meterType.selectedIndex].value;
    
    var startDate=document.getElementById('startingDate').value;    
    var endDate=document.getElementById('endingDate').value;    
    getOndemandReports(meterId,meterDataType,startDate,endDate);   
}
function getOndemandReports(meterId,meterDataType,startDate,endDate)
{
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getOndemandReport.jsp";
    url=url+"?meterId="+meterId;
    url=url+"&meterDataType="+meterDataType;
    url=url+"&startDate="+startDate;
    url=url+"&endDate="+endDate;
    //alert(url);                  
    xmlHttp.onreadystatechange=displayResult;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);

}
function ValidateSSR()
{
    var meter=document.getElementById('dtr');
    var meterId=meter.options[meter.selectedIndex].value;
    
    var meterType=document.getElementById('requestType');
    var requestType=meterType.options[meterType.selectedIndex].value; 

    var startDate=document.getElementById('startingDate').value;
    var endDate=document.getElementById('endingDate').value;

    getModemStatusReports(meterId,requestType,startDate,endDate);
}
function getModemStatusReports(meterId,requestType,startDate,endDate)
{
    xmlHttp=GetXmlHttpObject();
    if (xmlHttp==null)
    {
        alert ("Browser does not support HTTP Request");
        return;
    }
    var url="getModemStatusReports.jsp";
    url=url+"?meterId="+meterId;
    url=url+"&requestType="+requestType;
    url=url+"&startDate="+startDate;
    url=url+"&endDate="+endDate;
    //alert(url);
    xmlHttp.onreadystatechange=displayResult;
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}
function displayResult()
{
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        document.getElementById("data_part").innerHTML=showdata;
    }
}