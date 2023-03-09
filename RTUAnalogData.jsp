<%--
    Document   : RTUAnalogData.jsp
    Created on : Nov 29, 2011, 5:17:02 PM
    Author     : usha
--%>

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
                  alert("Please Select DCU...");
              }
              else
                  {
               document.rtuformdatamonitoring.action="./RTUAnalogData.do";
              document.rtuformdatamonitoring.submit();
              refreshPage();
                  }
                  
          }
          function refreshPage()
          {
               document.rtuformdatamonitoring.action="./RTUAnalogData.do";
               document.rtuformdatamonitoring.submit();
               setTimeout("refreshPage()",1000);
          }


        </script>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
            <html:form action="/RTUAnalogData">
            Select DCU :
                <html:select name="rtuformdatamonitoring" property="rtuName" onchange="getAnalogData(this)" >
                             <html:option value="-1">select</html:option>
                <html:optionsCollection name="rtuformdatamonitoring" property="alRtuNames" label="rtuName" value="rtuId"/>
            </html:select>
            </center>

       <%
       AnalogDataBean analogBean1=new AnalogDataBean();
	analogBean1=(AnalogDataBean)request.getAttribute("analogBean");
			    String rtuName="";
                            String date = null;
                            String time="";
			    if(request.getAttribute("rtuName")!=null)
			    {
				rtuName=request.getAttribute("rtuName").toString();
			    
                             if(analogBean1!=null)
			    {
				date= analogBean1.getDate()+"";
                                time=analogBean1.getTime()+"";
                             }
                          
	%>
      
					<%
						int rowCount=0;
						ArrayList alAnalogData1 =(ArrayList)request.getAttribute("alAnalogData");
						//System.out.println("the alAnalogData is :"+alAnalogData);
						if((alAnalogData1!=null && alAnalogData1.size()>0) && !(date.equals("null")))
						{
                                                   // System.out.println("the alAnalogData is :"+alAnalogData1);
					%>
                                          </center>
  <table id="rounded-corner" width="250px" border="0" align="center" >

  <tbody>
    <tr>
        <td align="left">DCU NAME : <font color="red"><%=rtuName%></font></td>
        <td></td>
        <td valign="top" align="right">LATEST DATE & TIME : <font color="red"><%=date%>&nbsp;<%=time.substring(0,time.lastIndexOf(":"))%></font></td>

            </tr>
            <tr>
                                                    
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
        <td align="center">

        <table id="rounded-corner" border="0" align="center" >
        <thead>
                                            <tr>
                                            <th col="col" align="center" class="rounded-company">  </th>
                                            <th col="col" colspan="1" align="center" class="rounded-q3"><b> ANALOG DATA</b></th>
                                            <th col="col" align="center" class="rounded-q4">  </b></th>
                                            </tr>
                                       
                                            <tr>
                                            <th col="col" align="center" class="rounded-q2"> <b>AI NAME</b> </th>
                                            <th col="col"align="center" class="rounded-q2"><b>Description</b></th>
					    <th col="col" align="center" class="rounded-q3"> <b>Value</b> </th>
                                            
                                           
                                            
                                            </tr>
                                        </thead>
                                        <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan="2"><em><font color="red">NA</font>:Not Available &nbsp;<font color="violet">Invalid Overflow:</font></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
                                        <tbody>
     
                                        
					<logic:iterate id="analogData" name="alAnalogData" scope="request">
						<%rowCount=rowCount+1;%>
                                                <tr>

                                <%
                                   AnalogDataBean analogBean=null;
                                  String paraType="";
                                  analogBean=(AnalogDataBean)alAnalogData1.get(rowCount-1);
                                    paraType=analogBean.getAI_Name();
                              
                                 
                                         %>


                                                      <td align="center">
                                                       
							  <bean:write name="analogData" property="AI_Name"/>
						    </td>
                                                   
                                                    

                                                     <td align="center">
                                                        <bean:write name="analogData" property="description"/>
						    </td>
						    <td align="center">
                                                    <%

                                                    if(analogBean.getAI_Value()==null)
                                                    {
                                                        out.println("<font color=red>NA</font>");
                                                    }
                                                    else
                                                    {
                                                        //if(paraType.equals("AI13") || paraType.equals("AI14"))
                                                          //  {
                                                            //try{
                                                            //long ai_v1 = Long.parseLong(analogBean.getAI_Value());
                                                            //if(ai_v1>2000)
                                                              //  out.println("0");
                                                            //else
                                                              //  out.println(ai_v1);
                                                            //}
                                                            //catch(NumberFormatException e)
                                                              //      {
//                                                                out.println("0");
  //                                                          }
    //                                                        }
                                                       // else
                                                        //{
                                                    %>
							 <bean:write name="analogData" property="AI_Value"/>
                                                    <%  
                                                        //}
                                                    } %>
						    </td>

				  
                                                   <!--<td align="center">
                                                        <%--<bean:write name="analogData" property="qdmin"/> - <bean:write name="analogData" property="qdmax"/>--%>
                                                    </td>-->
                                                    

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
                                                        <font color="red">DCU does not contain Data</font>
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
