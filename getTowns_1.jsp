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
        String subdivisionname = request.getParameter("emp_id").toString();
        System.out.println("subdivisionname---->"+subdivisionname);
        String data ="Select Town";

        PreparedStatement pstmt = con.prepareStatement("select * from town where subdivid="+subdivisionname+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("townid")+"_"+rs.getString("townname");

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