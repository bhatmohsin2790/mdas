/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function GetXmlHttpObject()
{
    var xmlHttp=null;
    if (window.XMLHttpRequest) {
        xmlHttp = new window.XMLHttpRequest;
    }
    else {
        try {
            xmlHttp = new ActiveXObject("MSXML2.XMLHTTP.3.0");
        }
        catch(ex) {
            return null;
        }
    }
    return xmlHttp;
}//GetXmlHttpObject
var graphTime=new Array();
var dateString=new Array();
var vaExp=new Array();
var vaImp=new Array();
var varExp=new Array();
var varImp=new Array();
var wExp=new Array();
var wImp=new Array();
var meterid=null;
var loadSurvayDate=null;
var paramNames=new Array();
var paramValues=new Array();
function getLoadGraph(butnValue)
{
   
   document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;	
   xmlHttp=GetXmlHttpObject();
    var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
     meterid=document.getElementById('dtr').options[Selected].text;
    
    loadSurvayDate=document.getElementById('loadgraphDate').value;

    var chbMF=document.getElementById("chbMF");

    var url="getLoadSurvayGraph.jsp?sdate="+escape(loadSurvayDate)+
        "&meterid="+escape(SelectedOption)+"&EMF="+(chbMF.checked?"1":"0");
      //alert(url);
    if(butnValue==1)
        {
           xmlHttp.onreadystatechange=getDayLine;
        }
        if(butnValue==2)
            {
                xmlHttp.onreadystatechange=getDayBarChart;
            }
     xmlHttp.open("GET",url,true);
     xmlHttp.send(null);
}
function getMultipleLoadGraph(butnType)
{
   
    if(document.getElementById("multiplesDate").value=="" && document.getElementById("multipleeDate").value=="")
        {
            alert("please select fromdate and todate");
        }
     xmlHttp=GetXmlHttpObject();
    var Selected = document.getElementById('dtr').selectedIndex;
    var SelectedOption = document.getElementById('dtr').options[Selected].value;
     meterid=document.getElementById('dtr').options[Selected].text;

    multipleLoads=document.getElementById('multiplesDate').value;
    multipleLoade=document.getElementById('multipleeDate').value;
   var chbMF=document.getElementById("chbMF");
    
    if(butnType==1)
        {
             var url="loadMultipleStepGraph.jsp?sdate="+escape(multipleLoads)+
                 "&edate="+escape(multipleLoade)+"&meterid="+escape(SelectedOption)+"&EMF="+(chbMF.checked?"1":"0");
			 //alert(url);
              // xmlHttp.onreadystatechange=getMultipleLine;
			  // xmlHttp.onreadystatechange=getMultipleStep;
			window.open (url, "mywindow","location=1,status=1,scrollbars=1, width=1000,height=400");
			window.moveTo(100,100); 
        }
        if(butnType==2)
            {
                 document.getElementById("DataPart").innerHTML= document.getElementById("dcu_loading").innerHTML;
                 var url="loadMultipleGraph.jsp?sdate="+escape(multipleLoads)+"&edate="+escape(multipleLoade)+"&meterid="+escape(SelectedOption)+"";
				 //alert(url);
                 xmlHttp.onreadystatechange=getMultipleBarChart;
				  xmlHttp.open("GET",url,true);
			     xmlHttp.send(null);
            }
    
}
function getDayLine()
{
   
    //document.getElementById('DataPart').innerHTML = "";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {       
        var showdata = xmlHttp.responseText;       
        for( i=0;i<showdata.split(";").length;i++)
        {                
            paramNames=paramNames+","+showdata.split(";")[i].substring(0,showdata.split(";")[i].indexOf(","));                 
            paramValues=paramValues+";"+showdata.split(";")[i].substring(showdata.split(";")[i].indexOf(","));                  
        // alert(showdata.split(";")[i].substring(showdata.split(";")[i].indexOf(",")));
        }         
      
        if(paramValues.split(";")[1].length<2){           
             paramValues={};paramNames={};
            document.getElementById("DataPart").innerHTML= "<h3 align='center'>No data Available.</h3>";
            return;
        }
        if(paramValues.split(";")[1].length>2){                        
            dayStep();
        }
        
    }
}
var tickInt;
function getMultipleLine()
{
     document.getElementById('DataPart').innerHTML = "";
              paramNames={};
              paramValues={};
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        for( i=0;i<showdata.split(";").length;i++)
            {
                  paramNames=paramNames+","+showdata.split(";")[i].substring(0,showdata.split(";")[i].indexOf(","));

                  paramValues=paramValues+";"+showdata.split(";")[i].substring(showdata.split(";")[i].indexOf(","));
            }
			//alert("paramNames--"+paramNames.split(","));
			 if(paramValues.split(";")[1].substring(1).split(",").length<=768)
				  tickInt=48;
			 if (paramValues.split(";")[1].substring(1).split(",").length>768)
			     tickInt=48*2;
           //alert("tickInte id"+tickInt);
            
        multipleStep();
    }
}

