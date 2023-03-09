<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement pst = null;
            String sql = null;
            String userTypeName = null;
            
            try {
                 
                userTypeName = request.getParameter("userTypeName").trim();
              

                con = new DBUtil().getConnection();
                sql = "insert into user_types(user_type_name) values(?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, userTypeName);            

                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("User Type  Added Successfully : " + userTypeName);
                } else {
                    out.println("User Type  Added Failed, Try Again :" + userTypeName);
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