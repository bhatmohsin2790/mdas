<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.*"%>
<table cellpadding="2" cellspacing="2" border="1" bgcolor="#EDF5FA">
    <tr><td colspan="13" align="center"><h2>Ht_Consumers</h2></td></tr>
      <tr>
      <td><h3>consumerId</h3></td>
      <td><h3>consumerName</h3></td>
      <td><h3>Address</h3></td>
      <td><h3>MobileNO</h3></td>
      <td><h3>phoneNo</h3></td>
      <td><h3>EmailId</h3></td>
      <td><h3>AltEmailId</h3></td>
      <td><h3>AgrmntFromDate</h3></td>
      <td><h3>AgrmntToDate</h3></td>
      <td><h3>Concession</h3></td>
      <td><h3>conletterNo</h3></td>
      <td><h3>Rebate</h3></td>
      <td><h3>FeederName</h3></td>
      </tr>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
           if (DBUtil.getTargetDB().equals("oracle")) {
              sql="select c.consumerid,c.consumername,c.address,c.mobileno,c.phoneno,c.emailid,c.altemailid,to_char(c.agrmntfromdate,'dd/mm/yyyy') abc,to_char(c.agrmnttodate,'dd/mm/yyyy') def,c.concession,c.conletterno,c.rebate,f.feedername from ht_consumer c,feeder f where c.feederid=f.feederid";
            } else if (DBUtil.getTargetDB().equals("mysql")) {
            sql="select c.consumerid,c.consumername,c.address,c.mobileno,c.phoneno,c.emailid,c.altemailid,date_format(c.agrmntfromdate,'%d/%m/%Y') abc,date_format(c.agrmnttodate,'%d/%m/%Y') def,c.concession,c.conletterno,c.rebate,f.feedername from ht_consumer c,feeder f where c.feederid=f.feederid";
                       }
             con = new DBUtil().getConnection();
                    st = con.createStatement();
                    ResultSet rs=st.executeQuery(sql);
                    while(rs.next())
                        {

  %>
  <tr>
      <td><%=rs.getInt(1)%></td>
      <td><%=rs.getString(2)%></td>
      <td><%=rs.getString(3)%></td>
      <td><%=rs.getString(4)%></td>
      <td><%=rs.getString(5)%></td>
      <td><%=rs.getString(6)%></td>
      <td><%=rs.getString(7)%></td>
      <td><%=rs.getString("abc")%></td>
      <td><%=rs.getString("def")%></td>
      <td><%=rs.getString(10)%></td>
      <td><%=rs.getString(11)%></td>
      <td><%=rs.getString(12)%></td>
      <td><%=rs.getString("feedername")%></td>

  </tr>


  <%
  }
        %>
         </table>