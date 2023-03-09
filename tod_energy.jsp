<%-- <%@ include file="report_header.jsp"%> --%>
<%!
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   static int noOfTods;
%>
<%
try{
      String meter_id = "";
      
      
    if(request.getParameter("meter_id")==null ||  request.getParameter("meter_id")=="")
       {
    meter_id = (String)session.getAttribute("meter_id");
    }else
       meter_id = request.getParameter("meter_id");
    session.setAttribute("meter_id",meter_id);
   String stringToReturn = "";
    %>

<%@ include file="getConnection.jsp"%>
<br>
<table width="100%" border="0">
    <tr bgcolor="#56a5ec">
        <td colspan="6" align="center" class="head1">
             TOD ENERGY
        </td>
    </tr>
</table>
<div style="overflow:scroll;width:700px;height:500px">
<table boarder="0">
    <tr>
        <td class="td1" width="150px">
            Billing Dates
        </td>
        <td class="td1" width="150px">
            TOD Reg.
        </td>

<%

 pstmt = con.prepareStatement("select b4_tod_params from metermake where metermakeid=(select metermake from meter where meterid="+meter_id+")");
   rs = pstmt.executeQuery();

   while(rs.next())
   {
    String data_string2[] = rs.getString("b4_tod_params").split(",");
    
    for(int i=0;i<data_string2.length;i++){
    %>
    <td class="td1" width="150px"><%=data_string2[i]%></td>
    <%}
     noOfTods=data_string2.length;
    }
  
%>

    </tr>


   <%
    int start = Integer.parseInt(request.getParameter("start"));
    int limit = 10;
    int count = 0;
    String sql=null;
    sql ="select count(*) from d3_b4 where cdfid in (select cdfid from meter_data_time_stamp where meterid="+meter_id+")";

                pstmt = con.prepareStatement(sql);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }//end if
                System.out.println("Total No of records :" + count);
                   //-----------------------------
                
String meter_sl_no="";
  pstmt = con.prepareStatement("select meter_serial_no from meter where meterid="+meter_id);
   rs = pstmt.executeQuery();
      if(rs.next())
   {
meter_sl_no = rs.getString("meter_serial_no");
}
   session.setAttribute("meter_sl_no",meter_sl_no);

   System.out.println("meterid---->"+meter_id);
   if (DBUtil.getTargetDB().equals("oracle")) {
   sql="select billing_date,tod_value,data_string from"
+"( select billing_date,tod_value,data_string,cdfid,billing_day,rownum r from "
+"(select  distinct(billing_date),b4.tod_value,b4.data_string,b4.cdfid,b4.billing_day from d3_b4 b4,d3_dates dates where b4.cdfid=dates.cdfid and b4.billing_day=dates.billing_day and b4.cdfid in (select cdfid from meter_data_time_stamp where meterid=?) order by to_timestamp(billing_date,'dd-mm-yyyy hh24:mi:ss') desc)"
+"where rownum<=?) where r>=?";
   
   pstmt = con.prepareStatement(sql);
   pstmt.setInt(2, start + limit);
   pstmt.setString(1, meter_id);
   pstmt.setInt(3, start);
   } else if (DBUtil.getTargetDB().equals("mysql")) {
       sql="select  distinct(billing_date),b4.tod_value,b4.data_string,b4.cdfid,b4.billing_day from d3_b4 b4,d3_dates dates "
               + "where b4.cdfid=dates.cdfid and b4.billing_day=dates.billing_day and b4.cdfid in (select cdfid from "
               + "meter_data_time_stamp where meterid=?) order by b4.d3_time_stamp limit ?,?";
       if (start == 1) {
                                                start = 0;
                                            }//end if
                                            pstmt = con.prepareStatement(sql);
                                            pstmt.setString(1, meter_id);
                                            pstmt.setInt(2, start);
                                            pstmt.setInt(3, start + limit);
   }
   rs = pstmt.executeQuery();
   String dataString = "";
   while(rs.next())
   {
    String data_string[] = rs.getString("data_string").split(",");
    String tod_value_string[] = rs.getString("tod_value").split(",");
    int first_valu=0;
    int total_tods = tod_value_string.length;
    
    first_valu=Integer.parseInt(tod_value_string[0]);
    for(int i=0;i<tod_value_string.length;i++)
        {
        if(i!=0 && first_valu==Integer.parseInt(tod_value_string[i]))
            {
        %>
        
        <td class="td2"><%=data_string[i]%></td>
    
        <% }else{
    if(Integer.parseInt(tod_value_string[i])==1) {
        %>
        <tr style="background-color: #EEEEEE;">
            <td class="td2" rowspan="<%=total_tods/noOfTods%>" valign="top"><%=rs.getString("billing_date")%></td>
        <%}else{
    %>
        <tr>
    <%}%>
       
        
         <td class="td2"><%=tod_value_string[i]%></td>
        <td class="td2"><%=data_string[i]%></td>
    
    <%}
        first_valu=Integer.parseInt(tod_value_string[i]);
    }
    }
   %>
   </table></div>
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
        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:tod_energy(<%=((start_tmp/100)*100)-9%>)" style="text-decoration:none;">Prev 10</a></td>&nbsp;
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

        <td id="pageNo" style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:tod_energy(<%=start%>)" style="text-decoration:none;"><%=i%></a></td>&nbsp;

        <%
                       }

                  else

                        {
        %>

        <td id="pageNo"><a href="#"  onclick="javascript:tod_energy(<%=start%>)"><%=i%></a></td>&nbsp;

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

        <td id="pageNo"  style="border:1px solid red;padding-right:5px;padding-left:5px;"><a href="#"  onclick="javascript:tod_energy(<%=start%>)" style="text-decoration:none;">Next 10</a></td>&nbsp;

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
