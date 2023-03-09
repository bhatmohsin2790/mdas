<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<table cellpadding="2" cellspacing="2" id="dtable" bgcolor="#EDF5FA" >
<thead>
    <tr>
        <td><h3>Discom</h3></td>
        <td><h3>Zone</h3></td>
        <td><h3>Circle</h3></td>
        <td><h3>Town</h3></td>
        <td><h3>division</h3></td>
        <td><h3>SubDivision</h3></td>       
    </tr>
	</thead>
	<tbody>
    <%
                Connection con = null;
                Statement st = null;
                String sql = null;
                sql = "select d.discom_name,z.zonename,c.circlename,t.townname,di.divisionname,sd.subdivname from subdivision sd,division di,circle c,town t ,zone z,discom d where z.discom_id=d.discom_id and c.zoneid=z.zoneid and c.circleid=t.circleid and t.townid=di.townid and di.divisionid=sd.divisionid order by d.discom_name,z.zonename,c.circlename,t.townname,di.divisionname,sd.subdivname";
                con = new DBUtil().getConnection();
                st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {

    %>
    <tr>
        <td><%=rs.getString(1)%></td>
        <td><%=rs.getString(2)%></td>
        <td><%=rs.getString(3)%></td>
        <td><%=rs.getString(4)%></td>
        <td><%=rs.getString(5)%></td>
        <td><%=rs.getString(6)%></td>
    </tr>


    <%
                }
    %>
	</tbody>
</table>