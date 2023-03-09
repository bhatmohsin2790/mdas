<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%
    Connection con = null;
    try {
        PreparedStatement ps = null;
        String sql = "";
        ResultSet rs = null;

        String values = request.getParameter("values").trim();
        String mail_ids = request.getParameter("mail_ids");
        if (mail_ids.contains("\n")) {
            mail_ids = mail_ids.replaceAll("\n", "");
        }

        //System.out.println("values---"+values+"----mail ids-----"+mail_ids.split(",")[2]);
        con = new DBUtil().getConnection();
        sql = "insert into CRITICAL_EVENTS(EVENT_CODE,EMAILID) values(?,?)";
        ps = con.prepareStatement(sql);
        for (int i = 0; i < values.split(",").length; i++) {
            //System.out.println(values.split(",")[i]+"----"+mail_ids);
            ps.setString(1, values.split(",")[i]);
            ps.setString(2, mail_ids);
            ps.execute();
        }
        out.println("Submitted Successfully...");
    } catch (Exception e) {
        //e.printStackTrace();
        out.println("Error,Try again..." + e.getMessage());
    } finally {
        con.close();
    }
%>