<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="in.amitech.db.DBUtil"%>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
 int tot_amrcount=0,tot_dcucount=0,tot_htcount=0;
 int amrcount=0,dcucount=0,htcount=0;
try{
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MMM-yy");
  
  con = new DBUtil().getConnection();
  String query="select count(distinct(meter_no)) from meter_comm_track where d2_timestamp like '"+sdf.format(new java.util.Date()).toUpperCase()+"%' and meter_no in(select meter_serial_no from meter where dtrid is not null) ";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              amrcount=rs.getInt(1);      
               }
           
 query="select count(distinct(meter_no)) from meter_comm_track where d2_timestamp like '"+sdf.format(new java.util.Date()).toUpperCase()+"%' and meter_no in(select meter_serial_no from meter where feederid is not null) ";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              dcucount=rs.getInt(1);           
               }
        
 query="select count(distinct(meter_no)) from meter_comm_track where d2_timestamp like '"+sdf.format(new java.util.Date()).toUpperCase()+"%' and meter_no in(select meter_serial_no from meter where htconsumerid is not null) ";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              htcount=rs.getInt(1);             
               } 
//-----------------------------------------------------------------
query="select count(meter_serial_no) from meter where dtrid is not null";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              tot_amrcount=rs.getInt(1);      
               }
           
 query="select count(meter_serial_no) from meter where feederid is not null";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              tot_dcucount=rs.getInt(1);           
               }
        
 query="select count(meter_serial_no) from meter where htconsumerid is not null ";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              tot_htcount=rs.getInt(1);             
               } 
    
    out.println(amrcount+"/"+tot_amrcount+","+dcucount+"/"+tot_dcucount+","+htcount+"/"+tot_htcount);
    //System.out.println(amrcount+","+dcucount+","+htcount);
    
}catch(Exception e){
    e.printStackTrace();
}
finally{
    try{
        if(con!=null) con.close();
    }catch(Exception e){}
}
    %>
