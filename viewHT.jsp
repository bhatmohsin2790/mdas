<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
   
    </style>
<table align="center" cellpadding="0" cellspacing="0" id="dtable" bgcolor="#EDF5FA" >
    <thead >
        <tr>
            <td >Town</td>
            <td >Substation</td>
            <td >FeederName</td>
            <td >consumerName</td>    
            <td >MobileNO</td>      
            <td >EmailId</td>
        </tr>
    </thead>
    <tbody>
        <%
            try {
                Connection con = null;
                Statement st = null;
                String sql = null;
                if (DBUtil.getTargetDB().equals("oracle")) {
                    sql = "select t.townname,s.substationname,f.feedername,c.consumername,c.mobileno,c.emailid from ht_consumer c,feeder f,substation s,town t ,division d,subdivision sd where t.townid=d.townid and d.divisionid=sd.divisionid and sd.subdivid=s.subdivid and c.feederid=f.feederid and s.substationid=f.substationid order by t.townname,s.substationname,f.feedername,c.consumername";
                } else if (DBUtil.getTargetDB().equals("mysql")) {
                    sql = "select t.townname,s.substationname,f.feedername,c.consumername,c.mobileno,c.emailid from ht_consumer c,feeder f,substation s,town t where t.townid=s.townid and c.feederid=f.feederid and s.substationid=f.substationid";
                }
                con = new DBUtil().getConnection();
                st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {

        %>
        <tr>
            <td ><%=rs.getString(1)%></td>       
            <td ><%=rs.getString(2)%></td>
            <td ><%=rs.getString(3)%></td>
            <td ><%=rs.getString(4)%></td>
            <td ><%=rs.getString(5)%></td>
            <td ><%=rs.getString(6)%></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.getMessage();
            }
        %>

    </tbody>
</table>