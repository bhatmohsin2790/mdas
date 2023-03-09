<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>
<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        String sectionid = request.getParameter("emp_id").toString();
        System.out.println("Section ID---->"+sectionid);
        String data ="0_Select Receiving Station";

       // PreparedStatement pstmt = con.prepareStatement("select * from substation where sectionid='"+sectionid+"'");
         PreparedStatement pstmt = con.prepareStatement("select * from substation where subdivid='"+sectionid+"'");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("substationid")+"_"+rs.getString("substationname");

       System.out.println("ss data is ---->"+data);
        out.println(data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>