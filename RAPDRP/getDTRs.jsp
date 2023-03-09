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
    //System.out.println("town is  >"+townId);
 Connection con = new DBUtil().getConnection();
  String query="select m.meter_serial_no,d.dtrname from dtr d,meter m,feeder f,substation s,town t,division di,subdivision sd where m.dtrid=d.dtrid and d.feederid=f.feederid and f.substationid=s.substationid and s.subdivid=sd.subdivid and sd.divisionid=di.divisionid and di.townid=t.townid and t.townid="+townId+"  order by d.dtrname";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);
        //System.out.println("query------>"+query);
 while(rs.next()){%>
    <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%>-<%=rs.getString(1)%></option>
    <%
    }
               }catch(Exception e){
                   e.printStackTrace();
                   out.println("<h4>Error:</h4>"+e.getMessage());
               }
    %>
 </select>
    </td></tr>
</table>