function getMultipleStep()
{
	 document.getElementById('DataPart').innerHTML = "";
	  if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
		  alert("in response");
		   var showdata = xmlHttp.responseText;
		   document.getElementById('DataPart').innerHTML = showdata;
		   		  

	}
}
function getDayBarChart()
{
    //document.getElementById('DataPart').innerHTML = "";
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        for( j=0;j<showdata.split(";").length;j++)
        {
            paramNames=paramNames+","+showdata.split(";")[j].substring(0,showdata.split(";")[j].indexOf(","));
            paramValues=paramValues+";"+showdata.split(";")[j].substring(showdata.split(";")[j].indexOf(","));                  
        }        
       
        if(paramValues.split(";")[1].length<2){           
             paramValues={};paramNames={};
            document.getElementById("DataPart").innerHTML= "<h3 align='center'>No data Available.</h3>";
            return;
        }
        if(paramValues.split(";")[1].length>2){                        
              dayBar();
        }
    }
}

function getMultipleBarChart()
{
    //document.getElementById('DataPart').innerHTML = "";
    paramNames={};
    paramValues={};
    if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete")
    {
        var showdata = xmlHttp.responseText;
        for( i=0;i<showdata.split(";").length;i++)
        {
            paramNames=paramNames+","+showdata.split(";")[i].substring(0,showdata.split(";")[i].indexOf(","));
            paramValues=paramValues+";"+showdata.split(";")[i].substring(showdata.split(";")[i].indexOf(","));
                  
        }           
             
        if(paramValues.split(";")[1].length<6){           
             paramValues={};paramNames={};
            document.getElementById("DataPart").innerHTML= "<h3 align='center'>No data Available.</h3>";
            return;
        }
        if(paramValues.split(";")[1].length>6){                        
               multipleBar();
        }
        
    }
}
function dayLine()
{

			var chart;


			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'DataPart',
						defaultSeriesType: 'line',
						marginRight: 100,
						marginBottom: 55,
                                                width:window.size,
                                                borderColor: "#4572A7",
                                                borderRadius: 15,
                                                borderWidth: 1,
                                                margin: [80, 80, 160,160]
					},
					title: {
						text: 'Line Graph for <br/>'+meterid+' on  '+loadSurvayDate+'',
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
                                                  enabled: false
                                              },
                                            title: {
							text: 'Time(hh:mm:ss)'

						},
						categories: graphTime
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
							text: 'values'
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
								this.x +'(hh:mm:ss)'+'</b><br/> '+ this.y +'';
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
					series: [
                                            
                                            {
						name: 'VA(E)',
						data: vaExp
					}, {
						name: 'VA(I)',
						data: vaImp,
                                                step: true
					}, {
						name: 'VAr(E)',
						data: varExp
					},
                                        {
						name: 'VAr(I)',
						data: varImp
					},
                                        {
						name: 'W(E)',
						data:wExp
					},
                                        {
						name: 'W(I)',
						data: wImp
					},
                                        ,],
                                     exporting: {
        enabled: true
      }
				});


			});

}
function dayStep()
{      
    var seriesData = [];  //constructor in series to add multiple series at a time
    for (var i = 2; i < paramNames.split(",").length; i++){       
        var dataSeries=new Array();
        for( j=0;j<paramValues.split(";")[i].substring(1).split(",").length;j++)
        {
            dataSeries[j]=+paramValues.split(";")[i].substring(1).split(",")[j];
        }
  
        seriesData.push({
            name: paramNames.split(",")[i],      // adding multiple series(params) values to graph
            data: dataSeries,
                                      
            step:true
        });
                                 
    }
    // Create the chart
    var chart;
    
    $(document).ready(function() {
        chart = new Highcharts.StockChart({
            chart: {
                renderTo: 'DataPart',
                width: window.size,
                marginRight: 100,
                marginBottom: 55,
                width:window.size,
                borderColor: "#4572A7",
                borderRadius: 15,
                borderWidth: 1,
                margin: [80, 80, 160,160]
                                        
            },
            title: {
                text: 'Graph for '+meterid+' on  '+loadSurvayDate+'',
                x: -20 //center
            },
            plotOptions:{
                lineWidth: 80

            },
            scrollbar: {
                enabled: true
            },
                                     
            xAxis: {
                tickInterval:3,
				        
                title: {
                    text: 'Time(hh:mm)'

                },
                categories: paramValues.split(";")[1].substring(1).split(","),
                min: 0,
                max:24
                                               
            },
            yAxis: {
                title: {
                    text: 'Values'
                }
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+this.x +'(hh:mm)'+'</b><br/> '+ this.y +'';
                }
            },
            legend: {
                layout: 'vertical',
                backgroundColor: '#FFFFFF',
                align: 'left',
                verticalAlign: 'top',
                x: 10,
                y: 50,
                floating: true,
                shadow: true
            },

                                       
            series: seriesData
        });
    });
    paramNames={};
    paramValues={};
}
function multipleLine()
{
    var chart;


			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'DataPart',
						defaultSeriesType: 'line',
						marginRight: 100,
						marginBottom: 55,
                                                width:window.size,
                                                borderColor: "#4572A7",
                                                borderRadius: 15,
                                                borderWidth: 1,
                                                margin: [80, 80, 160,160]
					},
					title: {
						text: 'Line Graph for <br/>'+meterid+' from  '+multipleLoads+' to '+multipleLoade,
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
                                                  enabled: false
                                              },
                                            title: {
							text: 'Time(hh:mm:ss)'

						},
						categories: dateString
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
							text: 'values'
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
								this.x +'(dd-mm-yyyy)'+'</b><br/> '+ this.y +'';
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
						name: 'VA(E)',
						data: vaExp
					}, {
						name: 'VA(I)',
						data: vaImp
					}, {
						name: 'VAr(E)',
						data: varExp
					},
                                        {
						name: 'VAr(I)',
						data: varImp
					},
                                        {
						name: 'W(E)',
						data:wExp
					},
                                        {
						name: 'W(I)',
						data: wImp
					},
                                        ,],
                                     exporting: {
        enabled: true
      }
				});


			});
}

