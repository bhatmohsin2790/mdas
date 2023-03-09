<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<select name="SS" onchange="getMeterTypes(1)">
  <option value="-1">Select Substation</option>  
<%
try{
  String townId = request.getParameter("townId");
  Connection con = new DBUtil().getConnection();
  String query="SELECT * from substation where subdivid in(select subdivid from subdivision where divisionid in (select divisionid from division where townid='"+townId+"')) order by substationname";
         stmt = con.createStatement();
         rs = stmt.executeQuery(query);
     while(rs.next()){    
         String val = rs.getString(1);
         if(val.trim().equals(""))
             continue;
 %>
 <option value="<%=rs.getString("substationid")%>"> <%=rs.getString("substationname")%>  </option>
<%
     }
  con.close();
   }catch(Exception e){
       out.println("<h4>Error:</h4>"+e.getMessage());
   }
%>
</select> 