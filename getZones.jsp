
<%@ page session="false" %><%@ include file="getConnection.jsp"%>

<%!
  PreparedStatement pstmt = null;
  ResultSet rs = null;
%>
<%
    try{
        String data ="Select Zone";

        pstmt = con.prepareStatement("select * from zone");
        rs = pstmt.executeQuery();
        while(rs.next())
            data = data +":"+rs.getString("zoneid")+"_"+rs.getString("zonename");

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