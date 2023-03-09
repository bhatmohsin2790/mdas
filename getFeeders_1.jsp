<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="in.amitech.db.DBUtil"%>

<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        String ss = request.getParameter("emp_id").toString();
        System.out.println("ss id ---->"+ss);
        String data ="Select feeder";

        PreparedStatement pstmt = con.prepareStatement("select feederid,feedername from feeder where substationId="+ss+" order by feedername");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("feederid")+"_"+rs.getString("feedername");

       // data = data +":abc:def";
        out.println(data);
        System.out.println("data is "+data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>