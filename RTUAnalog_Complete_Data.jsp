
<%@page import="bean.Analog_History_Bean"%>
<%--
    Document   : RTUDigitalData.jsp
    Created on : Nov 29, 2011, 5:17:02 PM
    Author     : usha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<%@ page  import="java.util.*,FormBean.*"%>
<%@ page  import="java.util.*,bean.AnalogDataBean,bean.RTUBean,bean.DigitalDataBean,java.text.*"%>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat"%>
<HTML>
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
    <body>
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                <td width=220px valign="top" style="padding-left:5px;padding-top:5px;background:url(images/side.jpg) repeat-x;background-color:#EDF5FA;" align="center">
                    <table border="0" cellpadding=0 cellspacing=0 style="font-family:Verdana,Arial,Helvetica,sans-serif;font-size:12px;">
                        <tr>
                            <td width="200px" style="border-bottom:1px solid rgb(204, 204, 204);border-top:1px solid rgb(204, 204, 204);" align="center">

                                <b>Select Data</b>
                            </td>
                        </tr>

                    </table>
                    <br></br>
                    <%@ include file="side_dcu.jsp"%>

                </td>
                <td width=14px style="background:url(images/bg-content-left.png) no-repeat;width:14px;background-color:#EDF5FA;"></td>
                <td width=83% style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>
        
<p align="center"></p>    
    
                    <html:form action="/RTUAnalogDataComplete">
        <table border="0" align="center">
            <tr>
                <td>
            Select RTU : 
                </td>
                <td>
                <html:select name="rtuaicomplreqform" property="rtuName">
                             <html:option value="-1">select</html:option>
                <html:optionsCollection name="rtuaicomplreqform" property="alRtuNames" label="rtuName" value="rtuId"/>
            </html:select>
                 </td>
            </tr>
            <tr>
                <td>Enter Date :</td>
                <td><html:text property="seldate" size="12"></html:text></td><td>&nbsp;</td>
                 <td><font color="red">(dd-mm-yyyy)</font></td>
            </tr>
            <tr>
                <td>Enter Time :</td>
                <td><html:text property="seltime" size="12"></html:text></td><td>&nbsp;</td>
                 <td><font color="red">(HH-mm)</font></td>
            </tr>
        </table>


                <center><html:submit>GET DATA</html:submit></center>

               <%
               try{
       Analog_History_Bean analogBean1=new Analog_History_Bean();
	analogBean1=(Analog_History_Bean)request.getAttribute("analogBean");
			   String timeInterval="";


                             if(analogBean1!=null)
			    {
				timeInterval=analogBean1.getPeriodicityInterval()+"";
                             }

	%>


               <table id="rounded-corner" width="250px" border="0" align="center" />

  <tbody>
    <tr>

        <td valign="top" align="right">Time Interval : <%=timeInterval%>&nbsp; Minutes.</td>

            </tr>
</tbody>
                    </table>
                </html:form>
             
                <%
                String rtuName = "";
                if(request.getAttribute("rtuName")!=null)
                {
                    rtuName=request.getAttribute("rtuName").toString();
                    int rowCount=0;
                    String time_values_str = "";
                    ArrayList analog_history =(ArrayList)request.getAttribute("analog_history");
                     
                    if(analog_history.size()>0)
                                               {
                        Analog_History_Bean analogBean2=(Analog_History_Bean)analog_history.get(0);
                                  
                                String[] times2 = analogBean2.getTime_values();
                                
                    if(analog_history!=null && analog_history.size()>0 && times2.length>=1)
                    {%>
                    <table id="rounded-corner" border="0" align="center" />
                    <thead>
                    <tr>
                        <th col="col" align="center" class="rounded-company">  </th>
                        <th col="col" colspan="11" align="center" class="rounded-q3"><b> ANALOG HISTORY DATA</b></th>
                        <th col="col" align="center" class="rounded-q4">  </b></th>
                      
                    </tr>
                    </thead>
                    

                       <tfoot>
    	<tr>
        	<td colspan="12" class="rounded-foot-left" ><em><font color="red">NA</font>:Not Applicable </em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
                    <tbody>
                        <logic:iterate id="analogData" name="analog_history" scope="request">
						<%rowCount=rowCount+1;%>
                                <%
                                   Analog_History_Bean analogBean=null;
                                  String paraType="";
                                  analogBean=(Analog_History_Bean)analog_history.get(rowCount-1);
                                  String ai_name = analogBean.getAi_name();
                                  String[] ai_values = analogBean.getAi_values();
                                String[] times = analogBean.getTime_values();
                                if(times.length>=1){
                                    String ai_values_str = "";
                                  if(rowCount==1)
                                {
                                %>
                                <thead>
                    <tr>
                        <th col="col" align="center" class="rounded-q2"> <b>AI NAME</b> </th>
                        <%  for(int times_size=0;times_size<times.length;times_size++) {
                            time_values_str = time_values_str + times[times_size].substring(0,5) +",";
                        %>
                        <th col="col"align="center" class="rounded-q3"><b><%=times[times_size].substring(0,5)%></b></th>
                        <% } %>
                        <th col="col" align="center" class="rounded-q2"> <b>Average</b> </th>
                         <th col="col" align="center" class="rounded-q2"> </th>
                    </tr>
                    </thead>
                                <% } %>
                                <tr>
                                    <td align="center"><%=ai_name%></td>
                                    <%
                                    float sum=0;
                                    float average;
                                    for(int ai_index=0;ai_index<ai_values.length;ai_index++)
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
                                    average = sum / (float)10;
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
                                            window.showModalDialog("ai_line_graph.jsp?ai_values_string="+document.getElementById("ai_values_string"+id).value+"&avg_value="+document.getElementById("avg_value"+id).value+"&time_values_string="+document.getElementById("time_values_string"+id).value ,"" ,'status:no;resizable=no;dialogWidth:850px;dialogHeight:450px;dialogHide:true;help:no;scroll:no');
                                        }
                                    </script>
                                        <input type="hidden" id="avg_value<%=rowCount%>" name="avg_value" value="<%=average%>"></input>
                                    <input type="hidden" id="ai_values_string<%=rowCount%>" name="ai_values_string" value="<%=ai_values_str%>" />
                                    <input type="hidden" id="time_values_string<%=rowCount%>" name="time_values_string" value="<%=time_values_str%>" />
                                    <td><input type="button" value="Graph" name="<%=rowCount%>" onClick="create_graph(this.name)"/></td>
                                </tr>
                                <% } %>
                        </logic:iterate>
                    </tbody>  
                    </table>
                                <% 
                    }
                          else
{%>
                                      <table id="rounded-corner" width="250px" border="0" align="center" />
                                                <tbody>
                                                <tr>
                                                    <td align="center">
                                                        <font color="red">RTU does not contain Data</font>
                                                    </td>
						</tr>
                                                </tbody>
                                             </table><%
}                
                                       }
                                else
{%>
                                      <table id="rounded-corner" width="250px" border="0" align="center" />
                                                <tbody>
                                                <tr>
                                                    <td align="center">
                                                        <font color="red">RTU does not contain Data</font>
                                                    </td>
						</tr>
                                                </tbody>
                                             </table><%
}   
                                
                }
                }//try
               catch(Exception e)
                       {System.out.println(""+e.getMessage());}
                %>
            
    
   <div id="DataPart"  align="center"></div>





            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>

