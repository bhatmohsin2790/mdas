<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="in.amitech.db.DBUtil"%>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
 int commCount=0,notcommCount=0,nevercommCount=0;
try{
  List<String> tot_meters=new ArrayList();
  List<String> tot_comm_meters=new ArrayList();
  List<String> comm_meters=new ArrayList();
  con = new DBUtil().getConnection();
  String query="select meter_serial_no from meter where (feederid is not null or dtrid is not null or htconsumerid is not null)";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              tot_meters.add(rs.getString(1).trim());       
               }
 query="select distinct(meter_no) from meter_comm_track where meter_no in(select meter_serial_no from meter where (feederid is not null or dtrid is not null or htconsumerid is not null)) and d2_timestamp is not null";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              tot_comm_meters.add(rs.getString(1).trim());       
               }
    SimpleDateFormat sdf=new SimpleDateFormat("dd-MMM-yy");       
 query="select meter_no from meter_comm_track where d2_timestamp like '"+sdf.format(new java.util.Date()).toUpperCase()+"%' and meter_no in(select meter_serial_no from meter where (feederid is not null or dtrid is not null or htconsumerid is not null))";
        stmt = con.createStatement();
        rs = stmt.executeQuery(query);       
           while(rs.next()){
              comm_meters.add(rs.getString(1).trim());       
               }           
    commCount=comm_meters.size();
    tot_meters.removeAll(tot_comm_meters);
    nevercommCount=tot_meters.size();
    tot_comm_meters.removeAll(comm_meters);
    notcommCount=tot_comm_meters.size();
    out.println(commCount+","+notcommCount+","+nevercommCount);
    System.out.println(commCount+","+notcommCount+","+nevercommCount);
}catch(Exception e){
    e.printStackTrace();
}
    %>
