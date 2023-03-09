<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String feederName = null;
            try {
              feederName = request.getParameter("feederId").trim();
                System.out.println(feederName);
                if (feederName.equals("")) {
                    System.out.println("feeder Name Should not be Empty :" + feederName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  feeder where feederid=" +  feederName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("feeder deleted Successfully : "+ feederName);
                    } else {
                        out.println("feeder deletion Failed, Try Again :"+ feederName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( feederName == null) {
                    out.println("feeder Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>