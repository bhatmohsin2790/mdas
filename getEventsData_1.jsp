<%@ page session="false" %>
<%@ include file="report_header.jsp"%>
<%!     PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<%
            try
            {
                String meter_id = "";
                if (request.getParameter("meter_id") == null || request.getParameter("meter_id") == "")
                {
                    meter_id = (String) session.getAttribute("meter_id");
                }
                else
                {
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
            Events Data
        </td>
    </tr>
</table>
<table class="mtable">
    <tr>
        <td class="td1" width="160px">
            Event Dates
        </td>
        <td class="td1">
            Event Type
        </td>
        <td class="td1">
            Event Status
        </td>

        <%
            pstmt = con.prepareStatement("select no_of_params,param_names from metermake where metermakeid=(select metermake from meter where meterid=" + meter_id + ")");
            rs = pstmt.executeQuery();

            while (rs.next())
            {
                String data_string2[] = rs.getString("param_names").split(",");
                for (int i = 0; i < data_string2.length; i++)
                {
        %>
                    <td class="td1"><%=data_string2[i]%></td>
        <%
                }
            }
        %>

    </tr>

    <%
        System.out.println("<--------------------------->");
        String sdate=request.getParameter("sdate");
        String edate=request.getParameter("edate");
       
        
      

        if(sdate.equals("") && edate.equals(""))
        {
            System.out.println("Both are empty............");
            String meter_sl_no = "";
            pstmt = con.prepareStatement("select meter_serial_no from meter where meterid=" + meter_id);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                meter_sl_no = rs.getString("meter_serial_no");
            }
            session.setAttribute("meter_sl_no", meter_sl_no);
            System.out.println("events meterid---->" + meter_id);
            String sql = "select  distinct event_date,event_type,event_status,data_string from "
                    + "d5_data d5 where d5.cdfid in (select cdfid from "
                    + "meter_data_time_stamp where meterid=?) order by event_date desc";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt( meter_id ));
            rs = pstmt.executeQuery();
            String dataString = "";
            System.out.println("executed--------------->");
            while (rs.next())
            {
                if(rs.getString("data_string")!=null)
                {
                     String data_string[] = rs.getString("data_string").split(",");
            %>
                    <tr>
                        <td class="td2"><%=rs.getString("event_date")%></td>
                        <td class="td2"><%=rs.getString("event_type")%></td>
                        <td class="td2"><%=rs.getString("event_status")%></td>
                        <% for (int i = 0; i <= data_string.length - 1; i++) {%>
                        <td class="td2"><%=data_string[i]%></td>
                        <% }%>
                    </tr>
            <%
                }
            }
        }
        else if(!sdate.equals("") && !edate.equals(""))
        {
            System.out.println("Both are not empty............");
            String cdfid = "",sql1="";
            sql1="select cdfid from meter_data_time_stamp where meterid='"+meter_id+"'";
            pstmt = con.prepareStatement(sql1);
            System.out.println("sql to find cdfid is---------->"+sql1);
            rs = pstmt.executeQuery();
            if (rs.next())
            {
                cdfid = rs.getString("cdfid");
            }
            session.setAttribute("cdfid", cdfid);
            System.out.println("events meterid---->" + meter_id);
            String sql = "select * from d5_data where cdfid='"+cdfid+"' and to_char(to_date(event_date,'YYYY-MM-DD HH24:MI:SS'),'DD/MM/YYYY') >= '"+sdate+"' and to_char(to_date(event_date,'YYYY-MM-DD HH24:MI:SS'),'DD/MM/YYYY') <= '"+edate+"'";


            System.out.println("dates sql------>"+sql);
            pstmt = con.prepareStatement(sql);
            //pstmt.setInt(1, Integer.parseInt( meter_id ));
            rs = pstmt.executeQuery();
            String dataString = "";
            while (rs.next())
            {
                if(rs.getString("data_string")!=null)
                {
                     String data_string[] = rs.getString("data_string").split(",");
            %>
                    <tr>
                        <td class="td2"><%=rs.getString("event_date")%></td>
                        <td class="td2"><%=rs.getString("event_type")%></td>
                        <td class="td2"><%=rs.getString("event_status")%></td>
                        <% for (int i = 0; i <= data_string.length - 1; i++) {%>
                        <td class="td2"><%=data_string[i]%></td>
                        <% }%>
                    </tr>
            <%
                }
            }
        }
        
        else
            {
                out.println("Both Dates Shouldnot be empty....?");
            }

       }
       catch (Exception e)
       {
             out.println("Plz Try Again....");
             e.printStackTrace();
       }
            finally{
                con.close();
            }
    %>
</table>