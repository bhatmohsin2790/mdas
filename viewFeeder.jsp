<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<style>
    .htheader
    {
        background-color:#EEEEEE;
        color:#666666;
        font-size:12px;
    }
    </style>
<table cellpadding="0" cellspacing="0" id="dtable" bgcolor="#EDF5FA" >
<thead>
      <tr>
      <td class="htheader"><h3>Zone</h3></td>
	  <td class="htheader"><h3>Circle</h3></td>
      <td class="htheader"><h3>Town</h3></td>
	  <td class="htheader"><h3>Division</h3></td>
	  <td class="htheader"><h3>Subdivision</h3></td>
      <td class="htheader"><h3>Substation</h3></td>
      <td class="htheader"><h3>Feeder</h3></td>
      </tr>
	  </thead>
	  <tbody>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            sql="select z.zonename,c.circlename,t.townname,di.divisionname,sd.subdivname,ss.substationname,f.feedername from feeder f,dcuinfo dc,substation ss,town t, subdivision sd,division di,circle c, zone z,discom d where z.discom_id=d.discom_id and c.zoneid=z.zoneid and c.circleid=t.circleid and t.townid=di.townid and di.divisionid=sd.divisionid and sd.subdivid=ss.subdivid and dc.substationid=ss.substationid and f.substationid=ss.substationid order by t.townname,ss.substationname,dc.dcuname,f.feedername";
             con = new DBUtil().getConnection();
                    st = con.createStatement();
                    ResultSet rs=st.executeQuery(sql);
                    while(rs.next())
                        {

  %>
  <tr>
      <td><%=rs.getString(1)%></td>
      <td><%=rs.getString(2)%></td>
      <td><%=rs.getString(3)%></td>
      <td><%=rs.getString(4)%></td>
	  <td><%=rs.getString(5)%></td>
	  <td><%=rs.getString(6)%></td>
	  <td><%=rs.getString(7)%></td>

  </tr>


  <%
  }
        %>
		</tbody>
         </table>