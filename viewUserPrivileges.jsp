<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*" %>

<form name="viewprvlgs">

<table border="1" align="center" bgcolor="#EEEEEE" >
    
    <caption>User Privileges</caption>
    
    <tr>
        <td><b>USER_ID</b></td>
        <td><b>Priviliged to Access</b></td>
        
    </tr>
    
<%
        Connection view_con = new DBUtil().getConnection();
        Statement view_st = null;
        ResultSet view_rs = null;

        try
        {
            view_st = view_con.createStatement();
            view_rs = view_st.executeQuery("select u.user_id,o.office_type,o.office_name from user_roles u,master_data o where u.office_id=o.office_id");

            while (view_rs.next())
            {
%>
<tr>
    
        <td><%=view_rs.getString("user_id")%></td>
        <td><%= view_rs.getString("office_name")+"("+view_rs.getString("office_type")+")" %></td>
       
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
    
