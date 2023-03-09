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
        String divisionname = request.getParameter("emp_id").toString();
        System.out.println("divisionname---->"+divisionname);
        String data ="Select Sub-Division";

        PreparedStatement pstmt = con.prepareStatement("select * from subdivision where divisionid="+divisionname+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("subdivid")+"_"+rs.getString("subdivname");

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