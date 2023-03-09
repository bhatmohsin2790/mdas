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
    try
    {
        String zonename = request.getParameter("emp_id").toString();
        System.out.println("zonename---->"+zonename);
        String data ="0_Select Circle";
        PreparedStatement pstmt = con.prepareStatement("select * from circle where zoneid="+zonename+"");
        rs = pstmt.executeQuery();
        while(rs.next())
        {
            data = data +":"+rs.getString("circleid")+"_"+rs.getString("circlename");
        }
        out.println(data);
        System.out.println("data is "+data);
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>