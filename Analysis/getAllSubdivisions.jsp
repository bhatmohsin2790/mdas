<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<select name="town" id="town" onchange="getMeterTypes(2)" style="width:250px;"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
  <option value="-1">Select Subdivisions</option>  

<%
    String query="";
try{
     HttpSession sess=request.getSession(false);
     String office_type=sess.getAttribute("office_type").toString();
     String office_type_id=sess.getAttribute("office_type_id").toString();
     
  Connection con = new DBUtil().getConnection();
  System.out.println("con = "+con);
  query="select * from subdivision ";
  if (office_type.equals("DO")) {
          query = query + " where divisionid=" + office_type_id;
      } else if (office_type.equals("SDO")) {
          query = query + " where subdivid=" + office_type_id;
      }
      query = query + " order by subdivname";
         stmt = con.createStatement();
         rs = stmt.executeQuery(query);
     while(rs.next()){    
         String val = rs.getString(2);         
 %>
 <option value="<%=rs.getString(1)%>"> <%=val%>  </option>
<%
     }
  con.close();
   }catch(Exception e){
       out.println("<h4>Error:</h4>"+e.getMessage());
   }
%>
</select> 
