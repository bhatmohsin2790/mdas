<%@ page session="false" %>
<%@page import="in.amitech.crypt.EncryptPassword"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs=null;
            String sql = null;
            String userId = null;
           String result="";
            try {

                userId = request.getParameter("userId").trim();             

                con = new DBUtil().getConnection();
                sql = "select * from users where user_id='"+userId+"'";
                pst = con.prepareStatement(sql);             
               rs=pst.executeQuery();
               if(rs.next())
               {
                   result=result+","+rs.getString("user_type")+","+rs.getString("is_active")+","+(rs.getString("first_name")==null?" ":rs.getString("first_name"))+","+(rs.getString("last_name")==null?" ":rs.getString("last_name"))+","+rs.getString("office_id")+","+rs.getString("office_type_id");
                   
               }
               out.println(result);
           System.out.println("user details --->"+result);
            } catch (Exception e) {
                System.out.println("Error----------------->" + e.getMessage());
                e.printStackTrace();
                out.println(e.getMessage());
            } finally {
                if (con != null) {
                    con.close();
                }
            }//end finally

%>