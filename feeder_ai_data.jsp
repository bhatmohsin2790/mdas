<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="FormBean.Feeder_AI_Data_Form"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>   
<html><head>
        <style>
            /* DIV container around table to constrict the height for IE (IE ignores the tbody height style) */
#FixedTableHead {
	overflow-y:auto;
	margin: 0px;
	padding: 0px;
	border: expression( '1px solid #FFFFFF');

	/* this fixes IE so container width is same as table width */
	width: expression( (this.childNodes[0].clientWidth + 17) + 'px' );

	/* This fixes IE so the container height is table height plus the height of the header */
	height: expression( (parseInt(this.childNodes[0].style.height) +
						 this.childNodes[0].childNodes[1].offsetTop + 1) +'px' );
}

/* Get rid of table cellspacing */
#FixedTableHead table {
	border-spacing: 1px;
	}

/* Get rid of table cellspacing */
#FixedTableHead table td {
	margin: 0px;
}

/* Scrollable Content */
#FixedTableHead table tbody {
	height:100%;
	overflow-x:hidden;
	overflow-y:auto;
	border: 4px solid #FFFFFF;
}

#FixedTableHead table tbody tr {
	height: auto;
	white-space: nowrap;
}

/* Prevent Mozilla scrollbar from hiding right-most cell content */
#FixedTableHead table tbody tr td:last-child {
	padding-right: 20px;

}

/* Fixed Header for IE (firefox uses the tbody overflow assignment, which is ignored by IE)   */
/* Note: In IE an element with a position property set to relative and is a child of         */
/* an element that has an overflow property set, the relative value translates into fixed.    */
#FixedTableHead table thead tr {
	
	height: auto;
	/* this fixes IE header jumping bug when mousing over rows in the tbody */
	top: expression( this.parentNode.parentNode.parentNode.scrollTop + 'px' );
}

/* Formatting Header Row */
#FixedTableHead table thead tr td {
	color: white;
	background-color: #303433;
}

            </style>
        <script>
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
            </script>
        <meta http-equiv="pragma" content="no-cache" />
        <meta http-equiv="pragma" content="-1" />
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="css/screen.css" />
 <link rel="stylesheet" type="text/css" href="css/tablestyles.css" />
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript" src="jquery.min.js"></script>
        <script type="text/javascript" src="highcharts.js"></script>
        <script type="text/javascript" src="exporting.js"></script>

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

    </head>
<script>
    function getFeeders()
    {
        var id = document.forms[0].rtuName.value;
        xmlHttp=GetXmlHttpObject();
        if (xmlHttp==null)
        {
             alert ("Browser does not support HTTP Request");
            return;
        }
        var url="getFeeders_DCU.jsp";
        url=url+"?rtuid="+id+"&feeder="+document.getElementById('feeder_sel').value;
        xmlHttp.onreadystatechange=displayFeeders;
        xmlHttp.open("GET",url,true);
        xmlHttp.send(null);

                //alert((document.forms[0].fromdate.value).replace(/-/gi,"/"));
                
            
        document.getElementById('period').innerHTML = "Period : "+document.forms[0].fromdate.value+" "+document.forms[0].fromtime.value+" To "+document.forms[0].todate.value+" "+document.forms[0].totime.value;
    }
    
    function displayFeeders()
    {
        var resp = xmlHttp.responseText;
        resp = resp.toString();
        document.getElementById("feeder").innerHTML = resp;
    }
