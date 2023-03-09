<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%
Connection con = null;
    try {
        String mailid = request.getParameter("mailid");
        con = new DBUtil().getConnection();
        con.prepareStatement("delete from critical_events where emailid='" + mailid + "'").execute();
        out.println("Critical Events deleted for this mail");
    } catch (Exception e) {
        e.printStackTrace();
        out.println(e.getMessage());
    }
    finally{
        con.close();
    }
%>