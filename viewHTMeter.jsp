<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
    
    </style>
<table  cellpadding="0" cellspacing="0" id="dtable" bgcolor="#EDF5FA" >
    <thead >        
        <tr>
            <td >Sl No</td>
			<td >Discom Name</td>
            <td >Town Name</td>
            <td >Substation Name</td>
            <td >Feeder Name</td>
            <td >ConsumerName</td>
            <td >Mapped Meter</td>
        </tr>
    </thead>
    <tbody>
        <%
            Connection con3 = null;
            Statement st = null;
            String sql = null;
            sql = "select d.discom_name,t.townname,s.substationname,f.feedername,h.consumername,m.meter_serial_no from ht_consumer h,meter m,substation s,feeder f,town t,discom d,zone z,circle c,division di,subdivision subdiv where d.discom_id=z.discom_id and z.zoneid=c.zoneid and c.circleid=t.circleid and t.townid=di.townid and di.divisionid=subdiv.divisionid and subdiv.subdivid=s.subdivid and  s.substationid=f.substationid and f.feederid=h.feederid and h.consumerid=m.htconsumerid order by t.townname,s.substationname,f.feedername,h.consumerid asc";
            con3 = new DBUtil().getConnection();
            st = con3.createStatement();
            ResultSet rs3 = st.executeQuery(sql);
            try {
				int sno=1;
                while (rs3.next()) {

        %>
        <tr>
            <td ><%=sno%></td>
			 <td ><%=rs3.getString(1)%></td>
            <td ><%=rs3.getString(2)%></td>
            <td ><%=rs3.getString(3)%></td>
            <td ><%=rs3.getString(4)%></td>
            <td ><%=rs3.getString(5)%></td>
            <td ><%=rs3.getString(6)%></td>



        </tr>


        <% sno++;
                }
            } catch (Exception e) {
                e.getMessage();
            }
        %>
    </tbody></table>

