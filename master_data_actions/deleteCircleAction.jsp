<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String circleName = null;
            try {
                circleName = request.getParameter("circleId").trim();
                System.out.println(circleName);
                if (circleName.equals("")) {
                    System.out.println("circle Name Should not be Empty :" + circleName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from circle where circleid=" + circleName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("circle deleted Successfully : "+ circleName);
                    } else {
                        out.println("circle deletion Failed, Try Again :"+ circleName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( circleName == null) {
                    out.println("circle Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>