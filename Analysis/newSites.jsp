<%@page import="FormBeans.HierarchyDetails"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.text.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="in.amitech.db.DBUtil"%>
<%@page import="ActionBeans.*"%>
<%@page import="FormBeans.AnalysisBean" %>
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
 String fromDate=request.getParameter("fromDate");
 String toDate=request.getParameter("toDate");
 
 ResultSet rs=null;
 Connection con=null;
 String sql="";
 
 
%>
<table width="100%" class="stdtable stdtablecb smallfont" id="dtable">
    <thead>
        <tr>
            <th class="thstyle">Sl No</th>           
            <th class="thstyle">Town</th>       
            <th class="thstyle">Substation</th>
            <th class="thstyle">Meter Type</th>
            <th class="thstyle">Location</th>
            <th class="thstyle">Meter Sl No</th> 
            <th class="thstyle">Site Added Date</th>          
           
        </tr>
    </thead>
    <tbody>
        <%
            try {
                   NumberFormat twoDec= new DecimalFormat("#0.00");
                   con=new in.amitech.db.DBUtil().getConnection();
//---------------------getting total dates from selected dates range------------------
                   List datesList=new ArrayList();
                   SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
                   SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
                   java.util.Date date1=sdf.parse(fromDate);
                   java.util.Date date2=sdf.parse(toDate);
                   while(!toDate.equals(sdf.format(date1))){
                       datesList.add(sdf1.format(date1));
                       date1.setDate(date1.getDate()+1);
                       //System.out.println("===========>"+sdf.format(date1));
                   }
                  // System.out.println(datesList);
//------------------------------------------------------------------------------------                                     
                   Map<String,String> metersMap=new HashMap<String,String>();
                  // sql="select g1,substr(g2,1,10) from d2 where cdfid in ( select min(cdfid) keep (dense_rank first order by log_time_stamp, cdfid)from d2 group by meter_serial_no )";
				    sql="select meter_no,to_char(meter_commisioned_timestamp,'DD-mm-YYYY') from meter_comm_track where meter_commisioned_timestamp between ? and ?";
                   PreparedStatement ps=con.prepareStatement(sql);
                   ps.setTimestamp(1, new java.sql.Timestamp(sdf.parse(fromDate).getTime()));
                   ps.setTimestamp(2, new java.sql.Timestamp(sdf.parse(toDate).getTime()));
                    rs=ps.executeQuery();
                   while(rs.next()){
                       metersMap.put(rs.getString(1),rs.getString(2));
                   }
                   metersMap.values().retainAll(datesList);
                 System.out.println("total meters------------>"+metersMap.size());
//-------------------------------getting master data details for these newely added meters------------------------
                  MasterDataAction mda=new MasterDataAction();
                 LinkedHashMap<String,HierarchyDetails> dataBean= mda.getMasterData(metersMap.keySet(), con);
                 System.out.println("data bean size----------->"+dataBean.size());
//----------------------------------------------------------------------------------------------------------                                                 
                 int sno=1; 
                 for(Entry em:dataBean.entrySet()){
             
                     HierarchyDetails hd =(HierarchyDetails)em.getValue();
        %>
                     <tr class="trbg">
                         <td class="tdbg" align="center"><%=sno%></td>
                         <td class="tdbg"><%=hd.getTown()==null?" ":hd.getTown()%></td>
                         <td class="tdbg"><%=hd.getSubstation()==null?" ":hd.getSubstation()%></td>
                         <td class="tdbg"><%=hd.getMeterType()==null?" ":hd.getMeterType()%></td>
                         <td class="tdbg"><%=hd.getLocation()==null?" ":hd.getLocation()%></td>
                         <td class="tdbg" align="center"> <%=em.getKey()%></td>
                         <td class="tdbg" align="center"><%=metersMap.get(em.getKey())%></td>
                     </tr>
        <%
        
                 sno++;
                 }
                 
                     }//try
            catch (Exception e) {
                e.printStackTrace();
                out.println("<h4>Error:</h4>" + e.getMessage());
            }
             finally{
                 if(con!=null)
                     con.close();
             }

        %>
        
    </tbody>
</table>
        
        