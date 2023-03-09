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
        String dtrId = request.getParameter("emp_id").toString();

        String data ="";

        PreparedStatement pstmt = con.prepareStatement("select * from dtr where dtrid="+dtrId+"");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +rs.getString("dtr_capacity");

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