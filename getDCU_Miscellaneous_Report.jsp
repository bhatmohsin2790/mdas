<%@ page session="false" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ include file="getConnection1.jsp"%>
<link rel="stylesheet" type="text/css" href="css/style.css" />
<%
try{
    NumberFormat twoDecFormat = new DecimalFormat("#0.000");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
String dcu_id = request.getParameter("dcu_id");
// pstmt = con.prepareStatement("select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid "
         //       + "and m.feederid in  (select feederid from feeder where substationid=?)");
        String sql11 = "select m.meterid,m.meter_serial_no,f.feederid,f.feedername,f.dcuid,f.classvoltage from meter m,feeder f where m.feederid=f.feederid and m.meterid in ("+dcu_id+")";
                System.out.println("Qry==>"+sql11);
       PreparedStatement pstmt = con.prepareStatement(sql11);
        //pstmt.setString(1, dcu_id);
ResultSet rs = pstmt.executeQuery();

String f_ids = "";
String f_names = "";
String meter_ids = "";
String meter_serial_nos = "";

while(rs.next())
{
    
    f_ids = f_ids + rs.getString("feederid") + ",";
    f_names = f_names + rs.getString("feedername") + ",";
    meter_ids = meter_ids + rs.getString("meterid") + ",";
    meter_serial_nos = meter_serial_nos + rs.getString("meter_serial_no") + ",";
}

String[] f_ids_arr = f_ids.split(",");
String[] f_names_arr = f_names.split(",");
String[] meter_ids_arr = meter_ids.split(",");
String[] meter_serial_nos_arr = meter_serial_nos.split(",");

for(int i=0;i<f_ids_arr.length;i++)
{
    System.out.println(f_ids_arr[i]+"-->"+f_names_arr[i]+"--->"+meter_ids_arr[i]+"--->"+meter_serial_nos_arr[i]);
    
    
    %>
    
    <table border="0" width="100%" id="table_disp" cellpadding="0" cellspacing="1px" style="float:left;margin-right: 10px;<% if(i>=2) out.println("margin-top:10px;"); %>" >
        <thead>
        <tr>
            <td colspan="7"><strong>Feeder Name : </strong><%= f_names_arr[i] %> (<%=meter_serial_nos_arr[i]%>)</td> 
        </tr>
            <td width="80px"><strong>DATE</strong></td>
            <td width="60px" ><strong>TIME</strong></td>
            <td align="center">Number of Power-Failures</td>
            <td align="center">Cumulative Power-Failure duration (Mins)</td>
            <td align="center">Cumulative Tamper count</td>
            <td align="center">Cumulative Billing count</td>
            <td align="center">Cumulative Programming count</td>
             
           
        </tr>
        </thead>
        <tbody>
            <%
            if (DBUtil.getTargetDB().equals("mysql")) {
            pstmt = con.prepareStatement("select g2,g32 from d1  d where d.cdfid in (select cdfid from  meter_data_time_stamp where meterid=?) order by d.meter_time_stamp desc limit 10");
            }
            if (DBUtil.getTargetDB().equals("oracle")) {
             pstmt = con.prepareStatement("select g2,g32 from(select g2,g32,rownum from d1  d where d.cdfid in (select cdfid from  meter_data_time_stamp where meterid=?) order by d.meter_time_stamp desc) where rownum<=10");   
            }              
            pstmt.setString(1, meter_ids_arr[i]);
            rs = pstmt.executeQuery();
            int data_available_flag = 0;
            while(rs.next())
            {
               String g32=rs.getString(2);
                out.println("<tr>");
                out.println("<td align='left' width='80px'>"+rs.getString(1).substring(0, 10) +"</td>");
                out.println("<td align='left' width='60px'>"+rs.getString(1).substring(10) +"</td>");
                if(g32.contains(":"))
                {
                out.println("<td align='right'>"+g32.split(":")[1] +"</td>");
                out.println("<td align='right'>"+Math.round(Double.parseDouble(g32.split(":")[0])/60) +"</td>");
                out.println("<td align='right'>"+g32.split(":")[2] +"</td>");
                out.println("<td align='right'>"+g32.split(":")[3] +"</td>");
                out.println("<td align='right'>"+g32.split(":")[4] +"</td>");
                 }
               else{
                      out.println("<td  colspan='5' align='center'>Data Not Available.</td>"); 
               }
               
                out.println("<tr>");
                data_available_flag = 1;
            }
            if(data_available_flag == 0)
            {
                out.println("<tr><td  colspan='12' align='center'>Data Not Available.</td></tr>");
            }
            %>
        </tbody>
        <tbody>
            
        </tbody>
    </table>
    <%

}
}
catch(Exception e)
           {
    e.printStackTrace();
}
finally{
    con.close();
}
%>


 