<%@page import="ami.util.Utilities"%>
<%@page import="java.sql.Connection,java.sql.Statement,java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="in.amitech.db.DBUtil"%>
<%
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    String result="";
try{
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
  List<String> tot_meters=new ArrayList();
  List<String> tot_comm_meters=new ArrayList();
  List<String> comm_meters=new ArrayList();
  Map<String,String> rawdataMap=new HashMap();
  Map<String,String> d2Map=new HashMap();
  Map<String,String> b3Map=new HashMap();
  Map<String,String> b5Map=new HashMap();
  Map<String,String> d4Map=new HashMap();
  Map<String,String> d5Map=new HashMap();
  con = new DBUtil().getConnection();
  String dates="";
          //"'17-12-2018','18-12-2018','19-12-2018','20-12-2018','21-12-2018','22-12-2018','23-12-2018'";
  String str=sdf.format(new java.util.Date());
  for(int i=0;i<7;i++){      
      
      str=new Utilities().previous_Day(str);
      dates=dates+",'"+str+"'";
  }
  dates=dates.substring(1);
  System.out.println(dates);
  String query="";
//          "select comm_date,sum(cdcrcsuccess+ipcrcsuccess),sum(d2),sum(b3),sum(b5),sum(d4),sum(d5) from  "
//              + "comm_status where comm_date in("+dates+") group by comm_date";
  query="select comm_date,count(* ) from  comm_status where comm_date in("+dates+") and cast(regexp_replace(cdcrcsuccess, '[^0-9]+', '') as number)+cast(regexp_replace(ipcrcsuccess, '[^0-9]+', '') as number) >0 group by comm_date";
  rs=con.prepareStatement(query).executeQuery();
       while(rs.next()){
           rawdataMap.put(rs.getString("comm_date"),rs.getString(2));
       }
query="select comm_date,count(* ) from  comm_status where comm_date in("+dates+") and d2 >0 group by comm_date";
  rs=con.prepareStatement(query).executeQuery();
       while(rs.next()){
           d2Map.put(rs.getString("comm_date"),rs.getString(2));
       }
query="select comm_date,count(* ) from  comm_status where comm_date in("+dates+") and b3 >0 group by comm_date";
  rs=con.prepareStatement(query).executeQuery();
       while(rs.next()){
           b3Map.put(rs.getString("comm_date"),rs.getString(2));
       }
query="select comm_date,count(* ) from  comm_status where comm_date in("+dates+") and b5 >0 group by comm_date";
  rs=con.prepareStatement(query).executeQuery();
       while(rs.next()){
           b5Map.put(rs.getString("comm_date"),rs.getString(2));
       }
query="select comm_date,count(* ) from  comm_status where comm_date in("+dates+") and d4 >0 group by comm_date";
  rs=con.prepareStatement(query).executeQuery();
       while(rs.next()){
           d4Map.put(rs.getString("comm_date"),rs.getString(2));
       }
query="select comm_date,count(* ) from  comm_status where comm_date in("+dates+") and d5 >0 group by comm_date";
  rs=con.prepareStatement(query).executeQuery();
       while(rs.next()){
           d5Map.put(rs.getString("comm_date"),rs.getString(2));
       }       
       
    result=dates;    
        for(String s:dates.split(",")){
            if(rawdataMap.containsKey(s.replaceAll("'", ""))){
                result=result+";"+rawdataMap.get(s.replaceAll("'", ""));
            }else{
                result=result+";0";
            }
            
            if(d2Map.containsKey(s.replaceAll("'", ""))){
                result=result+","+d2Map.get(s.replaceAll("'", ""));
            }else{
                result=result+",0";
            }
            
            if(b3Map.containsKey(s.replaceAll("'", ""))){
                result=result+","+b3Map.get(s.replaceAll("'", ""));
            }else{
                result=result+",0";
            }
            
            if(b5Map.containsKey(s.replaceAll("'", ""))){
                result=result+","+b5Map.get(s.replaceAll("'", ""));
            }else{
                result=result+",0";
            }
            
            if(d4Map.containsKey(s.replaceAll("'", ""))){
                result=result+","+d4Map.get(s.replaceAll("'", ""));
            }else{
                result=result+",0";
            }
            
            if(d5Map.containsKey(s.replaceAll("'", ""))){
                result=result+","+d5Map.get(s.replaceAll("'", ""));
            }else{
                result=result+",0";
            }
        }
    out.print(result);
    //System.out.print(result);
}catch(Exception e){
    e.printStackTrace();
}
    %>