</script>
    <body onload="getFeeders()">
        <%
        int feeder_sel = -1;
        if(request.getAttribute("feeder_sel")!=null)
            feeder_sel = Integer.parseInt((String)request.getAttribute("feeder_sel"));
        %>
        <input type="hidden" id="feeder_sel" name="feeder_sel" value="<%= feeder_sel %>" />
    <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>

                <td width=100% height="450px" style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>
                
                <h3 style="float: left;padding-left: 10px;">Feeder Statistics</h3>
               
                <html:form action="/feederdata" >
                    <table border="0" align="center" style="clear:both;align:center">
            <tr>
                <td>
            Select DCU : 
                </td>
                <td>
                <html:select name="feederreq" property="rtuName" onchange="getFeeders(this.value)">
                             <html:option value="-1">select</html:option>
                <html:optionsCollection name="feederreq" property="alRtuNames" label="rtuName" value="rtuId"/>
            </html:select>
                 </td>
            </tr>
                        
                        <tr>
                <td>
            Select Feeder : 
                </td>
                <td id="feeder">
                    
                <select name="selfeeder">
                             <option value="-1">All</option>
                </select>
                 </td>
            </tr>
            <tr>
                <td>Enter From Date &amp; Time :</td>
                <td>
                    <html:text property="fromdate" size="10"></html:text>
                    
    <a href="javascript:show_calendar('forms[0].fromdate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
                    <html:text property="fromtime" size="4" ></html:text>
                </td>
            </tr>
                <tr>
                    <td></td>
                    <td><font color="red">(dd-mm-yyyy)</font>&nbsp;&nbsp; &nbsp;&nbsp;
                    <font color="red">(HH:mm)</font></td>
                </tr>
            <tr>
                <td>Enter To Date &amp; Time :</td>
                <td>
                    <html:text property="todate" size="10"></html:text>
                     <a href="javascript:show_calendar('forms[0].todate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
                        <html:text property="totime" size="4"></html:text>
                </td>
            </tr>
        </table>


                <center><html:submit>GET DATA</html:submit></center>
                </html:form>
                <%
                if(request.getAttribute("listmap")!=null)
                {
                    java.util.Map listmap = (java.util.Map)request.getAttribute("listmap");
                    
                    for(int list=0;list<1;list++)
                    {
                       
                    
                %>
                
                <div id="reports_table">
                <%
                String rtuName = "";
                
                    rtuName=request.getAttribute("rtuName").toString();
                    int rowCount=0;
                    String time_values_str = "";
                    //ArrayList analog_history =(ArrayList)request.getAttribute("analogBean");
                    java.util.ArrayList analog_history =(java.util.ArrayList)listmap.get(list+"");
                     
                    if(analog_history.size()>0)
                                               {
                        Feeder_AI_Data_Form analogBean2=(Feeder_AI_Data_Form)analog_history.get(0);
                                  
                                String[] times2 = analogBean2.getTime_values();
                                String feeder_name = analogBean2.getFeeder_name();
                               System.out.println("analog size : "+times2.length); 
                    if(analog_history!=null && analog_history.size()>0 && times2.length>=1)
                    {%>
                    <div id="FixedTableHead">
                    <table width="96%" border="0" align="center" style="height:300px;">
                    <thead>
                    <tr>
                        <th col="col" colspan='<%=times2.length+2%>' align="center" class="rounded-company"><b> FEEDER STATISTICS</b></th>
                        <th col="col" align="center" class="rounded-q4">  </th>
                      
                    </tr>
                    <tr>
                        <th col="col" colspan='<%=times2.length+3%>' class="rounded-q3"><b> <%= feeder_name %></b></th>
                    </tr>
                    
                    <tr>
                        <th col="col" colspan='<%=times2.length+3%>' class="rounded-q3" align="center"><b><div id="period"></div></b></th>
                    </tr>
                    
                    </thead>
                    

                       <tfoot>
    	<tr>
        	<td colspan='<%= times2.length+2 %>' class="rounded-foot-left" ><em><font color="red">NA</font>:Not Available </em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
                <% for(int ii=0;ii<analog_history.size();ii++) {  %>
                        
						<%rowCount=rowCount+1;%>
                                <%
                                   Feeder_AI_Data_Form analogBean=null;
                                  String paraType="";
                                  analogBean=(Feeder_AI_Data_Form)analog_history.get(rowCount-1);
                                  String ai_name = analogBean.getName();
                                  String[] ai_values = analogBean.getAi_values();
                                String[] times = analogBean.getTime_values();
                                String[] feeder_times = analogBean.getTime_values2();
                                if(times.length>=1){
                                    String ai_values_str = "";
                                  if(rowCount==1)
                                {
                                %>
                                <thead>
                    <tr>
                        <th col="col" class="rounded-q2"> Description </th>
                        <%  for(int times_size=0;times_size<times.length;times_size++) {
                            time_values_str = time_values_str + times[times_size].substring(0,5) +",";
                        %>
                        <th col="col" align="right" class="rounded-q3"><%=times[times_size].substring(0,5)%></th>
                        <% } %>
                        <th col="col" align="right" class="rounded-q2"> Average </th>
                         <th col="col" align="center" class="rounded-q2"> </th>
                    </tr>
                    </thead>
                                <% } %>
                                <tr>
                                    <td><%=ai_name%></td>
                                    <%
                                    float sum=0;
                                    float average;
                                    for(int ai_index=0;ai_index<times.length;ai_index++)
                                    {
                                              
                                        if(ai_values[ai_index]!=null)
                                        {
                                            ai_values_str = ai_values_str + ai_values[ai_index] +",";
                                            sum = sum + Float.parseFloat(ai_values[ai_index]);
                                          // out.println(ai_values[ai_index]);


                                        %>
                                            <td align="right"><%=ai_values[ai_index]%></td>
                                        <%
                                        }
                                        else
                                        {
                                            ai_values_str = ai_values_str + "0" +",";
                                        %>
                                            <td align="center"><font color="red">NA</font></td>
                                        <%
                                        }
                                    }
                                    average = sum / (float)times.length;
                                    NumberFormat formatter=new DecimalFormat(".000");
                                    average=Float.parseFloat(formatter.format(average));
                                    %>
                                      <td align="right"><font color="green"><%=average%></font></td>
                                        <script>
                                        function create_graph(id)
                                        {
                                            //alert(id);
                                            //alert(document.getElementById("ai_values_string"+id).value);
                                            //alert(document.getElementById("avg_value"+id).value);
                                            //alert(document.getElementById("time_values_string"+id).value);
                                            window.showModalDialog("feeder_ai_line_graph.jsp?ai_values_string="+document.getElementById("ai_values_string"+id).value+"&avg_value="+document.getElementById("avg_value"+id).value+"&time_values_string="+document.getElementById("time_values_string"+id).value+"&ai_name="+document.getElementById('ai_name'+id).value ,"" ,'status:no;resizable=no;dialogWidth:850px;dialogHeight:450px;dialogHide:true;help:no;scroll:no');
                                        }
                                    </script>
                                        <input type="hidden" id="avg_value<%=rowCount%>" name="avg_value" value="<%=average%>"></input>
                                        <input type="hidden" id="ai_name<%=rowCount%>" name="ai_name" value="<%=ai_name%>"></input>
                                    <input type="hidden" id="ai_values_string<%=rowCount%>" name="ai_values_string" value="<%=ai_values_str%>" />
                                    <input type="hidden" id="time_values_string<%=rowCount%>" name="time_values_string" value="<%=time_values_str%>" />
                                    <td align="right"><input type="button" value="Graph" name="<%=rowCount%>" onClick="create_graph(this.name)"/></td>
                                </tr>
                                <% } %>
                        <% } %>
                    </tbody>  
                    </table>
                </div>
                                <% 
                    }
                                                        else if(list==0)
{%>
                                      <table id="rounded-corner" width="250px" border="0" align="center" />
                                                <tbody>
                                                <tr>
                                                    <td align="center">
                                                        <font color="red">Feeder Statistics Not Available</font>
                                                    </td>
						</tr>
                                                </tbody>
                                             </table><%
}                
                                       }
                                else if(list==0)
{%>
                                      <table id="rounded-corner" width="250px" border="0" align="center" />
                                                <tbody>
                                                <tr>
                                                    <td align="center">
                                                        <font color="red">Feeder Statistics Not Available</font>
                                                    </td>
						</tr>
                                                </tbody>
                                             </table><%
}   
                                
           } 
        }
        %>
              
                </div>
                </td>
                 </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>
