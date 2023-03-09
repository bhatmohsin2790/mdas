<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            PreparedStatement pst = null;
            String sql = null;
          String  userTypeId;
          String newName;
            
            try {
                 
                userTypeId = request.getParameter("userTypeName").trim();
                newName=request.getParameter("newUT").trim();
              

                con = new DBUtil().getConnection();
                sql = "update user_types set user_type_name=? where user_type_id=?";
                pst = con.prepareStatement(sql);
                pst.setString(1, newName);            
                pst.setString(2,userTypeId);

                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("User Type  changed to : " + newName);
                } else {
                    out.println("User Type updation Failed, Try Again :" + newName);
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