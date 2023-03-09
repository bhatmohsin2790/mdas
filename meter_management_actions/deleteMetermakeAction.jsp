<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%
            Connection con = null;
            PreparedStatement st = null;
            String metermake = null;
            metermake = request.getParameter("metermakeId").trim();
            con = new DBUtil().getConnection();
            String query = "  delete from metermake where metermakeid = " + metermake + "  ";
            st = con.prepareStatement(query);
            if (st.executeUpdate() > 0) {
                out.println("Metermake Id deleted Successfully : " + metermake);
            } else {
                out.println("Metermake Id deleted Failed, Try Again :" + metermake);
            }//end else
            con.close();

%>