<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*" %>
<html>
    <head>
        <title></title>
       
    </head>
    <body>
        <form action="InsertUserPrevileges.jsp">
            
<table align="center" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5">
   <tr><th colspan="4"><h2> User Privileges</h2></th></tr>
    <tr><td>
           
            USER_ID:</td><td>
            <select name="userId" id="userId" >
                <option value="-1">Select UserId</option>
                <%
                                Connection con = new DBUtil().getConnection();
                                Statement st = null;
                                ResultSet rs = null;                             
                                try
                                {
                                    st = con.createStatement();
                                    rs= st.executeQuery("select * from users");                                    
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
                                finally{
                                    con.close();
                                }
               %>
               
            </select></td></tr>
    <tr>
        <td>Privileges</td>
        <td>
             <select name="privileges" id="privileges" >
                <option value="-1">Select Privileges</option>
                <%
                                                       
                                try
                                {
                                    st = con.createStatement();
                                    rs= st.executeQuery("select * from master_data");                                    
                                    while (rs.next())
                                    {
                                        %>
                                               <option value="<%=rs.getString("office_id")%>" ><%=rs.getString("office_name")+"("+rs.getString("office_type")+")"%></option>
                                       <%
                                    }

                                }
	             catch (Exception e)
                                {
                                    e.printStackTrace();
                                }
               %>
        </td>
    </tr>
   
<tr><td></td><td align="center">

        <input type="button" value="ADD" onclick="add();"></td></tr>          
               

</table>
        </form>
    </body>
</html>
