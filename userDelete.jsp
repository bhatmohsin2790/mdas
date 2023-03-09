<%@ include file="getConnection.jsp"%>
<%
String user_id=request.getParameter("userId");
String sql="";
    try
    {
        ResultSet rs=null;
        Statement st=null;
        sql="delete from users where user_id='"+user_id+"'";
        st=con.createStatement();
        int del=st.executeUpdate(sql);
        if(del>0)
            out.println("UserId :"+user_id+" Deleted Successfully....!");
        else
            out.println("UserId :"+user_id+ "is not deleted");
    }
    catch(Exception e)
    {
        out.println(sql+"------->"+e);
        
    }
%>
