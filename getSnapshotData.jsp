<%--<%@ page session="false" %>--%>
<%@ include file="report_header.jsp"%> 
<%
    String[] data_string2=new String[0];
    int limit = 50;
    int count = 0;
    int start=0;
            try {
                
                String meter_id = "";
                int flag=0;
                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "") {
                    meter_id = (String) session.getAttribute("meter_id");
                } else {
                    meter_id = request.getParameter("meter_id");
                }
                session.setAttribute("meter_id", meter_id);
                String stringToReturn = "";
                String sdate=request.getParameter("sdate");
                String edate=request.getParameter("edate");
                start=Integer.parseInt(request.getParameter("start"));
%>

<%@ include file="getConnection.jsp"%>

<table width="100%" border="0">
    <tr >
        <td colspan="6" align="center" class="head1">
            SnapShot Data
        </td>
    </tr>
</table>
<table class="mtable" id="dtable">
    <thead>
    <tr>
        <td >
            SnapShot Dates
        </td>
        

        <%
        try{
                 pstmt = con.prepareStatement("select * from d6_columns_header where meter_serial_no=(select meter_serial_no from meter where meterid=" + meter_id + ")");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    flag=1;
                      System.out.println("---------------------------Snapshotr Header Got Dynamically-----------------------------------");
                data_string2 = rs.getString("SNAPSHOT_COLUMNS_HEADER").split(",");
			}else{
                    flag=1;
            pstmt = con.prepareStatement("select no_of_params,param_names from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
            rs = pstmt.executeQuery();

            while (rs.next()) {
                 data_string2 = rs.getString("param_names").split(",");
                               }}
                               }
        catch(Exception e)
                               {
             if(flag==0) %>
                  <td>No Snapshot Data Available</td>
                  <% 
                         e.printStackTrace();
                  }
               
                for (int i = 0; i < data_string2.length; i++) {
        %>
        <td ><%=data_string2[i]%></td>
        <%}
            
        %>

    </tr>
    </thead>
    <tbody>

    <%

        String meter_sl_no = "",sql="";
        pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            meter_sl_no = rs.getString("meter_serial_no");
        }
        session.setAttribute("meter_sl_no", meter_sl_no);
        System.out.println("snapshot meterid---->" + meter_id);
        
        sql = "select  snapshot_date,data_string,rownum r from d6_data where meter_serial_no='"+meter_sl_no+"' and "
                + "trunc(d6_time_stamp)<=to_date('"+edate+"','dd/mm/yyyy') and trunc(d6_time_stamp)>=to_date('"+sdate+"','dd/mm/yyyy') order by d6_time_stamp desc";
 //System.out.println("snap qyer----------->"+sql);       
        pstmt = con.prepareStatement(sql);
         //pstmt.setInt(1, start + limit);
         //pstmt.setInt(2, start);
        rs = pstmt.executeQuery();
        String dataString = "";
        while (rs.next()) {
            String data_string[] = rs.getString("data_string").split(",");

               %>

    <tr>
        <td ><%=rs.getString("snapshot_date")%></td>
        
        <% for (int i = 0; i <= data_string.length - 1; i++) {%>
        <td ><%=data_string[i]%></td>
        <% }%>
    </tr>
    
    <%
                    }
                } catch (Exception e) {
                    out.println("Plz Try Again....");
                    e.printStackTrace();
                }
    %>
    </tbody>
</table>
 