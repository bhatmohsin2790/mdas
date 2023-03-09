<%@ page session="false" %>

<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>

 
<form name="addUser" action="" >
<table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
   <tr><th colspan="2"><h2>Create User</h2></th></tr>
   <tr>
        <td>USER_ID:</td>
        <td>
            <input name="userId" type="text" id="userId">
        </td>
   </tr>
   <tr>
       <td>PASSWORD:</td>
       <td>
           <input name="password" type="password" id="password">
       </td>
   </tr>
   <tr>
       <td>USER_TYPE:</td>
       <td>
           <select name="userTypeAdd"  id="userTypeAdd">
               <option value="-1"> Select UserType</option>
               <%
                        Connection con = new DBUtil().getConnection();
                        Statement st = null;
                        ResultSet rs = null;
                        try
                        {
                            st = con.createStatement();
                            rs = st.executeQuery("select * from user_types order by user_type_name");
                            while (rs.next())
                            {
                %>
                                 <option value="<%=rs.getString("user_type_id")%>" ><%=rs.getString("user_type_name")%></option>
               <%
                            }

                        }
                        catch (Exception e)
                        {
                            e.printStackTrace();
                        }
                        finally
                        {
                            con.close();
                        }
               %>
              
           </select>
       </td>
   </tr>
     <tr>
         <td>IS_ACTIVE:</td>
         <td>
        <select name="isActive"  id="isActive" >
            <option value="0">False</option>
            <option value="1">True</option>
        </select>
         </td>
     </tr>
     <tr >
            <td>Office Type:</td>
            <td><select name="officeType"  id="officeType" onchange="getRelativeIds(this.value)">
                    <option value="all"> All</option>
                    <%
                        try {
                            st = con.createStatement();
                            rs = st.executeQuery("select office_type_code,office_type_name from Admin_Hierarchy order by office_type_name");
                            while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("office_type_code")%>" ><%=rs.getString("office_type_name")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>

                </select></td>
        </tr>
        <tr >
            <td>Select Office:</td>
            <td><select name="officeTypeId"  id="officeTypeId">
                    <option value="-1"> All</option>
                </select></td>
        </tr>
      <tr>
          <td>FIRST_NAME:</td>
          <td>
        <input name="firstName" type="text"  id="firstName">
          </td>
      </tr>
      <tr>
          <td>LAST_NAME:</td>
          <td>
        <input name="lastName" type="text" id="lastName">
          </td>
      </tr>
        
      <tr>
          <td>  </td>
          <td>
              <input type="button" value="ADD" onclick="addUsers()">
          </td>
      </tr>
 
</table>

      </form>
