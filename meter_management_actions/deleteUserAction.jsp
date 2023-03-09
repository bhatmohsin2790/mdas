<%@ page session="false" %>
<%@page import="in.amitech.crypt.EncryptPassword"%>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement pst = null;
            String sql = null;
            String userId = null;
            
            try {

                userId = request.getParameter("userId").trim();
                               con = new DBUtil().getConnection();
                sql = "delete from users where user_id='"+userId+"'";
                pst = con.prepareStatement(sql);
                       
               System.out.println("sql query is--->"+sql);
                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("User  Deleted Successfully : " + userId);
                } else {
                    out.println("User  Deletion Failed, Try Again :" + userId);
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