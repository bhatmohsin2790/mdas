<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    String loginID = "";
    String userType = "";
    boolean loginStatus = true;
    try {
        session = request.getSession(false);
        loginID = request.getHeader("USER_LOGINID");
        userType = request.getHeader("USER_TYPE");
        session.setAttribute("userid", loginID);
        session.setAttribute("user_type", userType);
        session.setAttribute("datasource", "");
        session.setAttribute("IDAM", "true");
        loginStatus = verifyUserCredentials(request,loginID);
		 
    } catch (Exception e) {
        loginStatus = false;
    }//end catch
    System.out.println(loginID + ", Login Status :" + loginStatus);
    if (loginStatus) {
        response.sendRedirect(response.encodeRedirectURL("dataReportsHome.jsp"));
    } else {
        //response.sendRedirect(response.encodeRedirectURL("login2.jsp"));
		response.sendRedirect(response.encodeRedirectURL("errorPage.jsp?message='UnAuthorized Access...please contact Administrator'"));
    }//end else
%>

<%!
    public boolean verifyUserCredentials(HttpServletRequest request,String loginID) {
        Connection connection = null;
        String target = null;
        Statement statement = null;
        ResultSet rs = null;
        String sql = null;
        boolean status = true;
         HttpSession httpsession = null;
        try {
             httpsession = request.getSession(false);
            connection = new DBUtil().getConnection();
            statement = connection.createStatement();

            sql = "select * "
                    + "from users us where us.user_id='" + loginID + "' "
                    + "and us.is_active=1";
System.out.println("---->"+sql);
            rs = statement.executeQuery(sql);
            if (rs.next()) {
                httpsession.setAttribute("office_type", rs.getString("office_id")==null?"all":rs.getString("office_id"));
                httpsession.setAttribute("office_type_id", rs.getString("office_type_id")==null?"-1":rs.getString("office_type_id"));
                System.out.println("SSO Login User Found in Database :" + loginID);
				 //-----------code to add login time into db
              if(status){
                  SimpleDateFormat sdf= new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                  rs=connection.prepareStatement("update users set lastlogin='"+sdf.format(new java.util.Date())+"' where user_id='"+loginID+"'").executeQuery();
                  
              }
            //--------------------------------------------
            } else {
                System.out.println("SSO Login User Not Found in Database :" + loginID);
                status = false;
            }
        } catch (Exception ex) {
            System.err.println("DB Error :" + ex.getMessage());
            status = false;
        }
        try {
            if (connection != null) {
                connection.close();
            }
        } catch (Exception ex) {
            //nothing to do
        }//end catch
        return status;
    }
%>