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
        
        String data ="";
        String modemId=request.getParameter("modem_id");

        PreparedStatement pstmt = con.prepareStatement("select modem_serial_no,mobile_no,imei_no,static_ip from modem where modem_id="+modemId);
        rs = pstmt.executeQuery();
        
        if(rs.next())
         data = data +","+rs.getString("modem_serial_no")+","+rs.getString("mobile_no")+","+rs.getString("imei_no")+","+rs.getString("static_ip");

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