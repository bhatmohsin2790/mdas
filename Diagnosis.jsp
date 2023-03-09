<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" height="100%">
    <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="pragma" content="-1" />

        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="jquery.min.js"></script>
        <script type="text/javascript" src="highcharts.js"></script>
        <script type="text/javascript" src="exporting.js"></script>
        <script type="text/javascript" src="admin_hirarchy.js"></script>

        <!--Import part -->
        <%@ include file="importpage.jsp"%>
        <%@page import="java.io.*"%>
        <style>
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
                font-size:12px;
            }
            .tab-box a.activeLink {
                background-color: #fff;
                border-bottom: 0;
                padding: 6px 15px;
            }
            .tabcontent { border: 1px solid #ddd; border-top: 0;}
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
                        if(tabeId=="cont-1")
                        {
                            setReportType("1");
                            //modemdiagnosis();
                        }
                        if(tabeId=="cont-2")
                        {
                            setReportType("2");
                            //signalgraph();
                        }
                        if(tabeId=="cont-3")
                        {
                            setReportType("3");
                            //temperaturegraph();
                        }
                        if(tabeId=="cont-4")
                        {
                            setReportType("4");
                            //temperaturegraph();
                        }
                        return false;
                    });
                });
            });

        </script>
        <script type="text/javascript" language="jscript">
            var substationId;
             var meterLocation;
             var reportType="0";
             function setReportType(option)
             {
                 reportType=option;
             }
             function getDiagReport()
             {
                 if(reportType=="0")
                     alert("please select Type of Report");
                 if(reportType=="1")
                     modemdiagnosis();
                 if(reportType=="2")
                     signalgraph();
                 if(meterLocation!="feeder")
                     {
                        if(reportType=="3")
                          temperaturegraph();
                        if(reportType=="4")
                          BatteryGraph();
                     }
             }
            function modemdiagnosis()
            {
               
                 var date=document.getElementById("startingDate").value;
                  if(date!=""){
                    xmlHttp=GetXmlHttpObject();
                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request");
                        return;
                    }
                    var url="ModemDiagnosis.jsp?meterId="+escape(meter)+"&date="+escape(date)+"&start=1&location="+escape(meterLocation)+"&substationId="+escape(substationId);                   
                     //alert(url);
                  xmlHttp.onreadystatechange=modemdiagnosisAction;
                    xmlHttp.open("GET",url,true);
                    xmlHttp.send(null);
                  }
                
            }
            function diagnosis(start)
            {
       
                date=document.getElementById("startingDate").value;
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }
                var url="ModemDiagnosis.jsp?meterId="+escape(meter)+"&date="+escape(date)+"&start="+escape(start);
                xmlHttp.onreadystatechange=modemdiagnosisAction;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null);
             
            }

            function modemdiagnosisAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("DataPart").innerHTML=xmlHttp.responseText;
                }//end if
            }
            function signalgraph()
            {
                date=document.getElementById("startingDate").value;               
                    xmlHttp=GetXmlHttpObject();
                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request");
                        return;
                    }
                    var url="signalGraph.jsp?meter_id="+escape(meter)+"&sdate="+escape(date)+"&location="+escape(meterLocation)+"&substationId="+escape(substationId);
                 //  alert(url);                    
                    xmlHttp.onreadystatechange=signalgraphAction;
                    xmlHttp.open("GET",url,true);
                    xmlHttp.send(null);
                
            }
            var time=new Array();
            var signal=new Array();
            var temperature=new Array();
            var batteryVoltage= new Array();
            function signalgraphAction()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("DataPart").innerHTML="";
                    var showdata = xmlHttp.responseText;
                    var selDate=showdata.substring(showdata.indexOf("date")+4,showdata.indexOf("time"));
                    signaltime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("signal")-1);
                    time=signaltime.split(",");      
        
                    signalstrength=showdata.substring(showdata.indexOf("signal")+7);
                    signal=signalstrength.split(",");
        
                    for(j=0;j<signal.length;j++)
                    {
                        signal[j]=+signal[j];
                    }
                    signalLineGraph(selDate);
                }
            }
           function applyGraphGradient() {        
        // Options
        var threshold =10,
        colorAbove = '#4572EE',
        colorBelow = '#EE4643';         
        // internal
        var series = this.series[0],
        i,
        point;
        series.graph.attr({
            stroke: {
                fill:'#EE4643'                
            }
        });
        
        // Apply colors to the markers
        for (i = 0; i < series.data.length; i++) {
            point = series.data[i];
            point.color = point.y < threshold ? colorBelow : colorAbove;
            if (point.graphic) {
                point.graphic.attr({
                    fill: point.color
                });              
                
            }            
        }        
        // prevent the old color from coming back after hover
        delete series.pointAttr.hover.fill;
        delete series.pointAttr[''].fill;
        
    }
            function signalLineGraph(selDate)
            {

        var chart;
        $(document).ready(function() {
            chart = new Highcharts.Chart({
                chart: {
                    renderTo: 'DataPart',
                    defaultSeriesType: 'line',
                    marginRight: 130,
                    marginBottom: 65,
                    width:window.size,
                    
                    borderColor: "#4572A7",
                    borderRadius: 15,
                    borderWidth: 1,
                    margin: [80, 80, 160,160],
                    events: {
                        load: applyGraphGradient
                    }
                },
                        title: {
                            text: 'Signal Strength On '+selDate,
                            x: -20 //center
                        },
                        subtitle: {
                            text: '',
                            x: -20
                        },
                        xAxis: {
                            gridLineWidth: 1,
                            lineColor: '#000',
                            tickColor: '#000',
                            tickWidth:2,
                            labels: {
                                y : 21, rotation: -45 ,align:'center',
                                style: {
                                    color: '#000',
                                    font: '11px Trebuchet MS, Verdana, sans-serif'
                                }
                            },
                            title: {
                                text: ' Time(hh:mm:ss)'

                            },
                            categories: time
                                                
                        },
                        yAxis: {
                            minorTickInterval: 'auto',
                            lineColor: '#000',
                            lineWidth: 1,
                            tickWidth: 1,
                            tickColor: '#000',
                            labels: {
                                style: {
                                    color: '#000',
                                    font: '11px Trebuchet MS, Verdana, sans-serif'
                                }
                            },
                            title: {
                                text: 'signal strength'
                            },
                            plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }]
                        },
                        tooltip: {
                            formatter: function() {
                                return '<b>'+ this.series.name +'</b><br/>'+
                                    this.x +'(hh:mm:ss)'+ '</b><br/> '+ this.y +'';
                            }
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'top',
                            x: 0,
                            y: 100,
                            borderWidth: 0
                        },
                        series: [{
                                name: 'signal strength',
                                data: signal
                            },]
                    });
                });
            }
            function temperaturegraph()
            {
                date=document.getElementById("startingDate").value;
               
                    xmlHttp=GetXmlHttpObject();
                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request");
                        return;
                    }

                    var url="temperatureGraph.jsp?meter_id="+escape(meter)+"&sdate="+escape(date);
                    xmlHttp.onreadystatechange=temperaturegraphAction;
                    xmlHttp.open("GET",url,true);
                    xmlHttp.send(null);
                
            }
            function BatteryGraph()
            {
                 date=document.getElementById("startingDate").value;
               
                    xmlHttp=GetXmlHttpObject();
                    if (xmlHttp==null)
                    {
                        alert ("Browser does not support HTTP Request");
                        return;
                    }

                    var url="BatteryVoltageGraph.jsp?meter_id="+escape(meter)+"&sdate="+escape(date);
                    xmlHttp.onreadystatechange=BatteryGraphAction;
                    xmlHttp.open("GET",url,true);
                    xmlHttp.send(null);
                
            }
            function temperaturegraphAction()
            {

                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {

                    document.getElementById("DataPart").innerHTML="";
                    var showdata = xmlHttp.responseText;
                    var selDate=showdata.substring(showdata.indexOf("date")+4,showdata.indexOf("time"));
                    signaltime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("temp")-1);
                    time=signaltime.split(",");
                    modemtemp=showdata.substring(showdata.indexOf("temp")+5);        
                    temperature=modemtemp.split(",");        
        
                    for(j=0;j<temperature.length;j++)
                    {
                        temperature[j]=+temperature[j].replace(/\*C/g,"");
                    }
                    temperatureLineGraph(selDate);
                }
            }
            function BatteryGraphAction()
            {
                 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {

                    document.getElementById("DataPart").innerHTML="";
                    var showdata = xmlHttp.responseText;
                    var selDate=showdata.substring(showdata.indexOf("date")+4,showdata.indexOf("time"));
                    signaltime=showdata.substring(showdata.indexOf("time")+5,showdata.indexOf("BVoltage")-1);
                    time=signaltime.split(",");
                    bVolt=showdata.substring(showdata.indexOf("BVoltage")+9);        
                    batteryVoltage=bVolt.split(",");        
        
                    for(j=0;j<batteryVoltage.length;j++)
                    {
                        batteryVoltage[j]=+batteryVoltage[j].replace(/\*C/g,"");
                    }
                   batteryVoltageLineGraph(selDate);
                }
            }
            function temperatureLineGraph(selDate)
            {
                var chart;
                $(document).ready(function() {
                    chart = new Highcharts.Chart({
                        chart: {
                            renderTo: 'DataPart',
                            defaultSeriesType: 'line',
                            marginRight: 130,
                            marginBottom: 65,
                            width:window.size,

                            borderColor: "#4572A7",
                            borderRadius: 15,
                            borderWidth: 1,
                            margin: [80, 80, 160,160]
                        },
                        title: {
                            text: 'Temperature Graph On '+selDate,
                            x: -20 //center
                        },
                        subtitle: {
                            text: '',
                            x: -20
                        },
                        xAxis: {
                            gridLineWidth: 1,
                            lineColor: '#000',
                            tickColor: '#000',
                            tickWidth:2,
                            labels: {
                                y : 21, rotation: -45 ,align:'center',
                                style: {
                                    color: '#000',
                                    font: '11px Trebuchet MS, Verdana, sans-serif'
                                }
                            },
                            title: {
                                text: ' Time(hh:mm:ss)',
                                padding:10

                            }, 
                            categories: time
                        },
                        yAxis: {
                            minorTickInterval: 'auto',
                            lineColor: '#000',
                            lineWidth: 1,
                            tickWidth: 1,
                            tickColor: '#000',
                            labels: {
                                style: {
                                    color: '#000',
                                    font: '11px Trebuchet MS, Verdana, sans-serif'
                                }
                            },
                            title: {
                                text: 'Modem Temp'
                            },
                            plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }]
                        },
                        tooltip: {
                            formatter: function() {
                                return '<b>'+ this.series.name +'</b><br/>'+
                                    this.x +'(hh:mm:ss)'+ '</b><br/> '+ this.y +'°C';
                            }
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'top',
                            x: -10,
                            y: 100,
                            borderWidth: 0
                        },
                                        
                        series: [{
                                name: 'temp',
                                data: temperature
                            },],
                        exporting: {
                            enabled: true
                        }

                    });


                });
            }
            function batteryVoltageLineGraph(selDate)
            {
                var chart;
                $(document).ready(function() {
                    chart = new Highcharts.Chart({
                        chart: {
                            renderTo: 'DataPart',
                            defaultSeriesType: 'line',
                            marginRight: 130,
                            marginBottom: 65,
                            width:window.size,

                            borderColor: "#4572A7",
                            borderRadius: 15,
                            borderWidth: 1,
                            margin: [80, 80, 160,160]
                        },
                        title: {
                            text: 'Battery Voltage On '+selDate,
                            x: -20 //center
                        },
                        subtitle: {
                            text: '',
                            x: -20
                        },
                        xAxis: {
                            gridLineWidth: 1,
                            lineColor: '#000',
                            tickColor: '#000',
                            tickWidth:2,
                            labels: {
                                y : 21, rotation: -45 ,align:'center',
                                style: {
                                    color: '#000',
                                    font: '11px Trebuchet MS, Verdana, sans-serif'
                                }
                            },
                            title: {
                                text: ' Time(hh:mm:ss)',
                                padding:10

                            }, 
                            categories: time
                        },
                        yAxis: {
                            minorTickInterval: 'auto',
                            lineColor: '#000',
                            lineWidth: 1,
                            tickWidth: 1,
                            tickColor: '#000',
                            labels: {
                                style: {
                                    color: '#000',
                                    font: '11px Trebuchet MS, Verdana, sans-serif'
                                }
                            },
                            title: {
                                text: 'Battery Voltage'
                            },
                            plotLines: [{
                                    value: 0,
                                    width: 1,
                                    color: '#808080'
                                }]
                        },
                        tooltip: {
                            formatter: function() {
                                return '<b>'+ this.series.name +'</b><br/>'+
                                    this.x +'(hh:mm:ss)'+ '</b><br/> '+ this.y ;
                            }
                        },
                        legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'top',
                            x: -10,
                            y: 100,
                            borderWidth: 0
                        },
                                        
                        series: [{
                                name: 'temp',
                                data: batteryVoltage
                            },],
                        exporting: {
                            enabled: true
                        }

                    });


                });
            }
            function sendMeterId()
            {
                mSel=document.getElementById("dtr");
                meter=mSel.options[mSel.selectedIndex].title;       
                document.getElementById("DataPart").innerHTML="";
                document.getElementById("startingDate").value="";
            }
            function sendFeederMeterId()
            {
                substationSel=document.getElementById("substation");
                substationId=substationSel.options[substationSel.selectedIndex].value;
                 if(substationId!="0")
                {
                    showDTRs(substationId,0); 
                    meter="All";
                }//cal this after selecting the substation only
       
                if(substationId=="0")
                {
                    mSel=document.getElementById("dtr");
                    meter=mSel.options[mSel.selectedIndex].title;   
                }              
                document.getElementById("startingDate").value="";
                document.getElementById("DataPart").innerHTML="";                
               
                
                // alert(substationId);
                    
            }
            function getDiagnosisHirarchy(meterLoc)
            {
                meterLocation=meterLoc;
                if(meterLoc=="feeder")
                {
                  document.getElementById('tempId').style.display="none";
                  document.getElementById('DataPart').innerHTML="";
                }
                if(meterLoc=="dtr" || meterLoc=="ht")
                {
                    document.getElementById('tempId').style.display="block";
                  document.getElementById('DataPart').innerHTML="";
                }
                document.getElementById("startingDate").value="";
                document.getElementById("DataPart").innerHTML="";   
                xmlHttp=GetXmlHttpObject();
                if (xmlHttp==null)
                {
                    alert ("Browser does not support HTTP Request");
                    return;
                }

                var url="getHirarchyForDiagnosis.jsp?meterLoc="+escape(meterLoc);   
                xmlHttp.onreadystatechange=insertDiagnosisHirarchy;
                xmlHttp.open("GET",url,true);
                xmlHttp.send(null); 
            }
            function insertDiagnosisHirarchy()
            {
                if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
                {
                    document.getElementById("getHirarchy").innerHTML=xmlHttp.responseText;
                }
            }
           
            
        </script>


    </head>
    <body>
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Select Meter</b>
                            </td>
                        </tr>

                    </table>
                    <br />
                    <%@ include file="side_modem_diagnosis.jsp"%>

                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                  
                    <div class="tab-box" style="padding-top: 6px;">
                        <table><tr>
                                <td><a href="javascript:;" class="tabLink " id="cont-1">Modem Diagnosis</a></td>
                                <td> <a href="javascript:;" class="tabLink " id="cont-2">Signal Strength Graph</a></td>
                                <td> <div  id="tempId" style="display: none;"><a href="javascript:;" class="tabLink " id="cont-3">Temperature Graph</a></div></td>
                               <!-- <td> <a href="javascript:;" class="tabLink " id="cont-3">Temperature Graph</a></td>
                                <td> <a href="javascript:;" class="tabLink " id="cont-4">Battery Voltage Graph</a></td> -->
                            </tr></table>
                    </div>
                     <form name="DiagnosisForm" action="javascript:void(0)" style="padding-top: 6px;padding-bottom: 3px" >
                        <table border="0" width="300px"> <tr>
                                <td>Select Date:</td>
                                <td><input type="text" size="10" name="startingDate" id="startingDate" />
                                    <a href="javascript:show_calendar('DiagnosisForm.startingDate');"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0/></a>
                                </td>
                                <td><input type="button" value="Get Report" onclick="getDiagReport();" /></td>
                            </tr>
                        </table>
                    </form>
                    
                    <div id="DataPart"  align="center"></div>



                </td>
                <td width=13px style="background:url(images/bg-content-right.png) no-repeat;width:13px;background-color:#EDF5FA;"></td>
            </tr>


        </table>
        <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
        <script>
          /*  var count = 5;
            var preset_date = document.getElementById("startingDate").value;
            function auto_call()
            {
                var link1_class = document.getElementById("cont-1").className;
                var link2_class = document.getElementById("cont-2").className;
                //alert(link2_class+"   "+link2_class.indexOf("activeLink"));                
                     
                if(link1_class.indexOf("activeLink")!=-1)
                {
                    if(preset_date!=document.getElementById("startingDate").value)
                        modemdiagnosis();
                    else
                        count = 10;
                }
                if(link2_class.indexOf("activeLink")!=-1)
                {
                    if(preset_date!=document.getElementById("startingDate").value)
                        signalgraph();
                    else
                        count = 10;
                }
            }
            var int = setInterval(function(){auto_call()},parseInt(count)*1000); */
            </script>
</html>

<%
    //code to delete image files


%>