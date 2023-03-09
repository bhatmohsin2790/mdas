<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<table cellpadding="2" cellspacing="2" border="1" bgcolor="#EDF5FA">
    <tr><td colspan="3" align="center"><h2>Feeders</h2></td></tr>
      <tr>
      <td><h3>feederId</h3></td>
      <td><h3>feederName</h3></td>
      <td><h3>substationName</h3></td>
      </tr>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            sql="select f.feederid,f.feedername,ss.substationname from feeder f,substation ss where f.substationid=ss.substationid";
             con = new DBUtil().getConnection();
                    st = con.createStatement();
                    ResultSet rs=st.executeQuery(sql);
                    while(rs.next())
                        {

  %>
  <tr>
      <td><%=rs.getInt(1)%></td>
      <td><%=rs.getString(2)%></td>
      <td><%=rs.getString("substationname")%></td>

  </tr>


  <%
  }
        %>
         </table>