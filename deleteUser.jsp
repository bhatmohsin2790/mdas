<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
      <%@page import="java.sql.*" %>
      <form name="delUser" action="">

<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
   <tr><th colspan="2"><h2>Delete User</h2></th></tr>
    <tr>
        <td>USER_ID:</td>
        <td>
            <select name="user_id" id="deluserId">
                <option value="0">Select UserId</option>
                <% Connection con2 = new DBUtil().getConnection();
                                Statement st2 = null;
                                ResultSet rs2 = null;                                
                                try
				{
                                    st2 = con2.createStatement();
                                    rs2 = st2.executeQuery("select * from users order by upper(user_id)");
                                        int value=0;
                                    while (rs2.next())
				    {
                %>
                       <option value="<%=value+1%>" ><%=rs2.getString("user_id")%></option>
               <%
                            value++;        }

                                }
				catch (Exception e)
                                {
                                    e.printStackTrace();
                                }
                                finally{
                                    con2.close();
                                }
               %>
            </select></td>
    </tr>
    <tr><td>  </td><td><input type="button" value="Delete" onclick="delUsers()"></td></tr>
</table>
          

      </form>
  
