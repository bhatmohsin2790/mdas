<%@ page session="false" %>
<%@page import="java.sql.*" %>
<%@page import="in.amitech.db.DBUtil"%>
 <%
 try{
    PreparedStatement ps=null;
    String sql="";
    ResultSet rs=null;

  String values=request.getParameter("values").trim();
  String mail_id=request.getParameter("mail");
 
  
  //System.out.println("values---"+values+"----mail ids-----"+mail_ids.split(",")[2]);
   Connection con = new DBUtil().getConnection();
   //deleting already existing critical events for this mail id 
   con.prepareStatement("delete from critical_events where emailid='"+mail_id+"'").execute();
   
   
   sql="insert into CRITICAL_EVENTS(EVENT_CODE,EMAILID) values(?,?)";
   ps=con.prepareStatement(sql);
   for(int i=0;i<values.split(",").length;i++){
       //System.out.println(values.split(",")[i]+"----"+mail_ids);
       ps.setString(1,values.split(",")[i]);
       ps.setString(2,mail_id);
       ps.execute();
  }
  out.println("Updated Successfully...");
    }
 catch(Exception e){
     e.printStackTrace();
     out.println("Error,Try again..."+e.getMessage());
}
%>