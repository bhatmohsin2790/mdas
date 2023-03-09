<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
            #zone_data h3
            {background-color:#EEEEEE;
border:1px solid #DDDDDD;
color:#666666;
 width:100px;
font-size:12px;
padding:5px 15px;
text-decoration:none;}
            .zone_data
            {
           width:100px;
            }
       
</style>
<table  border="0"  id="dtable" bgcolor="#EDF5FA" >
    <thead>
    <tr>
        <td align="center"><h3>Discom</h3></td>
        <td align="center"><h3>Zone</h3></td>
    </tr>
	</thead>
	<tbody>
    <%
                Connection con = null;
                Statement st = null;
                String sql = null;
                sql = "select d.discom_name,z.zonename from zone z,discom d where z.discom_id=d.discom_id";
                con = new DBUtil().getConnection();
                st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {

    %>
    <tr>
        <td align="center"><%=rs.getString(1)%></td>
        <td align="center"><%=rs.getString(2)%></td>
    </tr>


    <%
                }
    %>
	</tbody>
</table>