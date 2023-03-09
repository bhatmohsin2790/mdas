<%-- <%@page import="org.GNOME.Accessibility.Value"%> --%>
<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.*" %>

<form name="deluserprvlgs" action="">

<table align="center" bgcolor="#E0ECF8"  cellpadding="5" cellspacing="5">
    <tr><th colspan="4"><h2> User Privileges</h2></th></tr>
    <tr>
        <td>USER_ID:</td>
        <td>
            <select name="userId" id="userId" onchange="getRoles(this.value);">
                <option>Select UserId</option>
                <%
                                Connection del_con = new DBUtil().getConnection();
                                Statement del_st = null;
                                ResultSet del_rs = null;
                              

                                try
				{
                                    del_st = del_con.createStatement();
                                    del_rs = del_st.executeQuery("select distinct(user_id) from user_roles");

                                    while (del_rs.next())
				    {
                %>
                                             <option value="<%=del_rs.getString("user_id")%>"><%=del_rs.getString("user_id")%></option>
                <% 

                                    }

                                }
	            catch (Exception e)
                                {
                                   // e.printStackTrace();
                        
                                }
                %>
          </select>
        </td>
    </tr>
    
    <tr>
        <td>Assigned Privileges</td>
        <td><textarea cols="23" rows="3"  id="roles"></textarea></td>
    </tr>
    <tr id="newPrivileges" style="visibility: hidden" >
        <td> New Privileges</td>
        <td>
            <select name="privileges" id="privileges" multiple="true" style="width: 200px;">
                <option value="-1">Select Privileges</option>
                <%
                   Connection con = new DBUtil().getConnection();
                                Statement st = null;
                                ResultSet rs = null;        
                                                       
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
    <tr><td></td>
        <td>
            <input type="button" value="Edit" onclick="editUserprvlgs()">
        </td>
    </tr>
</table>


        </form>
     