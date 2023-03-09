<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>

<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try
    {
        String divid = request.getParameter("emp_id").toString();
        System.out.println("Sub-Division Selected is ---->"+divid);
        String data ="0_Select Sub-Division";
        PreparedStatement pstmt = con.prepareStatement("select * from subdivision where divisionid='"+divid+"'");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("subdivid")+"_"+rs.getString("subdivname");   
        System.out.println("getsubdivisions data\t"+data);
        out.println(data);
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>