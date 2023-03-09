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
        String data ="Select HT";

        PreparedStatement pstmt = con.prepareStatement("select consumerid,consumername from ht_consumer where feederid="+feeder+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("consumerid")+"_"+rs.getString("consumername");

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