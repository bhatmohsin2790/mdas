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
        String sectionname = request.getParameter("emp_id").toString();
        System.out.println("sectionname---->"+sectionname);
        String data ="Select substation";

        PreparedStatement pstmt = con.prepareStatement("select * from substation where subdivid="+sectionname+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("substationid")+"_"+rs.getString("substationname");

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