<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<table cellpadding="2" cellspacing="2" border="1" bgcolor="#EDF5FA">
    <tr><td colspan="3" align="center"><h2>DCU Mapping</h2></td></tr>
      <tr>
      <td><h3>modemId</h3></td>
      <td><h3>modemSerialNo</h3></td>
      <td><h3>dcuName</h3></td>
      </tr>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            sql="select m.modem_id,m.modem_serial_no,d.dcuname from modem m,dcuinfo d where m.dcu_id=d.dcuid";
             con = new DBUtil().getConnection();
                    st = con.createStatement();
                    ResultSet rs=st.executeQuery(sql);
                    while(rs.next())
                        {

  %>
  <tr>
      <td><%=rs.getInt(1)%></td>
      <td><%=rs.getString(2)%></td>
      <td><%=rs.getString("dcuname")%></td>

  </tr>


  <%
  }
        %>
         </table>