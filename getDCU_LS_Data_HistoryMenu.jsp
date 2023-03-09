<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<form name="dcuLs" action="">
<%
try
{
    String dcu_id = request.getParameter("dcu_id");
    PreparedStatement pstmt =  con.prepareStatement("select * from digital_input_details where rtu_id=? order by srlno");
    pstmt.setString(1, dcu_id);
    ResultSet rs = pstmt.executeQuery();
    int i=0;
    String strt_di ="";
    %>
    <div id="box_style" style="border: 1px solid #A1A1A1;
    background: #FFFFFF;
    width:auto;
    height:auto;
    margin: 5px;
    float:left;
    display: block;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-box-shadow: 0 6px 10px #A1A1A1;
    -webkit-box-shadow: 0 6px 10px #A1A1A1;">
    <table border="0" align="left">
    <tr>
        <td>Select Feeder :</td>
        <td><select name="selfeeder" id="selfeeder">
    <option value="-1">Select Feeder</option>
    <%
    while (rs.next())
    {
        i++;
        String di_name = rs.getString("Name1");
        di_name = di_name.substring(2);
        if(i==1) strt_di = di_name;
        else
        {
            if(strt_di.equals(di_name))
            break;
        }
        %>
        <option value="<%= rs.getString("INFO_OBJ_NO") %>"><%= rs.getString("DESCRIPTION") %></option>
        <%
    }
    %>
    </select>
    </tr>
    <tr>
                <td>Enter From Date :</td>
                <td>
                    <input type="text" id="fromdate" name="fromdate" size="10" />

    <a href="javascript:show_calendar('dcuLs.fromdate')"> <img src="images/cal1.gif" id="sdate"  width=24 height=22 border=0 /></a>
                    
                </td>
            </tr>
                <tr>
                    <td></td>
                    <td><font color="red">(dd-mm-yyyy)</font></td>
                </tr>
            <tr>
                <td>Enter To Date :</td>
                <td>
                    <input type="text" id="todate" size="10" />
                     <a href="javascript:show_calendar('dcuLs.todate')"> <img src="images/cal1.gif" id="edate"  width=24 height=22 border=0 /></a>
                        
                </td>
                <td><input type="button" value="Get Data" onclick="getHistory_LS()" /></td>
            </tr>
        </table></div>
    <div id="DataPart2"  align="center" style="background:#FFFFFF;clear:both;">
                        DCU Reports Home Page.
                    </div>
    <%
}
catch(Exception e)
{
    e.printStackTrace();
}
finally{
    con.close();
}
%>
</form>