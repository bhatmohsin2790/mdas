<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="report_header.jsp"%> 
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String[] data_string2 = new String[0];
    int flag = 0;
%>
<%
    try {
        NumberFormat twoDecFormat = new DecimalFormat("#0.000");
        String meter_id = "";
        if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
            meter_id = (String) session.getAttribute("meter_id");
        } else {
            meter_id = request.getParameter("meter_id");
        }
        session.setAttribute("meter_id", meter_id);
        String stringToReturn = "";
%>

<%@ include file="getConnection.jsp"%>
<table class="mtable" >
    <thead>
    <td class="td1">Event Type</td>
    <td class="td1">Occured Time</td>
    <td class="td1">Restored Time</td>
    <td class="td1">Diff(in mins)</td>
        
    </thead>

<%
    System.out.println("<--------------------------->");
    int count = 0; int noOfOccurence=0;
    long cumulativeEventDuration=0L;
    String eventType="";
    String sql = "";
    int limit = 10;
    String sdate = request.getParameter("sdate");
    String edate = request.getParameter("edate");
   
    
    String chkvalue = request.getParameter("chkvalues");
    int start = Integer.parseInt(request.getParameter("start"));
    String values[] = chkvalue.split(",");
    System.out.println("meter id--->"+meter_id);
    System.out.println("checked values" + chkvalue);
    String meter_sl_no = "";
    pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
    rs = pstmt.executeQuery();
    if (rs.next())
    {
        meter_sl_no = rs.getString("meter_serial_no");
    }
    System.out.println("meter serial no---->"+meter_sl_no);

//if dates are not selected
    if (sdate.equals("") && edate.equals("")) {
        sql="select e.event_type,d.start_timestamp,d.end_timestamp,d.diff_in_minutes from d5_data_diff_log d,events e where meter_id='"+meter_sl_no+"' and d.event_type in("+chkvalue.substring(0, chkvalue.length()-1) +") and d.event_type=e.event_code order by recordid desc";
        pstmt=con.prepareStatement(sql);
        rs=pstmt.executeQuery();
        System.out.println("query is--->"+sql);
        while(rs.next())
        { 
            noOfOccurence++;
            eventType=rs.getString(1);
            %>
        <tr>
            <td class="td2"><%=rs.getString(1) %></td>
            <td class="td2"><%=rs.getString("start_timestamp") %></td>
            <td class="td2"><%=rs.getString("end_timestamp") %></td>
            <td class="td2"><%=rs.getString("diff_in_minutes") %></td>
        </tr>
       <%
       cumulativeEventDuration=cumulativeEventDuration+Long.parseLong(rs.getString("diff_in_minutes"));
       }
    }//if
    //if dates are selected
    else if (!sdate.equals("") && !edate.equals("")) {
         SimpleDateFormat sdf= new SimpleDateFormat("dd/mm/yyyy");
    SimpleDateFormat sdf1= new SimpleDateFormat("dd-mm-yyyy");
    java.util.Date startdate= sdf.parse(sdate);
    java.util.Date enddate= sdf.parse(edate);
    sdate=sdf1.format(startdate);
    edate=sdf1.format(enddate);
        sql="select e.event_type,d.start_timestamp,d.end_timestamp,d.diff_in_minutes from d5_data_diff_log d,events e where "
                + "meter_id='"+meter_sl_no+"' and d.event_type in ("+chkvalue.substring(0, chkvalue.length()-1)+") and d.event_type=e.event_code and "
                + " str_to_date(substr(start_timestamp,1,10),'%d-%m-%Y')>=str_to_date('"+sdate+"','%d-%m-%Y') and"
                + " str_to_date(substr(start_timestamp,1,10),'%d-%m-%Y') <=str_to_date('"+edate+"','%d-%m-%Y')"
                + " order by recordid desc";
        pstmt=con.prepareStatement(sql);
        rs=pstmt.executeQuery();
        System.out.println("query is--->"+sql);
        while(rs.next())
        { 
            noOfOccurence++;
            eventType=rs.getString(1);
            %>
        <tr>
            <td class="td2"><%=rs.getString(1) %></td>
            <td class="td2"><%=rs.getString("start_timestamp") %></td>
            <td class="td2"><%=rs.getString("end_timestamp") %></td>
            <td class="td2"><%=rs.getString("diff_in_minutes") %></td>
        </tr>
       <%
       cumulativeEventDuration=cumulativeEventDuration+Long.parseLong(rs.getString("diff_in_minutes"));
       }
    }//elseif


%>
<tbody></tbody></table>
<table id="mtable" width="100%">
    <thead>
        <td class="td1">Number of Occurences</td>
         <td class="td2"><%= noOfOccurence %></td>
         <td class="td1">Cumulative <%=eventType%> Duration(in mins)</td>
         <td class="td2"><%= cumulativeEventDuration %></td>
       </thead>
       <tbody></tbody>
</table>
<%
    } catch (Exception e) {
        out.println("Plz Try Again....");
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>