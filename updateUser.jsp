<%@ page session="false" %>
      <%@page import="in.amitech.db.DBUtil"%>
      <%@page import="java.sql.*" %>
      <form name="updateUser" action="" >

      <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5" >
      <tr><th colspan="2"><h2>Update User</h2></th></tr>
      <tr>
          <td>USER_ID:</td>
         
        <td>
            <select name="userId" id="userId" onchange="getUserDetails(this.value);">
                <option value="-1">Select UserId</option>
               <%
                                Connection con = new DBUtil().getConnection();
                                Statement st = null;
                                ResultSet rs = null;
                                int i=0;
                                try
                                {
                                    st = con.createStatement();
                                    rs= st.executeQuery("select * from users order by upper(user_id)");                                    
                                    while (rs.next())
                                    {
                                        %>
                                               <option value="<%=rs.getString("user_id")%>" ><%=rs.getString("user_id")%></option>
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
       <td>OLD PASSWORD <sup  style="color:red">*</sup>:</td><td>
           <input name="password" id="oldpassword" type="password" ></td>
    </tr>
     <tr>
       <td>NEW PASSWORD <sup  style="color:red">*</sup>:</td><td>
           <input name="password" id="newpassword" type="password" ></td>
    </tr>
    
    <tr >
       <td> USER_TYPE:</td>       
       <td>
           <select name="userType" id="userType" >
                <option value="-1">Select UserType</option>
               <%
                                             
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
               %>
           </select>
       </td>
   </tr>   
   
    <tr>
         <td>   IS_ACTIVE:</td>
         <td>
             <select name="isActive" id="isActive">
                 <option value="-1"> Select Active</option>
                 <option value="0">False</option>
                 <option value="1">True</option> 
             </select>
         </td>
    </tr>
    <tr>
          <td>  FIRST_NAME:</td>
          <td>
               <input name="firstName" id="firstName" type="text" >
               
          </td>
    </tr>
    <tr>
        <td>  LAST_NAME:</td>
        <td>
              <input name="lastName" id="lastName" type="text" >
        </td>
    </tr>
     <tr >
        <td>Office Type:</td>
            <td><select name="officeType"  id="officeType" onchange="getRelativeIds(this.value)">
                    <option value="all"> All</option>
                    <%
                        try {
                            st = con.createStatement();
                            rs = st.executeQuery("select office_type_code,office_type_name from Admin_Hierarchy");
                            while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("office_type_code")%>" ><%=rs.getString("office_type_name")%></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>

                </select>
            </td>
        </tr>
       
        <tr >
            <td>Select Office:</td>
            <td><select name="officeTypeId"  id="officeTypeId">
                    <option value="-1"> All</option>
                </select></td>
        </tr>
    <tr>
        <td>          </td>
        <td>
            <input type="button" value="Update" onclick="updateUsers()">
        </td>
    </tr>
  </table>
    </form>
