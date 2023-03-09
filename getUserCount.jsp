<%@page import="in.amitech.db.SessionCounter"%>
<%
try{
     SessionCounter counter = (SessionCounter) session.getAttribute("counter");
     out.println(counter.getActiveSessionNumber());
}   catch(Exception e){
    //response.sendRedirect("login2.jsp");  
} 
%>