function dayBar()
{
    var seriesDataBar = [];  //constructor in series to add multiple series at a time
    for (var i = 2; i < paramNames.split(",").length; i++){
    var dataSeries=new Array();
    for( j=0;j<paramValues.split(";")[i].substring(1).split(",").length;j++)
        {dataSeries[j]=+paramValues.split(";")[i].substring(1).split(",")[j];}

    seriesDataBar.push({name: paramNames.split(",")[i],      // adding multiple series(params) values to graph
                                      data: dataSeries,
                                      step:true

                                  });

}
    var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo:  'DataPart',
						defaultSeriesType: 'column',
                                                marginRight: 100,
						marginBottom: 55,
                                                width:window.size,
                                                borderColor: "#4572A7",
                                                borderRadius: 15,
                                                borderWidth: 1,
                                                margin: [80, 80, 160,160]
                                                 
					},
					title: {
						text: 'Bar Chart for'+meterid+' on  '+loadSurvayDate+''
					},
					
					xAxis: {
                                                   
                                               title: {
							text: 'Time(hh:mm)'


						},
						categories: paramValues.split(";")[1].substring(1).split(","),
                                                min: 0,
                                                max:10
					},
					yAxis: {
						min: 0,
						title: {
							text: 'Values'
						}
					},
					legend: {
						layout: 'vertical',
						backgroundColor: '#FFFFFF',
						align: 'left',
						verticalAlign: 'top',
						x: 30,
						y: 50,
						floating: true,
						shadow: true
					},
                                        plotOptions: {
						column: {
							pointPadding: 1,
                                                        pointWidth:5,
							borderWidth: 0
						}
					},
                                        scrollbar: {
                                                                enabled: true
                                                            },

					tooltip: {
						formatter: function() {
				                return '<b>'+ this.x +'(hh:mm)'+'</b><br/> '+ this.y +'';
						}
					},
					
				        series:seriesDataBar
				});


			});
                  paramNames={};
                  paramValues={};
}
function multipleBar()
{
    //alert("tickInte id"+tickInt);
    var seriesData = [];  //constructor in series to add multiple series at a time
    for (var i = 2; i < paramNames.split(",").length; i++){
        var dataSeries=new Array();
        for( j=0;j<paramValues.split(";")[i].substring(1).split(",").length;j++)
        {
            dataSeries[j]=+paramValues.split(";")[i].substring(1).split(",")[j];
        }

        seriesData.push({
            name: paramNames.split(",")[i],      // adding multiple series(params) values to graph
            data: dataSeries,
            step:true

        });

    }
    var chart;
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo:  'DataPart',
                defaultSeriesType: 'column',
                marginRight: 100,
                marginBottom: 55,
                width:window.size,
                borderColor: "#4572A7",
                borderRadius: 15,
                borderWidth: 1,
                margin: [80, 80, 160,160]

            },
            title: {
                text: 'Graph for'+meterid+' from  '+multipleLoads+' to '+multipleLoade
            },

            xAxis: {

                title: {
                    text: 'Time(hh:mm:ss)'


                },
                categories:paramValues.split(";")[1].substring(1).split(","),
                min: 0,
                max:10
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Values'
                }
            },
            legend: {
                layout: 'vertical',
                backgroundColor: '#FFFFFF',
                align: 'left',
                verticalAlign: 'top',
                x: 30,
                y: 50,
                floating: true,
                shadow: true
            },
            plotOptions: {
                column: {
                    pointPadding: 1,
                    pointWidth:5,
                    borderWidth: 0
                }
            },
            scrollbar: {
                enabled: true
            },

            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'(hh:mm:ss)'+'</b><br/> '+ this.y +'';
                }
            },

            series:seriesData
        });


    });
    paramNames={};
    paramValues={};
                        
}
function multipleStep()
{

     var multiSeriesData = [];  //constructor in series to add multiple series at a time
	 //alert(paramNames);
    for (var i = 2; i < paramNames.split(",").length; i++){
    var dataSeries=new Array();
    for( j=0;j<paramValues.split(";")[i].substring(1).split(",").length;j++)
        {dataSeries[j]=+paramValues.split(";")[i].substring(1).split(",")[j];}

//alert(dataSeries);
   multiSeriesData.push({name: paramNames.split(",")[i],      // adding multiple series(params) values to graph
                                      data: dataSeries,
                                      step: true

                                  });

}
     var chart;
    
                                 $(document).ready(function() {
				chart = new Highcharts.StockChart({
				    chart: {
				        renderTo: 'DataPart',
							//defaultSeriesType: 'line',
                                        width:window.size

				    },



				    title: {
				      text: 'Graph for'+meterid+' from  '+multipleLoads+' to '+multipleLoade,
						x: -20 //center
				    },

				    xAxis: {
						tickInterval:tickInt,
						//tickInterval:1,
                                                  
						categories:paramValues.split(";")[1].substring(1).split(","),
							max:720,
						labels:
{
  enabled:true
}

											   
				    },
				    yAxis: {
				        title: {
				            text: 'Values'
				        },
						

				    },
						plotOptions: {
  line: {
    lineWidth:0.5,
    marker: {
      enabled: false
    }
  }
},
                                    tooltip: {
						formatter: function() {
				                return '<b>'+this.x +'</b><br/> '+ this.y +'';
						}
					},
                                      legend: {
						layout: 'vertical',
						align: 'right',
						verticalAlign: 'middle',
						x:10,
						y:-10, 
							shadow: true,
						borderWidth: 1
					},
                          scrollbar: {enabled: true},             
				    series:multiSeriesData
				});
                                });
                  paramNames={};
                  paramValues={};
}