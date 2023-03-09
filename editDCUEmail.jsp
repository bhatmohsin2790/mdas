<%@ page session="false" %>
<%@page import="java.net.*" %>
<%@ include file="getConnection1.jsp"%>
<%@page import="java.sql.*"%>
<%
    try {
        String substationId = null;
        String dynamicIp = null;
        String sql = "";
        PreparedStatement ps = null;
        ResultSet rs = null;

        substationId = request.getParameter("ssId");
        sql = "select dynamic_ip from substation_ip where substationid=" + substationId + " order by LOG_TIME_STAMP desc";
        System.out.println("ON_DEMAND Query Configuration = " + sql);
        ps = con.prepareStatement(sql);
        rs = ps.executeQuery();
        if (rs.next()) {
            dynamicIp = rs.getString(1);
            System.out.println("dynamicIp = " + dynamicIp);
            out.println(dynamicIp);
        } else {
            out.println("<h3>IP is not available for this substation </h3>");
        }


    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error, Try again...</h3>" + e.getMessage());
    } finally {
        con.close();
    }
%>