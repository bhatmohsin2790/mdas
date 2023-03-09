<%@ page session="false" %>
<%@page import="bean.Tamper_Bean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@page  import="java.util.*"%>
<%@ page import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<html><head>
        <link rel="stylesheet" type="text/css" media="all" href="css/jsDatePick_ltr.min.css" />
        <script type="text/javascript" src="js2/jsDatePick.min.1.3.js"></script>

        <style>
            /* DIV container around table to constrict the height for IE (IE ignores the tbody height style) */
#FixedTableHead {
	overflow-y:auto;
	margin: 0px;
	padding: 0px;
	border: expression( '1px solid #FFFFFF');

	/* this fixes IE so container width is same as table width */
	width: expression( (this.childNodes[0].clientWidth + 17) +'px');

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
<title>Remote Terminal Unit</title>

<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="css/screen.css" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<script type="text/javascript" src="js/com_port_js_functions.js"></script>
<script type="text/javascript" src="js/do_command_js.js"></script>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" href="css/screen.css" />

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<script type="text/javascript" src="js/com_port_js_functions.js"></script>
<script type="text/javascript" src="js/do_command_js.js"></script>
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

        document.getElementById('period').innerHTML = "Period : "+document.forms[0].fromdate.value+" "+document.forms[0].fromtime.value+" To "+document.forms[0].todate.value+" "+document.forms[0].totime.value;
    }

    function displayFeeders()
    {
        var resp = xmlHttp.responseText;
        resp = resp.toString();
        document.getElementById("feeder").innerHTML = resp;
    }
</script>
</head>
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

                <h3 style="float: left;padding-left: 10px;">Feeder Wise Tamper Data</h3>

                <html:form action="/tamper_data">
                    <table border="0" align="center" style="clear:both;">
            <tr>
                <td>
            Select DCU :
                </td>
                <td>
                <html:select name="tamperreq" property="rtuName" onchange="getFeeders(this.value)">
                             <html:option value="-1">select</html:option>
                <html:optionsCollection name="tamperreq" property="alRtuNames" label="rtuName" value="rtuId"/>
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
                    <input onclick="displayDatePicker('fromdate');" type="button" style="border:0px;background:url(images/date_picker1.gif);width:17px;height:17px;" />
                    <html:text property="fromtime" size="4" ></html:text>
                </td>
            </tr>
                <tr>
                    <td></td>
                    <td><font color="red">(dd-mm-yyyy)</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                    <font color="red">(HH:mm)</font></td>
                </tr>
            <tr>
                <td>Enter To Date &amp; Time :</td>
                <td>
                    <html:text property="todate" size="10"></html:text>
                    <input onclick="displayDatePicker('todate');" type="button" style="border:0px;background:url(images/date_picker1.gif);width:17px;height:17px;" />
                        <html:text property="totime" size="4"></html:text>
                </td>
            </tr>
        </table>


                <center><html:submit>GET DATA</html:submit></center>
                </html:form>
                <%
                if(request.getAttribute("listmap")!=null)
                {
                    Map listmap = (Map)request.getAttribute("listmap");

                    for(int list=0;list<listmap.size();list++)
                    {
                        String feeder_compl_val_str = "";
                        String param_names = "";


                %>

                <div id="reports_table">
                <%
                String rtuName = "";

                    rtuName=request.getAttribute("rtuName").toString();
                    int rowCount=0;
                    String time_values_str = "";
                    String date_values_str = "";
                    //ArrayList tamper_history =(ArrayList)request.getAttribute("tamperBean2");
                    ArrayList tamper_history =(ArrayList)listmap.get(list+"");
try{
                    if(tamper_history.size()>0)
                    {
                        Tamper_Bean tamperBean=(Tamper_Bean)tamper_history.get(0);
                        String feeder_name = tamperBean.getFeeder_name();
                        String[] param_names_arr = tamperBean.getParam_names();
                        System.out.println("param_names_arr len :"+param_names_arr.length);
                        System.out.println("step1");
                   %>
                   <div id="FixedTableHead">
                   <table width="96%" border="0" align="center" style="height:auto;">
                   <thead>
                    <tr>
                        <th col="col" align="center" colspan='<%=param_names_arr.length+3%>' class="rounded-company"><b> <%= feeder_name %> TAMPERS</b></th>
                        <th col="col" align="center" class="rounded-q4">  </th>
                    </tr>

                   </thead>


                       <tfoot>
    	<tr>
        	<td colspan='<%= param_names_arr.length+3 %>' class="rounded-foot-left" >&nbsp;</td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
                <% for(int ii=0;ii<tamper_history.size();ii++) {  %>

						<%rowCount=rowCount+1;%>
                                <%
                                System.out.println("step2");
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");

                                   Tamper_Bean tamperBean2=null;
                                  String paraType="";
                                  tamperBean2=(Tamper_Bean)tamper_history.get(rowCount-1);
                                  String[] param_values = null;
                                  try{
                                  param_values = tamperBean2.getParam_values();
                                  }
                                  catch(NullPointerException ex)
                                  {

                                  }
                                  System.out.println("step3");
                                  /*String[] ai_name = tamperBean2.getAi_name();
                                  String[] ai_values = tamperBean2.getParam1();
                                String[] times = tamperBean2.getTime_values();
                                String[] dates = tamperBean2.getDate_values();
                                String[] feeder_times = tamperBean2.getTime_values2();*/
                                //if(times.length>=1){
                                  //  String ai_values_str = "";
                                  if(rowCount==1)
                                {
                                %>
                                <thead>
                    <tr>
                        <th col="col" class="rounded-q2"> Tamper Date & Time </th>
                        <th col="col" align="left" class="rounded-q3"> Tamper Type</th>
                        <th col="col" align="left" class="rounded-q3"> Tamper Status</th>
                        <%  for(int params_size=0;params_size<param_names_arr.length;params_size++)
                        {
                        %>
                        <th col="col" align="left" class="rounded-q3"><%=param_names_arr[params_size]%>
                            </th>
                        <% } %>
                         <th col="col" align="center" class="rounded-q2"> </th>
                    </tr>
                    </thead>
                         <tbody>
                                <% } %>
                                <tr>
                                    <td><%=tamperBean2.getTamper_date() +" "+tamperBean2.getTamper_time() %></td>
                                    <td><%= tamperBean2.getTamper_type() %></td>
                                    <td><%= tamperBean2.getTamper_status() %></td>
                                    <%
                                    System.out.println("step4");
                                    int remaining_cols = param_names_arr.length - param_values.length;
                                    for(int values_size=0;values_size<param_values.length;values_size++)
                                    {
                                    %>
                                        <td align="right"><%= param_values[values_size] %></td>
                                    <%
                                    }
                                    for(int i_rem = 0;i_rem<remaining_cols;i_rem++)
                                    {
                                    %>
                                    <td>&nbsp;</td>
                                    <%
                                    }
                                    System.out.println("step5");
                                    %>
                                    <td>&nbsp;</td>
                                </tr>
                                <% } %>



                    </tbody>
                    </table>
                </div>
                     <% System.out.println("step6");}
                     }
catch(Exception e){ e.printStackTrace(); }%>
                </div>
                              <%  }

                    %>

                    <%
           }

        %>


           </div>
                </td>
                 </tr>


        </table>
                    <div id="navigation" ></div>
        <%@ include file="bottom.jsp"%>

</body></html>
