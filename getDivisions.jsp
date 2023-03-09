<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>

<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        String substationname = request.getParameter("emp_id").toString();
        System.out.println("substationname---->"+substationname);
        String data ="Select Division";

        PreparedStatement pstmt = con.prepareStatement("select * from division");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("divisionid")+"_"+rs.getString("divisionname");

       // data = data +":abc:def";
        out.println(data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>