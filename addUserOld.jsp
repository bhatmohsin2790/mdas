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
           <select name="userType"  id="userType" onchange="getSome(this.value)">
               <option value="-1"> Select UserType</option>
               <%
                        Connection con = new DBUtil().getConnection();
                        Statement st = null;
                        ResultSet rs = null;
                        try
                        {
                            st = con.createStatement();
                            rs = st.executeQuery("select * from user_types");
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
                        finally{
                            con.close();
                        }
               %>
              
           </select>
       </td>
   </tr>
    <tr><td>ZONE_ID:</td>
    <td>
        <select name="zoneId" onchange="getCircles(this.value)" id="zoneId">
            <option value="-1">Select ZoneId</option>
            <%
                    Connection con1 = new DBUtil().getConnection();
                    PreparedStatement pstmt1 = null;
                    ResultSet rs1 = null;
                    try
                    {
                        pstmt1 = con1.prepareStatement("select * from zone");
                        rs1 = pstmt1.executeQuery();
                        while (rs1.next())
                        {
           %>
                             <option value="<%=rs1.getString("zoneid")%>" ><%=rs1.getString("zonename")%></option>
           <%
                        }

                    }
                    catch (Exception e)
                    {
                        e.printStackTrace();
                    }
           %>
           </select>
      </td>
    </tr>
    <tr>
        <td>CIRCLE_ID:</td>
        <td>
            <select name="circleId" id="circleId">
                <option value="-1">Select CircleId</option>

            </select>
        </td>
    </tr>
     <tr>
         <td>IS_ACTIVE:</td>
         <td>
        <input name="isActive" type="text" id="isActive" >
         </td>
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
