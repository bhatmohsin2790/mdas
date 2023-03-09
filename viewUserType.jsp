<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*" %>
 <form action="">

    <table border="1" align="center" bgcolor="#E0ECF8" cellpadding="1" cellspacing="1">
     <tr><th colspan="2"><h2> UserTypes</h2></th></tr>
     <tr>
        
         <td><b>USER_TYPE_NAME</b></td>
         </tr>
         <%
                                Connection conView = new DBUtil().getConnection();
                                Statement stView = null;
                                ResultSet rsView = null;
                                
                                try
				{
                                    stView = conView.createStatement();
                                    rsView = stView.executeQuery("select * from user_types");

                                    while (rsView.next())
				    {
         %>
                                     <tr>
                                       
                                         <td><%=rsView.getString("user_type_name")%></td>
                                     </tr>
         <%

                                    }

                                }
				catch (Exception e)
                                {
                                    e.printStackTrace();
                                }
         %>
    </table>
</form>


    
