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

                userId = request.getParameter("userId").trim();
                role = request.getParameter("role").trim();
                

                con = new DBUtil().getConnection();
                sql = "insert into user_roles(user_id,office_id) values(?,?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, userId);
                pst.setString(2, role);
              


                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("User  Privileges Added Successfully : " + userId);
                } else {
                    out.println("User  Privileges Adding Failed, Try Again :" + userId);
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