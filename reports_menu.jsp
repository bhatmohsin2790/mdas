<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>
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
<style>
    .line{ border: 0px solid #ddd; border-top: 0;}
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
                document.getElementById("sDate").value="";
                document.getElementById("eDate").value="";
                document.getElementById("report_header").style.display = "none";
               
                if(tabeId=="cont-1")
                {
                    
                    var but_value;
                    var radioButtons = document.getElementsByName("instant");
                    for (var x = 0; x < radioButtons.length; x ++) 
                    {
                        if (radioButtons[x].checked) 
                        {
                            but_value = radioButtons[x].value;
                        }
                    }
//                    if(but_value==3) 
//                    {
//                        document.getElementsByName("instant")[0].checked=true;
//                    }
                        getInstantData2(but_value);
                }

                if(tabeId=="cont-2")
                {
                   document.getElementById("report_header").style.display = "none";
                   document.getElementById('energyFromDate').value="";
                   document.getElementById('energyToDate').value="";
                    //alert(document.getElementById("report_header").style.display);
                    var but_value;
                    var radioButtons = document.getElementsByName("e_opt1");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    getEnergy(but_value);
                }

                if(tabeId=="cont-3")
                {
                    document.getElementById("DataPart").innerHTML="";
                    document.getElementById("load_div1").innerHTML="";
                   
                    document.getElementById('graphTab').style.visibility="hidden";
                    document.getElementsByName("load_opt")[0].checked=true;
                     getLoadPage();
                   // getLoadsurvayData(but_value);
                }

                if(tabeId=="cont-4")
                {
                    
                    document.getElementById("DataPart").innerHTML="";
                    getEventsPage();
                }

                if(tabeId=="cont-5")
                {
                    var but_value;
                    var radioButtons = document.getElementsByName("snapshot_opt");
                    for (var x = 0; x < radioButtons.length; x ++) {
                        if (radioButtons[x].checked) {
                            but_value = radioButtons[x].value;
                        }
                    }
                    document.getElementById("DataPart").innerHTML="";
                    document.getElementById("sstartingDate").value="";
                    document.getElementById("sendingDate").value="";
                    //getSnapshotData(but_value);
                }
                if(tabeId=="cont-6")
                {
                    document.getElementById("startingDate").value="";
                    document.getElementById("endingDate").value="";
                    document.getElementById("DataPart").innerHTML="";
                                         
                }
                if(tabeId=="cont-7")
                {                   
                    document.getElementById("DataPart").innerHTML="";
                    document.getElementById("miscsdate").value="";
                    document.getElementById("miscedate").value="";
                    //miscellaneous();
                }
                if(tabeId=="cont-8")
                {                   
                    document.getElementById("DataPart").innerHTML="";
                    delayedDataInfo();
                }
                if(tabeId=="cont-9")
                {                   
                    document.getElementById("DataPart").innerHTML="";
                    document.getElementById("odsdate").value="";
                    document.getElementById("odedate").value="";
                    //ODReport();                   
                }
                if(tabeId=="cont-10")
                {                   
                   document.getElementById("DataPart").innerHTML="";
                   sendDcuOndemand();
                }
                
                
                document.getElementById("report_header").style.display = "none";
                return false;
            });
        });
    });
    
    
