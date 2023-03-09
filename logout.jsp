<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page import="javax.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.sql.*"%>

<script>
function clearForm() {
    document.getElementsByName("userid")[0].value="";
    document.getElementsByName("password")[0].value="";
	document.getElementById("id").focus();
}
</script>
<script language="JavaScript"><!--
function DisablingBackFunctionality()
{
var URL;
var i ;
var QryStrValue;
URL=window.location.href ;//alert(URL)
i=URL.indexOf("?");
QryStrValue=URL.substring(i+1);
if (QryStrValue!='X')
{
window.location=URL + "?X";
}
}
//--></script>

<%
		String userid=(String)session.getAttribute("userid");
	%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
    <%@include file="importpage.jsp" %>
</head>
<body>
    <div id="total_main" align="center">
        <div id="total_main2">
            <table width=100% border=0 cellpadding=0 cellspacing=0>
            <tr>
                <td class="header" colspan=3>
                    <%@include file="header.jsp" %>
                </td>
            </tr>

            <tr>
                <td class="body_left"></td>
                <td class="body_center">

                    <div id="main_menu">

		  <%
Connection connection=null;
Statement statement=null;
ResultSet rs=null;
DataSource ds=null;
%>
<%
try{
	if(request.getSession(false).getAttribute("userid")!=null){
	  ds=(DataSource)session.getAttribute("datasource");
      connection = ds.getConnection();
      try{
    	  	statement=connection.createStatement();
	    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	        //get current date time with Date()
	        java.util.Date date = new java.util.Date();
	        String sydate=dateFormat.format(date);
		    String s="update user set logouttime='"+sydate+"' where userid='"+session.getAttribute("userid")+"' and sid='"+session.getId()+"'";
		     int row = statement.executeUpdate(s);
              // System.out.println(row + " logoutcolumn affected");
	      }catch (SQLException s){
    	    System.out.println("SQL stattement is not executed!");
		  }
		 finally{
		  connection.close();
		 }
	 }
    }
    catch (Exception e){
      e.printStackTrace();
    }
request.getSession().invalidate();
%>

<br><br><br><br>
<table border="0"  width="300"  align="center" cellspacing="0">
<tr><td>&nbsp;</td></tr>


		  <tr ><td align="center" ><font  color="red">
You Have Logged Out Successfully</td></font></tr><br><br>

<tr><td align="center"><a href="<%=response.encodeRedirectURL("login2.jsp")%>"><u><font size ="3"color="black">Go to Login Page</a></u></font></td></tr>
</b>

<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
</table>
 </div>

                </td>
                <td class="body_right">
                </td>
            </tr>

            <tr>
                <td class="bottom" colspan=3>
                    <%@include file="footer.jsp" %>
                </td>
            </tr>
            </table>
  </div>
 </div>
</body>
</html>