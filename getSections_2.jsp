<%@ page session="false" %>
<%@ include file="getConnection.jsp"%>

<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        String subdivid = request.getParameter("emp_id").toString();
        System.out.println("SubDivision id---->"+subdivid);
        String data ="0_Select Section";

        PreparedStatement pstmt = con.prepareStatement("select * from section where subdivid='"+subdivid+"'");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("sectionid")+"_"+rs.getString("sectionname");

       // data = data +":pqr:stu:vwx";
        out.println(data);
    }catch(Exception e)
    {
        e.printStackTrace();
    }
    finally{
        con.close();
    }
%>