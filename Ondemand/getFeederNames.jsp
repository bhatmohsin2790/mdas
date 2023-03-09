<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<select name="Feeder" onchange="getMeterTypes(1)"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
  <option value="-1">Select Feeder</option>  
<%
try{
  String SSid = request.getParameter("SSid");
 Connection con = new DBUtil().getConnection();
  String query="SELECT * from feeder where substationid='"+SSid+"'";
         stmt = con.createStatement();
         rs = stmt.executeQuery(query);
     while(rs.next()){    
         String val = rs.getString(1);
         if(val.trim().equals(""))
             continue;
 %>
 <option value="<%=rs.getString("feederid")%>"> <%=rs.getString("feedername")%>  </option>
<%
     }
  con.close();
  
   }catch(Exception e){
       out.println("<h4>Error:</h4>"+e.getMessage());
   }
%>
</select> 
 