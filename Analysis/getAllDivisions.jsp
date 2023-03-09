<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<select name="town" id="town" onchange="getMeterTypes(2)" style="width:250px;"> <!-- 1 for config/ondemand logs and 2 for analysis reports-->
  <option value="-1">Select Division (Circle )</option>  

<%
   String query=""; 
try{
     HttpSession sess=request.getSession(false);
     String office_type=sess.getAttribute("office_type").toString();
     String office_type_id=sess.getAttribute("office_type_id").toString();
     
  Connection con = new DBUtil().getConnection();
  System.out.println("con = "+con);
    if (office_type.equals("SDO")) {
          query = query + "SELECT d.divisionid,d.divisionname,c.circlename from town t,circle c,division d,subdivision sd where t.circleid is not null and t.circleid=c.circleid and t.townid=d.townid and d.divisionid=sd.divisionid and sd.subdivid=" + office_type_id + " order by d.divisionname";
      } else if (office_type.equals("DO")) {
          query = query + "SELECT d.divisionid,d.divisionname,c.circlename from circle c,division d where d.circleid=c.circleid and d.divisionid=" + office_type_id + " order by d.divisionname";
      } else {
          query = "SELECT d.divisionid,d.divisionname,c.circlename from circle c,division d where d.circleid=c.circleid order by d.divisionname";
      }
  System.out.println("-------->"+query);
  stmt = con.createStatement();
         rs = stmt.executeQuery(query);
     while(rs.next()){    
         String val = rs.getString(2);         
 %>
 <option value="<%=rs.getString(1)%>"> <%=val + "  ("+ rs.getString(3) +")"%>  </option>
<%
     }
  con.close();
   }catch(Exception e){
       out.println("<h4>Error:</h4>"+e.getMessage());
       e.printStackTrace();
   }
%>
</select> 