</script>
<script>
    function sendDcuOndemand(){
        
        
        var ssId=document.getElementById("substation").value; 
        var meter=document.getElementById("dtr"); 
        meterNo=meter.options[meter.selectedIndex].title;
       xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="DCU_ondemand.jsp?dcu_id="+ssId+"&meterNo="+escape(meterNo);
       // alert(url);
        xmlHttp.onreadystatechange=sendDcuOndemandAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null); 
    }
    function sendDcuOndemandAction(){
        document.getElementById('DataPart').style.display = "block";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
    }
    function getReliableData()
    {              
        var opt;
        var radioButtons = document.getElementsByName("reliable");
        for (var x = 0; x < radioButtons.length; x ++)
        {
            if (radioButtons[x].checked) {
                            
                opt = radioButtons[x].value;
            }}
        if(opt==null)
        {
            alert("please select SAIDI or SAIFI");
            return;
        }
        else{
            var sdate=document.getElementById("startingDate").value;
            var edate=document.getElementById("endingDate").value;
            if(sdate==""||edate=="")
            {
                alert("please select from and to dates");
                return;
            }
            if(sdate==edate)
            {
                alert("starting date and ending date should not be same");
                return;
            }
               
            else{
                     
                var Selected = document.getElementById('dtr').selectedIndex;
                var SelectedOption = document.getElementById('dtr').options[Selected].value;
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                if(opt==1)
                    var url="getSAIDI.jsp?meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate);
                if(opt==2)
                    url="getSAIFI.jsp?meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate);
        
                xmlHttp.onreadystatechange=getReliableDataAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
            }
        }}
    function getReliableDataAction()
    {
        var showData=xmlHttp.responseText;
        document.getElementById("DataPart").innerHTML=showData;
        
    }
    function getEventsPage()
    {
        //alert("events")
        //document.getElementById("graphPart").style.display = "none";
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getEventsScreen.jsp";
        xmlHttp.onreadystatechange=getEventsPageAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function getEventsPageAction()
    {
        var showData=xmlHttp.responseText;
        document.getElementById("cont-4-1").innerHTML=showData;
    }
    function delayedDataInfo()
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
         var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].title;
        var url="delayedDataInfo.jsp?meterId="+escape(SelectedOption);
        xmlHttp.onreadystatechange=delayedDataInfoAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null); 
    }
    function delayedDataInfoAction()
    {
      if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {           
            document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
        }  
    }
    function getLoadPage()
    {
       
        document.getElementById("DataPart").innerHTML="";
        document.getElementById('graphTab').style.visibility="hidden";
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getLoadSurveyScreen.jsp";


        xmlHttp.onreadystatechange=getLoadPageAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function getLoadPageAction()
    {
        var showData=xmlHttp.responseText;
        document.getElementById("load_div2").innerHTML="";
        document.getElementById("load_div1").style.visibility="visible";
        document.getElementById("load_div1").innerHTML=showData;
    }
    function getLoadDate()
    {
        
        document.getElementById("DataPart").innerHTML="";
        document.getElementById("load_div1").innerHTML="";
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="load_daywise_screen.jsp";
        xmlHttp.onreadystatechange=getLoadDateAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);


    }
    function getLoadDateAction()
    {
        var showData=xmlHttp.responseText;
        document.getElementById("load_div2").style.visibility="visible";
        document.getElementById("load_div2").innerHTML=showData;
    }
    function getMultipleLoadDate()
    {
        
        document.getElementById("DataPart").innerHTML="";
        document.getElementById("load_div1").innerHTML="";
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="load_multiple_screen.jsp";
        xmlHttp.onreadystatechange=getMultipleLoadDateAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function getMultipleLoadDateAction()
    {
        var showData=xmlHttp.responseText;
        document.getElementById("load_div2").style.visibility="visible";
        document.getElementById("load_div2").innerHTML=showData;
    }
    //methods updated start
    function getLoadsurvayData_MF(data_type)
    {
        //getLoadsurvayData(data_type);
    }
    function getLoadsurvayData(data_type)
    {
        
        
        document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
        var lsdate=document.getElementById("loadsDate").value;
        var ledate=document.getElementById("loadeDate").value;
        var chbMF=document.getElementById("chbMF");
        //if(lsdate=="" && ledate=="")
        //   {
        //      alert("dates should not be empty");
        //     return;
        // }
        // else{
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getLoadsurvayData.jsp";
        url=url+"?lsdate="+escape(lsdate)+"&ledate="+escape(ledate)+"&meter_id="+escape(SelectedOption)+"&start=1&EMF="+(chbMF.checked?"1":"0");
        //url=url+"?&meter_id="+escape(SelectedOption)+"&start=1";

        xmlHttp.onreadystatechange=insertLoadsurvayData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
        // }

    }//getLoadsurvayData
    function insertLoadsurvayData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "none";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
			$('#dtable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5'
//            'pdfHtml5'
        ]
    });
        }
    }
    //methods updated end 
    function getLoadData(start)
    {
        //alert("get load data"+start);
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        
        var lsdate=document.getElementById("loadsDate").value;
        var ledate=document.getElementById("loadeDate").value;
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var chbMF=document.getElementById("chbMF");
    
        var url="getLoadsurvayData.jsp?start="+escape(start)+"&meter_id="+escape(SelectedOption)+"&lsdate="+escape(lsdate)+"&ledate="+escape(ledate)+"&EMF="+(chbMF.checked?"1":"0");
        
        xmlHttp.onreadystatechange=insertLoadsurvayData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function getEventsData(data_type)
    {
       
        document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
    
        var values=new Array();
        checkboxes = document.getElementsByName('R-Phase');
        for(var i=0;i< checkboxes.length;i++)
        {
            if(checkboxes[i].checked ==true)
            {
                 
                values=values+checkboxes[i].value+",";

            }
        }
        if(values.length==0)
        {
            alert("Please select atleast one checkbox");
            return;
        }
    
     
        document.getElementById('home_msg').innerHTML = "";        
        document.getElementById('submenu').style.display = "block";        
        document.getElementById('DataPart').style.display = "block";        
        document.getElementById('report_header').style.display = "none";        
        var esdate=document.getElementById("eventsDate").value;        
        var eedate=document.getElementById("eventeDate").value;     
           
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        
        if(data_type==1)
         var url="getEventsData.jsp";        
        if(data_type==2)
           var url="getEventsCumulativeData.jsp";
        url=url+"?chkvalues="+escape(values)+"&sdate="+escape(esdate)+"&edate="+escape(eedate)+"&meter_id="+escape(SelectedOption)+"&start=1";
        

        xmlHttp.onreadystatechange=insertEventsData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
            
    }//getEventData
    function getEventsPageData(start)
    {
        document.getElementById('DataPart').innerHTML="";
    
        var values=new Array();
        checkboxes = document.getElementsByName('R-Phase');
        for(var i=0;i< checkboxes.length;i++)
        {
            if(checkboxes[i].checked ==true)
            {
                 
                values=values+checkboxes[i].value+",";

            }
        }
        if(values.length==0)
        {
            alert("Please select atleast one checkbox");
            return;
        }   
     
        document.getElementById('home_msg').innerHTML = "";        
        document.getElementById('submenu').style.display = "block";        
        document.getElementById('DataPart').style.display = "block";        
        document.getElementById('report_header').style.display = "none";        
        var esdate=document.getElementById("eventsDate").value;        
        var eedate=document.getElementById("eventeDate").value;    
           
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getEventsData.jsp";
        
        url=url+"?chkvalues="+escape(values)+"&sdate="+escape(esdate)+"&edate="+escape(eedate)+"&meter_id="+escape(SelectedOption)+"&start="+escape(start);
        

        xmlHttp.onreadystatechange=insertEventsData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
            
    }//getEventData
    function insertEventsData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "none";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
			$('#dtable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5'
//            'pdfHtml5'
        ]
    });
        }
    }//insertEventsData
    function miscellaneous()
    {
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var meter_no = document.getElementById('dtr').options[Selected].title;
       
        var miscstartDate=document.getElementById("miscsdate").value;
        var miscendDate=document.getElementById("miscedate").value;
        
        var url="getMiscellaneous.jsp?startDate="+escape(miscstartDate)+"&endDate="+escape(miscendDate)+"&start=1&meter_no="+escape(meter_no);  // meter serial no is taking from session in this case only for no reason
        xmlHttp.onreadystatechange=miscellaneousAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function miscellaneousHistory(start)
    {
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var meter_no = document.getElementById('dtr').options[Selected].title;
       
        var miscstartDate=document.getElementById("miscsdate").value;
        var miscendDate=document.getElementById("miscedate").value;
        
        var url="getMiscellaneous.jsp?startDate="+escape(miscstartDate)+"&endDate="+escape(miscendDate)+"&start="+escape(start)+"&meter_no="+escape(meter_no);  // meter serial no is taking from session in this case only for no reason
        xmlHttp.onreadystatechange=miscellaneousAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function miscellaneousAction()
    {
          if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
        }
        
    }
    function getSnapshotData()
    {
       var Selected = document.getElementById('dtr').selectedIndex;
        var meter_no = document.getElementById('dtr').options[Selected].value;
        var ssdate=document.getElementById("sstartingDate").value;
        var sedate=document.getElementById("sendingDate").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSnapshotData.jsp";
//        url=url+"?data_type="+data_type;
         url=url+"?meter_id="+meter_no+"&sdate="+ssdate+"&edate="+sedate+"&start=1";

        xmlHttp.onreadystatechange=insertSnapshotData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getSnapshotData
    function getSnapshotHistory(start)
    {
       var Selected = document.getElementById('dtr').selectedIndex;
        var meter_no = document.getElementById('dtr').options[Selected].value;
        var ssdate=document.getElementById("sstartingDate").value;
        var sedate=document.getElementById("sendingDate").value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getSnapshotData.jsp";
//        url=url+"?data_type="+data_type;
         url=url+"?meter_id="+meter_no+"&sdate="+ssdate+"&edate="+sedate+"&start="+start;

        xmlHttp.onreadystatechange=insertSnapshotData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }
    function insertSnapshotData()
    {
        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('report_header').style.display = "none";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
			$('#dtable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5'
//            'pdfHtml5'
        ]
    });
        }
    }//insertLoadsurvayData
    function getInstant()
    {
        var but_value;
        var radioButtons = document.getElementsByName("instant");
        for (var x = 0; x < radioButtons.length; x ++) 
        {
            if (radioButtons[x].checked) 
            {
                but_value = radioButtons[x].value;
            }
        }
        getInstantData2(but_value);
        
    }
    function getInstantData2(data_type)
    {
        var meterType;
        var radioButtons = document.getElementsByName("r1");
        for (var x = 0; x < radioButtons.length; x ++) 
        {
            if (radioButtons[x].checked) 
            {
                meterType = radioButtons[x].value;
            }
        }
        
        document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
        document.getElementById('ip_opt_div1').style.display = "none";       
        document.getElementById('gdate').style.display = "none";          
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
         var chbEMF=document.getElementById("AEMF");       
        sdate=document.getElementById("sDate").value;        
        edate=document.getElementById("eDate").value;        
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var locationName=document.getElementById('dtr').options[Selected].text;
        if(data_type==2 || data_type==1){
        if(data_type==2){}
        if(data_type==1){document.getElementById('date_div').style.display = "none";}
        var url="getInstantData.jsp?data_type="+escape(data_type)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"&start=1"+"&ApplyEMF="+(chbEMF.checked?"1":"0"); 
        }
        if(data_type==4){
            if(meterType=='feeder'){
                alert("This report is available for only DTR and HT");
                return 0;
            }
            
            var url="getOverLoad.jsp?meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"&start=1"+"&ApplyEMF="+(chbEMF.checked?"1":"0")+"&name="+locationName; 
            
        }
        if(data_type==5)
            var url="getLoadImbalance.jsp?meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"&start=1"+"&ApplyEMF="+(chbEMF.checked?"1":"0")+"&name="+locationName; 
        if(data_type==6 )
            var url="getPeakLoad.jsp?meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate)+"&start=1"+"&ApplyEMF="+(chbEMF.checked?"1":"0")+"&name="+locationName; 
        //alert(url);

        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

    }//getInstantanious Data
    function getInstantData(start)
    {
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
         var chbEMF=document.getElementById("AEMF");
        sdate=document.getElementById("sDate").value;
        edate=document.getElementById("eDate").value;
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var url="getInstantData.jsp?data_type=2&start="+escape(start)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate);
        url=url+"&ApplyEMF="+(chbEMF.checked?"1":"0");
        //alert(url);
        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function getPeakLoadData(start)
    {
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
         var chbEMF=document.getElementById("AEMF");
        sdate=document.getElementById("sDate").value;
        edate=document.getElementById("eDate").value;
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var location=document.getElementById('dtr').options[Selected].text;
        var url="getPeakLoad.jsp?start="+escape(start)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate);
        url=url+"&ApplyEMF="+(chbEMF.checked?"1":"0")+"&name="+location;
        //alert(url);
        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function getOverLoadData(start)
    {
        
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
         var chbEMF=document.getElementById("AEMF");
        sdate=document.getElementById("sDate").value;
        edate=document.getElementById("eDate").value;
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;
        var url="getPeakLoad.jsp?start="+escape(start)+"&meter_id="+escape(SelectedOption)+"&sdate="+escape(sdate)+"&edate="+escape(edate);
        url=url+"&ApplyEMF="+(chbEMF.checked?"1":"0");
        //alert(url);
        xmlHttp.onreadystatechange=getInstantaneousData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    //get Main Energy data function
    function getEnergy(e_opt1)
    {    
        //alert("energy");
        document.getElementById('e_opt_div3').style.display = "none";
         document.getElementById("DataPart").innerHTML=""; 
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="";
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].title;
        //alert("selectedoption  "+SelectedOption)
        var esdate=document.getElementById('energyFromDate').value;
        var eedate=document.getElementById('energyToDate').value;
        //alert("e_opt1  "+e_opt1);
        if(esdate=="" || eedate==""){
             //alert("please select dates...");
             return 0;
         }  
             
          document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;     
        if(e_opt1==1)
            url="main_energy.jsp?meter_sl_no="+SelectedOption+"&start=1&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        if(e_opt1==2)
            url="tod_energy.jsp?meter_sl_no="+SelectedOption+"&start=1&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        if(e_opt1==3)
            url="energy_consumption.jsp?meter_sl_no="+SelectedOption+"&start=1&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        if(e_opt1==5)
            url="tod_consumption.jsp?meter_sl_no="+SelectedOption+"&start=1&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        if(e_opt1==6)
            url="max_demand.jsp?meter_sl_no="+SelectedOption+"&start=1&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        if(e_opt1==7)
            url="billing_format.jsp?meter_sl_no="+SelectedOption+"&start=1&esdate="+escape(esdate)+"&eedate="+escape(eedate);
           //alert(url);
        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
         
    }
    function mainEnergy(start)
    {

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].title;
        var esdate=document.getElementById('energyFromDate').value;
        var eedate=document.getElementById('energyToDate').value;
        var url="main_energy.jsp?meter_sl_no="+escape(SelectedOption)+"&start="+escape(start)+"&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function tod_energy(start)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].title;
        var esdate=document.getElementById('energyFromDate').value;
        var eedate=document.getElementById('energyToDate').value;
        var  url="tod_energy.jsp?meter_id="+escape(SelectedOption)+"&start="+escape(start)+"&esdate="+escape(esdate)+"&eedate="+escape(eedate);
        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function energy_consumption(start)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].title;
        var esdate=document.getElementById('energyFromDate').value;
        var eedate=document.getElementById('energyToDate').value;
        var  url="energy_consumption.jsp?meter_sl_no="+SelectedOption+"&start="+escape(start)+"&esdate="+escape(esdate)+"&eedate="+escape(eedate);
       // alert(url);
        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function max_demand(start)
    {
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].title;
        var esdate=document.getElementById('energyFromDate').value;
        var eedate=document.getElementById('energyToDate').value;
        var  url="max_demand.jsp?meter_sl_no="+SelectedOption+"&start="+escape(start)+"&esdate="+escape(esdate)+"&eedate="+escape(eedate);
       // alert(url);
        xmlHttp.onreadystatechange=getEnergyData;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);
    }
    function getEnergyData()
    {

        document.getElementById('home_msg').innerHTML = "";

        document.getElementById('submenu').style.display = "block";
        document.getElementById('DataPart').style.display = "block";
        document.getElementById('meter_details').style.display = "block";
        document.getElementById('report_header').style.display = "none";
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            document.getElementById("DataPart").innerHTML= showdata;
			$('#dtable').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5'
//            'pdfHtml5'
        ]
    });
        }
    }//
    //Data
    function getEnergyOptions(e_opt)
    {
       
       
        if(e_opt==1)
        {
             document.getElementsByName("e_opt1")[0].checked = true;
            document.getElementById('e_opt_div1').style.display = "block";
            document.getElementById('e_opt_div2').style.display = "none";
            document.getElementById('e_opt_div3').style.display = "none";
            //document.getElementById('egdate').style.display = "none";
            getEnergy(1);
        }
        if(e_opt==2)
        {
             document.getElementsByName("e_opt1")[2].checked = true;
            document.getElementById('e_opt_div2').style.display = "block";
            document.getElementById('e_opt_div1').style.display = "none";
            document.getElementById('e_opt_div3').style.display = "none";
            //document.getElementById('egdate').style.display = "none";
            getEnergy(6);
        }
        if(e_opt==3)
        {
             document.getElementsByName("e_opt")[2].checked = true;
            document.getElementById('e_opt_div1').style.display = "none";
            document.getElementById('e_opt_div2').style.display = "none";
            document.getElementById('e_opt_div3').style.display = "block";
            document.getElementById("DataPart").innerHTML="";
    
    
            document.getElementById("energygraphDate").value="";
            document.getElementById('egdate').style.display = "block";
        }
    }
    function getInstantOptions()
    {
        document.getElementById("DataPart").innerHTML="";
        //document.getElementById("graphPart").style.display = "none";
        document.getElementById('date_div').style.display = "none";
        document.getElementById("graphDate").value="";
        document.getElementById('gdate').style.display = "block";
        document.getElementById('ip_opt_div1').style.display = "block";
    }
    function getDates()
    {
        document.getElementById("DataPart").style.display="none";
        document.getElementById("sDate").value="";
        document.getElementById("eDate").value="";
        // document.getElementById("graphPart").style.display = "none";
        document.getElementById('date_div').style.display = "block";
        document.getElementById('ip_opt_div1').style.display = "none";
        document.getElementById("gdate").style.display = "none";
       $("#sDate").appendDtpicker({"closeOnSelected": true,  "minuteInterval": 15});
       $("#eDate").appendDtpicker({"closeOnSelected": true,  "minuteInterval": 15});
                           
    }
    function ODReport(){
        document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
      
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var meterType;
        var type=document.getElementsByName("r1");
        for(var i=0;i<type.length;i++){
            if(type[i].checked){
                meterType=type[i].value;
                break;
            }                
        }        
        
        var Selected = document.getElementById('dtr').selectedIndex;
        var meter_no = document.getElementById('dtr').options[Selected].title;
       
        var odstartDate=document.getElementById("odsdate").value;
        var odendDate=document.getElementById("odedate").value;
        
        var url="getODReport.jsp?startDate="+escape(odstartDate)+"&endDate="+escape(odendDate)+"&start=1&meter_no="+escape(meter_no)+"&meterType="+escape(meterType);  
        
        xmlHttp.onreadystatechange=miscellaneousAction;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);  
    }
