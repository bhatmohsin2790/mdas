<%@ page session="false" %>
<%@ include file="report_header.jsp"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
            try {
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
<br>
<table width="100%" border="0">
    <tr bgcolor="#56a5ec">
        <td colspan="6" align="center" class="head1">
            MAIN ENERGY
        </td>
    </tr>
</table>

    <table border="0">
    <tr>
        <td class="td1" width="150px">
            Billing Dates
        </td>

        <td class="td1" width="100px">KWH</td>
        
        <td class="td1" width="100px">KVArh Lag</td>
        <td class="td1" width="100px">KVArh Lead</td>
        <td class="td1" width="100px">KVA</td>
    </tr>


    <%
                    int start = Integer.parseInt(request.getParameter("start"));
    int limit = 10;
    int count = 0;
    String sql=null;
    sql = "select count(*) from d3_b3 where cdfid in (select cdfid from meter_data_time_stamp where meterid="+meter_id+")";

                pstmt = con.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }//end if
                System.out.println("Total No of records :" + count);
                   //-----------------------------
                    String meter_sl_no = "";
                    
                    pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        meter_sl_no = rs.getString("meter_serial_no");
                    }
                    session.setAttribute("meter_sl_no", meter_sl_no);

                    System.out.println("meterid---->" + meter_id);
                    sql="select distinct(billing_day),data_string from (select distinct(billing_day),data_string,cdfid,rownum r from( select distinct(billing_day),data_string,cdfid from d3_b3 ) where rownum<? and cdfid in (select cdfid from meter_data_time_stamp where meterid=?))where r>=?  order by billing_day desc";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, start + limit);
   pstmt.setString(2, meter_id);
   pstmt.setInt(3, start);
                    rs = pstmt.executeQuery();
                    String dataString = "";

                    while (rs.next()) {
                        if(rs.getString("data_string")!=null)
                            {
                        String data_string[] = rs.getString("data_string").split(",");
                        String val = null;
                        for (int i = 0; i < 4; i++) {
                            val = data_string[i];
                            if (val.length() > 1) {
                                try {
                                    double d = Double.parseDouble(val);
                                    data_string[i] = String.valueOf(d / 10);
                                } catch (Exception e) {
                                }//end catch
                            }//end if
                        }//end for

    %>



    <tr>
        <td class="td2"><%=rs.getString("billing_day")%></td>
        <% for (int i = 0; i < 4; i++) {%>
        <td class="td2"><%=data_string[i]%></td>
        <% }
                        }
                }
            %>
    </tr>
    
</table>
<!-- code for pagination --->
<table width="100%" border="0">
      <tr>
          <td width="100%" align="center">
  <table>&nbsp;&nbsp;
    <tr>
        <%


                   // code for previous
int start_tmp = start;

                // code for page numbers
               //  start = 1;

                 if(((Integer.parseInt(request.getParameter("start"))-1)/10)+1>10)
                     {
                     %>
        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:mainEnergy(<%=((start_tmp/100)*100)-9%>)" style="text-decoration:none;">Prev 10</a></td>&nbsp;
        <%
                     }
                 int page_no_start = (start_tmp / 100)*100+1;
                 int page_no_end = ((start_tmp/100)*100)+90;
                 page_no_start = (page_no_start / 10)+1;
                 page_no_end =  (page_no_end/10)+1;

                 start =1;
                 if(page_no_end>=Math.ceil((double) count / (double) limit))
                     page_no_end = (int)Math.ceil((double) count / (double) limit);

                   for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++)
                    {
                    if(i>=page_no_start && i<=page_no_end)
                        {
                    if(i==((Integer.parseInt(request.getParameter("start"))-1)/10)+1)
                        {
        %>

        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:mainEnergy(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>&nbsp;

        <%
                       }

                  else

                        {
        %>

        <td id="pageNo"><a href="#"  onclick="javascript:mainEnergy(<%=start%>)"><%=i%></a></td>&nbsp;

        <%
                        }
                    }
                       start = start + limit;
                        }
             // code for next
                        //if((((Integer.parseInt(request.getParameter("start"))-1)/10)+1)>=1)
                 start = start_tmp;
                            if(page_no_end>=Math.ceil((double) count / (double) limit))
                            {}else{


                            start=Integer.parseInt(request.getParameter("start"))+100;

%>

        <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:mainEnergy(<%=start%>)" style="text-decoration:none;">Next 10</a></td>&nbsp;

        <%
        }

%>
    </tr>
</table>
          </td>
      </tr>
  </table>

   <%

                } catch (Exception e) {
                    out.println("Plz Try Again....");
                    e.printStackTrace();
                }
    %>