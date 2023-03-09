<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
            Connection con = null;
            PreparedStatement st = null;
            String locid = null;
            locid = request.getParameter("locid").trim();
            con = new DBUtil().getConnection();
            String query = "  delete from meterlocation where locationid = " + locid + "  ";
            st = con.prepareStatement(query);
            if (st.executeUpdate() > 0) {
                out.println("Location Id deleted Successfully : " + locid);
            } else {
                out.println("Location Id deleted Failed, Try Again :" + locid);
            }//end else
            con.close();

%>