</script>
<script>
    function uploadToExcel(reportType){
        var url="";
       
        if(reportType=="load"){
            var lsdate=document.getElementById("loadsDate").value;
            var ledate=document.getElementById("loadeDate").value;
            var Selected = document.getElementById('dtr').selectedIndex;
            var SelectedOption = document.getElementById('dtr').options[Selected].value;
            var chbMF=document.getElementById("chbMF");
    
            url="Exports/exportLS.jsp?meter_id="+escape(SelectedOption)+"&lsdate="+escape(lsdate)+"&ledate="+escape(ledate)+"&EMF="+(chbMF.checked?"1":"0");
         
        }
       else if(reportType=="energy"){
            var esdate=document.getElementById('energyFromDate').value;
            var eedate=document.getElementById('energyToDate').value;
            var Selected = document.getElementById('dtr').selectedIndex;
            var SelectedOption = document.getElementById('dtr').options[Selected].value;          
    
            url="Exports/exportMainEnergy.jsp?meter_id="+escape(SelectedOption)+"&esdate="+escape(esdate)+"&eedate="+escape(eedate)+"&EMF=0";         
        }
        else if(reportType=="tampers"){
           var values=new Array();
        checkboxes = document.getElementsByName('R-Phase');
        for(var i=0;i< checkboxes.length;i++)
        {
            if(checkboxes[i].checked ==true)
            {                 
                values=values+checkboxes[i].value+",";
            }
        }              
        var esdate=document.getElementById("eventsDate").value;        
        var eedate=document.getElementById("eventeDate").value;     
           
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].value;

        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var url="Exports/exportTampers.jsp"
        url=url+"?chkvalues="+escape(values)+"&sdate="+escape(esdate)+"&edate="+escape(eedate)+"&meter_id="+escape(SelectedOption);
        //alert(url);
        }
       
       window.location=url; 
    }
    </script>
