<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%
        Statement st=null,st1=null,st2=null;
        ResultSet rs=null,rs1=null,rs2=null;
        Connection con=null;
        String sql="",sql1="",sql2=null;
        String user_type_name=request.getParameter("adduserTypeName");
            try
            {
                con=new in.amitech.db.DBUtil().getConnection();
                sql="insert into user_types(user_type_name) values('"+user_type_name+"')";
                st=con.createStatement();
                rs=st.executeQuery(sql);
                out.println(user_type_name+" Is Inserted into Database Successfully...!");

            }
            catch(Exception e)
            {
                out.println(user_type_name+" Is already in Database..!");
                
            }
            finally{
                con.close();
            }




%>
