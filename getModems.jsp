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
        
        String data ="Select modem";

        PreparedStatement pstmt = con.prepareStatement("select modem_id,modem_serial_no from modem where is_dcu=1");
        rs = pstmt.executeQuery();
        System.out.println("this is maruthi");
        while(rs.next())
         data = data +":"+rs.getString("modem_id")+"_"+rs.getString("modem_serial_no");

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