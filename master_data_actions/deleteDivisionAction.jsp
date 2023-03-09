<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection con = null;
            Statement st = null;
            String sql = null;
            String divisionName = null;
            try {
           divisionName = request.getParameter("divisionId").trim();
                System.out.println(divisionName);
                if ( divisionName.equals("")) {
                    System.out.println("division Name Should not be Empty :" + divisionName);
                } else {
                    con = new DBUtil().getConnection();
                    st = con.createStatement();
                    sql = "delete  from  division where divisionid=" + divisionName+"";
                    if (st.executeUpdate(sql) > 0) {
                        out.println("division deleted Successfully : "+ divisionName);
                    } else {
                        out.println("division deletion Failed, Try Again :"+ divisionName);
                    }//end else
                }//end else
            } catch (Exception e) {
                if ( divisionName == null) {
                    out.println("division Name Should Not be null");
                } else {
                    out.println(e.getMessage());
                }
            }//end catch
%>