<script type="text/JavaScript">
   /* function selectall(source)
    {
       // alert("selectall")
        chkboxes = document.getElementsByName('R-Phase');

        for(var i in chkboxes)
        {
            if(chkboxes[i].value.toString()!='undefined')
                chkboxes[i].checked = source.checked;

        }
    }*/
    function selectall(source) {
        if (source.id == "select") {
            if (source.checked == true) {
                chkboxes = document.getElementsByName('R-Phase');
                for(var i=0;i< chkboxes.length;i++)
                {            
                    chkboxes[i].checked = true;
                }
            } 
            if (source.checked == false) {
                chkboxes = document.getElementsByName('R-Phase');
                for(var i=0;i< chkboxes.length;i++)
                {           
                    chkboxes[i].checked = false;
                }
            } 
        }
    }
    function deselect(source)
    {
        checkbox = document.getElementsByName('allevent');
        for(var i in checkbox)
            checkbox[i].checked = source.unchecked;

    }
    var gAutoPrint = true; // Tells whether to automatically call the print function
    function printPage()
    {
        if (document.getElementById != null)
        {
            var html = '<HTML>\n<HEAD>\n';



            html += '\n</HEAD>\n\n';

            var printReadyElem = document.getElementById("DataPart");

            if (printReadyElem != null)
            {
                html += printReadyElem.innerHTML;
            }
            else
            {
                alert("Could not find the printReady function");
                return;
            }

            html += '\n</HTML>';

            var printWin = window.open("","printPage",'width=950,height=400,scrollbars=1,left=300,top=150');
            printWin.document.open();
            printWin.document.write(html);
         
            if (gAutoPrint)
            {
                printWin.print();

            }


        }
        else
        {
            alert("The print ready feature is only available if you are using an browser. Please update your browswer.");
        }
    }//printpage
    function exportMenu()
    {
        document.getElementById('export').style.display="block";
    }
    function hideExport()
    {
        document.getElementById('export').style.display="none";
    }
    function write_to_excel() {

        //window.open('data:application/vnd.ms-excel,'+document.getElementById("DataPart").html(););
        if (document.getElementById != null)
        {
            var html = "<HTML><HEAD>";



            html += "</HEAD>";

            var printReadyElem = document.getElementById("DataPart");

            if (printReadyElem != null)
            {
    

                html += printReadyElem.innerHTML;
            }
            else
            {
                alert("Could not find the printReady function");
                return;
            }

            html += "</HTML>";
        }

        //window.open('data:application/vnd.ms-excel,'+html);
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }

        var  url="export_excel.jsp";
        var parameters ="data="+ encodeURIComponent(html);
        alert( parameters.length);
        xmlHttp.onreadystatechange=excelAction;
        xmlHttp.open("POST",url,true);
        xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded;charset=UTF-8");
        xmlHttp.setRequestHeader("Content-length", parameters .length);
         
        xmlHttp.send(parameters);
 
    }
    function excelAction()
    {
        if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
        {
            var showdata = xmlHttp.responseText;
            alert("data"+showdata);
            // window.open('data:application/vnd.ms-excel,'+showdata);
        }
    }
    //new method
    function table_reverse_new()
    {
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].text;
        var exlsdate=document.getElementById("loadsDate").value;
        var exledate=document.getElementById("loadeDate").value;
        var chbMF=document.getElementById("chbMF");

        var url = "store_data.jsp";
        //var url = "test.jsp";
        var parameters="meterid="+SelectedOption+"&lsdate="+exlsdate+"&ledate="+exledate+"&start=1&EMF="+(chbMF.checked?"1":"0");
        url=url+"?"+parameters;
        //alert(url);
        alert("Please wait while page is being exported...");
        window.location=url;
    }
    //new method end
    function table_reverse_new_old()
    {
        //alert("method called");
        http=GetXmlHttpObject();
        if (http==null)
        {
            alert ("Browser does not support HTTP Request");
            return;
        }
        var Selected = document.getElementById('dtr').selectedIndex;
        var SelectedOption = document.getElementById('dtr').options[Selected].text;
        var exlsdate=document.getElementById("loadsDate").value;
        var exledate=document.getElementById("loadeDate").value;
        //var req_data = document.getElementById('table3').innerHTML;
        

        var url = "store_data.jsp";
        //var parameters = "data="+escape(req_data)+"&meterid="+SelectedOption;
        var parameters="meterid="+SelectedOption+"&lsdate="+exlsdate+"&ledate="+exledate;
        //alert(parameters);
        //alert(parameters.length);
        http.open("POST", url, true);

        //Send the proper header information along with the request
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", parameters.length);
        //http.setRequestHeader("Connection", "close");

        http.onreadystatechange = function() {//Handler function for call back on state change.
            if(http.readyState == 4) {
                alert(http.responseText);
            }
        }
        http.send(parameters);

        
        //window.open("store_data.jsp?data="+req_data);
       
       
    }
    function displayRadio()

    {
        
        var option;
	document.getElementById('DataPart').innerHTML="";
        document.getElementById('graphTab').style.visibility="visible";
        document.getElementById("load_div1").style.visibility="hidden";
         var inputs = document.getElementsByName("graph");  
       for (var i = 0; i < inputs.length; i++) {
          if (inputs[i].checked) {           
            option=inputs[i].value;
        }
        } 
        if(option=="DayWise")
            getLoadDate();
        if(option=="Multiple")
            getMultipleLoadDate();
            
    }
 function getEnergyReport()
 {
     
     var options=document.getElementsByName("e_opt1");
     var selectedEOption=0;
     for(var i=0;i<options.length;i++)
         {
             if(options[i].checked)
                 selectedEOption=options[i].value;
         }
        
     getEnergy(selectedEOption);
     
 }
 function exportExcel(tableId,name){ 
            //alert(document.getElementById("DataPart").innerHTML);
            //alert("sreenivas");
           table=document.getElementById(''+tableId+'');
          if (!table.nodeType) table = document.getElementById(table);
          download(table.outerHTML, name, "application/vnd.ms-excel");
          //download(table.innerHTML, "Export.xls", "application/vnd.ms-excel");
}
function download(strData, strFileName, strMimeType) {
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
</script>
<div class="tab-box" id="example">
    <a href="javascript:;" class="tabLink activeLink " id="cont-1">Instantaneous </a>
    <a href="javascript:;" class="tabLink " id="cont-2">Energy</a>
    <a href="javascript:;" class="tabLink " id="cont-3">Load Survey</a>
    <a href="javascript:;" class="tabLink " id="cont-4">Tampers </a>
    <a href="javascript:;" class="tabLink " id="cont-5">Snapshot Data</a> 
    <!--<a href="javascript:;" class="tabLink " id="cont-6">Reliable Indices</a> 
    <a href="javascript:;" class="tabLink " id="cont-7">Miscellaneous</a>-->
   <!-- <a href="javascript:;" class="tabLink " id="cont-8">Delayed Data Info</a> -->
    <a href="javascript:sendDcuOndemand();" class="tabLink" id="cont-10">Send On Demand</a>
  <!--  <a href="javascript:;" class="tabLink " id="cont-9">On Demand Data</a> -->
</div>
<div style="float:right;"><img src="images/p1.jpeg" id=""   onclick="printPage();" width=25 height=25 border=0  style="border-color:#ddd;cursor:pointer" title="print"/>
  <!-- <img src="images/2.jpeg" id=""   onclick="exportMenu();"width=20 height=20 border=0  style="border-color:#ddd;cursor:pointer" title="export"/>
     <div id="export" style="background-color:#F5F5F5;border:1px;width:95px;right:-14px;display:none;z-index:10;position:absolute;"onmouseover="exportMenu();"onmouseout="hideExport();" >
        <div style="cursor:pointer;background:transparent none repeat scroll 0% 0%;"onmouseover="this.style.background='#56a5ec';"onmouseout="this.style.background='#F5F5F5';" onclick="createPDF();">Save As pdf</div>
        <div style="cursor:pointer;background:transparent none repeat scroll 0% 0%;"onmouseover="this.style.background='#56a5ec';"onmouseout="this.style.background='#F5F5F5';" onclick="write_to_excel();">Save As excel</div>
    </div> -->
</div>
<script type="text/javascript" src="date-picker.js"></script>
<script type="text/javascript" src="load_survay_graphs.js"></script>
<div class="tabcontent paddingAll" id="cont-1-1">

    <div class="button_style"> <input type="radio" name="instant" id="instant" value="1" checked onclick="getInstantData2(this.value)"> Latest Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="instant" id="instant" value="2" onclick="getDates()"> Complete Data </div>
     <div class="button_style"><input type="radio" name="instant" id="instant" value="4" onclick="getDates()"> Over Load</div>
      <div class="button_style"><input type="radio" name="instant" id="instant" value="5" onclick="getDates()"> Load Imbalance </div>
      <div class="button_style"><input type="radio" name="instant" id="instant" value="6" onclick="getDates()"> Peak Load</div>

    <div class="button_style"><input type="radio" name="instant" id="instant" value="3" onclick="getInstantOptions()"> Graphs</div>
    <table>
        <tr>
            <td>
                <input type="checkbox" id="AEMF" checked= false onclick="">Apply EMF
            </td>
       
        <td>
           <form name="graphicalReports">
            <table><tr><td id="gdate" style="display:none" >
                        <b>Select Date:</b>
                        <input type="text" readonly="true" size="10" name="startingDate" id="graphDate"/>
                        <a href="javascript:show_calendar('graphicalReports.startingDate')"> <img src="images/cal1.gif" id="sdate1"  width=24 height=22 border=0/></a>
                        &nbsp;

                    </td></tr>
            </table></form>  
            </td></tr>
    </table>

    <div id="date_div" style="float:left;clear:both;display:none">
        <form name="iReports">
            <table><tr><td id="ictd" >
                        <b>From Date:</b>
                        <input type="text" readonly="true" size="10" name="startingDate" id="sDate"/>
                       <a href="javascript:show_calendar('iReports.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a> 
                        &nbsp;
                    </td>
                        <td id="ictd" >
                        <b>To Date:</b>
                        <input type="text" readonly="true" size="10" name="endingDate" id="eDate"/>
                       <a href="javascript:show_calendar('iReports.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a></td>
                        <td><input type="button" size="30" id="" value="Get Data" onclick="getInstant()">
                    </td></tr>
            </table></form>
    </div>
   
    <div id="ip_opt_div1" style="float:left;clear:both;display:none">
        <div class="button_style"><input type="radio" name="instant_1"  value="1"   onclick="getGraphs(this.value)"> Voltage Graph</div>
        <div class="button_style"><input type="radio" name="instant_1"  value="2" onclick="getGraphs(this.value)"> Current Graph</div>

    </div>

</div>
<div class="tabcontent paddingAll hide" id="cont-2-1">
    <div class="button_style"><input type="radio" name="e_opt" value="1" checked onclick="getEnergyOptions(this.value)"> Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="e_opt" value="2" onclick="getEnergyOptions(this.value)"> Demand</div>
    <!-- <div class="button_style"><input type="radio" name="e_opt" value="3" onclick="getEnergyOptions(this.value)"> Graphs</div> -->

    
    <div id="e_opt_div1" style="float:left;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt1" value="1" checked onclick="getEnergy(this.value)"> Main Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

        <div class="button_style"><input type="radio" name="e_opt1" value="3" onclick="getEnergy(this.value)"> Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="7" onclick="getEnergy(this.value)"> Billing Format &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

        <!--<div class="button_style"><input type="radio" name="e_opt1" value="2" onclick="getEnergy(this.value)"> TOD Energy &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
        <!--        <div class="button_style"><input type="radio" name="e_opt1" value="4" onclick="getEnergy(this.value)"> Midnight Data &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
        <!--<div class="button_style"><input type="radio" name="e_opt1" value="5" onclick="getEnergy(this.value)"> TOD Consumption &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>-->
    </div>
    <div id="e_opt_div2" style="float:left;display:none;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt1" value="6" onclick="getEnergy(this.value)"> Max Demand &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

        <!--
        <div class="button_style"><input type="radio" name="e_opt1" value="7" onclick=""> TOD MD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="8" onclick=""> CMD &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        <div class="button_style"><input type="radio" name="e_opt1" value="9" onclick=""> MD Reset Dates &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        -->
    </div>
    <div id="e_opt_div3" style="float:left;display:none;clear:both;">
        <div class="button_style"><input type="radio" name="e_opt2" value="1" onclick="getEnergyGraph(this.value)"> KWH Graph &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

    </div>
    <div id="energyDates" style="padding-top:30px;">      
        <form name="energygraphicalReports">
        <table><tr><td id="egdate"  >
                    From Date:
                    <input type="text" readonly="true" size="10" name="startingDate" id="energyFromDate"/>
                    <a href="javascript:show_calendar('energygraphicalReports.startingDate')"> <img src="images/cal1.gif" id="esdate"  width=24 height=22 border=0/></a>
                    &nbsp;

                </td>
            <td id="egdate"  >
                    To Date:
                    <input type="text" readonly="true" size="10" name="endingDate" id="energyToDate"/>
                    <a href="javascript:show_calendar('energygraphicalReports.endingDate')"> <img src="images/cal1.gif" id="eedate"  width=24 height=22 border=0/></a>
                    &nbsp;

                </td>
                <td><input type="button" value="GetReport" onclick="getEnergyReport();"/></td>
            </tr>
        </table></form> </div>

</div>  <!-- energy -->
<div class="tabcontent paddingAll hide" id="cont-3-1">
    <div class="button_style"><input type="radio" name="load_opt" value="1" onclick="getLoadPage();"> Tablar &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="load_opt" value="2" onclick="displayRadio();">Graphical</div>
    <div id="graphTab" style="visibility:hidden;padding-top:30px">
        <div class="button_style"><input type="radio" value="DayWise" onclick="getLoadDate();" name="graph"/>DayWise</div>
       <!-- <div class="button_style"><input type="radio" value="Multiple" onclick="getMultipleLoadDate();" name="graph"/>Multiple</div> -->
    </div>
    <div id="load_div1" style="float:left;clear:both;">

    </div>
    <div id="load_div2" style="float:left;clear:both;">
    </div>


</div>
<div class="tabcontent paddingAll hide" id="cont-4-1">

</div>
<div class="tabcontent paddingAll hide" id="cont-5-1">
    <div class="button_style"><input type="radio" name="snapshot_opt" id="snapshot_opt" value="12" checked onclick=""> SnapShot &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <form name="snap_reports" action="" >
        <table><tr>
                <td>

                </td>
                <td id="rtd" >
                    From Date:
                    <input type="text" readonly="true" size="10" name="startingDate" id="sstartingDate" style="border:1px solid #666666;"/>
                </td><td style="padding-top:0px;">
                    <a href="javascript:show_calendar('snap_reports.startingDate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
                </td><td style="padding-left:10px;">
                    To Date:
                    <input type="text" readonly="true" size="10" name="endingDate" id="sendingDate" style="border:1px solid #666666;"/>
                </td><td style="padding-top:5px;">
                    <a href="javascript:show_calendar('snap_reports.endingDate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0/></a>
                </td><td>
                    &nbsp;
                    <input type="button" size="30"  value="Get Value" onclick="getSnapshotData();"/>
                </td></tr>
        </table>
    </form>
</div>
<div class="tabcontent paddingAll hide" id="cont-6-1">
    <div class="button_style"><input type="radio" name="reliable" id="reliable_opt" value="1"  > SAIDI &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    <div class="button_style"><input type="radio" name="reliable" id="reliable_opt" value="2"  > SAIFI &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
    
</div>
<div class="tabcontent paddingAll hide" id="cont-7-1">
    <form name="misc">
        <table><tr><td id="egdate"  >
                    From Date:
                    <input type="text" readonly="true" size="10" name="startingDate" id="miscsdate"/>
                    <a href="javascript:show_calendar('misc.startingDate')"> <img src="images/cal1.gif" id="esdate"  width=24 height=22 border=0/></a>
                    &nbsp;

                </td>
            <td id="egdate"  >
                    To Date:
                    <input type="text" readonly="true" size="10" name="endingDate" id="miscedate"/>
                    <a href="javascript:show_calendar('misc.endingDate')"> <img src="images/cal1.gif" id="eedate"  width=24 height=22 border=0/></a>
                    &nbsp;

                </td>
                <td><input type="button" value="GetReport" onclick="miscellaneous();"/></td>
            </tr>
        </table></form>
   <!-- <div class="button_style"><input type="radio" name="Miscellaneous" id="Miscellaneous" value="1" checked onclick=""> Latest Records &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div> -->
</div>
<div class="tabcontent paddingAll hide" id="cont-8-1">
    
</div>
<div class="tabcontent paddingAll hide" id="cont-9-1">
   <form name="od">
        <table><tr><td id="egdate"  >
                    From Date:
                    <input type="text" readonly="true" size="10" name="startingDate" id="odsdate"/>
                    <a href="javascript:show_calendar('od.startingDate')"> <img src="images/cal1.gif" id="esdate"  width=24 height=22 border=0/></a>
                    &nbsp;

                </td>
            <td id="egdate"  >
                    To Date:
                    <input type="text" readonly="true" size="10" name="endingDate" id="odedate"/>
                    <a href="javascript:show_calendar('od.endingDate')"> <img src="images/cal1.gif" id="eedate"  width=24 height=22 border=0/></a>
                    &nbsp;

                </td>
                <td><input type="button" value="GetReport" onclick="ODReport();"/></td>
            </tr>
        </table></form> 
</div>
<div id="dcu_loading" style="display: none">
    <table width="100%"><tr><td align="center">
    <img src="./images/loading.jpg"/>
            </td></tr></table>
</div>