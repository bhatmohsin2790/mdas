<%@ include file="report_header.jsp"%> 
<%@page import="java.text.DecimalFormat"%>
<table align="vright" >
         <tr>
             <td  align="center" class="head1">
                 <input type="button" value="Export to excel" onclick="table_reverse_new()"/>
             </td>
         </tr>
     </table> 
<table width="100%" border="0">
    <tr bgcolor="#56a5ec">
        <td colspan="6" align="center" class="head1">
            MAXIMUM DEMAND REPORT
        </td>
    </tr>
</table>
<%@page import="java.lang.*" %>
<%!    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
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
        int count = 0;
        int start = 0;
        int limit = 50;
        System.out.println("meterid  " + meter_id);

%>
<%@ include file="getConnection.jsp"%>

<table boarder="0" width="100%">
    <tr>
        <td class="td1" width="200px">Billing Date</td>
        <td class="td1" width="200px">KW Occ Date</td>
        <td class="td1" width="200px">MD-KW</td>
        <td class="td1" width="200px">KVA Occ Date</td>
        <td class="td1" width="200px">MD-KVA</td>
    </tr>


    <%
        start = Integer.parseInt(request.getParameter("start"));
        //start=start-1;
        if(!fromDate.equals("") && !toDate.equals("")){ 
        if (DBUtil.getTargetDB().equals("oracle")) 
            sql = "select count(*) from d3_b5 where  meter_serial_no='" + meter_sl_no + "' and "
                    + "trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY') "
                    + "and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY') "
                    + "order by d3_time_stamp desc ";          
         else if (DBUtil.getTargetDB().equals("mysql")) 
            sql = "select count(*) from d3_b5 where data_string IS NOT NULL and data_string!='' and meter_serial_no='" + meter_sl_no + "' and"
                    + " str_to_date(date_format(d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') >= str_to_date('" + fromDate + "','%d/%m/%Y') and str_to_date(date_format(d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') <= str_to_date('" + toDate + "','%d/%m/%Y') "
                    + "order by d3_time_stamp desc ";
                }
        else
             sql = "select count(*) from d3_b5 where data_string IS NOT NULL  and meter_serial_no='" + meter_sl_no + "' order by d3_time_stamp desc ";
          
        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }//end if
        System.out.println("count query--->"+sql);
        System.out.println("Total No of records :" + count);
        //-----------------------------

        session.setAttribute("meter_sl_no", meter_sl_no);

        System.out.println("meterid---->" + meter_id);
        
        if (DBUtil.getTargetDB().equals("oracle")) {
            if(!fromDate.equals("") && !toDate.equals("")) 
            sql = "select billing_date,data_string,occ_date from (select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS') "
                    + "billing_date,data_string,occ_date,rownum rnum from d3_b5  where meter_serial_no='" + meter_sl_no + "' and "
                    + "trunc(d3_time_stamp) >= to_date('" + fromDate + "','DD/MM/YYYY') "
                    + "and trunc(d3_time_stamp) <= to_date('" + toDate + "','DD/MM/YYYY') "
                    + "and rownum <? order by d3_time_stamp desc) where rnum>=?";
            else
              sql = "select billing_date,data_string,occ_date from (select to_char(d3_time_stamp,'YYYY-MM-DD HH24:MI:SS') "
                    + "billing_date,data_string,occ_date,rownum rnum from d3_b5  where meter_serial_no='" + meter_sl_no + "' and  rownum <? order by d3_time_stamp desc) where rnum>=?";  
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, start + limit);
            pstmt.setInt(2, start);
            System.out.println("sql  " + sql);
        } else if (DBUtil.getTargetDB().equals("mysql")) {
             if(!fromDate.equals("") && !toDate.equals(""))
            sql = "SELECT date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s')  billing_date,occ_date,data_string FROM d3_b5 where meter_serial_no='" + meter_sl_no + "' and data_string IS NOT NULL and data_string!='' and"
                    + " str_to_date(date_format(d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') >= str_to_date('" + fromDate + "','%d/%m/%Y') and str_to_date(date_format(d3_time_stamp,'%d/%m/%Y'),'%d/%m/%Y') <= str_to_date('" + toDate + "','%d/%m/%Y') "
                    + "order by d3_time_stamp desc limit ?,?";
             else
                 sql = "SELECT date_format(d3_time_stamp,'%d-%m-%Y %H:%i:%s')  billing_date,occ_date,data_string FROM d3_b5 where meter_serial_no='" + meter_sl_no + "' and data_string IS NOT NULL and data_string!='' order by d3_time_stamp desc limit ?,?";
            start = start - 1;
            pstmt = con.prepareStatement(sql);

            pstmt.setInt(1, start);
            pstmt.setInt(2, limit);
        }// mysql
        else {
            sql = "select * from(select row_number() OVER(ORDER BY dates.d3_time_stamp desc) AS rownum,convert(datetime, billing_date, 105) as billing_date ,b5.occ_date ,b5.data_string,b5.cdfid,b5.billing_day  from d3_b5 b5,d3_dates dates where b5.cdfid in ( select cdfid from meter_data_time_stamp where meterid=? ) and b5.cdfid=dates.cdfid and b5.billing_day=dates.billing_day )as md where rownum<=? and rownum>?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, meter_id);
            pstmt.setInt(2, start + limit);
            pstmt.setInt(3, start);
        }

        //System.out.println("max demand--->"+sql);
        rs = pstmt.executeQuery();
        String dataString = "";

        while (rs.next()) {

            String occDate = rs.getString("occ_date");
            if (occDate.equals(",,") || occDate.equals(",")) {
                occDate = " , ,";
            }
            String dataStr = rs.getString("data_string");

            String occ_date[] = occDate.split(",");
            String data_string[] = dataStr.split(",");
            /* for (int i = 0; i < 4; i++) {
            try {
            occ_date[i] = occDate.split(",")[i];
            } catch (Exception e) {
            }//end catch
            }//end for
            for (int i = 0; i < 4; i++) {
            try {
            data_string[i] = dataStr.split(",")[i];
            } catch (Exception e) {
            }//end catch
            }//end for*/
            String val = null;
            for (int i = 0; i < data_string.length; i++) {
                val = data_string[i];
            }//end for

    %>



     <tr>
        <td class="td2"><%=rs.getString("billing_date")%></td>
        <td class="td2"><%=(occ_date[0] != null) ? occ_date[0] : ""%></td>
        <td class="td2"><%=data_string[0]%></td>
        <%if(data_string.length>1){ %>
        <td class="td2"><%=occ_date[1]%></td>
        <td class="td2"><%=data_string[1]%></td>
        <% }else{%>
        <td class="td2"></td>
        <td class="td2"></td>
        <% } %>
    </tr>
    <%
        }
    %>
