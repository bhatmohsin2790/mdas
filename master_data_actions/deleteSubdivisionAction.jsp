<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String subName = null;
            try {
            subName = request.getParameter("subdivisionId").trim();
               
                if ( subName.equals("")) {
                    System.out.println("Subdivision Name Should not be Empty :" +  subName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  subdivision where subdivid=" +  subName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("subdivision deleted Successfully : "+ subName);
                    } else {
                        out.println("subdivision deletion Failed, Try Again :"+ subName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( subName == null) {
                    out.println("subdivision Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>