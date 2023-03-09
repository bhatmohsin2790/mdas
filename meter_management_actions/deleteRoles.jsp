<%@ page session="false" %>

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
                sql = "delete from user_roles where user_id=?";
                pst = con.prepareStatement(sql);
                pst.setString(1, userId);           
              
                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("User  Privileges deleted Successfully : " + userId);
                } else {
                    out.println("User  Privileges  deletion  Failed, Try Again :" + userId);
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