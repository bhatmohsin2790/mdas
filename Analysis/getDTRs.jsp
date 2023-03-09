<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="in.amitech.db.DBUtil"%>
<%!    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
%>
<table bgcolor="#87CEEB" table="1">
    <tr>    
        <td colspan="4"><input type="checkbox" id="cbgroup1_master" onchange="togglecheckboxes(this,'meters')"> Select All</td>
    </tr>
    <%
        try {
            String townId = request.getParameter("townId");
            Connection con = new DBUtil().getConnection();
            String query = "select m.meter_serial_no,d.dtrname from dtr d,meter m ,feeder f,substation s ,town t where m.dtrid=d.dtrid and d.feederid=f.feederid and f.substationid=s.substationid and s.townid=t.townid and t.townid=" + townId + " order by d.dtrname";
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
            int colCount = 0, rowCount = 0, cellCount = 0;
            while (rs.next()) {
                cellCount++;
                if (colCount == 0) {
    %>
</tr>
<%           }
    if ((colCount % 5 == 0) && colCount != 0) {
        colCount = 0;
        rowCount++;
%>
</tr>
<%}%>
<td><input type="checkbox" id="cb1_<%=cellCount%>" name="meters" value="<%=rs.getString(1)%>"><%=rs.getString(2)%></td>
    <%colCount++;
                //if((rowCount==3)&&(colCount==5))
                //    break;
            }
        } catch (Exception e) {
            out.println("<h4>Error:</h4>" + e.getMessage());
        }
        finally{
            con.close();
        }
    %>
</table>