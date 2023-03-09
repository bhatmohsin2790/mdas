<%@ page session="false" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
            Connection condma = null;
            PreparedStatement stdma = null;
            String modemid = null;
            modemid = request.getParameter("modem_id").trim();
            condma = new DBUtil().getConnection();
            String query = "  delete from modem where modem_id = " + modemid + "  ";
            stdma = condma.prepareStatement(query);
            if (stdma.executeUpdate() > 0) {
                out.println("Modem deleted Successfully ");
            } else {
                out.println("Modem  deleted Failed, Try Again ");
            }//end else
            condma.close();
%>