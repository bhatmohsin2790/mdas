<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
    
</style>

<table  cellspacing="0" cellpadding="0"  id="dtable" bgcolor="#EDF5FA" >
    <thead >      
        <tr>
            <td >Sl No</td>
			<td >Discom</td>
            <td >Town</td>
            <td >Substation</td>
            <td >Feeder</td>
            <td >Mapped Meter</td>
        </tr>
    </thead>
    <tbody>
        <%
            Connection con = null;
            Statement st = null;
            String sql = null;
            sql = "select d.discom_name,t.townname,ss.substationname,f.feedername,m.meter_serial_no from discom d,zone z,circle c,division di,subdivision subdiv,town t,substation ss,meter m,feeder f where  d.discom_id=z.discom_id and z.zoneid=c.zoneid and c.circleid=t.circleid and t.townid=di.townid and di.divisionid=subdiv.divisionid and subdiv.subdivid=ss.subdivid  and ss.substationid=f.substationid and f.feederid=m.feederid  ";


            System.out.println("query--->"+sql);
            con = new DBUtil().getConnection();
            st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            try {
				int sno=1;
                while (rs.next()) {

        %>
        <tr>
            <td ><%=sno%></td>
		    <td ><%=rs.getString(1)%></td>
            <td ><%=rs.getString(2)%></td>
            <td ><%=rs.getString(3)%></td>
            <td ><%=rs.getString(4)%></td>
            <td ><%=rs.getString(5)%></td>


        </tr>


        <% sno++;
                }
            } catch (Exception e) {
                e.getMessage();
            }
        %>
    </tbody></table>
