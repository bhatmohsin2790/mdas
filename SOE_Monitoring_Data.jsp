<%--
    Document   : RTUAnalogData.jsp
    Created on : Nov 29, 2011, 5:17:02 PM
    Author     : usha
--%>

<%@page import="bean.SOE_Bean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<%@ page  import="java.util.*,FormBean.rtuform"%>
<%@ page  import="bean.AnalogDataBean,bean.RTUBean,bean.DigitalDataBean"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

        <script>
          function getAnalogData(e)
          {
              if(e.options[e.selectedIndex].value==-1)
              {
                  alert("Please Select RTU...");
              }
              else
                  {
               document.rtuformdatamonitoring.action="./soe_data.do";
              document.rtuformdatamonitoring.submit();
              refreshPage();
                  }
                  
              }
              function refreshPage()
          {
                document.rtuformdatamonitoring.action="./soe_data.do";
                document.rtuformdatamonitoring.submit();
                setTimeout("refreshPage()",1000);
          }


        </script>
 <HTML>
    <%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
    <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
    <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
    <head>
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
    <body>
        <div id="navigation"></div>

        <table width=100% border=0 cellpadding=0 cellspacing=0 style="background:url(images/body.png) repeat-x;">
            <%@ include file="top.jsp"%>
            <tr>
                
                <td width=100% height="450px" style="background:url(images/bg-content-center.png) repeat-x;padding-left:10px;padding-right:10px;padding-bottom:10px;padding-top:10px;" valign="top">

                    <%@ include file="menu1.jsp"%>
                    <br></br>
        <center> 
            <html:form action="/soe_data">
            Select DCU :
                <html:select name="rtuformdatamonitoring" property="rtuName" onchange="getAnalogData(this)" >
                             <html:option value="-1">select</html:option>
                <html:optionsCollection name="rtuformdatamonitoring" property="alRtuNames" label="rtuName" value="rtuId"/>
            </html:select>
            </center>

       <%
       
			    String rtuName="";
                            String date = null;
                            String time="";
			    if(request.getAttribute("rtuName")!=null)
			    {
				rtuName=request.getAttribute("rtuName").toString();
			    
                            
                          
	%>
      
					<%
						int rowCount=0;
						ArrayList alAnalogData1 =(ArrayList)request.getAttribute("soedata");
						//System.out.println("the alAnalogData is :"+alAnalogData);
						if((alAnalogData1!=null && alAnalogData1.size()>0))
						{
                                                   // System.out.println("the alAnalogData is :"+alAnalogData1);
					%>
                                          </center>
  <table id="rounded-corner" width="250px" border="0" align="center" />

  <tbody>
    <tr>
        <td align="left">DCU NAME : <font color="red"><%=rtuName%></font></td>
        <td></td>
        <td valign="top" align="right"></td>

            </tr>
            
</tbody>

        </table>
        <!--<table width="100%" >
            <tr>
                 <td align="left">AI Points:</td> &nbsp;<td>Valid Points:</td> &nbsp;<td>Invalid Points:</td>
            </tr>
        </table>-->
       
           <table align="center" width=96%">
    <tr>
        <td>

        <table id="rounded-corner" border="0" align="center" >
        <thead>
                                            <tr>
                                            <th col="col" align="center" class="rounded-company">  </th>
                                            <th col="col" colspan="4" align="center" class="rounded-q4"><b>SOE DATA</b></th>

                                            </tr>
                                        
                                            <tr>
                                            <th col="col" align="center" class="rounded-q2"> <b>DI DESC</b> </th>
                                            <th col="col"align="center" class="rounded-q2"><b>VALUE</b></th>
					    <th col="col" align="center" class="rounded-q3"> <b>DATE</b> </th>
                                            <th col="col" align="center" class="rounded-q3"><b>TIME</b></th>
                                            <!--<th col="col" align="center" class="rounded-q3"><b>Valid Range</b></th>-->
                                            <th col="col" align="center" class="rounded-q3"> <b>DATE TIME OF DEVICE</b></th>
                                            </tr>
                                        </thead>
                                        <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan="4"></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
                                        <tbody>
     
                                        
					<logic:iterate id="soedata" name="soedata" scope="request">
						<%rowCount=rowCount+1;%>
                                                <tr>

                                <%
                                   SOE_Bean soebean=null;
                                  String paraType="";
                                  soebean=(SOE_Bean)alAnalogData1.get(rowCount-1);
                                         %>
                                <td align="center">
                                    <bean:write name="soedata" property="div_id"/>
				</td>
                                <td align="center">
                                    <%
                                    int div_va = Integer.parseInt(soebean.getDiv_value());
                                    if(div_va==0)
                                        out.println("UNDEFINED");
                                    if(div_va==1)
                                        out.println("OPEN");
                                    if(div_va==2)
                                        out.println("CLOSE");
                                    if(div_va==3)
                                        out.println("TRANSIANT");
                                    %>
				</td>
                                <td align="center">
                                    <bean:write name="soedata" property="date"/>
				</td>
                                <td align="center">
                                    <bean:write name="soedata" property="time"/>
				</td>
                                <td align="center">
                                    <%  
                                    String timestamp = soebean.getDiv_timestamp();
                                    String[] split_data = timestamp.split(",");
                                    for(int i=1;i<6;i++)
                                    {
                                        if(split_data[i].length()==1)
                                            split_data[i] = "0"+split_data[i];
                                    }
                                    String timestamp_date = split_data[0]+"-"+split_data[1]+"-20"+split_data[2];
                                    String timestamp_time = split_data[3]+":"+split_data[4];
                                    String msec = split_data[5];
                                    String sec = ""+(Double.parseDouble(msec) / (double)1000);
                                    timestamp_time = timestamp_time+":"+sec;
                                    out.println(timestamp_date+" "+timestamp_time);
                                    %>
                                   
				</td>
                            </tr>
					</logic:iterate>
                                                </tbody>
                                                
				</table>
					    <%
					     }//end of if
                                                                                               
					  else
					     {
					     %>
                                             <table id="rounded-corner" width="250px" border="0" align="center" />
                                                <tbody>
                                                <tr>
                                                    <td align="center">
                                                        <font color="red">RTU does not contain Data</font>
                                                    </td>
						</tr>
                                                </tbody>
                                             </table>
					<%
					     }
                                                                                               }
					    %>
					
            </html:form>
      <div id="DataPart"  align="center"></div>





            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>
