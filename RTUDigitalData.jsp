
<%--
    Document   : RTUDigitalData.jsp
    Created on : Nov 29, 2011, 5:17:02 PM
    Author     : usha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="css/screen.css" />
 <link rel="stylesheet" type="text/css" href="css/tablestyles.css" />
<%@ page  import="java.util.*,FormBean.rtuform"%>
<%@ page  import="java.util.*,bean.AnalogDataBean,bean.RTUBean,bean.DigitalDataBean"%>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  
<html>
    <head>
         <style>
                                                    #rounded-corner h3
                                                    {background-color:#EEEEEE;
                                                     border:1px solid #DDDDDD;
                                                     color:#666666;
                                                     font-size:12px;
                                                     padding:5px 15px;


                                                     text-decoration:none;}

                                                </style>
 <script>
       
          function getDigitalData(e)
          {
            if(e.options[e.selectedIndex].value==-1)
              {
                  alert("Please Select RTU...");
              }
              else
                  {
               document.rtuformdatamonitoring.action="./RTUDigitalData.do";
               document.rtuformdatamonitoring.submit();
               refreshPage();
                  }
          }
          function refreshPage()
          {
               document.rtuformdatamonitoring.action="./RTUDigitalData.do";
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
            <html:form action="/RTUDigitalData">
            Select DCU :
                <html:select name="rtuformdatamonitoring" property="rtuName" onchange="getDigitalData(this)" >
                             <html:option value="-1">select</html:option>
                <html:optionsCollection name="rtuformdatamonitoring" property="alRtuNames" label="rtuName" value="rtuId"/>
            </html:select>
            </center>
       <%
      DigitalDataBean digitalBean1=new DigitalDataBean();
	digitalBean1=(DigitalDataBean)request.getAttribute("digitalBean");
			    String rtuName="";
                            String date="";
                            String time="";
			    if(request.getAttribute("rtuName")!=null)
			    {
				rtuName=request.getAttribute("rtuName").toString();

			    

                             if(digitalBean1!=null)
			    {
				date=digitalBean1.getDate()+"";
                                time=digitalBean1.getTime()+"";
                              }

  
                                                  int rowCount=0;
						ArrayList alDigitalData1 =(ArrayList)request.getAttribute("alDigitalData");
						//System.out.println("the alAnalogData is :"+alAnalogData);
						if((alDigitalData1!=null && alDigitalData1.size()>0) && !(date.equals("null")))
						{
                                                    
					%>

        <table id="rounded-corner" width="250px" border="0" align="center" />

  <tbody>
    <tr>
        <td align="left">DCU NAME : <font color="red"><%=rtuName%></font></td>
        <td></td>
        <td valign="top" align="right">TIME STAMP : <font color="red"><%=date%>&nbsp;<%=time.substring(0,time.lastIndexOf(":"))%></font></td>
  <tr>
                                                   
                                                </tr>
            </tr>
</tbody>

        </table>
   
   <table align="center" width=96%">
    <tr>
        <td>

        <table id="rounded-corner"  border="0" align="center"  >
            <thead>
                <tr>
                    <th col="col" align="right" class="rounded-company"><b> </b></th>
                    <th colspan="2" col="col"align="center" class="rounded-q4"><b>DIGITAL DATA</b></th>
                    
                </tr>
           
                <tr>
                    <th col="col"  class="rounded-q3" align="center"> DI Name </th>
                    <th col="col"align="center" class="rounded-q2"><b>Description</b></th>
                    
                     <th col="col"align="center" class="rounded-q2"><b>Value</b></th>
                </tr>
            </thead>
             <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left" ><em><font color="red">NA</font>:Not Available </em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
					<tbody>

					

					
					<logic:iterate id="digitalData" name="alDigitalData" scope="request">
						<%rowCount=rowCount+1;%>
                                                <%
                                                    DigitalDataBean digitalBean=null;
                                                    digitalBean=(DigitalDataBean)alDigitalData1.get(rowCount-1);                                                
                                                %>
						<tr>
						    <td align="center">

							  <bean:write name="digitalData" property="DI_Name"/>
						    </td>
                                                    <td align="center">

							  <bean:write name="digitalData" property="description"/>
						    </td>
						    
                                                    <td align="center">
                                                            <%
                                                            if(digitalBean.getDI_Value()!=null)
                                                            {
                                                                int di_value = Integer.parseInt(digitalBean.getDI_Value());
                                                                 
                                                                        switch(di_value)
                                                                        {
                                                                            case 0: out.println("Undefined");break;
                                                                            case 1: out.println("OPEN");break;
                                                                            case 2: out.println("CLOSE");break;
                                                                            case 3: out.println("Transiant");break;
                                                                        }
                                                                       
                                                                }
                                                                
                                                            
                                                            else
                                                                out.println("<font color=red>NA</font>");
                                                            %>
                            </td>


						</tr>
					</logic:iterate>
					    <% }
					     else
					     {
					     %>
                                             <table id="rounded-corner" width="250px" border="0" align="center" />
                                                <tbody>
                                                <tr>
                                                    <td align="center">
                                                        <font color="red">DCU does not contain Data</font>
                                                    </td>
						</tr>
                                                </tbody>
                                             </table>
					<%
					     }
                                                                                               }
					    %>
					</tbody>
				</table>
        
            </html:form>
   
    
    <div id="DataPart"  align="center"></div>





            </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

    </body>
</html>
