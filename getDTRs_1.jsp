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
       String feeder = request.getParameter("emp_id").toString();
        System.out.println("feeder id ---->"+feeder);
        String data ="Select dtr";

        PreparedStatement pstmt = con.prepareStatement("select dtrid,dtrname from dtr where feederId="+feeder+" order by dtrname");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("dtrid")+"_"+rs.getString("dtrname");

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