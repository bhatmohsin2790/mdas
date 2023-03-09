<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>


<table cellpadding="0" cellspacing="0"  id="dtable"> 
    <thead>
    <tr>
      <td><h3>Discom</h3></td>
      <td><h3>Town</h3></td>
      <td><h3>Substation</h3></td>
      <td><h3>Feeder</h3></td>
      <td><h3>DTR</h3></td>
    </tr>
    </thead>   
    <tbody>
    <%
                int start = Integer.parseInt(request.getParameter("start"));
                
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String sql = null;
                
               con = new DBUtil().getConnection();
                 if (DBUtil.getTargetDB().equals("oracle")) {
//                 sql="select discom_name,townname,substationname,feedername,dtrname from "+
//                      "(select discom_name,townname,substationname,feedername,dtrname,rownum r from "+
//                      "(select d.discom_name,t.townname,ss.substationname,f.feedername,dt.dtrname from dtr dt,feeder f,dcuinfo dc,substation ss,town t, subdivision sd,division di,circle c, zone z,discom d where z.discom_id=d.discom_id and c.zoneid=z.zoneid and c.circleid=t.circleid and t.townid=di.townid and di.divisionid=sd.divisionid and sd.subdivid=ss.subdivid and dc.substationid=ss.substationid "+
//                      " and f.substationid=ss.substationid and dt.feederid=f.feederid order by t.townname,ss.substationname,f.feedername,dt.dtrname) where rownum<=?) where r>=?";
                sql="select d.discom_name,t.townname,ss.substationname,f.feedername,dt.dtrname from dtr dt,feeder f,dcuinfo dc,substation ss,town t, subdivision sd,division di,circle c, zone z,discom d where z.discom_id=d.discom_id and c.zoneid=z.zoneid and c.circleid=t.circleid and t.townid=di.townid and di.divisionid=sd.divisionid and sd.subdivid=ss.subdivid and dc.substationid=ss.substationid "+
                      " and f.substationid=ss.substationid and dt.feederid=f.feederid order by t.townname,ss.substationname,f.feedername,dt.dtrname";
                 System.out.println("query------->"+sql);
                ps = con.prepareStatement(sql);
              
                 } 
                rs = ps.executeQuery();
                while (rs.next()) {

    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(2)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(4)%></td>
        <td><%=rs.getString(5)%></td>
    </tr>
    <%
                }
    %>
    </tbody>
</table>

<%
           con.close();
%>