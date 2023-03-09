<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement pst = null;
            String sql = null;
            String userId = null;
            String role = null;
           
            try {
                 int counter=0;
                userId = request.getParameter("userId").trim();
                role = request.getParameter("roles");
                System.out.println("roles are--->"+role);
               String roles[]=role.split(",");
               System.out.println("roles lenght-->"+roles.length);
                con = new DBUtil().getConnection();
                sql = "delete from user_roles where user_id=?";
                pst = con.prepareStatement(sql);
                pst.setString(1, userId);   
                pst.executeUpdate();
                for(int i=0;i<roles.length;i++)
               {
                sql = "insert into user_roles(user_id,office_id) values(?,?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, userId);
                pst.setString(2, roles[i]);
                pst.executeUpdate();
                counter++;
                 }


             
                if (counter==roles.length) {
                    out.println("User  Privileges updated Successfully : " + userId);
                } else {
                    out.println("User  Privileges updation Failed, Try Again :" + userId);
                }//end else

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