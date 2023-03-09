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
        String htId = request.getParameter("emp_id").toString();
        System.out.println("ht---->"+htId);
        String data ="";

        PreparedStatement pstmt = con.prepareStatement("select * from meter where htconsumerid="+htId+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +rs.getString("meterid")+"_"+rs.getString("meter_serial_no");

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