<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>


<form>

    <table align="center" bgcolor="#E0ECF8" cellpadding="5" cellspacing="5">
        <tr><th colspan="2"><h2> UserType</h2></th></tr>

        <tr>

            <td>USER_TYPE_NAME:</td>
            <td>
                <select name="deleteUserTypeName" id="UserTypeName" >
                    <option value="-1">Select UserTypeName</option>
                    <%
                        Connection con14 = new DBUtil().getConnection();
                        Statement st14 = null;
                        ResultSet rs14 = null;
                        try {
                            st14 = con14.createStatement();
                            rs14 = st14.executeQuery("select * from user_types");
                            while (rs14.next()) {
                    %>
                    <option value="<%=rs14.getString("user_type_id")%>" ><%=rs14.getString("user_type_name")%></option>
                    <%
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            con14.close();
                        }
                    %>
                </select>
            </td>
        </tr>
        <tr>
            <td>   </td>
            <td>
                <input type="button" value="Delete" onclick="deleteUserTypeAction()">
            </td>
        </tr>



    </table>


</form>



