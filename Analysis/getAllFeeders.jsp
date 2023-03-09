<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<select name="town" id="town" onchange="getMeterTypes(2)" style="width:250px;"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
  <option value="-1">Select Feeders</option>  

<%
try{
  Connection con = new DBUtil().getConnection();
  System.out.println("con = "+con);
  String query="select feederid,feedername from feeder where feederid in(select distinct(feederid) from dtr) or feederid in(select distinct(feederid) from ht_consumer) order by upper(feedername)";
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
