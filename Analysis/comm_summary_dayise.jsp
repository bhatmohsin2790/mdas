<%@page import="in.amitech.db.DBUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<style>
    .thstyle{
        background-color: #8FA1B5; 
        color:#FFFFFF;
        font-size:14px;
        border-left:1px solid #FFFFFF;
        text-decoration:none;
        font-family: monospace;
        border-bottom: 1px solid #FFFFFF;

    }
    .trbg{
        background-color: #E8EBE2;
        border-bottom: 1px solid #FFFFFF;
    }
    .tdbg{
        border-bottom: 1px solid #FFFFFF;
        border-left: 1px solid #FFFFFF;
    }
    #district_11kv_load tr  td {
        background-color: #E8EBE2;
        border-bottom: 1px solid #FFFFFF;
        border-left: 1px solid #FFFFFF;
    }
</style> 

<%
 Connection con=null;
try{
    String from=request.getParameter("from");
    String first=from;
    String to=request.getParameter("to");
    List<String> dates=new ArrayList();
    String datesStr="";
    dates.add(from);
    datesStr=datesStr+"'"+from.replaceAll("/", "-")+"'";
    SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
    while(!from.equals(to)){
        from=sdf.format(sdf.parse(from).getTime()+(2460*60*1000));
        datesStr=datesStr+",'"+from.replaceAll("/", "-")+"'";
        dates.add(from);
    }
    //datesStr=datesStr.substring(1);
    System.out.println(datesStr);
   

%>    
<div class="table-responsive">
0=NOT COMMUNICATING &nbsp;&nbsp;&nbsp;
1=COMMUNICATING &nbsp;&nbsp;&nbsp;
2=COMMUNICATING BUT NOT CONVERTING &nbsp;&nbsp;&nbsp;
3=PARTIAL DATA &nbsp;&nbsp;&nbsp;
    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="stdtable stdtablecb smallfont" id="dtable">
        <thead>        
        <th class="thstyle">Meter</th>        
        <%
            for(String date:dates){
                %>
               <th class="thstyle"><%=date%></th>
            <%}
          %>
        </thead>
        <tbody>
            
<%
     con = new DBUtil().getConnection();
    String sql="SELECT * FROM meter where (feederid is not null or htconsumerid is not null or dtrid is not null)";
    ResultSet rs=con.prepareStatement(sql).executeQuery();
    List<String> meters=new ArrayList();
        
    while(rs.next()){
        meters.add(rs.getString("meter_serial_no"));
    }
    System.out.println("Total meters -----------"+meters.size());
    Map<String,Map<String,Integer>> metersMap=new HashMap();
    
    sql="select * from comm_status where comm_date in ("+datesStr+")";
    
    rs=con.prepareStatement(sql).executeQuery();
    while(rs.next()){
        try{
        String meter=rs.getString("meter_serial_no");
        int status=-1;
        if(rs.getInt("d2")>0) status=1;
        if(rs.getInt("d2")==0){
            if(rs.getInt("CDCRCSUCCESS")>0 || rs.getInt("IPCRCSUCCESS")>0){ status=2;}
            else if(rs.getInt("CDCRCFAIL")>0 || rs.getInt("IPCRCFAIL")>0){ status=3;}
            else if(rs.getInt("CDCRCSUCCESS")==0 && rs.getInt("IPCRCSUCCESS")==0 && rs.getInt("CDCRCFAIL")==0 && rs.getInt("IPCRCFAIL")==0){ status=0;}
        }
        
        if(metersMap.containsKey(meter)){
            metersMap.get(meter).put(rs.getString("comm_date").replaceAll("-", "/"),status);
        }else{
            Map<String,Integer> map=new HashMap();
            map.put(rs.getString("comm_date").replaceAll("-", "/"),status);
            metersMap.put(meter,map);
        }
        }catch(Exception e){}
    }
   // System.out.println(metersMap);
    for(String meter:meters){         
          Map<String,Integer> map=metersMap.containsKey(meter)?metersMap.get(meter):new HashMap();
        %>
        <tr class="trbg">
            
            <td class="tdbg"><%=meter%></td>
            <%
            for(String date:dates){
               
                %>
                <td class="tdbg"><%=map.containsKey(date)?map.get(date):"NA"%></td>
            <%
             
            }
           %>
        </tr>
    <%}
}catch(Exception e){
 e.printStackTrace();
}
finally{
    try{
        if(con!=null) con.close();
    }catch(Exception e){}
}


%>
   </tbody>
  </table>
   

</div>