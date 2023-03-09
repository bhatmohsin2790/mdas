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
        String discom = request.getParameter("emp_id").toString();
        System.out.println("discom---->"+discom);
        String data ="0_Select Zone";

        PreparedStatement pstmt = con.prepareStatement("select * from zone where discom_id="+discom+"");
        rs = pstmt.executeQuery();
        while(rs.next()){
            data = data +":"+rs.getString("zoneid")+"_"+rs.getString("zonename");
            }
       // data = data +":abc:def";
        out.println(data);
        System.out.println("data is "+data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally
    {
        con.close();
    }
%>