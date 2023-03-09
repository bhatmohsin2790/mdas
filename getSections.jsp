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
        String data ="0_Select Town";

        PreparedStatement pstmt = con.prepareStatement("select * from town where subdivid='"+subdivid+"'");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("townid")+"_"+rs.getString("townname");

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