<%@include file="report_header.jsp" %>
<%@page import="java.text.*"%>
<%@ include file="getConnection.jsp"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;
    int energyMF = 1;
    Double emf = 1.0;
    String data_string2[]=null;
    String sql="";
%>
<%

    try {
        String meter_sl_no = "";
        String meter_id = "";
        NumberFormat oneDec = new DecimalFormat("#0.0");
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
        session.setAttribute("meter_sl_no", meter_sl_no);
        String stringToReturn = "";
        String fromDate = request.getParameter("esdate").trim();
        String toDate = request.getParameter("eedate").trim();
        System.out.println("meterid  " + meter_sl_no);
        if (energyMF == 1) {
            pstmt = con.prepareStatement("select mf from meter where meter_serial_no='" + meter_sl_no + "'");
            rs = pstmt.executeQuery();
            if (rs.next()) {
                emf = Double.parseDouble(rs.getString("mf"));
            }
        }
        System.out.println("mf for energy---->" + emf);
%>

<%
    pstmt = con.prepareStatement("select * from d3_columns_header where meter_serial_no='" + meter_sl_no + "' and billing_type='b3'");
    rs = pstmt.executeQuery();
    while (rs.next()) {
        data_string2 = rs.getString("billing_columns_header").split(",");
    }
%>

<%
    //getting the first and last kwh values in selected dates
    double firstValue=0,lastValue=0,TotalEnergy=0;
    if (!fromDate.equals("") && !toDate.equals("")) 
      sql="select * from d3_b3 where meter_serial_no='" + meter_sl_no + "' and trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY') and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY') order by d3_time_stamp ";
    else
      sql="select * from d3_b3 where meter_serial_no='" + meter_sl_no + "' order by d3_time_stamp ";
       pstmt=con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
       rs=pstmt.executeQuery();
       if(rs.first()){
          String firstRow[]=rs.getString("data_string").split(",") ;
          for(int i=0;i<firstRow.length;i++){
              if(data_string2[i].equals("KWh(I)_tot") || data_string2[i].equals("KWh(Import)") )
                  firstValue=Double.parseDouble(firstRow[i]);
          }
       }//first 
       if(rs.last()){
          String lastRow[]=rs.getString("data_string").split(",") ;
          for(int i=0;i<lastRow.length;i++){
              if(data_string2[i].equals("KWh(I)_tot") || data_string2[i].equals("KWh(Import)") )
                  lastValue=Double.parseDouble(lastRow[i]);
          }
       }//last 
    
        TotalEnergy=lastValue-firstValue; 
    %>     
     
    <table width="100%" border="0" >
        <tr >
            <td colspan="6" align="center" class="head1">
               <!-- <input type="button" value="Export to excel" style="float:left;margin-top:15px" onclick='uploadToExcel("energy")'/> -->
                MAIN ENERGY
            <h4 style="text-align: right;top:0px; ">
                Consumption of (KWH):   With MF= <%= oneDec.format(TotalEnergy*emf) %>, Without MF= <%= oneDec.format(TotalEnergy) %>
            </h4>
            </td>
            
        </tr>
    </table>
    <table class="mtable" id="dtable">
        <thead>
        <tr>
            <td  width="150px">
                Billing Dates
            </td>
            <%
                for (int i = 0; i < data_string2.length; i++) {
            %>
            <td ><%=data_string2[i]%></td>
            <%}
            
            %>
        </tr>
       </thead>
       <tbody>

    <%
        int start = Integer.parseInt(request.getParameter("start"));
       
       
    
        if (!fromDate.equals("") && !toDate.equals("")) {
            
        session.setAttribute("meter_sl_no", meter_sl_no);
        System.out.println("meterid---->" + meter_sl_no);

        if (DBUtil.getTargetDB().equals("oracle")) {
            if (!fromDate.equals("") && !toDate.equals("")) {
                sql = "select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS')"
                        + " billing_date,data_string,rownum rnum from d3_b3 b3 where meter_serial_no='" + meter_sl_no + "' and "
                        + "trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY')"
                        + "and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY')"
                        + " order by d3_time_stamp desc";
            } else {
                sql = "select billing_date,data_string from (select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS')"
                        + "billing_date,data_string,rownum rnum from d3_b3 b3 where meter_serial_no='" + meter_sl_no + "' and rownum < ? order by d3_time_stamp desc) where rnum>=?";
            }
            pstmt = con.prepareStatement(sql);
            
            //System.out.println("sql  " + sql);
        } else if (DBUtil.getTargetDB().equals("mysql")) {
            start = start - 1;
            if (!fromDate.equals("") && !toDate.equals("")) {
                sql = "select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,"
                        + "data_string from d3_b3 b3 where meter_serial_no=? and  str_to_date(date_format(b3.d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y')>= str_to_date('" + fromDate + "','%d/%m/%Y') and str_to_date(date_format(b3.d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') <= str_to_date('" + toDate + "','%d/%m/%Y') "
                        + "order by d3_time_stamp desc limit ?,?";
            } else {
                sql = "select date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s') billing_date,"
                        + "data_string from d3_b3 b3 where meter_serial_no=? order by d3_time_stamp desc limit ?,?";
            }

            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, meter_sl_no);
            
        }//end else if


        rs = pstmt.executeQuery();

        String dataString = "";
        NumberFormat formatter = new DecimalFormat("#0.000");
        while (rs.next()) {
            if (rs.getString("data_string") != null) {
                String data_string[] = rs.getString("data_string").split(",");
                String val = null;
                for (int i = 0; i < data_string.length; i++) {
                    
                    val = data_string[i];
                    if (val.length() > 1) {
                        try {
                            double d = Double.parseDouble(val);                            
                             data_string[i] = String.valueOf(formatter.format(d));   
                        } catch (Exception e) {
                        }//end catch
                    }//end if
                }//end for

    %>



    <tr>
        <td ><%=rs.getString("billing_date")%></td>
        <%
            if (energyMF == 1) {
                for (int i = 0; i < data_string.length; i++) {

        %>
        <td  align="right"><%= formatter.format(Double.parseDouble(data_string[i]))%></td>		
        <!--<td  align="right"><%= formatter.format(Double.parseDouble(data_string[i]) * emf)%></td>-->
        <%
            }
        }//if mf is checked(with MF)
        else { // if mf is not checked (without MF)
            for (int i = 0; i < data_string.length; i++) {

        %>
        <td  align="right"><%= formatter.format(Double.parseDouble(data_string[i]))%></td>
        <%
                        }

                    } //end of else without MF


                }//if data string not null
            }//while
       }//if
        %>
    </tr>
</tbody>
</table>
          
<%

    } catch (Exception e) {
        out.println("Plz Try Again....");
        //e.printStackTrace();

    }
%>