</table>
<!-- code for pagination --->
<table width="100%" border="0">
    <tr>
        <td width="100%" align="center">
            <table>
                <tr>
                    <%


                        // code for previous
                        int start_tmp = start;

                        // code for page numbers
                        //  start = 1;

                        if (((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1 > limit) {
                    %>
                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:max_demand(<%=((start_tmp / (limit * 10)) * (limit * 10)) - (limit - 1)%>)" style="text-decoration:none;">Prev 10</a></td>
                    <%
                        }
                        int page_no_start = (start_tmp / (limit * 10)) * (limit * 10) + 1;
                        int page_no_end = ((start_tmp / (limit * 10)) * (limit * 10)) + (limit * 9);
                        // System.out.println("page ene--->"+page_no_end);
                        page_no_start = (page_no_start / limit) + 1;
                        page_no_end = (page_no_end / limit) + 1;

                        start = 1;
                        if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                            page_no_end = (int) Math.ceil((double) count / (double) limit);
                        }

                        for (int i = 1; i <= Math.ceil((double) count / (double) limit); i++) {
                            if (i >= page_no_start && i <= page_no_end) {
                                if (i == ((Integer.parseInt(request.getParameter("start")) - 1) / limit) + 1) {
                    %>

                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:max_demand(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>

                    <%
                    } else {
                    %>

                    <td id="pageNo"><a href="#"  onclick="javascript:max_demand(<%=start%>)"><%=i%></a></td>

                    <%
                                }
                            }
                            start = start + limit;
                        }
                        // code for next
                        //if((((Integer.parseInt(request.getParameter("start"))-1)/10)+1)>=1)
                        start = start_tmp;
                        if (page_no_end >= Math.ceil((double) count / (double) limit)) {
                        } else {


                            //start = Integer.parseInt(request.getParameter("start")) +(limit*10);
                            start = (((start_tmp / (limit * 10)) * (limit * 10)) + (limit * 9)) + limit + 1; //to go to first page in next 10 pages

                    %>

                    <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:max_demand(<%=start%>)" style="text-decoration:none;">Next 10</a></td>

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