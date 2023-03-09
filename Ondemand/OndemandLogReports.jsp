<%@ page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<style>
        .thstyle{
        background-color: #8FA1B5; 
        color:#FFFFFF;
         font-size:14px;
         border-left:1px solid #FFFFFF;
          text-decoration:none;
          font-family: monospace;
           border-bottom: 1px solid #FFFFFF;
        }
        .trbg{
            background-color: #E8EBE2;
             border-bottom: 1px solid #FFFFFF;
        }
        .tdbg{
             border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
        #district_11kv_load tr  td {
             background-color: #E8EBE2;
              border-bottom: 1px solid #FFFFFF;
             border-left: 1px solid #FFFFFF;
        }
     </style> 
<%
 String reportDate=request.getParameter("reportDate");
 String meters=request.getParameter("meters").trim();
 System.out.println(reportDate+"\t"+meters);
 String meter[]=meters.split(",");
 ResultSet rs=null;
 Connection con=null;
 String sql="";
 
 
%>
<table width="100%">
    <thead>
        <tr>
            <th class="thstyle">Meter No</th>       
            <th class="thstyle">TimeStamp</th>
            <th class="thstyle">Request Type</th>           
            <th class="thstyle">Response Data</th>
            <th class="thstyle">On-Demand Status</th>
        </tr>
    </thead>
    <tbody>
        <% 
        try{
        con=new DBUtil().getConnection();
          if(!reportDate.equals("")){
            sql="select * from sms_config where meter_id in(";
           for(int i=0;i<meter.length;i++){
               if(i==meter.length-1)
                sql=sql+"'"+meter[i]+"'";
               else
                 sql=sql+"'"+meter[i]+"',";
           }
           sql=sql+ ") and trunc(req_time_stamp)=to_date('"+reportDate+"','dd/mm/yyyy')order by req_time_stamp ";
                     }
                     else{
               sql="select * from sms_config where meter_id in(";
           for(int i=0;i<meter.length;i++){
               if(i==meter.length-1)
                sql=sql+"'"+meter[i]+"'";
               else
                 sql=sql+"'"+meter[i]+"',";
           }
           sql=sql+ ") order by req_time_stamp ";
                     }
               
          // System.out.println(sql);
           rs=con.prepareStatement(sql).executeQuery();
           while(rs.next()){ %>
           <tr class="trbg">
               <td class="tdbg"><%=rs.getString("meter_id")%></td>              
               <td class="tdbg"><%=rs.getDate("req_time_stamp")+" "+rs.getTime("req_time_stamp")%></td>
               <td class="tdbg"><%=rs.getString("req_type")%> </td>            
               <td class="tdbg"><%=rs.getString("res_data")%></td>
               <td class="tdbg"><%=rs.getString("sms_status")%></td>
           </tr>  
           <%}//while
           }//try
        catch(Exception e){
                           out.println("<h4>Error:</h4>"+e.getMessage());
                                     }
                   
        %>
        
    </tbody>
</table>