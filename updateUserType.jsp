<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*" %>
 <form>

 <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
     <tr><th colspan="2"><h2> UserType</h2></th></tr>
     
         <tr>
             <td>USER_TYPE_NAME:</td>
             <td>
                 <select name="userTypeName" id="userTypeName" onchange="document.getElementById('newUT').value=this.options[selectedIndex].text">
                     <option>Select UserType</option>
                     <%
                                Connection Updatecon = new DBUtil().getConnection();
                                Statement Updatest = null;
                                ResultSet Updaters = null;

                                try
				{
                                    Updatest = Updatecon.createStatement();
                                    Updaters = Updatest.executeQuery("select * from user_types");

                                    while (Updaters.next())
				    {
                    %>
                       <option value="<%=Updaters.getString("user_type_id")%>" ><%=Updaters.getString("user_type_name")%></option>
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
             <td> NEW NAME </td>
             <td> <input type="text" name="Uptext" id="newUT"></td>
         </tr>
           <tr>
               <td>   </td>
               <td>
                   <input type="button" value="Modify" onclick="updateUserTypeAction()">
               </td>
           </tr>



</table>
</form>
