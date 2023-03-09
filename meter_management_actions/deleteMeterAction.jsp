<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
            Connection con = null;
            PreparedStatement st = null;
            String meterid = null;
            
            meterid = request.getParameter("meterid").trim();
            con = new DBUtil().getConnection();
            String query = "  delete from meter where meterid = " + meterid + "  ";
            st = con.prepareStatement(query);
            if (st.executeUpdate() > 0) {
                out.println("Meter Id deleted Successfully : " + meterid);
            } else {
                out.println("Meter Id deleted Failed, Try Again :" + meterid);
            }//end else
            con.close();

%>