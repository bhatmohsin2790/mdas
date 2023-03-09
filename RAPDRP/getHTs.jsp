<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<table >
    <tr>
        <td>
            <select name="meters" id="meters" style="width:250px;height:20px;font-size:12px;font-family:verdana;">
                <option value="-1">Select Meter</option> 
<%
try{
  String townId = request.getParameter("townId");
 Connection con = new DBUtil().getConnection();
    String query="select m.meter_serial_no,h.consumername from ht_consumer h,meter m,feeder f,substation s,town t,subdivision sd,division d where h.consumerid=m.htconsumerid and h.feederid=f.feederid and f.substationid=s.substationid and s.subdivid=sd.subdivid and sd.divisionid=d.divisionid and d.townid=t.townid and t.townid="+townId+" order by h.consumername";
   System.out.println("----------->"+query);       
    stmt = con.createStatement();
        rs = stmt.executeQuery(query);
       
 while(rs.next()){
     %>
     <option  value="<%=rs.getString(1)%>"><%=rs.getString(2)%>-<%=rs.getString(1)%></option>
    <%
    }
               }catch(Exception e){
                   out.println("<h4>Error:</h4>"+e.getMessage());
               }
    %>
    </select>
    </td></tr>
</table>