<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<table bgcolor="#87CEEB">
<tr>    
    <td colspan="4"><input type="checkbox" id="cbgroup1_master" onchange="togglecheckboxes(this,'meters')"> Select All</td>
</tr>
<%
try{
  String ssID = request.getParameter("ssID");
 Connection con = new DBUtil().getConnection();
    String query="select m.meter_serial_no,h.consumername from ht_consumer h,meter m,feeder f,substation s where h.feederid=f.feederid and f.substationid=s.substationid and s.substationid="+ssID+" and h.consumerid=m.htconsumerid order by h.consumername";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);
        int colCount=0,rowCount=0,cellCount=0;
 while(rs.next()){
     cellCount++; 
     if(colCount==0){
       %>
         </tr>
       <%   
      }
      if((colCount%5==0) && colCount!=0){
         colCount=0; rowCount++;
     %>
      </tr>
      <%}%>
     <td><input type="checkbox" id="cb1_<%=cellCount%>" name="meters" value="<%=rs.getString(1)%>"><%=rs.getString(2)%></td>
    <%colCount++; 
     //if((rowCount==3)&&(colCount==5))
       //  break;
    }
               }catch(Exception e){
                   out.println("<h4>Error:</h4>"+e.getMessage());
               }
    %>
</table>