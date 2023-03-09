<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%
Connection con = null;
try{
String mailid=request.getParameter("mailid");
con= new DBUtil().getConnection();
String event_codes="";
ResultSet rs=con.prepareStatement("select event_code from critical_events where emailid='"+mailid+"'").executeQuery();
while(rs.next()){
    event_codes=event_codes+rs.getString(1)+",";
}
out.println(event_codes);
System.out.println("events --->"+event_codes);
}catch(Exception e){
    e.printStackTrace();
}
finally{
    con.close();
}
%>