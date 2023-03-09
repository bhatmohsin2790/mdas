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
            String password = null;
            String userType = null;
            String isActive = null;
            String firstName = null;
            String lastName = null;
             String officeType = null;
            String officeTypeId = null;
            try {

                userId = request.getParameter("userId").trim();
                password = request.getParameter("password").trim();
                userType = request.getParameter("userType").trim();
                isActive = request.getParameter("isActive").trim();
                firstName = request.getParameter("firstName").trim();
                lastName = request.getParameter("lastName").trim();
                officeType = request.getParameter("officeType").trim();
                officeTypeId = request.getParameter("officeTypeId").trim();

                con = new DBUtil().getConnection();
                sql = "insert into users(user_id,password,user_type,is_active,"
                        + "first_name,last_name,office_id,office_type_id) "
                        + "values(?,?,?,?,?,?,?,?)";
                pst = con.prepareStatement(sql);
                pst.setString(1, userId);
                pst.setString(2, new EncryptPassword().encrypt(password));
                pst.setString(3, userType);
                pst.setString(4, isActive);
                pst.setString(5, firstName);
                pst.setString(6, lastName);
                pst.setString(7, officeType);
                pst.setString(8, officeTypeId);


                int result = pst.executeUpdate();
                if (result > 0) {
                    out.println("User  Added Successfully : " + userId);
                } else {
                    out.println("User  Added Failed, Try Again :" + userId);
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