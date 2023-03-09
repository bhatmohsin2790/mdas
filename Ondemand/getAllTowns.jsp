<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<select name="town" id="town" onchange="getSubstation(this.value)" style="width:250px;">
  <option value="-1">Select Town (Circle )</option>  

<%
try{
  Connection con = new DBUtil().getConnection();
  System.out.println("con = "+con);
  String query="SELECT t.townid,t.townname,c.circlename from town t,circle c where t.circleid is not null and t.circleid=c.circleid order by t.townname";
         stmt = con.createStatement();
         rs = stmt.executeQuery(query);
     while(rs.next()){    
         String val = rs.getString("townname");
         if(val.trim().equals(""))
             continue;
 %>
 <option value="<%=rs.getString(1)%>"> <%=val + "  ("+ rs.getString(3) +")"%>  </option>
<%
     }
  con.close();
   }catch(Exception e){
       out.println("<h4>Error:</h4>"+e.getMessage());
   }
%>
</select> 
