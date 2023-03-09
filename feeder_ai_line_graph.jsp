<%--
    Document   : ai_line_graph
    Created on : Dec 9, 2011, 4:44:54 PM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AI DATA LINE GRAPH</title>

                <script type="text/javascript" src="jquery.min.js"></script>
		<script type="text/javascript" src="highcharts.js"></script>
                <script type="text/javascript" src="gray.js"></script>
		<!--<script type="text/javascript" src="js2/modules/exporting.js"></script>-->

<%
    String ai_values_str = request.getParameter("ai_values_string");
    String time_inter_str = request.getParameter("time_values_string");
    String ai_avg_value = request.getParameter("avg_value");
    String ai_name = request.getParameter("ai_name");

    String[] ai_values = ai_values_str.split(",");
    String[] time_inter = time_inter_str.split(",");
    //ai_values = "7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 16.5, 23.3, 48.3,".split(",");
    //time_inter = "00:00,01:00,02:00,03:00,04:00,05:00,06:00,07:00,08:00,09:00,".split(",");

%>
		<script type="text/javascript">

			var chart;
			$(document).ready(function() {
				chart = new Highcharts.Chart({
					chart: {
						renderTo: 'container',
						defaultSeriesType: 'line',
						marginRight: 130,
						marginBottom: 35
					},
					title: {
						text: '<%=ai_name%> DATA',
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
                                                    out.println("'"+time_inter[i]+"',");
                                                %>
                                                ]
					},
					yAxis: {
						title: {
							text: '<%=ai_name%> VALUES '
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
					series: [{
						name: '<%=ai_name%> Data',
						data: [
                                                <%
                                                for(int i=0;i<ai_values.length;i++)
                                                    out.println(ai_values[i]+",");
                                                %>
                                                ]
					},{
						name: '<%=ai_name%> AVG DATA',
						data: [
                                                    <%
                                                for(int i=0;i<ai_values.length;i++)
                                                    out.println(ai_avg_value+",");
                                                %>
                                                ]
					}]
				});


			});

		</script>
    </head>
    <body>
        <div id="container" style="width: auto; height: 400px; margin: 0 auto"></div>
    <center><input type="button" value="Close" onclick="window.close()" /></center>
    </body>
</html>
