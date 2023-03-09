<%-- 
    Document   : ai_line_graph
    Created on : Dec 9, 2011, 4:44:54 PM
    Author     : root
--%>
<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Load Survey DATA LINE GRAPH</title>
        
                <script type="text/javascript" src="jquery.min.js"></script>
		<script type="text/javascript" src="highcharts.js"></script>
                <script type="text/javascript" src="gray.js"></script>
		<!--<script type="text/javascript" src="js2/modules/exporting.js"></script>-->
                
<%
    String[] ai_values_str = request.getParameter("feeder_compl_val_str").split(",DATA_END,");
    String time_inter_str = request.getParameter("time_values_string");
    String date_inter_str = request.getParameter("date_values_string");
    String[] time_inter = time_inter_str.split(",");
    String[] date_inter = date_inter_str.split(",");
    
    //String[] ai_values_str = "10,20,30,40,DATA_END,5,30,6,34,DATA_END,10,14,34,20,DATA_END,".split(",DATA_END,");
    //String time_inter_str = "'01:00','02:00','03:00','04:00'";
    //String ai_avg_value = request.getParameter("avg_value");
    String[] ai_name = request.getParameter("param_names").split(",");
    
    
    
%>

		<script type="text/javascript">
		
			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						defaultSeriesType: 'line',
						marginRight: 130,
						marginBottom: 50
					},
					title: {
						text: 'Load Survey Graph',
						x: -20 //center
					},
					subtitle: {
						text: '',
						x: -20
					},
					xAxis: {
						title: {
							text: 'Time Interval'
						},
						categories: [
                                                    <%
                                                for(int i=0;i<time_inter.length;i++)
                                                    out.println("'"+date_inter[i]+" <br />"+time_inter[i]+"',");
                                                %>
                                                ]
					},
					yAxis: {
						title: {
							text: 'VALUES '
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
								this.x +': '+ this.y ;
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
                                            <%
                                                for(int i=0;i<ai_values_str.length;i++)
                                                {
                                                %>
                                                      {
						name: '<%=ai_name[i]%> Data',
						data: [
                                                <%=ai_values_str[i]%>
                                                ]
                                                }       
                                                <%
                                                if(i==ai_values_str.length-1)
                                                {}
                                                else
                                                {
                                                    out.print(",");
                                                }
                                                }
                                                %>
                                                                ]
                                            
				});
				
				
			});
				
		</script>
    </head>
    <body>
        <div id="container" style="width: auto; height: 400px; margin: 0 auto"></div>
    <center><input type="button" value="Close" onclick="window.close()" /></center>
    </body>
</html>


