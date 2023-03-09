<%@include file="report_header.jsp" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.*"%>
<%@ include file="getConnection.jsp"%>
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
        System.out.println("meterid  " + meter_id);
        String stringToReturn = "";
        String startDate = request.getParameter("startDate").trim();
        String endDate = request.getParameter("endDate").trim();
        String meter_no = request.getParameter("meter_no").trim();
        System.out.println("meter_no  " + meter_no);
        int count = 0;
        String sql = "";
        int limit = 50;
        int start = Integer.parseInt(request.getParameter("start"));
        //start=start-1;
        //System.out.println("meterid----->"+meter_id);
%>


<table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-right: 10px;" >
    <thead>
        <tr>
    <td width="80px"><strong>DATE</strong></td>
    <td width="60px"><strong>TIME</strong></td>
    <td align="center">Number of Power-Failures</td>
    <td align="center">Cumulative Power-Failure duration (Mins)</td>
    <td align="center">Cumulative Tamper count</td>
    <td align="center">Cumulative Billing count</td>
    <td align="center">Cumulative Programming count</td>


</tr>
</thead>
<tbody>
    <%
        if (startDate.equals("") && endDate.equals("")) {

            sql = "SELECT count(*) FROM d1 where meter_serial_no='" + meter_no + "'  ";

            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = Integer.parseInt(rs.getString(1));
            }
            System.out.println("total number of records----->" + count);
            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "select g2,g32 from(SELECT g2,g32,meter_time_stamp,rownum r from(SELECT g2,g32,meter_time_stamp FROM d1 where "
                        + "meter_serial_no='" + meter_no + "' order by meter_time_stamp desc)where rownum<?)where r>=?";

                System.out.println("query--->" + sql);
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, start + limit);
                pstmt.setInt(2, start);
            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "SELECT g2,g32 FROM d1 where meterid='" + meter_id + "'  order by meter_time_stamp desc limit ?,? ";
                //sql="select g2,g32 from d1  d where d.cdfid in (select cdfid from  meter_data_time_stamp where meterid=?) order by d.meter_time_stamp desc limit 20";           
                System.out.println("query--->" + sql);
                pstmt = con.prepareStatement(sql);
                start = start - 1;
                pstmt.setInt(1, start);
                pstmt.setInt(2, limit);
            }

        } else {

            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = " SELECT count(*) FROM d1 where meter_serial_no='" + meter_no + "' "
                        + "and trunc(meter_time_stamp) <= to_date('" + endDate + "','DD/MM/YYYY') "
                        + "and trunc(meter_time_stamp) >= to_date('" + startDate + "','DD/MM/YYYY') order by meter_time_stamp desc ";


            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "SELECT count(*) FROM d1 where meter_serial_no='" + meter_no + "' and str_to_date(g2,'%d-%m-%Y')<=str_to_date('" + endDate + "','%d/%m/%Y') and str_to_date(g2,'%d-%m-%Y')>=str_to_date('" + startDate + "','%d/%m/%Y') order by meter_time_stamp desc ";

            }
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = Integer.parseInt(rs.getString(1));
            }
            System.out.println("total number of records----->" + count);

            if (DBUtil.getTargetDB().equals("oracle")) {
                sql = "select g2,g32 from(SELECT g2,g32,meter_time_stamp,rownum r from(SELECT g2,g32,meter_time_stamp FROM d1 where  "
                        + "meter_serial_no='" + meter_no + "' and trunc(meter_time_stamp) <= to_date('" + endDate + "','DD/MM/YYYY') "
                        + "and trunc(meter_time_stamp) >= to_date('" + startDate + "','DD/MM/YYYY') "
                        + "order by meter_time_stamp desc)where rownum<?)where r>=? ";

                System.out.println("query--->" + sql);
                pstmt = con.prepareStatement(sql);
                pstmt.setInt(1, start + limit);
                pstmt.setInt(2, start);
            } else if (DBUtil.getTargetDB().equals("mysql")) {
                sql = "SELECT g2,g32 FROM d1 where meter_serial_no='" + meter_no + "' and str_to_date(g2,'%d-%m-%Y')<=str_to_date('" + endDate + "','%d/%m/%Y') "
                        + "and str_to_date(g2,'%d-%m-%Y')>=str_to_date('" + startDate + "','%d/%m/%Y') order by meter_time_stamp desc limit ?,? ";

                System.out.println("query--->" + sql);
                pstmt = con.prepareStatement(sql);
                start = start - 1;
                pstmt.setInt(1, start);
                pstmt.setInt(2, limit);
            }

        }
        rs = pstmt.executeQuery();
        int data_available_flag = 0;
        while (rs.next()) {
            String g32 = rs.getString(2);
            out.println("<tr>");
            out.println("<td align='left' width='80px'>" + rs.getString(1).substring(0, 10) + "</td>");
            out.println("<td align='left' width='60px'>" + rs.getString(1).substring(10) + "</td>");
            if (g32.contains(":")) {
                out.println("<td align='right' >" + g32.split(":")[1] + "</td>");
                out.println("<td align='right'>" + Math.round(Double.parseDouble(g32.split(":")[0]) / 60) + "</td>");
                out.println("<td align='right'>" + g32.split(":")[2] + "</td>");
                out.println("<td align='right'>" + g32.split(":")[3] + "</td>");
                out.println("<td align='right'>" + g32.split(":")[4] + "</td>");
            } else {
                out.println("<td  colspan='5' align='center'>Data Not Available.</td>");
            }

            out.println("</tr>");
            data_available_flag = 1;
        }
        if (data_available_flag == 0) {
            out.println("<tr><td  colspan='12' align='center'>Data Not Available.</td></tr>");
        }
    %>
</tbody>

</table>
<!-- code for pagination -->
<table width="100%" border="0">
    <tr>
        <td width="100%" align="center">
            <table>
                <tr>
                    <%
                        // code for previous
                        int start_tmp = start;

                        if (((Integer.parseInt(request.getParameter("start")) - 1) / 10) + 1 > limit) {
                    %>
                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:miscellaneousHistory(<%=((start_tmp / (limit * 10)) * (limit * 10)) - (limit - 1)%>)" style="text-decoration:none;">Prev 10</a></td> 
                    <%
                        }
                        int page_no_start = ((start_tmp / (limit * 10)) * (limit * 10)) + 1;
                        int page_no_end = ((start_tmp / (limit * 10)) * (limit * 10)) + (limit * 9);

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

                    <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:miscellaneousHistory(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>

                    <%
                    } else {
                    %>

                    <td id="pageNo"><a href="#"  onclick="javascript:miscellaneousHistory(<%=start%>)"><%=i%></a></td>

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
                            start = (((start_tmp / (limit * 10)) * (limit * 10)) + (limit * 9)) + limit + 1;
                    %>
                    <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:miscellaneousHistory(<%=start%>)" style="text-decoration:none;">Next 10</a></td>

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
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>


