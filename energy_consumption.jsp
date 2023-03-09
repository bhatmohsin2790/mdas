<%@include file="report_header.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%@page import="java.lang.*" %>
<%
    try {
        DecimalFormat tdec = new DecimalFormat("#0.00");
        String meter_id = "";
        String meter_sl_no = "";
         if (request.getParameter("meter_sl_no") == null || request.getParameter("meter_sl_no") == "") {
            meter_sl_no = (String) session.getAttribute("meter_sl_no");
        } else {
            meter_sl_no = request.getParameter("meter_sl_no");
        }
        if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
            meter_id = (String) session.getAttribute("meter_id");
        } else {
            meter_id = request.getParameter("meter_id");
        }
        session.setAttribute("meter_id", meter_id);
        String stringToReturn = "";
        String fromDate = request.getParameter("esdate").trim();
        String toDate = request.getParameter("eedate").trim();
        String sql = "";
        
        int start = 0;
        

%>

<%@ include file="getConnection.jsp"%>

<table width="100%" border="0">
    <tr >
        <td colspan="6" align="center" class="head1">
            ENERGY CONSUMPTION
        </td>
    </tr>
</table>
<table class="mtable" id="dtable">
    <thead>
    <tr>
        <td >
            Billing Date1
        </td>
        <td >
            Billing Date2
        </td>
        <%  if (meter_id.equals("48") || meter_id.equals("49") || meter_id.equals("51") || meter_id.equals("52") || meter_id.equals("53") || meter_id.equals("54") || meter_id.equals("55") || meter_id.equals("56") || meter_id.equals("57") || meter_id.equals("58")) {%>
        <td >KWH</td>
        <td >KVARH LAG</td>
        <td >KVARH LEAD</td>
        <td >KVAH</td>


        <% } else {%>

        <%
            pstmt = con.prepareStatement("select billing_columns_header from d3_columns_header where meter_serial_no='" + meter_sl_no + "' and billing_type='b3'");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String data_string2[] = rs.getString(1).split(",");
                for (int i = 0; i < data_string2.length; i++) {
        %>
        <td ><%= data_string2[i]%></td>
        <%}
                }
            }
        %>

    </tr>
</thead>
<tbody>

    <%


        session.setAttribute("meter_sl_no", meter_sl_no);

        System.out.println("meterid---->" + meter_sl_no);
      if(!fromDate.equals("") && !toDate.equals("")){ 
         

        if (DBUtil.getTargetDB().equals("oracle")) {
           if(!fromDate.equals("") && !toDate.equals("")) 
            sql = "select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS')"
                    + "billing_date,data_string,rownum rnum from d3_b3 b3 where meter_serial_no='" + meter_sl_no + "' and "
                    + "trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY')"
                    + "and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY')"
                    + " order by d3_time_stamp desc";
           else
             sql = "select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS')"
                    + "billing_date,data_string,rownum rnum from d3_b3 b3 where meter_serial_no='" + meter_sl_no + "'  order by d3_time_stamp desc";  
            pstmt = con.prepareStatement(sql);
            
            System.out.println("sql  " + sql);
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            start = start - 1;
          if(!fromDate.equals("") && !toDate.equals("")) 
            sql = "select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 where meter_serial_no='" + meter_sl_no + "' and "
                    + "str_to_date(date_format(d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y')>=str_to_date('" + fromDate + "','%d/%m/%Y') and "
                    + "str_to_date(date_format(d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') <=str_to_date('" + toDate + "','%d/%m/%Y') order by d3_time_stamp desc limit ?,?";
          else
              sql = "select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,data_string from d3_b3 where meter_serial_no='" + meter_sl_no + "' order by d3_time_stamp desc limit ?,?";                        
            pstmt = con.prepareStatement(sql);
        }
        rs = pstmt.executeQuery();
        String dataString = "";
        int rs_records = 0;
        String[] data_string3 = {""};
        String prve_billing_date = "";

        while (rs.next()) {
            if (rs_records == 0) {
                data_string3 = rs.getString("data_string").split(",");
                prve_billing_date = rs.getString("billing_date");
            } else {
                String data_string[] = rs.getString("data_string").split(",");
                //System.out.println("Data string lenth"+data_string.length);
%>



    <tr>

        <td ><%=prve_billing_date%></td>
        <td ><%=rs.getString("billing_date")%></td>
        <%
            try {
                for (int i = 0; i <= data_string.length - 1; i++) {%>
        <td ><%=tdec.format(Double.parseDouble(data_string3[i]) - Double.parseDouble(data_string[i]))%></td>
        <% }
            } catch (Exception e) {
            }

        %>
    </tr>
    <%
            }
            rs_records++;
            data_string3 = rs.getString("data_string").split(",");
            prve_billing_date = rs.getString("billing_date");
        }
}
    %>
    </tbody>
    
</table>

<%
    }//try
    catch (Exception e) {
        out.println("Plz Try Again....");
        e.printStackTrace();
    }
%>
