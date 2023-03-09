<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
   
   
        <table  align="center"  border="0"  id="dtable" cellspacing="0" cellpadding="0">
       <thead>
       
      <tr>
      
      <td><h3>ModemSlNo</h3></td>      
      <td><h3>Mobile No</h3></td>
      <td><h3>IMEI NO</h3></td>
      <td><h3>STATIC IP</h3></td>    
      
      </tr>
       </thead>
       <tbody>
<%
           int start = Integer.parseInt(request.getParameter("start"));
                
            Connection con = null;
            PreparedStatement ps = null;
            String sql = null;            
             con = new DBUtil().getConnection();
             ResultSet rs=null;
               // System.out.println("Total Dtrs :" + count);
                if (DBUtil.getTargetDB().equals("oracle")) {
//                   sql="select modem_serial_no,mobile_no,imei_no,static_ip from"
//                                   +"(select modem_id,modem_serial_no,mobile_no,rownum r,imei_no,static_ip from"
//                                     +"(select modem_id,modem_serial_no,mobile_no,imei_no,static_ip from modem order by modem_id)where rownum<=?) where r>=?" ;
             sql="select modem_id,modem_serial_no,mobile_no,imei_no,static_ip from modem order by modem_id";
                    ps = con.prepareStatement(sql);
//                    ps.setInt(1, start + limit);
//                     ps.setInt(2, start);
                       } else if (DBUtil.getTargetDB().equals("mysql")) {
                           
                       }

                rs = ps.executeQuery();
                    while(rs.next())
                        {

  %>
  <tr>
      <td ><%=rs.getString(1)%></td>
      <td ><%=rs.getString(2)%></td>
      <td ><%=rs.getString(3)%></td>
      <td ><%=rs.getString(4)==null?" ":rs.getString(4)%></td>
      
     

  </tr>


  <%
  }
        %>
       </tbody></table>
       